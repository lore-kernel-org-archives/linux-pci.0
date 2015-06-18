Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49312 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151AbbFRSBI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 14:01:08 -0400
Date: Thu, 18 Jun 2015 11:01:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
Message-ID: <20150618180103.GA23809@roeck-us.net>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com>
 <20150528022332.GA23724@roeck-us.net>
 <20150528124112.GJ10210@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528124112.GJ10210@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 07:41:12AM -0500, Bjorn Helgaas wrote:
> 
> > > I'd like res->flags to reflect the capabilities of the hardware, not
> > > whether the window is currently enabled.
> > > 
> > Flag bits seem to be all taken. Could we use IORESOURCE_DISABLED for that
> > purpose, or could that cause conflicts elsewhere ?
> 
> Yes, I think IORESOURCE_DISABLED would be appropriate for any I/O windows
> below a host bridge that doesn't support I/O space.
> 
I integrated Lorenzo's patch and tried to get this working.

Problem is that the use of a resource is widely checked with "!res->flags"
throughout the code. That would have to be changed to something like
"(!res->flags || (res->flags & IORESOURCE_DISABLED))" whereever it is used.

I tried going with "!res->flags" instead, but have not been able to get it
to work realiably; it is just very difficult to distinguish if "!res->flags"
means that the resource has not yet been assigned or if it means that it is not
supported.

The correct approach, in my opinion, would be to go with IORESOURCE_DISABLED
and make the necessary changes whereever needed. Effectively this means to
replace the "!res->flags" check with something like pci_res_used() [ pick
your preferred name ] and define it as

#define pci_res_used(res) ((res)->flags && !((res)->flags & IORESOURCE_DISABLED))

Is that the right direction ?

Thanks,
Guenter
