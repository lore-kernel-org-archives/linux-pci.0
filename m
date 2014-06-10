Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <539713B2.1010506@citrix.com>
Date: Tue, 10 Jun 2014 15:18:26 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Grant Likely" <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Yinghai Lu" <yinghai@kernel.org>, <x86@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Michal Simek <monstr@monstr.eu>,
	"Tony Lindgren" <tony@atomide.com>
CC: Tony Luck <tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Joerg Roedel <joro@8bytes.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<linux-pci@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [Xen-devel] [Patch V4 19/42] x86, irq: count legacy IRQs by legacy_pic->nr_legacy_irqs
 instead of NR_IRQS_LEGACY
References: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com> <1402302011-23642-20-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1402302011-23642-20-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/06/14 09:19, Jiang Liu wrote:
> Some platforms, such as Intel MID and mshypv, do not support legacy
> interrupt controllers. So count legacy IRQs by legacy_pic->nr_legacy_irqs
> instead of hard-coded NR_IRQS_LEGACY.
> 
[...]
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c

Xen bits:

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
