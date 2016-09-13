Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33963 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755003AbcIMPRf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2016 11:17:35 -0400
Date: Tue, 13 Sep 2016 17:17:27 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pcie-rcar: fix some checkpatch warnings
Message-ID: <20160913151727.GB25005@verge.net.au>
References: <4686727.8sYr70Tb6R@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4686727.8sYr70Tb6R@wasted.cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 09, 2016 at 01:26:18AM +0300, Sergei Shtylyov wrote:
> The R-Car PCIe driver causes 13 warnings from scripts/checkpatch.pl --
> let's fix at least 10 easier ones:
> 
> - line over 80 characters;
> 
> - blank line missing after declarations;
> 
> - statements not starting on a tabstop.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo plus
> two patches  posted  earlier...

This looks good to me.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
