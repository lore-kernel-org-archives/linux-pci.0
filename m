Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:52955 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbaBXQ3K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2014 11:29:10 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so4771748wgg.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2014 08:29:08 -0800 (PST)
Date: Mon, 24 Feb 2014 16:29:02 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] timberdale: Use pci_enable_msix_exact() instead of
 pci_enable_msix()
Message-ID: <20140224162902.GI15847@lee--X1>
References: <1392804931-30671-3-git-send-email-agordeev@redhat.com>
 <20140219114424.GD10504@lee--X1>
 <20140221165606.GH17353@dhcp-26-207.brq.redhat.com>
 <20140221165809.GI17353@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140221165809.GI17353@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 21 Feb 2014, Alexander Gordeev wrote:

> As result of deprecation of MSI-X/MSI enablement functions
> pci_enable_msix() and pci_enable_msi_block() all drivers
> using these two interfaces need to be updated to use the
> new pci_enable_msi_range()  or pci_enable_msi_exact()
> and pci_enable_msix_range() or pci_enable_msix_exact()
> interfaces.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/mfd/timberdale.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
