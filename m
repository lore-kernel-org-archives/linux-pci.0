Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E0C0015E
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jun 2023 17:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjFWRma (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFWRm1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 13:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861451FDF;
        Fri, 23 Jun 2023 10:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A27A61AEF;
        Fri, 23 Jun 2023 17:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06578C433CD;
        Fri, 23 Jun 2023 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687542145;
        bh=B+ile9UQYyNQVSV2ovecEJKbv71x2PzA3Mu7PzfgpNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V3n+dW/7W+8e4ky/y2CyPQlPjv86avWhWcfjxymBA4Y+zefycJKi8ZcW3Y4UdCeDd
         ecCGXt5OXv7xbAB2gFl4x15UlnXyZc7d65neHutk/85HFFdSo+PS1Lo6PB53sRFxBP
         xiWSzo6wQ58H3gdEAxcIRxnTAuKcwgJGSmNmWy85pdv+5qBxweplEJc3T0tw4UYfjC
         474rwzv8sdgGpqCsDussCzD4t1h39VW749/8df2hG14suPM2epAAy+wlHB3/rbie1h
         FzKyo28RbTcpg2kD+y7/dzqUOjxloaopxsE4ZVy5svZ8OCnX1vNyVT0C9KkR38tRSO
         kS4iSHMz7h+dQ==
Date:   Fri, 23 Jun 2023 12:42:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        mani@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] pcie: qcom: Fix the macro
 PARF_SLV_ADDR_SPACE_SIZE_2_3_3
Message-ID: <20230623174221.GA180338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623093445.3977772-2-quic_srichara@quicinc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 23, 2023 at 03:04:42PM +0530, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro used for IPQ8074
> pcie slave addr size was initially set to 0x358, but
> was wrongly changed to 0x168 as a part of
> 'PCI: qcom: Sort and group registers and bitfield definitions'
> Fixing it back to right value here.
> 
> Without this pcie bring up on IPQ8074 is broken now.
> 
> Fixes: 769e49d87b15 ("PCI: qcom: Sort and group registers and bitfield definitions")

769e49d87b15 appeared in v6.4-rc1, so ideally this would get merged
before v6.4 releases on Monday.  I can try to do that, given an ack
from Manivannan.

> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 4ab30892f6ef..59823beed13f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -43,7 +43,7 @@
>  #define PARF_PHY_REFCLK				0x4c
>  #define PARF_CONFIG_BITS			0x50
>  #define PARF_DBI_BASE_ADDR			0x168
> -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
> +#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x358 /* Register offset specific to IP ver 2.3.3 */
>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> -- 
> 2.34.1
> 
