Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE7ECDE42
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 00:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47E221473
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 00:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47E221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJRI3J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:29:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43114 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRI3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Oct 2018 04:29:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id k9so28079646otl.10;
        Wed, 17 Oct 2018 17:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GvIV7r1JTZj7e8ielxd27cka5Niqj3zz57/9NWiX0zY=;
        b=kKA7meG8OBlBBH9vyhkd6dk23MVrYN/WQC9eglAMWaZhkUwEeutFOGs3CHyHlsp1o4
         hzvkRbw4xJmcrrYIdP3t7RLp0ud0PdOWvP5p5BDTH7ok9KR/d7AGV7xcryE12v4mt8Mu
         VjYCJsS5nTFCVT1mQnYeoFVVPxzy82e5Sep8+Vdkg5T12bXCeHQcf+a6yGM9VFgXEqZV
         RuVNn/n2BOmcArPPO+3gyou5avqlNs/Wnek742Iz6UwRLCZD06upA84C33sjM6Ks351p
         O0n4NZUhQaGcBjNuMjd4V+Al/Fg+wnrbk5RTSeJH1HGQxKA+hHgffFml7bNHjrOhwRm7
         dCgA==
X-Gm-Message-State: ABuFfoiZQ6T1Xr/me57EYatWrRTgT/T6IczaipF6HUiOJ84ZWMVavdYr
        IV1OS3MQJ4S42XqY9Ow4Uw==
X-Google-Smtp-Source: ACcGV60tx+D4HIKzG1GdVGxdnWnEYm0pjXk1d0LWmEu4qrvs5YVoVLuWFPucXFxsMwCUhaZhnfDiAQ==
X-Received: by 2002:a9d:48f1:: with SMTP id a46mr19101066otj.84.1539822652866;
        Wed, 17 Oct 2018 17:30:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u17-v6sm5808353oia.43.2018.10.17.17.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 17:30:52 -0700 (PDT)
Date:   Wed, 17 Oct 2018 19:30:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, peter.maydell@linaro.org,
        joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        mark.rutland@arm.com, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 1/7] dt-bindings: virtio-mmio: Add IOMMU description
Message-ID: <20181018003051.GA3400@bogus>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012145917.6840-2-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 12, 2018 at 03:59:11PM +0100, Jean-Philippe Brucker wrote:
> The nature of a virtio-mmio node is discovered by the virtio driver at
> probe time. However the DMA relation between devices must be described
> statically. When a virtio-mmio node is a virtio-iommu device, it needs an
> "#iommu-cells" property as specified by bindings/iommu/iommu.txt.
> 
> Otherwise, the virtio-mmio device may perform DMA through an IOMMU, which
> requires an "iommus" property. Describe these requirements in the
> device-tree bindings documentation.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  .../devicetree/bindings/virtio/mmio.txt       | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)

One nit, otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.txt b/Documentation/devicetree/bindings/virtio/mmio.txt
> index 5069c1b8e193..748595473b36 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.txt
> +++ b/Documentation/devicetree/bindings/virtio/mmio.txt
> @@ -8,10 +8,40 @@ Required properties:
>  - reg:		control registers base address and size including configuration space
>  - interrupts:	interrupt generated by the device
>  
> +Required properties for virtio-iommu:
> +
> +- #iommu-cells:	When the node corresponds to a virtio-iommu device, it is
> +		linked to DMA masters using the "iommus" or "iommu-map"
> +		properties [1][2]. #iommu-cells specifies the size of the
> +		"iommus" property. For virtio-iommu #iommu-cells must be
> +		1, each cell describing a single endpoint ID.
> +
> +Optional properties:
> +
> +- iommus:	If the device accesses memory through an IOMMU, it should
> +		have an "iommus" property [1]. Since virtio-iommu itself
> +		does not access memory through an IOMMU, the "virtio,mmio"
> +		node cannot have both an "#iommu-cells" and an "iommus"
> +		property.
> +
>  Example:
>  
>  	virtio_block@3000 {
>  		compatible = "virtio,mmio";
>  		reg = <0x3000 0x100>;
>  		interrupts = <41>;
> +
> +		/* Device has endpoint ID 23 */
> +		iommus = <&viommu 23>
>  	}
> +
> +	viommu: virtio_iommu@3100 {

iommu@3100

> +		compatible = "virtio,mmio";
> +		reg = <0x3100 0x100>;
> +		interrupts = <42>;
> +
> +		#iommu-cells = <1>
> +	}
> +
> +[1] Documentation/devicetree/bindings/iommu/iommu.txt
> +[2] Documentation/devicetree/bindings/pci/pci-iommu.txt
> -- 
> 2.19.1
> 
