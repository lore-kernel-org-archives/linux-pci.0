Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53664C3F6B0
	for <linux-pci@archiver.kernel.org>; Tue,  2 Aug 2022 09:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiHBJ0G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Aug 2022 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiHBJ0F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 05:26:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 321FB1BE8E;
        Tue,  2 Aug 2022 02:26:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D40F139F;
        Tue,  2 Aug 2022 02:26:04 -0700 (PDT)
Received: from [10.57.12.109] (unknown [10.57.12.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C91A3F67D;
        Tue,  2 Aug 2022 02:26:02 -0700 (PDT)
Message-ID: <a673e846-e3d7-63e3-70cd-4adef3f761cc@arm.com>
Date:   Tue, 2 Aug 2022 10:25:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: PCI: host-generic-pci: Allow IOMMU and MSI
 properties
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220728175137.1172841-1-robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220728175137.1172841-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-07-28 18:51, Rob Herring wrote:
> Allow 'iommu-map', 'iommu-map-mask', and 'msi-parent' properties for
> generic host. This fixes unevaluated property warnings on Arm Juno, AMD
> Seattle, and FSL LS1028a.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> index 6bcaa8f2c3cf..d25423aa7167 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> @@ -106,6 +106,9 @@ properties:
>       maxItems: 3
>   
>     dma-coherent: true
> +  iommu-map: true
> +  iommu-map-mask: true
> +  msi-parent: true

Hmm, in general this set looks suspiciously incomplete without msi-map 
and msi-map-mask too. Am I right in thinking that the ideal thing to do 
here would be to convert pci-msi.txt and pci-iommu.txt to schema and 
$ref them?

Robin.

>   
>   required:
>     - compatible
