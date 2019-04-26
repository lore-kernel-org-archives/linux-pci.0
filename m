Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2127C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 15:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CB6208CB
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556293522;
	bh=/WIF5ZsOAHRvnXvFaRIh8SPxwDKNHT15GaB4L4qzTMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1y+S6GhXnomYILrel4yj/4V0tpgST/ASt2Q/5pOdDIQhio1nLb6MxSIyX2zFILVau
	 ZP2rROPYQenXiLMh+wmLhL8+UjkmhMvx3qTTziZEPWxdfjmsNF4lORRG0LtgewOXfi
	 2bkFsRnWNMXvFno9aM0UUR8jcdvtssJKnXspn3b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDZPpV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:45:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37684 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfDZPpV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 11:45:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id r20so1894933otg.4;
        Fri, 26 Apr 2019 08:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNTtEvqJlRv85tDYzGzLiqv1W7Qq1L++Q9HTzcYFWas=;
        b=YFIGJMegua31zthlWraeSdaBdZaN/02jIq/mQ4ikamPjFC51ade/csm61Yfo9ort7W
         Y79v9IGjgfEQiJeBuI650Pp6JuNszSOictQJcJwAhnn49k/PfM3SWgIq1C0TGCONSQh/
         hwAYpz7l5oJO3VJEMpKbn9pa1TdBcZBECiKaYJ59mgDw/q69LoWnxm3uGEE5ANHwyrLn
         oJ0HkSM9unT0pv0xkDBGZgmtm+IbzjwMeGTtyzUJo7AafQxFFSOPFMg6gI/JsrSCG7Kr
         Nj4KIt9H/NKMZbJrkXquM+Vpu+NT8LOSAEpob2pAT8J7OZXTBZCUW1bTvN8EYzDr/PBt
         1XOQ==
X-Gm-Message-State: APjAAAWZ1NPaqytmrDPvhm1aT/To/D6Wguofz2V14qQZqlHUwOZd7nNP
        tHlZgMhNFg6wr3nZ2z9NIQ==
X-Google-Smtp-Source: APXvYqyCQ+DYlEX56dmy2H5QMZOm1oDfwASMFMM2tkO7QWRhHh28uNpJzEJ8wq9qkHjZomKtAnI9SQ==
X-Received: by 2002:a9d:7ad9:: with SMTP id m25mr28870711otn.75.1556293520461;
        Fri, 26 Apr 2019 08:45:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a34sm11760507otc.46.2019.04.26.08.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:45:19 -0700 (PDT)
Date:   Fri, 26 Apr 2019 10:45:19 -0500
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
Subject: Re: [PATCH V5 11/16] dt-bindings: PHY: P2U: Add Tegra 194 P2U block
Message-ID: <20190426154519.GA19329@bogus>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-12-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-12-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 10:49:59AM +0530, Vidya Sagar wrote:
> Add support for Tegra194 P2U (PIPE to UPHY) module block which is a glue
> module instantiated one for each PCIe lane between Synopsys Designware core
> based PCIe IP and Universal PHY block.

Missing Sob.

> ---
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * Changed node label to reflect new format that includes either 'hsio' or
>   'nvhs' in its name to reflect which UPHY brick they belong to
> 
> Changes since [v1]:
> * This is a new patch in v2 series
> 
>  .../bindings/phy/phy-tegra194-p2u.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> new file mode 100644
> index 000000000000..8b543cba483b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> @@ -0,0 +1,28 @@
> +NVIDIA Tegra194 P2U binding
> +
> +Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
> +Speed) each interfacing with 12 and 8 P2U instances respectively.
> +A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
> +interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
> +lane.
> +
> +Required properties:
> +- compatible: For Tegra19x, must contain "nvidia,tegra194-p2u".
> +- reg: Should be the physical address space and length of respective each P2U
> +       instance.
> +- reg-names: Must include the entry "ctl".

-names is pointless when there is only 1.

> +
> +Required properties for PHY port node:
> +- #phy-cells: Defined by generic PHY bindings.  Must be 0.
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> +
> +Example:
> +
> +p2u_hsio_0: p2u@3e10000 {

phy@...

> +	compatible = "nvidia,tegra194-p2u";
> +	reg = <0x03e10000 0x10000>;
> +	reg-names = "ctl";
> +
> +	#phy-cells = <0>;
> +};
> -- 
> 2.17.1
> 
