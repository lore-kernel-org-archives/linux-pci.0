Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50191 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbaCaOSJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 31 Mar 2014 10:18:09 -0400
Subject: Re: Interrupt remapping quirk tainting the kernel
From: Jean Delvare <jdelvare@suse.de>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
In-Reply-To: <20140331105619.GA8050@hmsreliant.think-freely.org>
References: <1396253868.23070.94.camel@chaos.site>
	 <20140331105619.GA8050@hmsreliant.think-freely.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Mar 2014 16:18:05 +0200
Message-ID: <1396275485.23070.261.camel@chaos.site>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Neil,

Le Monday 31 March 2014 à 06:56 -0400, Neil Horman a écrit :
> On Mon, Mar 31, 2014 at 10:17:48AM +0200, Jean Delvare wrote:
> > Hi Neil and all,
> > 
> > I have (once again) a question about this commit:
> > 
> > From: Neil Horman <nhorman@tuxdriver.com>
> > Date: Tue, 16 Apr 2013 20:38:32 +0000
> > Subject: iommu/vt-d: add quirk for broken interrupt remapping on 55XX chipsets
> > Git-commit: 03bbcb2e7e292838bb0244f5a7816d194c911d62
> > 
> > When interrupt remapping is disabled by this quirk, the kernel gets
> > tainted. What is the rationale for doing that?
> > 
> > The user can boot with intremap=off. That will also disable interrupt
> > remapping, as the quirk does, but not taint the kernel. If this is
> > considered OK then I fail to see why the quirk should behave differently
> > and taint the kernel.
> > 
> > Thanks,
> The quirk is intented to flag to the user the fact that BIOS has not followed
> the recommended procedure that was laied out in the intel published errata
> sheet.  Arguably you could say that we should still taint the kernel in the
> event that intremap=off is still specified, but it seems pragmatic not to do so,
> as the use of that option suggsts the administrator has asserted a workaround to
> the problem that is identical to the fix (in the event that the BIOS vendor has
> not released an update).

That doesn't really answer my question. While I understand that the
preferred fix is that the BIOS disables the feature, how bad are we if
it does not and the kernel has to do it?

We normally taint the kernel when the situation is such that debugging
the kernel would be a waste of time. For example, because a binary
driver was loaded, or a module was forcibly unloaded, etc. How does that
apply here? If the quirk kicks in, aren't we just as safe as if the BIOS
had disabled the feature? If not, then I would like to understand why,
and document it properly.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

