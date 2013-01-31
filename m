Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36134 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab3AaNKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jan 2013 08:10:24 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Oliver Neukum <oneukum@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
Date: Thu, 31 Jan 2013 14:16:35 +0100
Message-ID: <59119187.s0aIH5HTY2@vostro.rjw.lan>
In-Reply-To: <510A1376.4020601@cn.fujitsu.com>
References: <1359377173.1345.25.camel@x61.thuisdomein> <1359534681.1345.74.camel@x61.thuisdomein> <510A1376.4020601@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 31, 2013 02:47:18 PM Gu Zheng wrote:
> On 01/30/2013 04:31 PM, Paul Bolle wrote:
> 
> > On Wed, 2013-01-30 at 11:08 +0800, Gu Zheng wrote:
> >> On 01/29/2013 06:35 PM, Paul Bolle wrote:
> >>> So should the fix here be to actually suspend and remove this
> >>> device? (Note that pciehp_suspend() is now basically a NOP.)
> >> 	The resume routine should handle all possible situations here. As Rafael said, 
> >> in some cases there's no way to tell the difference between "internal" and "external".
> >> If this problem seriously disturbs you, you can avoid this feature.
> > 
> > 0) Actually, before v3.7 I was unaware of pciehp. And if these errors
> > hadn't shown up I would still be. I'm only using pciehp because Fedora
> > 17 has CONFIG_HOTPLUG_PCI_PCIE enabled in its kernel config. 
> > 
> >>  But the better way is
> >> reporting a bug report on the bugzilla, it can call more developers to fix this issue.
> > 
> > 1) Fine with me, though my experience is that kernel bugs should first
> > be discussed on the appropriate mailinglist.
> > 
> > 2) Regarding the errors I see at resume: it seems that if a device
> > already exists when board_added() is called, this almost certainly means
> > we're resuming with the same device we suspended with. So there's no
> > reason to send errors to the log.
> 
> 
> No, It's hard to detect whether the existed device is the one you want to resume.
> Maybe the existed device was added during suspend, and the one you really want to
> resume was removed. 

We can save the PCI config space of it on suspend and then compare with what we
have on resume.  There are a few registers there whose values shouldn't change
and should differ for different devices.  That shouldn't be too hard I suppose.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
