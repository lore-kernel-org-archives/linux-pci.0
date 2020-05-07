Return-Path: <SRS0=kFL5=6V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31DBC54E49
	for <linux-pci@archiver.kernel.org>; Thu,  7 May 2020 21:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C9C215A4
	for <linux-pci@archiver.kernel.org>; Thu,  7 May 2020 21:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588885527;
	bh=83PrL5s+hTnt+kmPDJQ+oyNs/Tji4/M4/BIN15DDJHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dO3vR5b02r7nwKhA5aBnBhqskmOecuHX0M+pmIyfhhbsaS7QmxQ1+dJYEwlPOfxNB
	 2ihjna2FFrnCic3J1wZv4ZDyTYHsHnnC12BnGba4qbyTdAqV9ICFoO4SGkvLYFZLgt
	 hUIBDyEWYM+pwugw2PC50anfv4kKCLPTIYusoMTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgEGVF1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 May 2020 17:05:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41966 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:05:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so5777838otp.8;
        Thu, 07 May 2020 14:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GIj6kxDR7LGNuMotCOajJTwyR96cZe3Qpni2Sj/PoIY=;
        b=l1447p3gnOCNtkWw6U2Vu+6hvNC9desFaXzPss625l+w/mM/gaJJR0VUkUAot79vs9
         8bbiBzoN0YgBySrbZS73PgupapeMyPJkn6WcDva4qohpguygt2oZ3hy9NDiE2aIC2Jzu
         Z3KBZzE4fD8lYrnGDmOLpB3+UwnG9UAZHRUXWdKb/LkLLqoPuH7ctouNg6hO25OfqO59
         I9VEn9m8wZesTn5tePjyRaVe7A78AzV1nfxKCm47zBlZvjPDGactrktURIA+BdgfBeaX
         ygzr/3toYJSm0IChVGL+gvr89CJ3QS8m6E6aeBA9eT3x5FPnjkG8UqnVgG/XQbnENEIM
         qGEQ==
X-Gm-Message-State: AGi0PuanioIEmGB/tzVX9Bba9EU5+0KvMkL5Ia7xO1vW0fi/7SJ2WLJB
        3/Xbw4KZLqUknOVzLlinG/Uf774=
X-Google-Smtp-Source: APiQypJdtsPrvNlnN0TthkAX/I+9RMU6sL0lnI0AMoufaSaLCpUUL+uGICO4QBCt32XId2EnXg1yQw==
X-Received: by 2002:a05:6830:1592:: with SMTP id i18mr12868544otr.190.1588885525673;
        Thu, 07 May 2020 14:05:25 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e13sm1619297otj.46.2020.05.07.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:05:24 -0700 (PDT)
Received: (nullmailer pid 23601 invoked by uid 1000);
        Thu, 07 May 2020 21:05:23 -0000
Date:   Thu, 7 May 2020 16:05:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/12] PCI: aardvark: Train link immediately after
 enabling training
Message-ID: <20200507210523.GA23539@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-2-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 10:06:14 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> Adding even 100ms (PCI_PM_D3COLD_WAIT) delay between enabling link
> training and starting link training causes detection issues with some
> buggy cards (such as Compex WLE900VX).
> 
> Move the code which enables link training immediately before the one
> which starts link traning.
> 
> This fixes detection issues of Compex WLE900VX card on Turris MOX after
> cold boot.
> 
> Fixes: f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready...")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
