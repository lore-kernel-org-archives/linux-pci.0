Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42670 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752739AbbITRYe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2015 13:24:34 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 802A220194
	for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2015 13:24:33 -0400 (EDT)
Date: Sun, 20 Sep 2015 10:24:31 -0700
From: Greg KH <greg@kroah.com>
To: Knuth Posern <knuth@posern.org>
Cc: linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] Thunderbolt 2 driver for recent Apple MacBooks
Message-ID: <20150920172431.GB27148@kroah.com>
References: <55FEDAAD.6000804@posern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55FEDAAD.6000804@posern.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 20, 2015 at 06:11:25PM +0200, Knuth Posern wrote:
> Hi,
> 
> This patch is submitted for upstream inclusion.
> This is a first for me, so I hope the format of this mail is convenient.
> 
> Thanks to Greg and Andreas the attached patch (diff -up) fixes the bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=100191
> 
> The pci device ids listed in the tb driver are to restrictive, which
> prevents the driver from being loaded. We have had a similar issue
> with the new Mac mini.
> 
> Changing the subvendor and subdevice to PCI_ANY_ID in
> 	drivers/thunderbolt/nhi.c
> the thunderbolt driver loads and binds to the pci device
> 07:00.0 System peripheral: Intel Corporation Device 156c
> which is the thunderbolt 2 controller.
> 
> 
> Cheers,
> 
> Knuth.
> 

> --- linux/drivers/thunderbolt/nhi.c.orig	2015-09-20 17:36:14.014964300 +0200
> +++ linux/drivers/thunderbolt/nhi.c	2015-09-13 09:58:18.000000000 +0200
> @@ -643,7 +643,7 @@ static struct pci_device_id nhi_ids[] =
>  	{
>  		.class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
>  		.vendor = PCI_VENDOR_ID_INTEL, .device = 0x156c,
> -		.subvendor = 0x2222, .subdevice = 0x1111,
> +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
>  	},
>  	{ 0,}
>  };
> 
> 


This looks good, but can you resend it in the format described in
Documentation/SubmittingPatches so that I can apply it (i.e. a cleaned
up changelog comment and a signed-off-by: line?)

thanks,

greg k-h
