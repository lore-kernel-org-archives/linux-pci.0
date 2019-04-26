Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EC7C43219
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF0E208CA
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556289171;
	bh=9EpVbmKcC7vyQxE7ZKI0ZjPcUeIideqn3OP5ld7ZuGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fkZaimZchzxRSqtnHJP/Om2Z5cdJBet1lcbvkriVDOofEwcVOgpjU7PQlRqZZj5dl
	 tq07d9cf1C9noBDJe0vp/DjGx/b3vSSbMKRkXxaCdwTH4oXTjHyBYHlHzZUOwMu7Ec
	 pX5kbYmva8OCNA2J6Sh5Y/OyD5cBwVkLx3dCeF0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfDZOcu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:32:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43859 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfDZOcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 10:32:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so2782380otq.10;
        Fri, 26 Apr 2019 07:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+Ue7ivIsKOsUkHJC/bMOCYbPJiI1SxZnQrNPVL3T0c=;
        b=Ik+/cVEM9BKkmKD/42XW+n6wh50xDNadZT9HOE6nD7xH7/oxTLSAbil+duWVEOFHZN
         7XUBBqTaoTgNxLHfjXvcGt3M/iput9zJMiUT5QTnFdJ7eTok27bq5t0+Ux3k84NxwiGP
         SleYpE7iEzV0OEo33FBzVeO5B9mLE+an4eDrAgHjQliMWEVwnPn5m9NczjSGD/7sKXvQ
         RkuSSvSeaLW1QEo3LLOU6PPKgsvvbktl7Fb3EV/joc6YvNYvigCOXZrIWgAvmWP1H7x5
         auCmWHXxAabasoZBG4kvqdRvvnvWNeUU1auzABqgGbrK5OGC8Q+iJAKKbnDAeTdlYY6E
         AJPg==
X-Gm-Message-State: APjAAAVPGelfRE2AF2t+aRm2FRhVBHi7P893G5fVRXbTSo93E7RX8ioE
        f09NouTHmsdw/zfuudzIuw==
X-Google-Smtp-Source: APXvYqytPe5YamloN95nKCj651tjxE5HbSJEKdcrI93sHCBrjxavU9cEUunUn3iBB8GW+dIcgvYH/g==
X-Received: by 2002:a9d:7643:: with SMTP id o3mr1393114otl.129.1556289169100;
        Fri, 26 Apr 2019 07:32:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm10565485oia.46.2019.04.26.07.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:32:48 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:32:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 07/16] dt-bindings: PCI: designware: Add binding for
 CDM register check
Message-ID: <20190426143247.GA25107@bogus>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-8-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-8-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 10:49:55AM +0530, Vidya Sagar wrote:
> Add support to enable CDM (Configuration Dependent Module) registers check
> for any data corruption. CDM registers include standard PCIe configuration
> space registers, Port Logic registers and iATU and DMA registers.
> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
> Version 4.90a
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * Changed flag name from 'cdm-check' to 'enable-cdm-check'
> * Added info about Port Logic and DMA registers being part of CDM
> 
> Changes since [v1]:
> * This is a new patch in v2 series
> 
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 5561a1c060d0..85b872c42a9f 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -34,6 +34,11 @@ Optional properties:
>  - clock-names: Must include the following entries:
>  	- "pcie"
>  	- "pcie_bus"
> +- enable-cdm-check: This is a boolean property and if present enables

This needs a vendor prefix.

> +   automatic checking of CDM (Configuration Dependent Module) registers
> +   for data corruption. CDM registers include standard PCIe configuration
> +   space registers, Port Logic registers, DMA and iATU (internal Address
> +   Translation Unit) registers.
>  RC mode:
>  - num-viewport: number of view ports configured in hardware. If a platform
>    does not specify it, the driver assumes 2.
> -- 
> 2.17.1
> 
