Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1FEC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 18:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C2921773
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550514986;
	bh=MwDMJNkQK3eNhuitznVAj4lRE7ybP69LWb3swgr03t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vKiaaThVzopfsOtb02oWs9jfDr7zZdftbkio6+SYVkPsITIC5+WCQ/csdqb/QqXzu
	 +imDTym6P8oUws29I/bHs1rAjKFQTax3Mgwe32I4gKs4tAWI5pe8yKn1lMxUDR6coO
	 lytLfSu9pWXz/w6HWOBBCQ0TTMEQAbhkbDXPFMFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfBRSgZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:36:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42231 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBRSgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Feb 2019 13:36:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id i5so29870368oto.9;
        Mon, 18 Feb 2019 10:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=poDN7HGT8OK/Vt8DkQPgztYruhJGUiMQ5O8VO0hsYj0=;
        b=dNVkVIlWhbwDKKg/D7fD3HbjhIoSuDUKkTpWZQ/RcQTlsU/Jbyq/bmX/IjvPZFWJLA
         XvMnVXFPxj8aSTKzbkWN/nr1KHmnp50rlwUEhhcrtLmJVWHTM22mcdgspA1WlAhvHRfH
         0I6OrcZl39K6eb9njXFnvZOcD8QV0r/GJjPU06nyndTAxB2assIn5d32SQo/iGqpo7D4
         tgWJzTjGIlasJHS3ClYF1rPDlSmwkPFKFTM+0YZzu1STFBEW37yNUYolR99hkwUlfJbu
         AYxbuULqFsPIhsrGAIJzBOwgWJeM57ic5Pgd7MjFa+SRlYi8uGxT6PjWjbRp2fRcfMhn
         5TYQ==
X-Gm-Message-State: AHQUAuaKsQrby2htU3m49s+5aeKtKmQkLDDpp8plwS9lDpb5Pfb2oKdW
        OSI76e6mU8S0RT7qwni8Y1rYLMk=
X-Google-Smtp-Source: AHgI3IbOMjaNh20kpvmz3Dyl2nOaxyxYjj9dTllQ2NinWmEgUjywNrc6xTWttHEcmeMoTTZtrJaVXg==
X-Received: by 2002:aca:4747:: with SMTP id u68mr145493oia.38.1550514984056;
        Mon, 18 Feb 2019 10:36:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v20sm5330570oto.31.2019.02.18.10.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 10:36:23 -0800 (PST)
Date:   Mon, 18 Feb 2019 12:36:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Add vendor ID for Microsemi
Message-ID: <20190218183622.GA16980@bogus>
References: <20190215162424.564-1-daire.mcnamara@microchip.com>
 <20190215162424.564-2-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215162424.564-2-daire.mcnamara@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 15, 2019 at 04:24:22PM +0000, Daire McNamara wrote:
> This patch adds a new PCI vendor ID for Microsemi.

A 'PCI vendor ID' is something else.

This patch and file have nothing to do with PCI.

> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8fcc16..d13f6e40dbf4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -238,6 +238,7 @@ micrel	Micrel Inc.
>  microchip	Microchip Technology Inc.
>  microcrystal	Micro Crystal AG
>  micron	Micron Technology Inc.
> +microsemi	Microsemi Corporation
>  mikroe		MikroElektronika d.o.o.
>  minix	MINIX Technology Ltd.
>  miramems	MiraMEMS Sensing Technology Co., Ltd.
> -- 
> 2.17.0
> 
