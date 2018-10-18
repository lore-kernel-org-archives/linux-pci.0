Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DAEECDE42
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C2121470
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 00:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C2121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeJRIdU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:33:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35567 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIdU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Oct 2018 04:33:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id 14so24102365oth.2;
        Wed, 17 Oct 2018 17:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nz3hAE2Cd8JYS0cawRUMHWX4NpLviQZKFQrJmZ+uETc=;
        b=BobcqkoLEoiaqTk9e4Cbmtu43jdd/HCyzkvjsh+elDdEOvtO0eBEhMqIgdqk+Vq6jo
         C7OQDzD1s6LxIVAM6Y07PmbY2ppvu6HiYJczBpahIXZXtSggt0mmELosiZxf4uBr8c/y
         Bk3dUrVSK/r4XBROcmzJkEhEwX1jAdJf6wuOTsLCKJlEvD15C08rt2BUhFEdS4XIxLaq
         5eksUaGoEKv5AVJKqfrn7JxD+m/qbiq79jOjr+Mw1nbrYnVjHz2JvpiIELP5TKAi6eDY
         dLR7aPLxMHYD216DoNoZ21alXAB8q8sqWmEHKkCQAV9XuPXuO47NSk4OX+h7oveb09ah
         A4jQ==
X-Gm-Message-State: ABuFfogLbwDfN18MS5ol4/HFtbE1+BZmlJ05wcexOgMSZ74mNxn0h+rU
        g45/hsov8d9lwS9bTBT8Kw==
X-Google-Smtp-Source: ACcGV62HHvWNrj+eRsDtIRNmoYBZebJEsLxMWQGNPDfFR9FTDKcHDk9W95NKqRTzAtEmrg3PVUmvVw==
X-Received: by 2002:a9d:3644:: with SMTP id w62mr14184538otb.23.1539822903823;
        Wed, 17 Oct 2018 17:35:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u123-v6sm6704825oie.22.2018.10.17.17.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 17:35:03 -0700 (PDT)
Date:   Wed, 17 Oct 2018 19:35:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, peter.maydell@linaro.org,
        joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        robh+dt@kernel.org, mark.rutland@arm.com, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 2/7] dt-bindings: virtio: Add virtio-pci-iommu node
Message-ID: <20181018003502.GA28260@bogus>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-3-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012145917.6840-3-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 12 Oct 2018 15:59:12 +0100, Jean-Philippe Brucker wrote:
> Some systems implement virtio-iommu as a PCI endpoint. The operating
> systems needs to discover the relationship between IOMMU and masters long
> before the PCI endpoint gets probed. Add a PCI child node to describe the
> virtio-iommu device.
> 
> The virtio-pci-iommu is conceptually split between a PCI programming
> interface and a translation component on the parent bus. The latter
> doesn't have a node in the device tree. The virtio-pci-iommu node
> describes both, by linking the PCI endpoint to "iommus" property of DMA
> master nodes and to "iommu-map" properties of bus nodes.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  .../devicetree/bindings/virtio/iommu.txt      | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
