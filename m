Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:51029 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754009AbdD0IBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2017 04:01:42 -0400
Date: Thu, 27 Apr 2017 10:02:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kyle Gale <kylewgale@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI Rescan Question
Message-ID: <20170427080207.GA11141@wunner.de>
References: <CAEhpy_c96xmviS8fE4rMDeK9dPiSLhTrW_MQNtdkKXkwoU8PEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEhpy_c96xmviS8fE4rMDeK9dPiSLhTrW_MQNtdkKXkwoU8PEg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 26, 2017 at 03:56:09PM -0700, Kyle Gale wrote:
> Can someone help me understand why I need to remove my stale PCI
> device files from the tree if I want to properly get my device
> re-initialized after unplugging and reinserting?
> 
> For example, I turn on my system with my PCI device plugged in. All is
> fine. I unplug it, plug it back in, and rescan (echo 1 >
> /sys/bus/pci/devices/rescan) and end up in this state where my BAR0 is
> not set, and other things are not entirely correct.
> 
> But if I do a remove (echo 1 > /sys/bus/pci/devices/xxxx/xx.x/remove)
> of the port, it then properly re-initializes my device when I do a
> rescan.
> 
> Why does it not suffice to simply do a rescan? Does the rescan skip
> some step if it finds that the device is already in the PCI tree? It's
> not as if the rescan completely skips the device if I don't do a
> remove, it just doesn't do all of the initialization.

Initiating a rescan via sysfs results in a call to pci_rescan_bus(),
which only adds devices but doesn't remove any.  I guess it can be
argued that this behavior is counter-intuitive and should be changed.

Thanks,

Lukas
