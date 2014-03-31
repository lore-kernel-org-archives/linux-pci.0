Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:34146 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbaCaP3M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Mar 2014 11:29:12 -0400
Date: Mon, 31 Mar 2014 11:28:56 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Interrupt remapping quirk tainting the kernel
Message-ID: <20140331152856.GB8050@hmsreliant.think-freely.org>
References: <1396253868.23070.94.camel@chaos.site>
 <20140331105619.GA8050@hmsreliant.think-freely.org>
 <1396275485.23070.261.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1396275485.23070.261.camel@chaos.site>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 31, 2014 at 04:18:05PM +0200, Jean Delvare wrote:
> Hi Neil,
> 
> Le Monday 31 March 2014 à 06:56 -0400, Neil Horman a écrit :
> > On Mon, Mar 31, 2014 at 10:17:48AM +0200, Jean Delvare wrote:
> > > Hi Neil and all,
> > > 
> > > I have (once again) a question about this commit:
> > > 
> > > From: Neil Horman <nhorman@tuxdriver.com>
> > > Date: Tue, 16 Apr 2013 20:38:32 +0000
> > > Subject: iommu/vt-d: add quirk for broken interrupt remapping on 55XX chipsets
> > > Git-commit: 03bbcb2e7e292838bb0244f5a7816d194c911d62
> > > 
> > > When interrupt remapping is disabled by this quirk, the kernel gets
> > > tainted. What is the rationale for doing that?
> > > 
> > > The user can boot with intremap=off. That will also disable interrupt
> > > remapping, as the quirk does, but not taint the kernel. If this is
> > > considered OK then I fail to see why the quirk should behave differently
> > > and taint the kernel.
> > > 
> > > Thanks,
> > The quirk is intented to flag to the user the fact that BIOS has not followed
> > the recommended procedure that was laied out in the intel published errata
> > sheet.  Arguably you could say that we should still taint the kernel in the
> > event that intremap=off is still specified, but it seems pragmatic not to do so,
> > as the use of that option suggsts the administrator has asserted a workaround to
> > the problem that is identical to the fix (in the event that the BIOS vendor has
> > not released an update).
> 
> That doesn't really answer my question. While I understand that the
> preferred fix is that the BIOS disables the feature, how bad are we if
> it does not and the kernel has to do it?
> 
For exactly the reason Prarit indicated.  Because the way its currently coded
gives me valuable information when debugging systems.  It tells me that the
customer is running with a bios that exposes a bug in the hardware, that while
we can work around dynamically, we should still inform them of.

> We normally taint the kernel when the situation is such that debugging
> the kernel would be a waste of time.
Um, no.  Thats absolutely not the reason we taint the kernel.  If you are using
the kernel taint as an excuse to shurg off support responsibiilty, you're doing
it wrong.

> For example, because a binary
> driver was loaded, or a module was forcibly unloaded, etc.
That just means that those things happeend, which may be (and very likely are)
relevant to the debugging process.  It means that you need to ask the bug
reporter about it, get in touch with the module vendor, Attempt to recreate
without the tainting actions, etc.  It by no means indicates debugging is
"useless"

> How does that
> apply here? If the quirk kicks in, aren't we just as safe as if the BIOS
> had disabled the feature? If not, then I would like to understand why,
> and document it properly.
> 
Yes, we are just as safe, but see above, the reasons we taint the kernel aren't
the reasons you think.

Regards
Neil

> Thanks,
> -- 
> Jean Delvare
> SUSE L3 Support
> 
> 
