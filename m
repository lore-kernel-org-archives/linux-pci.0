Return-Path: <SRS0=7zCy=77=linux.intel.com=andriy.shevchenko@kernel.org>
Return-Path: <SRS0=7zCy=77=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1504014774.25945.146.camel@linux.intel.com>
Subject: Re: [PATCH v1] xen/pci: Use acpi_noirq_set() helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter
 Anvin" <hpa@zytor.com>,  x86@kernel.org, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Date: Tue, 29 Aug 2017 16:52:54 +0300
In-Reply-To: <1502356760.29303.381.camel@linux.intel.com>
References: <20170717103907.77308-1-andriy.shevchenko@linux.intel.com>
	 <20170802214537.GM20308@bhelgaas-glaptop.roam.corp.google.com>
	 <1502356760.29303.381.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-08-10 at 12:19 +0300, Andy Shevchenko wrote:
> On Wed, 2017-08-02 at 16:45 -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 17, 2017 at 01:39:07PM +0300, Andy Shevchenko wrote:
> > > No need to keep an #ifdef since we have a helper (in x86 world).
> > > Use it instead.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Looks reasonable to me, and I assume some non-PCI tree will take it.
> 
> It seems either TODO list is long, or everyone from x86 is on vacation
> :-)
> 
> Can't you push this through your tree?

It might be lost in pile of mails, a gentle up.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
