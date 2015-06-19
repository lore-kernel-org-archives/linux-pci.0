Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45332 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbbFSQX5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Jun 2015 12:23:57 -0400
Date: Fri, 19 Jun 2015 17:24:13 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
Message-ID: <20150619162413.GA21533@red-moon>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com>
 <20150528022332.GA23724@roeck-us.net>
 <20150528124112.GJ10210@google.com>
 <20150618180103.GA23809@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150618180103.GA23809@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Guenter,

On Thu, Jun 18, 2015 at 07:01:03PM +0100, Guenter Roeck wrote:
> On Thu, May 28, 2015 at 07:41:12AM -0500, Bjorn Helgaas wrote:
> > 
> > > > I'd like res->flags to reflect the capabilities of the hardware, not
> > > > whether the window is currently enabled.
> > > > 
> > > Flag bits seem to be all taken. Could we use IORESOURCE_DISABLED for that
> > > purpose, or could that cause conflicts elsewhere ?
> > 
> > Yes, I think IORESOURCE_DISABLED would be appropriate for any I/O windows
> > below a host bridge that doesn't support I/O space.
> > 
> I integrated Lorenzo's patch and tried to get this working.

Thanks. How do you want to proceed with this ? Are you taking my patch
and post it along with your updated series ? We need to extend test
coverage to platforms we could not test on, as you know my series
affects all archs but SPARC (I mean it should *not* affect them, this
has to be tested though, I do not have the HW needed, your coverage
for x86 and PowerPC is great but I do not think it can be deemed
sufficient).

Please let me know, thanks !

Lorenzo

> Problem is that the use of a resource is widely checked with "!res->flags"
> throughout the code. That would have to be changed to something like
> "(!res->flags || (res->flags & IORESOURCE_DISABLED))" whereever it is used.
> 
> I tried going with "!res->flags" instead, but have not been able to get it
> to work realiably; it is just very difficult to distinguish if "!res->flags"
> means that the resource has not yet been assigned or if it means that it is not
> supported.
> 
> The correct approach, in my opinion, would be to go with IORESOURCE_DISABLED
> and make the necessary changes whereever needed. Effectively this means to
> replace the "!res->flags" check with something like pci_res_used() [ pick
> your preferred name ] and define it as
> 
> #define pci_res_used(res) ((res)->flags && !((res)->flags & IORESOURCE_DISABLED))
> 
> Is that the right direction ?
> 
> Thanks,
> Guenter
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
