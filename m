Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C5C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 20:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F04D20866
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 20:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547583215;
	bh=bhKayzoGjHTJ9hqSbj9+qhLbvY2UwG5eCI4XQ0yXlN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tuqAAFnkvgEOgMURoZyoaXPk1xAiI93sEY/8RH215AT4hVqTuHKTsJOl2v7OgyTma
	 2cwzwJySjI0EbWr4N3JfPLKE/nAsI2pLEEdHWsWHBJn+1nxmGOUFWuLXDXmFrgOp7t
	 qEj2VeiQMRJ9H1aUmEFUzVPHiYScC3qhaUrqj5Oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfAOUN3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:13:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41154 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfAOUN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jan 2019 15:13:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so3728346otk.8;
        Tue, 15 Jan 2019 12:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ntKjFpByjGj36qZvDhl/OOUnSo1d4VZ4QJeEdynsDEY=;
        b=TXgvp/d4Lz7NtxughA3VVP+2w6hbuvSO7w+qNI35NX1o88Z0hBwvZanCVF1JsD98Wq
         iFO5uNb/YR4N8dkXMjQXFd7Y9LqI3DZdQCvGwYZXBPc6Oc0zPsqlOK6fIrnDoobRiVyL
         B1D0XZx01hUy8mVJwWtQGJ7PjrXb5WcpqLnnMCT79yATnl/3i37ASJWp1NGrfsFaslEu
         xRpK+zRAgNvSwR2CnQ8kxkvVETvmuZN3uD1mrS8c+StszTe6GYOtTBL+0nk9A8WPl32C
         Ox5K8ut98kKk0TIPL0L+/96SLqa1E4PgDSpemBbJdb1aLP+NbqXbgkHg4oWjpdDlGhr7
         vSVA==
X-Gm-Message-State: AJcUukd6V9BbT0BOiDo5jsvwiXE0a4AaH3qEcR5UnUWA4X48994DUTSe
        maUxKHEN5ZtHs+chjZwdTA==
X-Google-Smtp-Source: ALg8bN7t3Lz/eQkN7CMD4yoZQfY2i1duDgD5LmYSYmSakPfABj157uRkN4uPI64Eg9VbMp8XK2PFSA==
X-Received: by 2002:a05:6830:140e:: with SMTP id v14mr3502286otp.10.1547583208512;
        Tue, 15 Jan 2019 12:13:28 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id y2sm1715646oto.49.2019.01.15.12.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:13:27 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:13:26 -0600
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
Subject: Re: [PATCH v3 10/15] dt-bindings: PCI: aardvark: Describe the PCIe
 endpoint card reset pins
Message-ID: <20190115201326.GA2362@bogus>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
 <20190108162441.5278-11-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108162441.5278-11-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  8 Jan 2019 17:24:35 +0100, Miquel Raynal wrote:
> A line might be used by the PCIe IP to reset the endpoint card upon:
>   - platform reset,
>   - hot reset,
>   - link failure.
> 
> Describe the properties needed in this case (optional).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/pci/aardvark-pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
