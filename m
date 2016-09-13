Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:34021 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758881AbcIMPTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2016 11:19:40 -0400
Date: Tue, 13 Sep 2016 17:19:35 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pcie-rcar: MSI range allocation support
Message-ID: <20160913151934.GD25005@verge.net.au>
References: <2520843.q5xC3E7R5B@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2520843.q5xC3E7R5B@wasted.cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 08, 2016 at 10:32:59PM +0300, Sergei Shtylyov wrote:
> From: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
> 
> Impelment MSI setup_irqs() method which enables allocation of several MSIs
> at once.
> 
> [Sergei Shtylyov: removed unrelated/unneeded changes, fixed too long lines,
> reordered the variable declarations, reworded the summary/description.]
> 
> Signed-off-by: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

