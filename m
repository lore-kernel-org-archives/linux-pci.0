Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:52689 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbcDZVDY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 17:03:24 -0400
Date: Tue, 26 Apr 2016 23:05:58 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pcie: Add driver for Downstream Port Containment
Message-ID: <20160426210558.GB17561@wunner.de>
References: <1461703693-29400-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461703693-29400-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Tue, Apr 26, 2016 at 02:48:13PM -0600, Keith Busch wrote:
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -11,7 +11,7 @@
>  
>  #include <linux/compiler.h>
>  
> -#define PCIE_PORT_DEVICE_MAXSERVICES   4
> +#define PCIE_PORT_DEVICE_MAXSERVICES   5

You're adding a fifth port service yet the name of port service devices
encodes the service type in one nibble, so there's only room for four
service types.

You need to amend your patch to fixup get_descriptor_id() in portdrv.h
as well as dev_set_name() in portdrv_core.c to cope with more than four
service types, as I've done in this commit:

https://github.com/l1k/linux/commit/b688d6e4873ab082e5916b1a993bc1d38c6f4178


You may also want to fixup these small nits in the commit message:

> This adds driver support for root and downstream ports that implement
> the Downstream Port PCI-Express extended capability. DPC is an optional
                     ^
                     Containment
> capability to contained uncorrectable errors below a downstream port.
                ^
                contain
> 
> When a DPC is triggered due to receipt of an uncorrectable error message,
> the DPC driver will schedule removal for all downstream devices as DPC
> capable ports disable downstream links. This may happen concurrently
> with a PCI-e hotplug driver if enabled. After the downstream devices
> are removed, the DPC driver will clear the status and interrupt bits
                                                                      ^
                                                                      and
> the link may retrain for a newly connected device.


Best regards,

Lukas
