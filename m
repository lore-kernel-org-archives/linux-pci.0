Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8542 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab3CRS0F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Mar 2013 14:26:05 -0400
Date: Mon, 18 Mar 2013 11:26:04 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: USB list <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Lan Tianyu <tianyu.lan@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled
Message-ID: <20130318182604.GI17414@xanatos>
References: <5142094D.2070305@fold.natur.cuni.cz>
 <20130318170159.GF17414@xanatos>
 <51474CCC.3090802@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51474CCC.3090802@fold.natur.cuni.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 18, 2013 at 06:20:12PM +0100, Martin Mokrejs wrote:
> Hi Sarah,
>   in this particular thread, the USB3 socket of the laptop works once
> I plugin a device. When I unplug it and insert same or another device it appears
> to be dead until I use 'lsusb -vvv'. After that, I see in dmesg the two lines:

Which kernel are you running on?  We had a regression that involved dead
ports after a USB disconnect in 3.8.  This was was fixed in 3.8.3.  Can
you please retest with that kernel version?

Sarah Sharp
