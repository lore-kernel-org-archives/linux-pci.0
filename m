Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE3C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE9D2243E
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 08:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE9D2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeKOSwf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:52:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbeKOSwe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 13:52:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C08D5A144F;
        Thu, 15 Nov 2018 08:45:41 +0000 (UTC)
Received: from [10.36.116.180] (ovpn-116-180.ams2.redhat.com [10.36.116.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68FA8600D6;
        Thu, 15 Nov 2018 08:45:35 +0000 (UTC)
Subject: Re: [PATCH v3 2/7] dt-bindings: virtio: Add virtio-pci-iommu node
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        peter.maydell@linaro.org, joro@8bytes.org, mst@redhat.com,
        jasowang@redhat.com, robh+dt@kernel.org, mark.rutland@arm.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        marc.zyngier@arm.com, robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-3-jean-philippe.brucker@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <0b6a8b92-352d-9508-ec00-655a34e65853@redhat.com>
Date:   Thu, 15 Nov 2018 09:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181012145917.6840-3-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 15 Nov 2018 08:45:42 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 10/12/18 4:59 PM, Jean-Philippe Brucker wrote:
> Some systems implement virtio-iommu as a PCI endpoint. The operating
> systems needs to discover the relationship between IOMMU and masters long
s/systems/system
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
> diff --git a/Documentation/devicetree/bindings/virtio/iommu.txt b/Documentation/devicetree/bindings/virtio/iommu.txt
> new file mode 100644
> index 000000000000..2407fea0651c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/iommu.txt
> @@ -0,0 +1,66 @@
> +* virtio IOMMU PCI device
> +
> +When virtio-iommu uses the PCI transport, its programming interface is
> +discovered dynamically by the PCI probing infrastructure. However the
> +device tree statically describes the relation between IOMMU and DMA
> +masters. Therefore, the PCI root complex that hosts the virtio-iommu
> +contains a child node representing the IOMMU device explicitly.
> +
> +Required properties:
> +
> +- compatible:	Should be "virtio,pci-iommu"
> +- reg:		PCI address of the IOMMU. As defined in the PCI Bus
> +		Binding reference [1], the reg property is a five-cell
> +		address encoded as (phys.hi phys.mid phys.lo size.hi
> +		size.lo). phys.hi should contain the device's BDF as
> +		0b00000000 bbbbbbbb dddddfff 00000000. The other cells
> +		should be zero.
> +- #iommu-cells:	Each platform DMA master managed by the IOMMU is assigned
> +		an endpoint ID, described by the "iommus" property [2].
> +		For virtio-iommu, #iommu-cells must be 1.
> +
> +Notes:
> +
> +- DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
> +  virtio-iommu node doesn't have an "iommus" property, and is omitted from
> +  the iommu-map property of the root complex.
> +
> +Example:
> +
> +pcie@10000000 {
> +	compatible = "pci-host-ecam-generic";
> +	...
> +
> +	/* The IOMMU programming interface uses slot 00:01.0 */
> +	iommu0: iommu@0008 {
> +		compatible = "virtio,pci-iommu";
> +		reg = <0x00000800 0 0 0 0>;
> +		#iommu-cells = <1>;
> +	};
> +
> +	/*
> +	 * The IOMMU manages all functions in this PCI domain except
> +	 * itself. Omit BDF 00:01.0.
> +	 */
> +	iommu-map = <0x0 &iommu0 0x0 0x8>
> +		    <0x9 &iommu0 0x9 0xfff7>;
> +};
> +
> +pcie@20000000 {
> +	compatible = "pci-host-ecam-generic";
> +	...
> +	/*
> +	 * The IOMMU also manages all functions from this domain,
> +	 * with endpoint IDs 0x10000 - 0x1ffff
> +	 */
> +	iommu-map = <0x0 &iommu0 0x10000 0x10000>;
> +};
> +
> +ethernet@fe001000 {
> +	...
> +	/* The IOMMU manages this platform device with endpoint ID 0x20000 */
> +	iommus = <&iommu0 0x20000>;
> +};
> +
> +[1] Documentation/devicetree/bindings/pci/pci.txt
> +[2] Documentation/devicetree/bindings/iommu/iommu.txt
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> 
