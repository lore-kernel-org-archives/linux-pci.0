Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55016 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeDIK41 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 06:56:27 -0400
Date: Mon, 9 Apr 2018 12:56:23 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/4] pcie-rcar: remove PHYRDY polling from
 rcar_pcie_hw_init_h1()
Message-ID: <20180409105622.cl2joe6yoaozlvpz@verge.net.au>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
 <5322b1c2-109d-bd0c-7785-697ca6a5324a@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5322b1c2-109d-bd0c-7785-697ca6a5324a@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 06, 2018 at 02:04:52PM +0300, Sergei Shtylyov wrote:
> Now that we've added PCIEPHYSR.PHYRDY polling to rcar_pcie_hw_init(),
> there is no need anymore  for polling the PHY specific register in
> rcar_pcie_hw_init_h1() -- remove it.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This looks good, but has it been tested?
