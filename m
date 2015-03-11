Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1426083169-8698-8-git-send-email-tomasz.nowicki@linaro.org>
References: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org> <1426083169-8698-8-git-send-email-tomasz.nowicki@linaro.org>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 11 Mar 2015 10:37:29 -0500
Message-ID: <CAL_JsqJfvOcQ9sSuKfq3YCWubL9QctEDU0CR2mjBze2ZyB+nVg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] x86, pci, ecam: mmconfig_64.c becomes default
 implementation for ECAM driver.
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
> Architectures which want to take advantage of ECAM generic goodness

This is not necessarily an architecture decision. It is likely per host.

> should select CONFIG_PCI_ECAM_GENERIC. Otherwise, like x86 32bits machines,
> are obligated to provide own low-level ECAM calls.
>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---

[...]

> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index c588234..796b6e7 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -23,6 +23,119 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
>
>  LIST_HEAD(pci_mmcfg_list);
>
> +#ifdef CONFIG_GENERIC_PCI_ECAM
> +static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus,
> +                                 unsigned int devfn)
> +{
> +       struct pci_mmcfg_region *cfg = pci_mmconfig_lookup(seg, bus);
> +
> +       if (cfg && cfg->virt)
> +               return cfg->virt + (PCI_MMCFG_BUS_OFFSET(bus) | (devfn << 12));
> +       return NULL;
> +}
> +
> +int pci_mmcfg_read(unsigned int seg, unsigned int bus,
> +                         unsigned int devfn, int reg, int len, u32 *value)
> +{
> +       char __iomem *addr;
> +
> +       /* Why do we have this when nobody checks it. How about a BUG()!? -AK */
> +       if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095))) {
> +err:           *value = -1;
> +               return -EINVAL;
> +       }
> +
> +       rcu_read_lock();

What is the purpose of the rcu lock other than the old implementation had it?

> +       addr = pci_dev_base(seg, bus, devfn);

The .map_bus op provides the same function if you restructure to use
the generic accessors.

> +       if (!addr) {
> +               rcu_read_unlock();
> +               goto err;
> +       }
> +
> +       *value = pci_mmio_read(len, addr + reg);
> +       rcu_read_unlock();
> +
> +       return 0;
> +}
> +
> +int pci_mmcfg_write(unsigned int seg, unsigned int bus,
> +                          unsigned int devfn, int reg, int len, u32 value)
> +{
> +       char __iomem *addr;
> +
> +       /* Why do we have this when nobody checks it. How about a BUG()!? -AK */
> +       if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
> +               return -EINVAL;
> +
> +       rcu_read_lock();
> +       addr = pci_dev_base(seg, bus, devfn);
> +       if (!addr) {
> +               rcu_read_unlock();
> +               return -EINVAL;
> +       }
> +
> +       pci_mmio_write(len, addr + reg, value);
> +       rcu_read_unlock();
> +
> +       return 0;
> +}
> +
> +static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
> +{
> +       void __iomem *addr;
> +       u64 start, size;
> +       int num_buses;
> +
> +       start = cfg->address + PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
> +       num_buses = cfg->end_bus - cfg->start_bus + 1;
> +       size = PCI_MMCFG_BUS_OFFSET(num_buses);
> +       addr = ioremap_nocache(start, size);
> +       if (addr)
> +               addr -= PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
> +       return addr;
> +}
> +
> +int __init pci_mmcfg_arch_init(void)

Where would this be called for the case of the generic host and using DT?

Rob
