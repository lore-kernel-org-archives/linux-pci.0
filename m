Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAA9C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 22:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39821218CD
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553119422;
	bh=74KpYV6dfYZDWtfuaUWmLfwBeifkLeo8R5Ykkyriqeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xT5FId8KLDbxknNDkWfPQATXiLauKeAf3eZ4wYDKBpBOPv8TtmUBH2ycQwxY5dfdI
	 fai0nurtFmdvcxqb7dn2TPjH827qRJxR0Ftudq+OsOHEROWL1u5jYJ0fIM5q9Xwn+2
	 clm4tIioTUhOmRbqWecWzItuPS7wnFpEQf+JJVxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfCTWDl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfCTWDl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 18:03:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1718B218AE;
        Wed, 20 Mar 2019 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553119420;
        bh=74KpYV6dfYZDWtfuaUWmLfwBeifkLeo8R5Ykkyriqeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sb5W8cwBdrzvB3VHOdZnBsS5/X+R0cw/9L4srkVCZ9YmUS+ScFOgBKl57hz6kf5xH
         3jOQJT486wwV2PkWhmW38nRwnGwChFMNT6PLR1RJuyjxYptXuuhuoMqo5zdBd5bSJU
         UAEIsMkVqPsjOdJVdN1WdZKDX7J2p5OdACqRIFWA=
Date:   Wed, 20 Mar 2019 17:03:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Jeremy.Linton@arm.com, Grant.Likely@arm.com, Robin.Murphy@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: Add external-facing PCIe port property
Message-ID: <20190320220338.GH251185@google.com>
References: <20190318182124.53859-1-jean-philippe.brucker@arm.com>
 <20190318182124.53859-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318182124.53859-2-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 18, 2019 at 06:21:23PM +0000, Jean-Philippe Brucker wrote:
> Provide a way for the firmware to tell the OS which devices are external
> to the machine and therefore untrusted. The property can describe for
> example thunderbolt and other hot-pluggable ports, which should always
> have the strongest IOMMU protection.

s/thunderbolt/Thunderbolt/

I think the important bit is that the port is user-accessible, whether
it is hot-pluggable or not, right?

I think I'm OK with this from a PCI perspective.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index c77981c5dd18..55cdbc5d2804 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -24,3 +24,50 @@ driver implementation may support the following properties:
>     unsupported link speed, for instance, trying to do training for
>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>     for gen2, and '1' for gen1. Any other values are invalid.
> +
> +PCI-PCI Bridge properties
> +-------------------------
> +
> +Root ports and switch ports may be described explicitly in the device

Maybe "PCIe root ports and switch ports" since pci.txt seems to apply
to both conventional PCI and PCIe?

> +tree, as children of the host bridge node. Even though those devices are
> +discoverable by probing, it might be necessary to describe properties that
> +aren't provided by standard PCIe capabilities.
> +
> +Required properties:
> +
> +- reg:
> +   Identifies the PCI-PCI bridge. As defined in the IEEE Std 1275-1994
> +   document, it is a five-cell address encoded as (phys.hi phys.mid
> +   phys.lo size.hi size.lo). phys.hi should contain the device's BDF as
> +   0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
> +
> +   The bus number is defined by firmware, through the standard bridge
> +   configuration mechanism. If this port is a switch port, then firmware
> +   allocates the bus number and writes it into the Secondary Bus Number
> +   register of the bridge directly above this port. Otherwise, the bus
> +   number of a root port is the first number in the bus-range property,
> +   defaulting to zero.
> +
> +   If firmware leaves the ARI Forwarding Enable bit set in the bridge
> +   above this port, then phys.hi contains the 8-bit function number as
> +   0b00000000 bbbbbbbb ffffffff 00000000. Note that the PCIe specification
> +   recommends that firmware only leaves ARI enabled when it knows that the
> +   OS is ARI-aware.
> +
> +Optional properties:
> +
> +- external-facing:
> +   When present, the port is external facing. All bridges and endpoints
> +   downstream of this port are external to the machine.

Maybe include a note about why this is important, ie, we care because
malicious devices may be attached to an external port?  I know you
have that in the commit log but it would be more visible here.

Elsewhere you use "external-facing", here too for consistency?

> +Example:
> +
> +pcie@10000000 {
> +	compatible = "pci-host-ecam-generic";
> +	...
> +	pcie@0008 {
> +		/* Root port 00:01.0 is external-facing */
> +		reg = <0x00000800 0 0 0 0>;
> +		external-facing;
> +	};
> +};
> -- 
> 2.21.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
