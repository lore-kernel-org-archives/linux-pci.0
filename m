Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29FC433EF
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jun 2022 19:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347869AbiFOTtv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347544AbiFOTtu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 15:49:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87002C643;
        Wed, 15 Jun 2022 12:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77611B82170;
        Wed, 15 Jun 2022 19:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCEDC34115;
        Wed, 15 Jun 2022 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322587;
        bh=rBvzEyolOcujqmm0/x2BC51cRXjwZnn6X3EE5PL0Byo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GpWgqXuRvrHquUqtFwlCMlFOspj1bu0kMVKk1bgdSYbHMkZ9bj6c4qnC4tiIcBDpW
         6w/ORqxcC1qmIQ5XoNXGDwc7E9aooEpBp1j03eMnOIUbFcWdge2iKls2S0dvZVgSO9
         08boRDgmG9NmAgRgLj0CXViXAuvERG+ELDZ39W8nZ92vxZMcI5M3pHWkY+cPAgQshJ
         sfUFbnImPBew91wWT1yX79T3B+S4IGoVzQR6UZQ8M9ji9qPOGjxTvEVbyfjKAN+Ett
         fj+Rp1oOTsnvl/+ulSdLgSnkWCUVOA1OX3LaFsCD7AkMwG98+Pf3cwDyVwA7JraX/s
         tsAX9ura2FrkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220608105238.2973600-4-dmitry.baryshkov@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org> <20220608105238.2973600-4-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v11 3/5] clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 15 Jun 2022 12:49:44 -0700
User-Agent: alot/0.10
Message-Id: <20220615194946.EBCEDC34115@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Dmitry Baryshkov (2022-06-08 03:52:36)
> Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
>=20
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
