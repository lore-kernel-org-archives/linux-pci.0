Return-Path: <andriy.shevchenko@linux.intel.com>
Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1480362193.21899.35.camel@linux.intel.com>
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Mon, 28 Nov 2016 21:43:13 +0200
In-Reply-To: <20161128192530.GO16033@bhelgaas-glaptop.roam.corp.google.com>
References: 
	<c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
	 <20161128192530.GO16033@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2016-11-28 at 13:25 -0600, Bjorn Helgaas wrote:

+Cc: Rafael

> I can't remember a discussion about having this code in drivers/pci in
> the first place.  Would it make sense to move it to
> arch/x86/platform/intel-mid/?
> 
> 8e522e1d321b ("x86/platform/intel-mid: Add Intel Penwell to ID table")
> fixed a sync issue and added a comment about staying in sync with
> arch/x86/platform/intel-mid/pwr.c.  Maybe moving this code to arch/x86
> would help with that?
> 
> Looks like we'd have to expose pci_platform_pm_ops and
> pci_set_platform_pm(), but setting platform-specific PM ops does seem
> like something that would fit in the arch directories, so maybe that
> wouldn't be a bad thing.

We have pci-acpi.c there which is used AFAIU by drivers/acpi. I'm not
sure that it's a good idea to spread users of pci_platform_pm_ops under
arch/x86 and drivers/acpi. OTOH I have no strong opinion. Whatever fits
better.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
