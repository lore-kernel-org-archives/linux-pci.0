Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87333C433EF
	for <linux-pci@archiver.kernel.org>; Mon, 28 Feb 2022 15:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiB1Pw5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiB1Pw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 10:52:57 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07A47ED8A
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 07:52:17 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3479D1C0005;
        Mon, 28 Feb 2022 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646063536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzM6EcJQgoTQRYJZbvxsuySykIyt7y41vKl6pFvHoDA=;
        b=dIX5+Sns/Vt5p7Df7db2TKMQ1mYLWEo2+Lz8NPTAJ98WuwPgcmnqWUhfrx7Lj5WLI6UKqq
        KunnXPxJmnpzZ8R1SBmJzcsM8kYpiX8nzJmdHGQs3pNCQaX91qQVYoLcddm/6sAtUDXF34
        sbMbYVYBYys3lO5iC8ShgTrsrjH3FOi7q6pE2Ry8Sd8/O0N34xwvPuD/EOPEbUkiHISm29
        ELhk9FSvuB8LXxE7lrp2ZG1MToRwTERnxHCMWOVMlL7QNCK+vTqJkXK1c346NGkPQ815SB
        taQUeIpYxFfRKz+sZPLFqQIskCU/Hy6u9i2eZ3NJjXOHGKa2Cq5plv0WIod/Ng==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH 15/18] arm64: dts: marvell: armada-37xx: Add clock to
 PCIe node
In-Reply-To: <20220220193346.23789-16-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-16-kabel@kernel.org>
Date:   Mon, 28 Feb 2022 16:52:14 +0100
Message-ID: <87k0df0z0x.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marek Beh=C3=BAn <kabel@kernel.org> writes:

> The clock binding documents PCIe clock for a long time already. Add
> clock phande into the PCIe node.
>
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>

Applied on mvebu/arm64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-37xx.dtsi
> index 673f4906eef9..c0de8d10e58c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -489,6 +489,7 @@ pcie0: pcie@d0070000 {
>  			bus-range =3D <0x00 0xff>;
>  			interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>  			#interrupt-cells =3D <1>;
> +			clocks =3D <&sb_periph_clk 13>;
>  			msi-parent =3D <&pcie0>;
>  			msi-controller;
>  			/*
> --=20
> 2.34.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
