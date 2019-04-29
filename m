Return-Path: <SRS0=ph/K=S7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6893DC43219
	for <linux-pci@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371CE20675
	for <linux-pci@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556562837;
	bh=DmWhyTQI0epDsstGE9oh+0gGdXVvX1ngocOon2jM6nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GIuc7F3NUzM7v7VpP8HvLOkYhIpQer1CMpE1sbHTE0T/jISDB0N+BiJNSwwjznL+V
	 fL3WA/xvJGp+6//Fy7mj3ZIHj90vgWDQ222+1qA+UPNMYSTGiPvx0UKVUdOed+F9xx
	 vGIjUxHbD5I3f2wEWkyPeB9Tl/SV2DR9d+g1TVKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfD2Sd4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:33:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36750 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2Sd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Apr 2019 14:33:56 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so9166930oia.3;
        Mon, 29 Apr 2019 11:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJFu8dTPT6iuvNmfV3Wh3Rzk/IF0n/PBhWFcc8TY2TA=;
        b=iLSEjXFzYOBpkGrpQkla7Jz76o0XB/MaqbKFBXx4Fvo/jyRJn1lvsYAM7aFHfsOAEt
         fhINmEkmkSlN7Yj/iMEK7U1v0vLTiW0aQMbsxh0DFCcfpj4aXL91bBlZdYEBSsdkz/EP
         lxMqjUCT+skA6KacCPjvINGPVMB93wTZhJRh2w0rDpFjgWjhAtY7H9QJNgQON2FhWLEi
         xPVByuJT2DuOx3fF8bHHt6fM1zlE69C8G5TLaB4FqCfOzpSMdfJ+1O3/ssddJGUwD8Od
         mf9cKuJ4B7twPg+V4N4cTklZ/vaCB/caionKpEwPt/rmGLWrlXEP81xvU5OmXKPMjs0N
         sVJQ==
X-Gm-Message-State: APjAAAVcxbYSpFUCV2QG4Nj13QQIyglEB62LqcTxzTSq2B1LCvIHC935
        UfAuUHg7DRzVm2bm4o5wXg==
X-Google-Smtp-Source: APXvYqzPIhElNEZuiQQVniG7rQupF2EIia+0z66Gb6MUydRNqzefBooqBOuTphKj7MvrW3USyNhXbA==
X-Received: by 2002:aca:ecd5:: with SMTP id k204mr363249oih.38.1556562835563;
        Mon, 29 Apr 2019 11:33:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j82sm14275095oih.31.2019.04.29.11.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 11:33:54 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:33:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
        mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 28/30] dt-bindings: pci: tegra: Document nvidia,rst-gpio
 optional prop
Message-ID: <20190429183354.GA9331@bogus>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-29-mmaddireddy@nvidia.com>
 <20190415142012.GB29254@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415142012.GB29254@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 04:20:12PM +0200, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:53PM +0530, Manikanta Maddireddy wrote:
> > Document "nvidia,rst-gpio" optional property which supports GPIO based
> > PERST# signal.
> > 
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > index dca8393b86d1..23928fd59538 100644
> > --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > @@ -75,6 +75,8 @@ Optional properties:
> >    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
> >  - nvidia,plat-gpios: A list of platform specific gpios which controls
> >    endpoint's internal regulator or PCIe logic.
> > +- nvidia,rst-gpio: If GPIO is used as PERST# signal instead of available
> > +  SFIO, add this property with phandle to GPIO controller and GPIO number.
> 
> GPIO properties are pretty much standardized, so this should really be
> called just "reset-gpio".

"reset-gpios" actually.

Rob
