Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37181 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbcLUGU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2016 01:20:56 -0500
Subject: Re: [4/4] PCI: exynos: remove the duplicated codes
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-pci@vger.kernel.org
Cc: helgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
From: "pankaj.dubey" <pankaj.dubey@samsung.com>
Message-id: <e6e5313e-a024-0d79-bbf3-88100631bd78@samsung.com>
Date: Wed, 21 Dec 2016 11:53:29 +0530
MIME-version: 1.0
In-reply-to: <20161219081740.5457-5-jh80.chung@samsung.com>
Content-type: text/plain; charset=utf-8
References: <20161219081740.5457-5-jh80.chung@samsung.com>
 <CGME20161221062054epcas1p178b0503e66acc9d005a6e08fa8753954@epcas1p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jaehoon,

On Monday 19 December 2016 01:47 PM, Jaehoon Chung wrote:
> Removed the duplicated codes.
> It can use the more simply than now.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/pci/host/pci-exynos.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> 

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
