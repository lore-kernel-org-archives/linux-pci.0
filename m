Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55081 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeDILAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 07:00:23 -0400
Date: Mon, 9 Apr 2018 13:00:19 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/4] pcie-rcar: add R-Car gen3 PHY support
Message-ID: <20180409110019.72enypppkcalfv5y@verge.net.au>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
 <d8dde257-814f-142c-d58b-91eaf78a7d10@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d8dde257-814f-142c-d58b-91eaf78a7d10@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 06, 2018 at 02:08:12PM +0300, Sergei Shtylyov wrote:
> On R-Car gen3 SoCs the PCIe PHY has its own register region -- and I have
> written  a generic PHY driver for it, thus we need to add the corresponding
> code in  rcar_pcie_hw_init_gen3() and call devm_phy_optional_get() at the
> driver's probing time,  so that the existing R-Car gen3 device trees (not
> having a PHY node) would still work (we only need  to power up the PHY on
> R-Car V3H).
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
