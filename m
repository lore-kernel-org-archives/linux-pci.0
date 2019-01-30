Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0EC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84732087F
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548876261;
	bh=sgTHidybVzN2pa2WK0R7PtQJqzx1uIjcOw/HxdS2gxI=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=n/EPXLw44OH8RuVI3tPpYW1CZgfR0irHLozBNi4k38cGF18TpBoN9jwOUh3xbsB19
	 L8W/RFmjTW4k6iYjrQ5WtZifj4RHUJQQTIVsYOhkVkrKNc2OcZxwuDYPzCL0C9T4z6
	 HlOIvMyyypJifoOufTyqpzr3IHOQvIyzd3IG/IPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbfA3TYQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387606AbfA3TYP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 14:24:15 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4E62086C;
        Wed, 30 Jan 2019 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548876254;
        bh=sgTHidybVzN2pa2WK0R7PtQJqzx1uIjcOw/HxdS2gxI=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=AJCXgUXBC4yGLvne2Xilu1IbFiDIgzmQtypDt2WvBQQawSNUfhb1dtzAYJXTt46Gs
         A4uDnPxaFSAo9IgDvEGb1ANKVaG+C4q6xravPSpy+LDXPIBB8AnnHYckwVLpuacbwq
         GUdBx2X32eiQH9q5dJ04Xo6/MC8jJr2YG6Oa4lSQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/7] arm64: dts: qcom: qcs404: Add PCIe related nodes
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154887625299.169292.6293540451460425008@swboyd.mtv.corp.google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20190125234509.26419-1-bjorn.andersson@linaro.org> <20190125234509.26419-8-bjorn.andersson@linaro.org>
User-Agent: alot/0.8
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20190125234509.26419-8-bjorn.andersson@linaro.org>
Date:   Wed, 30 Jan 2019 11:24:12 -0800
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Bjorn Andersson (2019-01-25 15:45:09)
> @@ -771,6 +788,56 @@
>                                 status =3D "disabled";
>                         };
>                 };
> +
> +               pcie: pci@10000000 {
> +                       compatible =3D "qcom,pcie-qcs404", "snps,dw-pcie";
> +                       reg =3D  <0x10000000 0xf1d

Nitpick: Can you format these like <0x10000000 0xf1d>, <0x10000f20 0xa8>, e=
tc?

> +                               0x10000f20 0xa8
> +                               0x07780000 0x2000
> +                               0x10001000 0x2000>;
> +                       reg-names =3D "dbi", "elbi", "parf", "config";
> +                       device_type =3D "pci";
> +                       linux,pci-domain =3D <0>;
> +                       bus-range =3D <0x00 0xff>;
> +                       num-lanes =3D <1>;
> +                       #address-cells =3D <3>;
> +                       #size-cells =3D <2>;
> +
> +                       ranges =3D <0x81000000 0 0          0x10003000 0 =
0x00010000   /* I/O */

Same for this one? It's nice to know what the size of the cells are.

> +                                 0x82000000 0 0x10013000 0x10013000 0 0x=
007ed000>; /* memory */
> +
