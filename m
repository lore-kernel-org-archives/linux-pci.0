Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1433391238-19471-4-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com> <1433391238-19471-4-git-send-email-jiang.liu@linux.intel.com>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date: Thu, 4 Jun 2015 15:15:10 +0300
Message-ID: <CAHNKnsQfxRrG_gzVUyCkxj5svRcS-znGZWLf+R14_guJH0MO1g@mail.gmail.com>
Subject: Re: [RFT v2 03/48] MIPS, irq: Use irq_desc_get_xxx() to avoid
 redundant lookup of irq_desc
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
	Aleksey Makarov <aleksey.makarov@auriga.com>,
	David Daney <david.daney@cavium.com>,
	Christoph Lameter <cl@linux.com>,
	John Crispin <blogic@openwrt.org>,
	Andrew Bresticker <abrestic@chromium.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-06-04 7:13 GMT+03:00 Jiang Liu <jiang.liu@linux.intel.com>:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Note: this patch has been queued by Ralf Baechle <ralf@linux-mips.org>.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/mips/ath25/ar2315.c             |    2 +-
>  arch/mips/ath25/ar5312.c             |    2 +-
>  arch/mips/cavium-octeon/octeon-irq.c |    4 +++-
>  arch/mips/pci/pci-ar2315.c           |    2 +-
>  arch/mips/pci/pci-ar71xx.c           |    2 +-
>  arch/mips/pci/pci-ar724x.c           |    2 +-
>  arch/mips/pci/pci-rt3883.c           |    2 +-
>  arch/mips/ralink/irq.c               |    2 +-
>  8 files changed, 10 insertions(+), 8 deletions(-)
>
For ath25 (AR231x/AR5312) changes

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

-- 
Sergey
