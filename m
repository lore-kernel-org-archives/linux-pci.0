Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0861DC43612
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 06:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACA32183F
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 06:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="dEhNdTE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfAHGKd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:10:33 -0500
Received: from ni.piap.pl ([195.187.100.4]:37078 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfAHGKd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 01:10:33 -0500
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id DCE36443165;
        Tue,  8 Jan 2019 07:10:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl DCE36443165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1546927827; bh=uoBagCH+67tI29OPEiGnuMlwv6BRBdtEVv6doUPb5EQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dEhNdTE2jQe1w9Hv85tUFBouQ+B1wLxesQH7EEqlybYz2fTdE+Vp/H7Abl0Y7ux9W
         m93IEy1pO854zX51E3s60PUWFeTH85lDjrXI1nQM7XdyPd4LHemIcbbxW7ftxQJjb8
         LUc5XZqaYQsBql21RnTu6Zsg7vH4y7mbonQG8SCc=
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tim Harvey <tharvey@gateworks.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm: cns3xxx: use actual size reads for PCIe
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
        <20190107134510.32494-2-koen.vandeputte@ncentric.com>
Date:   Tue, 08 Jan 2019 07:10:26 +0100
In-Reply-To: <20190107134510.32494-2-koen.vandeputte@ncentric.com> (Koen
        Vandeputte's message of "Mon, 7 Jan 2019 14:45:10 +0100")
Message-ID: <m37efffzn1.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 133775 [Jan 08 2019]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 232 232 27ac0ce265d8cfe64c397d431e1d2387c92c9415, {Tracking_DKIM, one}, {Tracking_marketers, sender}, {Tracking_ sender_matches_from}, {Tracking_subj_double_letters}, {Tracking_weird_subj_double_letters}, {Tracking_text_let_digits}, Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2018/12/29 09:49:57
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, bases: 2019/01/08 00:26:00 #9315795
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Koen Vandeputte <koen.vandeputte@ncentric.com> writes:

> commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> reimplemented cns3xxx_pci_read_config() using pci_generic_config_read32(),
> which preserved the property of only doing 32-bit reads.
>
> It also replaced cns3xxx_pci_write_config() with pci_generic_config_write(),
> so it changed writes from always being 32 bits to being the actual size,
> which works just fine.
>
> Due to:
> - The documentation does not mention that only 32 bit access is allowed.
> - Writes are already executed using the actual size
> - Extensive testing shows that 8b, 16b and 32b reads work as intended
>
> It makes perfectly sense to also swap 32 bit reading in favor of actual size.

Acked-by: Krzysztof Halasa <khalasa@piap.pl>

> --- a/arch/arm/mach-cns3xxx/pcie.c
> +++ b/arch/arm/mach-cns3xxx/pcie.c
> @@ -93,7 +93,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
>  	u32 mask = (0x1ull << (size * 8)) - 1;
>  	int shift = (where % 4) * 8;
>  
> -	ret = pci_generic_config_read32(bus, devfn, where, size, val);
> +	ret = pci_generic_config_read(bus, devfn, where, size, val);
>  
>  	if (ret == PCIBIOS_SUCCESSFUL && !bus->number && !devfn &&
>  	    (where & 0xffc) == PCI_CLASS_REVISION)

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
