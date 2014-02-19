Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:33947 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaBSLoa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 06:44:30 -0500
Received: by mail-we0-f179.google.com with SMTP id q58so224196wes.38
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 03:44:29 -0800 (PST)
Date: Wed, 19 Feb 2014 11:44:24 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] timberdale: Use pci_enable_msix_range() instead of
 pci_enable_msix()
Message-ID: <20140219114424.GD10504@lee--X1>
References: <1392804931-30671-3-git-send-email-agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1392804931-30671-3-git-send-email-agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> As result of deprecation of MSI-X/MSI enablement functions
> pci_enable_msix() and pci_enable_msi_block() all drivers
> using these two interfaces need to be updated to use the
> new pci_enable_msi_range() and pci_enable_msix_range()
> interfaces.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/mfd/timberdale.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
