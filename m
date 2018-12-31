Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A06C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC9D21783
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 10:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="VrdEK9Zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeLaKVD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:21:03 -0500
Received: from ni.piap.pl ([195.187.100.4]:55222 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbeLaKVD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 05:21:03 -0500
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2018 05:21:02 EST
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id B393C441E7B;
        Mon, 31 Dec 2018 11:14:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl B393C441E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1546251269; bh=oaSulQfLn7M4vvjRGvwagR4ybyDPMiU/KyQKj4HcQKo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VrdEK9ZnuOALJGGa52nPww9jPoxujWFz76m9Ezp9lTyTx4A1Tc35mecROioCYAKWK
         yybSHrY21v1rJ34EJE1rGKC1gPUamEj1vdyq90PvowObLkmlQBGU0HBsNmScK0TIJf
         6K2gnsJfI9v9vCK/AW4GBYo4mIpqjqIxO7IdHd/w=
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Koen Vandeputte <koen.vandeputte@ncentric.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
        Robin Leblon <robin.leblon@ncentric.com>,
        Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after alignment
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
        <20181230010625.GC159477@google.com>
Date:   Mon, 31 Dec 2018 11:14:28 +0100
In-Reply-To: <20181230010625.GC159477@google.com> (Bjorn Helgaas's message of
        "Sat, 29 Dec 2018 19:06:26 -0600")
Message-ID: <m336qegfzv.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 133560 [Dec 31 2018]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 232 232 27ac0ce265d8cfe64c397d431e1d2387c92c9415, {Tracking_DKIM, one}, {Tracking_marketers, sender}, {Tracking_ sender_matches_from}, {Tracking_subj_double_letters}, {Tracking_weird_subj_double_letters}, {Tracking_text_let_digits}, Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2018/12/29 09:49:57
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, bases: 2018/12/31 06:10:00 #9277396
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Bjorn Helgaas <helgaas@kernel.org> writes:

> 802b7c06adc7 replaced cns3xxx_pci_write_config(), which always used
> __raw_writel() so it only did 32-bit accesses, with
> pci_generic_config_write(), which uses writeb/writew/writel()
> depending on the size.
>
> 802b7c06adc7 also converted cns3xxx_pci_read_config() from always
> using __raw_readl() (a 32-bit access) to using
> pci_generic_config_read32(), which also always does a 32-bit access.
>
> This makes me think the cnx3xxx hardware is only capable of 32-bit
> accesses, and this patch should change the driver to use
> pci_generic_config_write32() instead of pci_generic_config_write() in
> addition to the mapping fix above.

Hasn't it already been verified that the CNS3xxx can do 8-bit accesses
(and probably 16-bit ones as well), and that the docs don't mention any
such limitation?

> I don't think hardware that only supports 32-bit PCI writes can be
> quite spec-compliant (see the comments in
> pci_generic_config_write32()).  So (1) you may see an additional
> dmesg warning when you convert to use it, and (2) it's possible that
> there may still be instability related to the corruption caused by
> using a 32-bit write when an 8-bit write was intended.

Right. I think IDE/SATA controllers are affected, for example.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
