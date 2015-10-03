Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 3 Oct 2015 11:45:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device driver
Message-ID: <20151003094512.GA29104@gmail.com>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443721454-25467-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Keith Busch <keith.busch@intel.com> wrote:

> +config VMDDEV
> +	depends on PCI && PCI_DOMAINS && PCI_MSI && GENERIC_MSI_IRQ_DOMAIN && IRQ_DOMAIN_HIERARCHY
> +	tristate "Volume Management Device Driver"
> +	default N
> +	select HAVE_VMDDEV
> +	---help---
> +	Adds support for the Intel Volume Manage Device (VMD). VMD is
> +	a secondary PCI host bridge that allows PCI Express root ports,
> +	and devices attached to them, to be removed from the default PCI
> +	domain and placed within the VMD domain. If your system provides
> +	one of these and has devices attached to it, say "Y".

So what this text does not explain is why does the user care? What tangible 
benefits does this feature offer to users?

Thanks,

	Ingo
