Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38579 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbbEGPJx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 11:09:53 -0400
Received: by igbhj9 with SMTP id hj9so48084919igb.1
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2015 08:09:53 -0700 (PDT)
Date: Thu, 7 May 2015 10:09:50 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: wdavis@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, tripperda@nvidia.com,
	jhubbard@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH 2/6] DMA-API: Introduce dma_(un)map_resource
Message-ID: <20150507150950.GK24643@google.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <1430505138-2877-3-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430505138-2877-3-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 01, 2015 at 01:32:14PM -0500, wdavis@nvidia.com wrote:
> From: Will Davis <wdavis@nvidia.com>
> 
> Add functions to DMA-map and -unmap a resource for a given device. This
> will allow devices to DMA-map a peer device's resource (for example,
> another device's BAR region on PCI) to enable peer-to-peer transactions.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/asm-generic/dma-mapping-broken.h |  9 +++++++++
>  include/asm-generic/dma-mapping-common.h | 34 ++++++++++++++++++++++++++++++++
>  include/linux/dma-mapping.h              |  7 +++++++

You should document these new interfaces in Documentation/DMA-API-*

Bjorn
