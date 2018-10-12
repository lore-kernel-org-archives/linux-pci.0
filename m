Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974CEC6787C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 22:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5756B21470
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 22:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5756B21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeJMFoN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Oct 2018 01:44:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45007 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeJMFoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Oct 2018 01:44:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id p23so13749090otf.11;
        Fri, 12 Oct 2018 15:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WLm9FYOOsLn0taoemsu7VctajAaPqo6OOhciaoA1+6w=;
        b=FFdFbiWPR0KjQM06KETZ2KHAlvfTcKcUbNUeX0TCyg8nOeJf6HbUIhKQKztTHgXG0E
         YnwwkAxMoDWK0/+klLYg4d8Emu1p1Hqs+Tyeo42vSkfFNk/MtYn8DPkJ4u723vnNUuRF
         mC/rd6MTvICFlPtjhpvctLIkJOgIDp/p1VKUk483VzQmVOVXey82UcUuS1S+L63gMUUU
         1tdLK1oIhRpudvTqp/kWm335QeaI5zExRHyPG6AnZPppICTIO4J4l/zDJfRZeiabMXpW
         ghfGk0rC2TL8WxzkKP/OF+equr58dSLiNJ+HdFQ088ReD1V6oa5rFpKhKBW/BX4XS+VV
         7fxA==
X-Gm-Message-State: ABuFfoinTaRja5HdMjGF6JhClQH0M7IKoLRcYHY7VgiwhXM3q/4k8b7g
        JQ4kck13nXFcCV054acSiw==
X-Google-Smtp-Source: ACcGV62WNV4UZ8jmFbBYtVyFCK+ux1/K7FQA9fP3nNMKfNbEcxCSj/y3gKbnB7rUeIjPJfBXWMiEdg==
X-Received: by 2002:a9d:524b:: with SMTP id q11mr4588726otg.129.1539382183541;
        Fri, 12 Oct 2018 15:09:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 107sm761436oth.20.2018.10.12.15.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 15:09:42 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:09:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: imx6q-pcie: Add multi-pd bindings
 for  imx6sx
Message-ID: <20181012220941.GA13742@bogus>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <fb622df91d2e4aa339e8831fb8bcde03327f5bda.1539020938.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb622df91d2e4aa339e8831fb8bcde03327f5bda.1539020938.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 8 Oct 2018 18:06:20 +0000, Leonard Crestez wrote:
> The PCIE and PCIE_PHY blocks are in different power domains on imx6sx
> and this needs to be described using multi-pd bindings.
> 
> This was not required until now because the power-domain of the PCIE
> block (DISPLAY) was always on.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
