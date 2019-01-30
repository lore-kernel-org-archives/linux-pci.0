Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CBEC282D8
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4362086C
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548876273;
	bh=XPVPo44kmgYh760mUfV5dbzwfHHU2Q1Kd8idPbOIDiY=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=EujcP0IuLagifXCq9n6ziv8wUGiaFR3w59wIX7z8BQHvJWmLuEwiOzDG/xPi+379R
	 zxWGDC/gXVV6dMYofBp4+bii5QMZWtV17OxoFv4HI2w5obWcIVdIw1OtqBHtq4SFQp
	 rRGXsQmxAz1ISeYGNck4ZIXTDehm75ovn5InZQ1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfA3TY2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387509AbfA3TY1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 14:24:27 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9892086C;
        Wed, 30 Jan 2019 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548876267;
        bh=XPVPo44kmgYh760mUfV5dbzwfHHU2Q1Kd8idPbOIDiY=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=GDXq6IoiQG6vsoMMp9WN1Zgl9GIUC3LuAyvW9M1iVoG2xnXNedrVLgET+ahdJl6Le
         wABzR8PqWlIN3IfqZAHpV2Kca6PGsDDmULfAWdpHvJqiIuqvdiO5H+JIZ067FiDCbT
         yZh/3srOq8b8DaViyxOqWoTNLvy3l5aiK+3d9ftw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/7] clk: gcc-qcs404: Add PCIe resets
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154887626650.169292.5794894680187564157@swboyd.mtv.corp.google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20190125234509.26419-1-bjorn.andersson@linaro.org> <20190125234509.26419-2-bjorn.andersson@linaro.org>
User-Agent: alot/0.8
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20190125234509.26419-2-bjorn.andersson@linaro.org>
Date:   Wed, 30 Jan 2019 11:24:26 -0800
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Bjorn Andersson (2019-01-25 15:45:03)
> Enabling PCIe requires several of the PCIe related resets from GCC, so
> add them all.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

