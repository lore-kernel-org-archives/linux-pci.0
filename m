Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36139 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab3AaNLx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jan 2013 08:11:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Oliver Neukum <oneukum@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
Date: Thu, 31 Jan 2013 14:18:06 +0100
Message-ID: <679823626.6Dz1DicNqX@vostro.rjw.lan>
In-Reply-To: <1359629934.1345.109.camel@x61.thuisdomein>
References: <1359377173.1345.25.camel@x61.thuisdomein> <510A1376.4020601@cn.fujitsu.com> <1359629934.1345.109.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 31, 2013 11:58:54 AM Paul Bolle wrote:
> On Thu, 2013-01-31 at 14:47 +0800, Gu Zheng wrote:
> > On 01/30/2013 04:31 PM, Paul Bolle wrote:
> > > 2) Regarding the errors I see at resume: it seems that if a device
> > > already exists when board_added() is called, this almost certainly means
> > > we're resuming with the same device we suspended with. So there's no
> > > reason to send errors to the log.
> > 
> > No, It's hard to detect whether the existed device is the one you want to resume.
> > Maybe the existed device was added during suspend, and the one you really want to
> > resume was removed. 
> 
> Because the domain, bus, slot, and function being equal doesn't mean
> it's the same device? (I had to look up those names in man 8 lspci, I'm
> unfamiliar with all this.)

No, that's not sufficient in general.

> Could an additional test on vendor ID and device ID help. Ie, if
> board_added() and friends notice a device already exists and the
> previous an current device have identical IDs, would we then know all
> that's needed to not bother to scare people with errors?

Yes, that's roughly the way to go in my opinion.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
