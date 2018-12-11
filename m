Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A8C67839
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 21:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF572086D
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564676;
	bh=OGfE9wJUkhsRMDFl6rjfKN0rjVgOdVm+pcKJzvPhA1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1zfsaJSWjwTpJ86PAcjJrZkd/5THi/Y65aI6Yjt5d36nQSxFG0IIIBn8boUARq5nX
	 Xa3Cjf0771x2v2PmLWzvd6zzbMLp+5gHQEngeWECQGWncXJmH2eiHCZZZVZy2fcYzj
	 tMGIeV5RJNMVurcGCus4SimGsTVml+N2V8064bCQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF572086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLKVof (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:44:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47008 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKVoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 16:44:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so15564211otm.13;
        Tue, 11 Dec 2018 13:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SxewEjABoL2XL2a2ZAoCry0dufPCPnX8qdtg/EJq7Bo=;
        b=dirIX0mJhGFaatC54ofWSqy8n5xwWIvE/uagYQNoSrKIK+J0HaDnFDrf5eLTAxkfU0
         i67QetnPdUZxere1ziiwGHHR9H+A74guiXBT8PpdouBlSLmm3bIwBPzEqotWBq9zaWin
         Ow+7Tb4uGtF9c4VkdUZn6HUWlPaB7AESZlrlS2yG1KTy7XcjQeDss9vHhmF7T0IQyLjk
         HK1XGsf8TlsK8KFcrX7FnWqncTTspzGaGXjEW4W3DDRwG0S54pVV/hIwMNTetLXLwXz6
         LBQgFa73vFphhnHEQvukjo/4zEC5vTJxQ8eCaLFTVWDUTDer9R3Wphhc5CVFfSmoKhyz
         6MQw==
X-Gm-Message-State: AA+aEWZAJ3RkfduxNnllgqchl/Tmo4OfJmD4BBiCS+B41k7Si4q8LzgF
        +6J53LNWO0Wet1Ng8nYhdg==
X-Google-Smtp-Source: AFSGD/VBCjXFYmCrK2wzcW/UGw3/9X3g0VcnojV8THfikCQvw0ngBqBtCoyVrnWbWrkiRwEYS7QZGA==
X-Received: by 2002:a9d:23e5:: with SMTP id t92mr12917058otb.159.1544564673901;
        Tue, 11 Dec 2018 13:44:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s186sm7272392oif.0.2018.12.11.13.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:44:33 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:44:32 -0600
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
Subject: Re: [PATCH 06/12] dt-bindings: PCI: aardvark: describe the
 reset-gpios property
Message-ID: <20181211214432.GA30246@bogus>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123141831.8214-7-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 23 Nov 2018 15:18:25 +0100, Miquel Raynal wrote:
> A GPIO might be used to reset the PCI IP. Describe the property needed
> in this case.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/pci/aardvark-pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
