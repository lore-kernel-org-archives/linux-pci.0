Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1433391238-19471-40-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com> <1433391238-19471-40-git-send-email-jiang.liu@linux.intel.com>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date: Thu, 4 Jun 2015 15:21:29 +0300
Message-ID: <CAHNKnsQOWOR+WLM=rsbvGyaGPfJ8WrFCmEMKX53-yzsp1i-Hmg@mail.gmail.com>
Subject: Re: [RFT v2 39/48] genirq, mips: Kill the first parameter 'irq' of irq_flow_handler_t
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Aleksey Makarov <aleksey.makarov@auriga.com>,
	David Daney <david.daney@cavium.com>,
	Christoph Lameter <cl@linux.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Tejun Heo <tj@kernel.org>, John Crispin <blogic@openwrt.org>,
	Andrew Bresticker <abrestic@chromium.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-06-04 7:13 GMT+03:00 Jiang Liu <jiang.liu@linux.intel.com>:
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
>
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/alchemy/common/irq.c          |    4 ++--
>  arch/mips/alchemy/devboards/bcsr.c      |    2 +-
>  arch/mips/ath25/ar2315.c                |    2 +-
>  arch/mips/ath25/ar5312.c                |    2 +-
>  arch/mips/ath79/irq.c                   |    8 ++++----
>  arch/mips/cavium-octeon/octeon-irq.c    |    8 ++++----
>  arch/mips/include/asm/netlogic/common.h |    4 ++--
>  arch/mips/jz4740/gpio.c                 |    2 +-
>  arch/mips/netlogic/common/smp.c         |    4 ++--
>  arch/mips/pci/pci-ar2315.c              |    2 +-
>  arch/mips/pci/pci-ar71xx.c              |    2 +-
>  arch/mips/pci/pci-ar724x.c              |    2 +-
>  arch/mips/pci/pci-rt3883.c              |    2 +-
>  arch/mips/ralink/irq.c                  |    2 +-
>  14 files changed, 23 insertions(+), 23 deletions(-)
>

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

-- 
Sergey
