Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5CAC10F14
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C324218E2
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013907;
	bh=Tum1w9fXrp9kimeXyVj7hipZFM3gVPW0vat4a5pupU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QBcBk9SHMo8U2E4VnEQZ8bDzKbe//IcafNCk9qbbsGUmcDrXYzGpGnwUkcxoW7NMZ
	 gcCqmIDOMkZCIXZXSWlHAYuDurrDvVeScPJjvdOkfHADW/OmgT6TlQVzDbVsHSrr67
	 K6fh2fFZZ59IOof3RFx9QBDqSuR9NcoN+s+PHcus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDKUSZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfDKUSQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 16:18:16 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D093020850;
        Thu, 11 Apr 2019 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013895;
        bh=Tum1w9fXrp9kimeXyVj7hipZFM3gVPW0vat4a5pupU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0Nu4AiEkpv5tw5Wns+H8DFKfcNZXRmGbICPvgjtptOWUfJ/ellEKo8hGJQiezWpk
         0aiyOhwUJxvHvP+2ulCUMj6HQWgUxig+D5fTL50wLj/uYPskS4UqIqLDKiNd4oimqk
         w1JCSNeVVMO8IFcZ+8QbL6628bb7zLdNYh3/cjYc=
Date:   Thu, 11 Apr 2019 15:18:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 26/30] dt-bindings: pci: tegra: Document
 nvidia,plat-gpios optional prop
Message-ID: <20190411201813.GT256045@google.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-27-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-27-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 10:33:51PM +0530, Manikanta Maddireddy wrote:
> Document "nvidia,plat-gpios" optional property which supports configuring
> of platform specific gpios.

s/gpios/GPIOs/ (also in the description below)

Acronyms in commit logs, comments, printks, etc should be capitalized.

> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index fbbd3bcb3435..dca8393b86d1 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -73,6 +73,8 @@ Optional properties:
>    pinctrl phandle to allow driver to explicitly put PCIe IO in DPD state.
>  - pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable state.
>    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
> +- nvidia,plat-gpios: A list of platform specific gpios which controls
> +  endpoint's internal regulator or PCIe logic.
>  
>  Required properties on Tegra124 and later (deprecated):
>  - phys: Must contain an entry for each entry in phy-names.
> @@ -567,6 +569,7 @@ Board DTS:
>  		pci@2,0 {
>  			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
>  			phy-names = "pcie-0";
> +			nvidia,plat-gpios = <&gpio TEGRA_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
>  			status = "okay";
>  		};
>  	};
> -- 
> 2.17.1
> 
