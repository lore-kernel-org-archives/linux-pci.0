Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54835 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTSeK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 14:34:10 -0400
Date: Tue, 20 Mar 2018 19:34:06 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 1/2] x86/PCI: Fix a potential regression when use
 dmi_get_bios_year()
Message-ID: <20180320193406.3d76d4f1@endymion>
In-Reply-To: <alpine.DEB.2.21.1803201746450.1567@nanos.tec.linutronix.de>
References: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com>
        <20180320135410.11627-2-andriy.shevchenko@linux.intel.com>
        <20180320163258.5ac39580@endymion>
        <1521560965.23017.68.camel@linux.intel.com>
        <alpine.DEB.2.21.1803201746450.1567@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 20 Mar 2018 17:47:41 +0100 (CET), Thomas Gleixner wrote:
> On Tue, 20 Mar 2018, Andy Shevchenko wrote:
> > On Tue, 2018-03-20 at 16:32 +0100, Jean Delvare wrote:  
> > > When fixing a regression, a good practice is to tag the fix commit as
> > > such:
> > > 
> > > Fixes: 69c42d493db4 ("x86/pci: Simplify code by using the new
> > > dmi_get_bios_year() helper")  
> > 
> > Someone (perhaps Ingo) told me that Fixes doesn't make much sense if the
> > fixing commit is not yet in vanilla.  
> 
> No. If the commit is already queued for the next merge window then a fixes
> tag is appropriate.

+1

Even if it won't be used for stable branches, it's still valuable for
distribution kernel maintainers to find out the fixes to patches they
backport.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
