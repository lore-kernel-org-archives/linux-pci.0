Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0354FC6783B
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 21:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD9720879
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 21:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564688;
	bh=G9m7ZnsUOUcvgkNn1ty8aRvY43XQq2TFmUz5gCVBXzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oe3R2EMuTMw0dygJvy1+SBvhlA231ye4QD2X+SjpHrys1ud1pzhMKNDhhP9D2TREM
	 Hh6G1pjuhEFYPPeqANj7cmfSxpA1/iFIXRtQmSRIydZmk8F+BUl4vn7c9bX+njvl59
	 bs6qr5X4QQc5Irtw13l2y3IRXsMr3770aROJ4Vho=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD9720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLKVos (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:44:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38425 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKVor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 16:44:47 -0500
Received: by mail-oi1-f193.google.com with SMTP id a77so13320480oii.5;
        Tue, 11 Dec 2018 13:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9EAWa1IC7qMF4Th+r9/Z//SfIrnlUcSsuJ4gReQCrg=;
        b=bAckhk6Zp2OVkvfhl52mrBu+OfH1NXGDHumYgrVi3qUC9IJ744OKnZ2jBK72tpqZop
         VmLg53da5eYSYoGTuMEQwvGSwmRaTvxSCDHtn6h7OxwMfDrWyg1i5lKGB6JFcnWJANaM
         qLEVyl3hO+9lhcj1vNVSQHV/JmdDnVMxjW+PYSyo8HgMWqSRZTaczG1ytfTHE6aZuZnS
         qMwzkQZ8kMct8g0DAnC9xy+ruKkBwO77SFV1dB9CT9r68ICL4g5My30WONiFcYfSs/qc
         kwK440u63jLxIKFUEh/FZdyTC9A05M27zzdcZWR/dPV/nt6aQppkzVvP7Xz3m7q8+yZt
         iU8w==
X-Gm-Message-State: AA+aEWY9s4IfOKFOukTNGmAvZmwP08kU26U1kBEG57Vh2pfVv0bYuoum
        tE8M8JDIJWgkXR1acLWrrnHcLE8=
X-Google-Smtp-Source: AFSGD/UQFWfU1+x0TLFTIcWSuYESGa08TLRfjF45GGRlXNpbcpQ2JeZNjccZAa/FzkD8DzfsY3Z0aA==
X-Received: by 2002:aca:dd57:: with SMTP id u84mr2354970oig.216.1544564686974;
        Tue, 11 Dec 2018 13:44:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d66sm7788086oia.29.2018.12.11.13.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:44:46 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:44:46 -0600
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
Subject: Re: [PATCH 07/12] dt-bindings: PCI: aardvark: describe the clocks
 property
Message-ID: <20181211214446.GA30791@bogus>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123141831.8214-8-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 23 Nov 2018 15:18:26 +0100, Miquel Raynal wrote:
> Describe the missing gated clock feeding the PCIe IP.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/pci/aardvark-pci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
