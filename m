Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8ADC46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 21:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9912075D
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 21:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9912075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeJZGZX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:25:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40280 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJZGZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Oct 2018 02:25:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so8036206oib.7;
        Thu, 25 Oct 2018 14:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nCINmxiQQbBxZkbJ+QlI+5E66OxlpYKnuEt7u50apuk=;
        b=Pwl4uY0NMEy9Y79dWg38b3DZuh2xyTdTw+l5a2I4nqb1X2aEH/Kmr7G/jnkzvzRKxD
         DllV2mlPtULgqw6f+6Jw/EVWppnh6cpAiPKualznsuPxmRflUQzwq0joIt8O1b9fRhc0
         fj42IDYmS4Fn5VWjZMZ1hOikjVu5QW9/j5KnrrooWyst9+q4EMXHeDq8xP6xjurOBIyk
         vdttfhPSNN8QpgkSa4dby8LliDsmbM2o8VXYDQZkMeKGLRCXHttV0AErwauENgmfL7PG
         MzzQkTh69F+kwhPwgOHGpcFAw9xBBcm/acH9/Rc+0tuXCqeGXxp42HVS9Mu7ylmtgNm6
         goxg==
X-Gm-Message-State: AGRZ1gJeDo/x9mysEd3f87fl/jDLR9ggo/8QnaBQYysnFVCTzRBIUP2S
        ntxXTX96LBs6gJ6GK+P8uA==
X-Google-Smtp-Source: AJdET5e7jx1rMj1nKaZajzz9OMZ1RWbzOs14243xYXnseaPG1nOmQwRG0Cta36mxG8YIomgCBI8qxQ==
X-Received: by 2002:aca:ce47:: with SMTP id e68-v6mr615674oig.83.1540504258484;
        Thu, 25 Oct 2018 14:50:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 111sm4889121otf.51.2018.10.25.14.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:50:57 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:50:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pci: layerscape-pci: add compatible
  strings "fsl,ls1043a-pcie"
Message-ID: <20181025215056.GA13567@bogus>
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
 <20181025094929.29481-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025094929.29481-2-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Oct 2018 09:49:34 +0000, "Z.q. Hou" wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The PCIe compatible string for LS1043A was lost, so add it.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Improved the subject and corrected 'PCIe' casing.
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
