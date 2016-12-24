Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35984 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbcLXKxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Dec 2016 05:53:24 -0500
Date: Sat, 24 Dec 2016 12:52:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, helgaas@google.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH 2/4] PCI: exynos: Remove the unnecessary variables
Message-ID: <20161224105249.GA6103@kozik-lap>
References: <20161219081740.5457-1-jh80.chung@samsung.com>
 <20161219081740.5457-3-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161219081740.5457-3-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 19, 2016 at 05:17:38PM +0900, Jaehoon Chung wrote:
> Remove the unnecessary variables(elbi/phy/block_base).
> It needs one resource structure for assigning each resource.
> So it replaces with one 'res' variable.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/pci/host/pci-exynos.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

