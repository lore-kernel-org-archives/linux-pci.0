Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34328 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754060AbcLXKyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Dec 2016 05:54:17 -0500
Date: Sat, 24 Dec 2016 12:54:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, helgaas@google.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH 3/4] PCI: exynos: Use the bitops API to operate the bit
 shifting
Message-ID: <20161224105403.GB6103@kozik-lap>
References: <20161219081740.5457-1-jh80.chung@samsung.com>
 <20161219081740.5457-4-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161219081740.5457-4-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 19, 2016 at 05:17:39PM +0900, Jaehoon Chung wrote:
> Just use the bitops api to operate the bit.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/pci/host/pci-exynos.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

