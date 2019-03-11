Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55391C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 17:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2748D2075C
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552325688;
	bh=UWtPlmQaR7sliraYATCPtyacTIPkYHDDo6g3z7Ae5y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vGfiryiC+1ZErY1kHPciiqkdVnq7V5SfYkNVXX8jmCdpoPByPmqLaJOK9BGBaPGIf
	 68kMhEKDN/vhim7/IkCH6DmsQhibxbFGuEsj3UsRLsJe1MIbbNfi/b3svPQzFNrKXh
	 F0PGv+2U+WS8qrtWShUFYynJ/AQTuv4k+szaHJkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCKRem (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfCKRem (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 13:34:42 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F112063F;
        Mon, 11 Mar 2019 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552325680;
        bh=UWtPlmQaR7sliraYATCPtyacTIPkYHDDo6g3z7Ae5y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDzdVQQHeJh7nwyApH4FA64nn5k9aF9+stPGjn8AyPvjxGV8jp9MZ7VL5osRVHEDS
         5rr3RH9T/8SfxM0GVpSftsYLJLxJBFBl1xe5f3KE6+V51yk9cu0kSpt0GDqeclwXAI
         39kz/lOBNnGemQHSaHY0CgGPNmvUgNfaAFM1D+Dw=
Date:   Mon, 11 Mar 2019 12:34:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv4 26/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Message-ID: <20190311173439.GH214730@google.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-27-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093130.7209-27-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 09:33:32AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> When LX2 PCIe controller is sending multiple split completions and
> ACK latency expires indicating that ACK should be send at priority.
> But because of large number of split completions and FC update DLLP,
> the controller does not give priority to ACK transmission. This
> results into ACK latency timer timeout error at the link partner and
> the pending TLPs are replayed by the link partner again.
> 
> Workaround:
> 1. Reduce the ACK latency timeout value to a very small value.
> 2. Restrict the number of completions from the LX2 PCIe controller
>    to 1, by changing the Max Read Request Size (MRRS) of link partner
>    to the same value as Max Packet size (MPS).
> 
> This patch implemented part 1, the part 2 can be set by kernel parameter
> 'pci=pcie_bus_perf'

If I understand correctly, you're saying that LX2160A Rev1.0 will only
work correctly if you have this patch applied AND you boot with
"pci=pcie_bus_perf".

That might be OK if these rev 1.0 parts are only used in the lab and
are never shipped to customers.  But if these parts are ever shipped
to customers, I don't think it's acceptable for them to have to figure
out that they must boot with "pci=pcie_bus_perf".  Yes, you can
document that in release notes, but it's still a poor user experience,
and users will forget, and they will see mysterious hard-to-debug
issues.

Maybe there's a way for you to automatically set that pcie_bus_perf
mode?  With a dmesg note to indicate that you're overriding any mode
the user may have selected?

> This ERRATA is only for LX2160A Rev1.0, and it will be fixed
> in Rev2.0.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V4:
>  - no change
> 
>  .../pci/controller/mobiveil/pci-layerscape-gen4.c | 15 +++++++++++++++
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h   |  4 ++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> index d2c5dbbd5e3c..20ce146788ca 100644
> --- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> +++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> @@ -82,12 +82,27 @@ static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pcie)
>  	return header_type == PCI_HEADER_TYPE_BRIDGE;
>  }
>  
> +static void workaround_A011451(struct ls_pcie_g4 *pcie)
> +{
> +	struct mobiveil_pcie *mv_pci = pcie->pci;
> +	u32 val;
> +
> +	/* Set ACK latency timeout */
> +	val = csr_readl(mv_pci, GPEX_ACK_REPLAY_TO);
> +	val &= ~(ACK_LAT_TO_VAL_MASK << ACK_LAT_TO_VAL_SHIFT);
> +	val |= (4 << ACK_LAT_TO_VAL_SHIFT);
> +	csr_writel(mv_pci, val, GPEX_ACK_REPLAY_TO);
> +}
> +
>  static int ls_pcie_g4_host_init(struct mobiveil_pcie *pci)
>  {
>  	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
>  
>  	pcie->rev = csr_readb(pci, PCI_REVISION_ID);
>  
> +	if (pcie->rev == REV_1_0)
> +		workaround_A011451(pcie);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index ab43de5e4b2b..f0e2e4ae09b5 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -85,6 +85,10 @@
>  #define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
>  #define PAB_INTP_AXI_PIO_CLASS		0x474
>  
> +#define GPEX_ACK_REPLAY_TO		0x438
> +#define  ACK_LAT_TO_VAL_MASK		0x1fff
> +#define  ACK_LAT_TO_VAL_SHIFT		0
> +
>  #define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
>  #define  AMAP_CTRL_EN_SHIFT		0
>  #define  AMAP_CTRL_TYPE_SHIFT		1
> -- 
> 2.17.1
> 
