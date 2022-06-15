Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34407C43334
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jun 2022 19:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiFOTrc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbiFOTrb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 15:47:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA8B13;
        Wed, 15 Jun 2022 12:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F325AB82167;
        Wed, 15 Jun 2022 19:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C35AC34115;
        Wed, 15 Jun 2022 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322447;
        bh=fhjkmvu98WTMSZHsSEG0wh9iy6niaFpMABEpKGwpNUw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Km7Zg+/XdSIIPpCSmvZ9+xIXkKWQFXCWKwcXDYvmfqdWi6nHfCY5PttRXt50ujOR7
         da6fQcRNRumKj8G8SKpuabXvTIOteVL+7wfvFH/aLaLm1vrFnKTVtwiIJIUPWBYbGz
         KGKBZnUwmH1WcoDA9NBA4hdmG12Hs9AmDkcSYtVV35AepOSS1p4osLBd6AZx+hzSgl
         sTBBqeZ6rZ14tm0HulhwAm9uLuypdthwNL7ct7cr+A/KuX7/yysY/jQtuwwrQCr+Sh
         c1yCn5QcIspBzzGJkLyINMmMwZd7C4RMEzpe86h9KmZYrqg4r4MYZKj/6nPqM/SH2j
         6jzLaE9u+s3Hw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220608105238.2973600-3-dmitry.baryshkov@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org> <20220608105238.2973600-3-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v11 2/5] clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
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
Date:   Wed, 15 Jun 2022 12:47:25 -0700
User-Agent: alot/0.10
Message-Id: <20220615194727.6C35AC34115@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Dmitry Baryshkov (2022-06-08 03:52:35)
> Use newly defined clk_regmap_phy_mux_ops for PCIe pipe clocks to let
> the clock framework automatically park the clock when the clock is
> switched off and restore the parent when the clock is switched on.
>=20
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
