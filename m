Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59427 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab3A2VfC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 16:35:02 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Paul Bolle <pebolle@tiscali.nl>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Oliver Neukum <oneukum@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
Date: Tue, 29 Jan 2013 22:41:11 +0100
Message-ID: <3112957.IGAg1VkqM8@vostro.rjw.lan>
In-Reply-To: <5107E088.6030608@fold.natur.cuni.cz>
References: <1359377173.1345.25.camel@x61.thuisdomein> <1359462737.1345.58.camel@x61.thuisdomein> <5107E088.6030608@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 29, 2013 03:45:28 PM Martin Mokrejs wrote:
> Hi,
> 
> Paul Bolle wrote:
> > On Tue, 2013-01-29 at 12:35 +0100, Rafael J. Wysocki wrote:
> >> On Tuesday, January 29, 2013 11:35:32 AM Paul Bolle wrote:
> >>> Thanks. So should the fix here be to actually suspend and remove this
> >>> device? (Note that pciehp_suspend() is now basically a NOP.)
> >>
> >> I think it wouldn't be useful to remove devices on all suspends, but then there
> >> are a few different situations that resume has to consider and handle correctly:
> >>
> >> 1) Device has been removed while suspended.
> >> 2) Device was present before suspend and is still there.
> >> 3) Device has been added while suspended.
> > 
> > Obviously, I care about situation 2) here. (It would be quite a feat to
> > remove or add a wireless card while the laptop is suspended.)
> 
>   I don't use suspend on my laptop to avoid possible problems with crashes
> and data loss (so I rather quit my apps and shutdown). Therefore I have no
> experience with that ... but it is my impression that the obvious use is to
> close the lid, unplug an external mouse/keyboard and go elsewhere, maybe
> re-plug the mouse/keyboard into different slots (hey, I can't remember
> whether I had mouse in this or the other socket) and open the lid. Even
> being unintentionally nasty to the OS and re-plugging the devices after
> I opened the laptop lid! I understand one is in all these scenarios just
> doing the bad thing and just asking for a trouble ... but that's why I
> don't use that feature. My memory is leaky and my behavior is error-prone
> so I am sure once I would screw the order. Maybe OS could force disconnect of all
> external devices which are reasonably safe (mouse and keyboard while not
> say external USB drive)?
> 
>   Nevertheless, is it possible to have an external drive connection preserved
> through suspend so that it survives under same device id? I don't know if this
> a possible at all ... If not, then OS could could unplug even external drives.

This is possible for PCI devices.  The IDs won't change if the device is
plugged in all the time.

Moreover, in some cases there's no way to tell the difference between "internal"
and "external".  The OS just has to handle all of the possible situations
during resume correctly.  If it doesn't, then there is a bug that needs to be
fixed.

And avoiding a given feature just because you're scared of it doesn't lead to
any progress.  If you instead use it and report problems with it, then chances
are those problems will be addressed over time.

I use suspend all the time and it works for me.  I don't have any PCIe hotplug
devices, though, so any information on whether or not it works for people is
quite valuable to me.

I'll have a look at the pciehp driver's resume, but that's going to take some
time.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
