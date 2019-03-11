Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E26C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F97214AE
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 22:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552342305;
	bh=E7OTK+px8krR9btwgcCl0dbnCUpJpsP8Ti6z67a+6TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=evhLPZ3d7zHAMKpbEozKuaCcAF3vZKpqpqj9cJeKXHoVs8XPtOLe4yBhE3lyNtf+Q
	 UDtOin4UT/xweZuDizvzDUdzdYOvs32JS7HI87p/MWrBIWdu1MJJSbAu6vG+gNsIyT
	 Cb0FiM9XLDcF1R57cSFYzATaugkiP4KqQBYT9ec4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCKWLo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:11:44 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45321 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKWLo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2019 18:11:44 -0400
Received: by mail-oi1-f169.google.com with SMTP id t82so398211oie.12;
        Mon, 11 Mar 2019 15:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g06LVNrauuE7R0vBYjIxqyjCq9bGfxPwPfA/mrG1JoE=;
        b=GtXDZZf9v7vKOn7puApcK6WtIwghwLy3IPzrFPyhDlwT43WrYw3Be6klDuTtRyNonz
         UX1P05xPufFIdoQTE9+mHKn+llTHPZ2aGv59wgV+UUCMVUVqeBW+i2LY9xYUHpvdn7tc
         NQb4pyclK9K2jgFK7xztYhu2ngvt1JEIJySLF0zeCfXMUVReatZypbTDi8ZplqDNk3bs
         d3llJr9CCqqskfY6rP39ZgYH4mSlB3WRGF0oGruGLZkZvDOdqWoC4yjthoSlDCLEIQQj
         3GGSIWXtDxZiW8cnCZ/Gniqo71IZEYxTWoNrqjg9tCsrIysIWwTy2UE4sNPwEKHbXjD4
         xkZw==
X-Gm-Message-State: APjAAAW2tUYMz87oqFQt1UKp9dVZePiwypemRxG2aFtAG3tl6mzP5GIT
        BIxRs/pAIw0dY8OPxbwqWA==
X-Google-Smtp-Source: APXvYqwmg4vPliIWjL7Oy5QLxWpagMFe+8+2H/SV8s+yfCpHhuSmz/3HPuKkj7nC0WarejWgcaYXjA==
X-Received: by 2002:aca:aad1:: with SMTP id t200mr302251oie.70.1552342303221;
        Mon, 11 Mar 2019 15:11:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l63sm2787290oig.46.2019.03.11.15.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:11:42 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:11:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCHv4 23/28] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4  controller
Message-ID: <20190311221142.GA11898@bogus>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-24-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093130.7209-24-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Mar 2019 09:33:05 +0000, "Z.q. Hou" wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V4:
>  - no change
> 
>  .../bindings/pci/layerscape-pci-gen4.txt      | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
