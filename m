Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49754 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984AbbITWXJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2015 18:23:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3CB1320502
	for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2015 18:23:09 -0400 (EDT)
Date: Sun, 20 Sep 2015 15:22:34 -0700
From: Greg KH <greg@kroah.com>
To: Knuth Posern <knuth@posern.org>
Cc: linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Allow loading of module on recent Apple
 MacBooks with thunderbolt 2 controller
Message-ID: <20150920222234.GA13447@kroah.com>
References: <55FF0822.90901@posern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55FF0822.90901@posern.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 20, 2015 at 09:25:22PM +0200, Knuth Posern wrote:
> The pci device ids listed in the thunderbolt driver are to restrictive,
> which prevents the driver from being loaded on recent Apple MacBooks
> using a thunderbolt 2 controller. In particular this prevented any
> hot-plugging functionality for thunderbolt based ethernet dongles
> (i.e. Apples thunderbolt gigabit ethernet broadcom tg3 based dongle
> Model A1433 EMC 2590).
> 
> Changing the subvendor and subdevice to PCI_ANY_ID the thunderbolt driver
> loads and binds to the pci device 07:00.0 System peripheral:
> Intel Corporation Device 156c which is the thunderbolt 2 controller on
> the MacBookPro12,1.
> 
> Successfully tested on MacBookPro12,1. With the patch the thunderbolt
> module gets now loaded on boot. And it provides hot-plugging support both
> for a cold-plugged and a warm-plugged ethernet dongle.
> 
> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
> Acked-by: Knuth Posern <knuth@posern.org>
> ---
> 
> ... never 2 without 3 ;)

Thanks for being persistent, that worked fine and is now queued up, you
should have received an email with all of the details.

greg k-h
