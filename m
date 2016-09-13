Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:34018 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758881AbcIMPTh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2016 11:19:37 -0400
Date: Tue, 13 Sep 2016 17:19:26 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pcie-rcar: try setting PCIe speed to 5 GT/s at boot
Message-ID: <20160913151926.GC25005@verge.net.au>
References: <6896977.DKiraAXap6@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6896977.DKiraAXap6@wasted.cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 07, 2016 at 11:22:14PM +0300, Sergei Shtylyov wrote:
> From: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
> 
> Initially, the PCIe link speed is set up only at 2.5 GT/s.
> For better performance,  we're trying to increase link speed to 5 GT/s.
> 
> [Sergei Shtylyov: indented the macro definitions with tabs, renamed the
> SPCHG register bits for consistency, renamed the link speed field/values,
> fixed too long lines, fixed redundancy in clearing the MACSR register bits,
> fixed grammar/typos in  the comments/messages, removed unrelated/useless
> changes, fixed bugs in rcar_rwm32() calls done to set the bits, removed
> unneeded braces, removed non-informative comment, reworded the patch
> summary/description.]
> 
> Signed-off-by: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

