Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752112AbeGIWsX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Jul 2018 18:48:23 -0400
Date: Mon, 9 Jul 2018 17:48:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/12] pci: use for_each_if
Message-ID: <20180709224821.GA188359@bhelgaas-glaptop.roam.corp.google.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-10-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180709083650.23549-10-daniel.vetter@ffwll.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 09, 2018 at 10:36:48AM +0200, Daniel Vetter wrote:
> Avoids the inverted condition compared to the open-coded version.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this with the rest of the series.

> ---
>  include/linux/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 340029b2fb38..1484471ed048 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -601,7 +601,7 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
>  
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
> -		if (!pci_is_bridge(dev)) {} else
> +		for_each_if (pci_is_bridge(dev))
>  
>  static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
>  {
> -- 
> 2.18.0
> 
