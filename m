Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:51418 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbbELWFX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2015 18:05:23 -0400
Message-ID: <55527919.2030206@broadcom.com>
Date: Tue, 12 May 2015 15:05:13 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, <bhelgaas@google.com>,
	<arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <sbranden@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>, <zajec5@gmail.com>
Subject: Re: [PATCH 0/2] PCI: iproc: add bcma PCIe 2.0 controller
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hauke,

On 5/12/2015 2:22 PM, Hauke Mehrtens wrote:
> After Ray submitted the PCIe controller for the iProc devices using 
> pure device tree this adds support for the devices using bcma to scan 
> the bus. This should replaces the driver I initially send for inclusion.
> 
> @Ray The driver found in the Broadcom SDK does some more stuff:
> * setting up some DMA memory areas
> * chaining MPS and MRRS to 512
> * PHY changes:
>  * "improving" the PCIe jitter 
>  * some special initializations for the 3rd PCIe port
> 
> For me it works without these additions, but I haven't tested for 
> performance or stability or 3rd port. Can you check if this is needed 
> at all for the devices found on the market?

Good work, Hauke!

I'll eventually get to these. It may take a while but I'll eventually
get to them.

Thanks,

Ray
