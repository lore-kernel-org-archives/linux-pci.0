Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 7 Nov 2014 11:40:12 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Alexander Gordeev <agordeev@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch Part2 v5 21/31] PCI/MSI: Enhance core to support hierarchy
 irqdomain
In-Reply-To: <1415283644-2559-22-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1411071139260.3789@nanos>
References: <1415283644-2559-1-git-send-email-jiang.liu@linux.intel.com> <1415283644-2559-22-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 6 Nov 2014, Jiang Liu wrote:

> Enhance PCI MSI core to support hierarchy irqdomain, so the common
> code could be shared among architectures.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
> Hi Thomas,
> 	These changes are a temporary solution, I'm working on another
> patch set which will refine these interfaces, especially kill 
> arch_msi_irq_domain_{set|get}_hwirq().

Ok. Please don't forget the irq_chip change :)

Thanks,

	tglx
