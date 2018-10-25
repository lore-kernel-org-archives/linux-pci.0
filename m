Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EF5C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A717820856
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 21:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A717820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJZG0D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:26:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44081 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJZG0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Oct 2018 02:26:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so10622788otf.11;
        Thu, 25 Oct 2018 14:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZwKgJArtSQGJzQGac02Ty7W2q3dUJmqtTOZNHZ+IfA=;
        b=nqitiSCN6nSVuWRNALZRLUrUGw3IAJyZR/V7iMw6KnaOU4SKkDCEoZPo7LpTSAES4D
         MG0tEFYWmNWLNOBf86+z7sFpdCwKyA177gYLoykHoQI/UjMTRaogzxQAj38g+d/MZgS5
         c3w/YIGefuVyrzSM8rk7SwaIRQJLQVSOs4kDFzFa1o+Yfz6rEpHMnDNP6US2gNeONUHp
         zEG+FTtRzqxUUQUC5xMyFrWYz3Lc0+D+gBB3zZmvMYRG2lwTASQnBLQSqUetm1XZ9vdg
         sT9trsulenhcNrcxLbFU/LE4Sz8gAsUCropUJuDdJ9bt+WqgmdRiop43amLGTf0AgFlV
         wX9g==
X-Gm-Message-State: AGRZ1gIoxbH0qoKKLn6FPRuM5OK1YAEP+Ls/XCnaHR0JB5AioIRqDRVR
        F/AMmJZKTIP1nKsvJbS1Qg==
X-Google-Smtp-Source: AJdET5cAjpIihb+Y2pTJQh0jZWdWi6flrtcw8qo11P5lCz19fYVHpi3yN62OpLjXJe1A44AZ18Q0fg==
X-Received: by 2002:a9d:758f:: with SMTP id s15mr579528otk.353.1540504298656;
        Thu, 25 Oct 2018 14:51:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w199-v6sm252591oiw.7.2018.10.25.14.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:51:37 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:51:37 -0500
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
Subject: Re: [PATCH v2 2/4] dt-bindings: pci: layerscape-pci: removed
 compatible  string "snps,dw-pcie"
Message-ID: <20181025215137.GA14643@bogus>
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
 <20181025094929.29481-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025094929.29481-3-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Oct 2018 09:49:39 +0000, "Z.q. Hou" wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Removed the compatible string "snps,dw-pcie", it is for the reference
> platform driver for PCI RC IP Protoyping Kits based on the ARC SDP,
> so it is not suitable for all platform with designware PCIe controller,
> and platform vendors have themselves' drivers.
> 
> The compatible string "snsp,dw-pcie" was added by mistake and it's not
> matched that time, but it is matched because PCIe drivers has been
> collected recently.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Improved the subject.
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
