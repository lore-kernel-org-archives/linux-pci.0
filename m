Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8535ECCA473
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jun 2022 19:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347544AbiFOTus (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiFOTur (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 15:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2841D2DA81;
        Wed, 15 Jun 2022 12:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BB07612E7;
        Wed, 15 Jun 2022 19:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE07FC34115;
        Wed, 15 Jun 2022 19:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322645;
        bh=S8OMVV+dp9vJSmxm2h1rvzz1y9K5rRJtUnP2k5pzVOw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=poQjSCa7tOxpyX5uQDU/w5OeGkUigTlDAimZno9fRk8HCm5JXFNvlcP+SfgoWEkFr
         x3pVpJ3FvWyhKBebGbJDABG+/AwbUqx/KZMNng2XHYFQFFKSYOlFPJNBTDOc4FRHa4
         693fYd2F+PRaSJRuFj8NRy87FQxHsiTMdcXO4waa/CM3OyLYtQpWMSKo9ddepRz+G6
         s7AIskmNpGizECgIP+py+GLvWUm+EnIlqIERkOfQUr2WnsVXHtsFBtYHdSjtrVErDx
         IWAXsUCqUHsRIY3m57hTosFkwMdAkZJWwDXR9v+Br3TLA/V0Lh8/nBsiP5r28TDwAt
         DbKwyxFXj6R4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220608105238.2973600-5-dmitry.baryshkov@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org> <20220608105238.2973600-5-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v11 4/5] PCI: qcom: Remove unnecessary pipe_clk handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 15 Jun 2022 12:50:44 -0700
User-Agent: alot/0.10
Message-Id: <20220615195045.DE07FC34115@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Dmitry Baryshkov (2022-06-08 03:52:37)
> PCIe PHY drivers (both QMP and PCIe2) already do clk_prepare_enable() /
> clk_prepare_disable() pipe_clk. Remove extra calls to enable/disable
> this clock from the PCIe driver, so that the PHY driver can manage the
> clock on its own.
>=20
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
