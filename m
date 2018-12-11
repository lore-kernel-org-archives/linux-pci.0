Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188E8C6783B
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAFE2086D
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 21:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564709;
	bh=D9y9/6MOmnLHU7L3nY2YMfAWPC/s3FxoL4Tsx3rBOqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OzKDSy7yR+wrcP1CCxmb8WqhztUhJ5QBca/Ax8ZPlXpV5KFXI+JMqLbuZ7PYDV+2O
	 M/1/Dr4yQoraePUAGAQreK7FwLrVsLRD6lJwp8zdSAucEqiNn0MWPkcy8mGI1gOod8
	 uMoEnKj+OQeF6z7P9ihGXj66hrIA6YuRu1IfGQts=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAFE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeLKVo6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:44:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41203 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKVo6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 16:44:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so15598510otk.8;
        Tue, 11 Dec 2018 13:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nh/++tBFztfnpJVOC/AWMVD202Om0iilmb3m9BACEZw=;
        b=GX6cpAnCBZ8CT+PGXvRkzQbjFlfNaxAxuPDXpNUwXa4pN+LrqwpQpdRbqeh2I23UmJ
         JTVMrnQ4yrBdSbXCwmI1cNMnjkDpAnBzgbHCJx4DK+AEM+uA3lWroI52vmgOrN58qdXe
         f057p/tlh+ll58wYyDTLpMzY+XuX1qzBKe2WvUVg8LXlqy/pNMsC6jao0IodxVxMu7rN
         hR1HTcAxFFErln2Knb64wuch5v9LR2RcmSyFORmOJfBC6zZru1YsAEBYiHSlYz20d4Tf
         rSgHn4FMyrp0/HuTvczRaNn7oeX3IA0j95NrTwH9Xh78q4I2jZ2OwPWM79veoJu2cOFc
         pe4g==
X-Gm-Message-State: AA+aEWbPz2btQ2i6T0Ljex6a8MLE0llcwv+ZQevwqujH4Ti+ejKiuX7z
        ZvsJ5DifzUQ3fOwfWqI4Qw==
X-Google-Smtp-Source: AFSGD/WtRoQtvwhUSlWxKLYTclL1Yv1bZ69wP4YYExVM+8uUZOFh4UaOPcZZO65DFEGk+KplvhPl1w==
X-Received: by 2002:a9d:282:: with SMTP id 2mr12296543otl.287.1544564697644;
        Tue, 11 Dec 2018 13:44:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c19sm8473015otl.16.2018.12.11.13.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:44:57 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:44:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 08/12] dt-bindings: PCI: aardvark: describe the PHY
 property
Message-ID: <20181211214456.GA31214@bogus>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-9-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123141831.8214-9-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 23 Nov 2018 15:18:27 +0100, Miquel Raynal wrote:
> Document the possibility to reference a PHY.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/pci/aardvark-pci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
