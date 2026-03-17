Received: from mail-m32108.qiye.163.com (mail-m32108.qiye.163.com [220.197.32.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952911E5702;
	Tue, 17 Mar 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728903; cv=none; b=UZXcFYT/TlvGzbSv6lQcP3bwV858kypYj49H9HbBVBzBVbqGpx6hL2rjh+a4h13BunfOSDMuzBA2/M5ZBHI5c5tOa14KzKCTBPc5zB/+ZPtYzic4Dt7nu2jjrdDhDlbw31d7N6uyK1vrYKogigIO9jAhzkWJ1pFRdy4sBcBsYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728903; c=relaxed/simple;
	bh=PYddBAsBQOM0kNK5jK6z9Sy3R3gz+pDgGt04JYeSnyg=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fLPg+kNEtf019Obxu7ASMW92MulLe3g/QPpgECvApI7nIdSTPdpBAWIW8IEywsOnYbZGU75eiSAtQ3T3/Oz2iY/2ZPDEvKc77+LXNmGP/fGRlecZmbFGYCO6xpNUnzfSdzNJaCCH0bBkgOgmCY3w6WLinOBgQy43WAmrxNp1YBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VKPwMCcF; arc=none smtp.client-ip=220.197.32.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VKPwMCcF"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3738dcfdd;
	Tue, 17 Mar 2026 14:22:59 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: bt1: Use common dw_pcie_ltssm enum for LTSSM states
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org
References: <20260315154015.126074-1-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <8bc47270-6d08-ae71-ac8b-c9d17044ff9c@rock-chips.com>
Date: Tue, 17 Mar 2026 14:22:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260315154015.126074-1-18255117159@163.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cfa763e7909cckunm1e0109bd475720
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xKSlYdSkofGhlKThgaSU9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VKPwMCcFILWyO8Gs3j4W7rbUB/AmMmHt85pmnClXoyCi4eq4xfy/CjSWMmpSgiC7rzoDC42/HelWCOICuapMVOxsfkuYlYUZXwJFdjGR48oxJpddPx2n1QCEHbAerLFlSC8T4oyrtXtwoepj0x6HBKwhB6qmxB9IgXWJqXGhEP8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Uv2Uk6mj8RLYjeEtIg6ikqjqLxPBqnAo6T0DStgjIzU=;
	h=date:mime-version:subject:message-id:from;

Hi Hans,

在 2026/03/15 星期日 23:40, Hans Zhang 写道:
> Use the generic dw_pcie_ltssm enum from pcie-designware.h instead of
> defining private LTSSM state macros. This eliminates duplication and
> aligns the driver with common DesignWare core d

No, this driver's removed due to the sanction policy in this community..

efinitions.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/controller/dwc/pcie-bt1.c | 38 +--------------------------
>   1 file changed, 1 insertion(+), 37 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> index 1340edc18d12..429fab073bba 100644
> --- a/drivers/pci/controller/dwc/pcie-bt1.c
> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> @@ -41,42 +41,6 @@
>   
>   #define BT1_CCU_PCIE_PMSC			0x148
>   #define BT1_CCU_PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
> -#define BT1_CCU_PCIE_LTSSM_DET_QUIET		0x00
> -#define BT1_CCU_PCIE_LTSSM_DET_ACT		0x01
> -#define BT1_CCU_PCIE_LTSSM_POLL_ACT		0x02
> -#define BT1_CCU_PCIE_LTSSM_POLL_COMP		0x03
> -#define BT1_CCU_PCIE_LTSSM_POLL_CONF		0x04
> -#define BT1_CCU_PCIE_LTSSM_PRE_DET_QUIET	0x05
> -#define BT1_CCU_PCIE_LTSSM_DET_WAIT		0x06
> -#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_START	0x07
> -#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_ACEPT	0x08
> -#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_WAIT	0x09
> -#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_ACEPT	0x0a
> -#define BT1_CCU_PCIE_LTSSM_CFG_COMPLETE		0x0b
> -#define BT1_CCU_PCIE_LTSSM_CFG_IDLE		0x0c
> -#define BT1_CCU_PCIE_LTSSM_RCVR_LOCK		0x0d
> -#define BT1_CCU_PCIE_LTSSM_RCVR_SPEED		0x0e
> -#define BT1_CCU_PCIE_LTSSM_RCVR_RCVRCFG		0x0f
> -#define BT1_CCU_PCIE_LTSSM_RCVR_IDLE		0x10
> -#define BT1_CCU_PCIE_LTSSM_L0			0x11
> -#define BT1_CCU_PCIE_LTSSM_L0S			0x12
> -#define BT1_CCU_PCIE_LTSSM_L123_SEND_IDLE	0x13
> -#define BT1_CCU_PCIE_LTSSM_L1_IDLE		0x14
> -#define BT1_CCU_PCIE_LTSSM_L2_IDLE		0x15
> -#define BT1_CCU_PCIE_LTSSM_L2_WAKE		0x16
> -#define BT1_CCU_PCIE_LTSSM_DIS_ENTRY		0x17
> -#define BT1_CCU_PCIE_LTSSM_DIS_IDLE		0x18
> -#define BT1_CCU_PCIE_LTSSM_DISABLE		0x19
> -#define BT1_CCU_PCIE_LTSSM_LPBK_ENTRY		0x1a
> -#define BT1_CCU_PCIE_LTSSM_LPBK_ACTIVE		0x1b
> -#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT		0x1c
> -#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT_TOUT	0x1d
> -#define BT1_CCU_PCIE_LTSSM_HOT_RST_ENTRY	0x1e
> -#define BT1_CCU_PCIE_LTSSM_HOT_RST		0x1f
> -#define BT1_CCU_PCIE_LTSSM_RCVR_EQ0		0x20
> -#define BT1_CCU_PCIE_LTSSM_RCVR_EQ1		0x21
> -#define BT1_CCU_PCIE_LTSSM_RCVR_EQ2		0x22
> -#define BT1_CCU_PCIE_LTSSM_RCVR_EQ3		0x23
>   #define BT1_CCU_PCIE_SMLH_LINKUP		BIT(6)
>   #define BT1_CCU_PCIE_RDLH_LINKUP		BIT(7)
>   #define BT1_CCU_PCIE_PM_LINKSTATE_L0S		BIT(8)
> @@ -108,7 +72,7 @@
>   #define BT1_CCU_PCIE_LTSSM_LINKUP(_pmsc) \
>   ({ \
>   	int __state = FIELD_GET(BT1_CCU_PCIE_LTSSM_STATE_MASK, _pmsc); \
> -	__state >= BT1_CCU_PCIE_LTSSM_L0 && __state <= BT1_CCU_PCIE_LTSSM_L2_WAKE; \
> +	__state >= DW_PCIE_LTSSM_L0 && __state <= DW_PCIE_LTSSM_L2_WAKE; \
>   })
>   
>   /* Baikal-T1 PCIe specific control registers */
> 
> base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
> 
