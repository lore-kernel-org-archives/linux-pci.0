Return-Path: <SRS0=k2hq=X3=linux.intel.com=andriy.shevchenko@kernel.org>
Return-Path: <SRS0=k2hq=X3=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1481559073.7188.36.camel@linux.intel.com>
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, x86@kernel.org, Bjorn Helgaas
	 <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Mon, 12 Dec 2016 18:11:13 +0200
In-Reply-To: <20161212160155.GA29792@bhelgaas-glaptop.roam.corp.google.com>
References: 
	<ba07572b4c4fad1f60593454693a58137f518896.1480859081.git.lukas@wunner.de>
	 <20161207225315.GI22129@bhelgaas-glaptop.roam.corp.google.com>
	 <20161212072733.GA23597@gmail.com>
	 <20161212160155.GA29792@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2016-12-12 at 10:01 -0600, Bjorn Helgaas wrote:
> On Mon, Dec 12, 2016 at 08:27:33AM +0100, Ingo Molnar wrote:

> I can't remember why we decided to put pci-mid.c in drivers/pci.

In the first place there were no such comments like below.

>   The
> obviously reason is that it uses pci_platform_pm_ops, which isn't
> visible outside drivers/pci, but pci-mid.c is clearly platform-
> specific, and even the name "pci_platform_pm_ops" sounds like
> something that should be implemented in the arch directories, so maybe
> pci_platform_pm_ops should be moved to include/linux/pci.h.

You are repeating yourself here. Last time I have referred to another
user of that struct which doesn't belong to arch, but to drivers/acpi.
And my opinion here is to keep things for now, until some common
solution would be developed.

> I have strange sense of déjà vu writing this, so sorry if I'm
> repeating something.

Yes, that's right.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
