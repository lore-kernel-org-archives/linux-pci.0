Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1426083169-8698-3-git-send-email-tomasz.nowicki@linaro.org>
References: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org> <1426083169-8698-3-git-send-email-tomasz.nowicki@linaro.org>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 11 Mar 2015 10:19:22 -0500
Message-ID: <CAL_Jsq+AtQAkzfGL0Gk8O7_r-H8wXWF2Rw=0oN6saj9oa3s-CA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] x86, pci: Abstract PCI config accessors and use
 AMD Fam10h workaround exclusively.
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Al Stone <al.stone@linaro.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 11, 2015 at 9:12 AM, Tomasz Nowicki
<tomasz.nowicki@linaro.org> wrote:
> From now on, readb()/writeb()/etc. generic calls are used as default
> approach. Special MMIO accessors are registered for AMD Fam10h CPUs only.
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---
>  arch/x86/include/asm/pci_x86.h |   8 +++
>  arch/x86/pci/mmconfig-shared.c | 114 +++++++++++++++++++++++++++++++++++++++++
>  arch/x86/pci/mmconfig_32.c     |  24 +--------
>  arch/x86/pci/mmconfig_64.c     |  24 +--------
>  arch/x86/pci/numachip.c        |  24 +--------
>  5 files changed, 128 insertions(+), 66 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index d024f4d..c57c225 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -137,6 +137,11 @@ struct pci_mmcfg_region {
>         char name[PCI_MMCFG_RESOURCE_NAME_LEN];
>  };
>
> +struct pci_mmcfg_mmio_ops {
> +       u32 (*read)(int len, void __iomem *addr);
> +       void (*write)(int len, void __iomem *addr, u32 value);

We already have nearly the same struct with pci_ops...

> +};
> +
>  extern int __init pci_mmcfg_arch_init(void);
>  extern void __init pci_mmcfg_arch_free(void);
>  extern int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
> @@ -145,6 +150,9 @@ extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
>                                phys_addr_t addr);
>  extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
>  extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
> +extern u32 pci_mmio_read(int len, void __iomem *addr);
> +extern void pci_mmio_write(int len, void __iomem *addr, u32 value);
> +extern void pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops);
>
>  extern struct list_head pci_mmcfg_list;
>
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index dd30b7e..8b3bc4f 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -31,6 +31,118 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
>
>  LIST_HEAD(pci_mmcfg_list);
>
> +static u32
> +pci_mmconfig_generic_read(int len, void __iomem *addr)
> +{
> +       u32 data = 0;
> +
> +       switch (len) {
> +       case 1:
> +               data = readb(addr);
> +               break;
> +       case 2:
> +               data = readw(addr);
> +               break;
> +       case 4:
> +               data = readl(addr);
> +               break;
> +       }

This same function logic already exists with pci_generic_config_read.
I think you need to move the differentiation between AMD and generic
ECAM to pci_ops.

Rob
