Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34492 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbbHFPdJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 11:33:09 -0400
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Kishon Vijay Abraham I'" <kishon@ti.com>
Cc: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nsekhar@ti.com>, "'Jingoo Han'" <jingoohan1@gmail.com>
References: <1438345512-28973-1-git-send-email-kishon@ti.com>
In-Reply-To: <1438345512-28973-1-git-send-email-kishon@ti.com>
Subject: Re: [PATCH v5 0/3] dra7xx: Add PM support to PCIe
Date: Fri, 7 Aug 2015 00:33:01 +0900
Message-ID: <000001d0d05d$321dbcd0$96593670$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 31, 2015 9:25 PM, Kishon Vijay Abraham I wrote:
> 
> This series adds PM support to pci-dra7xx so that PCI clocks can be disabled
> during suspend and enabled back during resume without affecting
> PCI functionality.
> 
> Changes from v4:
> *) Fixed a bug caused by sending incomplete patch.
> 
> Changes from v3:
> *) Fix compilation errors when individual patches are applied
> 
> Changes from v2:
> *) Used SET_SYSTEM_SLEEP_PM_OPS and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for
>    populating PM ops.
> 
> Changes from v1:
> *) Moved resetting and setting of MSE bit to pci-dra7xx.
> 
> The comment to reset and set ISE is not done now since I don't have a card
> with IO space. Once I get to test that, I'll post a separate patch for
> handling that.
> 
> Kishon Vijay Abraham I (3):
>   PCI: host: pci-dra7xx: Disable pm_runtime on get_sync failure
>   PCI: host: pci-dra7xx: add pm support to pci dra7xx
>   PCI: host: pci-dra7xx: Idle the module by disabling MSE bit

Hi Kishon,

Looks good! :-)

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> 
>  drivers/pci/host/pci-dra7xx.c |   95 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
> 
> --
> 1.7.9.5

