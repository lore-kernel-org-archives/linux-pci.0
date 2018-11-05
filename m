Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FCAC0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 22:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FAD2085A
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 22:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FAD2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbeKFHjW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:39:22 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36262 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHjW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 02:39:22 -0500
Received: by mail-oi1-f175.google.com with SMTP id r127-v6so8995753oie.3;
        Mon, 05 Nov 2018 14:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6LoVs/lvXd/sw+h/f73B4xZvJb0JTqol5x8Q4JQgo9A=;
        b=rl7vkVSayQGc60SWLMVbYeJv5pe84JVizqNXQgziR/mqbmaPy6u05mJI5go9yGPnLx
         0e/QKLkmlYexPMIy6j29w4w8HVW1USNiDtYM9la6MN/80lKDgXL2tNVVOoi7qnFGy92G
         9hApR4v2eQRwUjy/hO3iFyO3aT6VH4Cr+OgJ1ybJZ8Cg6iTeeT/jo5G5/yXCzcJ7qICF
         DspregWsKyB18RuTvnBSefg2QKIUcKzjXSLMaqu3hLZsNcCT52h3Kx1jW6lHStL69nEF
         ji1HQPAYYirojzW0FbUWlHw7EiE43TZiT3gml7axLO0aaU/Or/hECFVT8jjfl8uzRWD6
         6lhA==
X-Gm-Message-State: AGRZ1gLCWrJHKP+ge7qQWt33P6KgUsePnB66UxUaVZFmL0d3y8no4jLz
        j4znP6Pebv2bprQ2pMLBEQ==
X-Google-Smtp-Source: AJdET5db8FgQZa0KQyf96olLWNhAcBxluU4X4EDgVEnvKg9lHa7KT4GmaopMYVws27hM0brwiY64Cg==
X-Received: by 2002:aca:c41:: with SMTP id i1-v6mr5476786oiy.272.1541456248928;
        Mon, 05 Nov 2018 14:17:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t38sm4809275otf.29.2018.11.05.14.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:17:28 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:17:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv2 3/6] PCI: layerscape: Add the EP mode support
Message-ID: <20181105221727.GA7729@bogus>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
 <20181105084653.26597-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105084653.26597-3-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  5 Nov 2018 16:46:50 +0800, Xiaowei Bao wrote:
> Add the EP mode support.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
