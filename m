Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B235E948
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019590; cv=none; b=Nv8XVbJfwwAz5p2URYI/QrU7gANkVtt8bCq6ggBYIdVXV6Do/46alPK7oYHX7Sn+dZO+sQhmdjMxnnUGUG33Sk4zRz6TKKzhe6HQv9QWV9LWAX7aABLqbJ/UTnAhaii+uh35/T23UZZc0/tuI59Ir4t3bC5Iblrp1+ghDrn5qtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019590; c=relaxed/simple;
	bh=uSgg3LG3bjAiL3uHLzQfA8IDBj034IWdbEN6Jy0FfTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhVBTcwDnw+e8Cie9OpHaZFhGl6cX4VMvSqr+BinLl5Bp3LtBPKWAEK3N61EdSzQY4D2n23W3aVuykPOA4dRLp9J19zc1HeGYo2HEfhPzdhHNzKi4kWy11rOVLDtf2ogwv4C/mWNg81jXa7thMHvOdL92tha4XK4TL97witSJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GMV4kVbk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iYTCgltL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GMV4kVbk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iYTCgltL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GqeA810318
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 05:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bOYTxfTEYThEP4K6HnEj0mMj/pEzMsl1qxdgBX/+fyI=; b=GMV4kVbkwDCVwSak
	a6qI/SfZWdO6N9cik+YmMsU3dxSOfRp8JGoESlrrlYw3Febq8OCqn59PfkxqbemH
	41noYa2VJfwevNL/neAnljPcKwMOm3PC26zWooO7NIuBh5oDbdlHfgfEJllfin/D
	/9zhETevl4VpJoRjDXd79Ju8/9qYlh+6RA/kPfUJqEYdWYAMJzrP8r1N3OSBLlTn
	bgakghGLf1wGsmjEQofhuZDh6VhLQy+WmpF95zOBZRHONK/BIPn2Zr15dWE17WeF
	rkAUumyCTrjOc8yCZUZylt0lMFKhIniN5yNaWjLnyY7auPq4UOiG5iIQlvhCQB95
	C7oEvw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydj9h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 05:53:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc487bd6bfbso4113285a12.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 22:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789019585; x=1789624385; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bOYTxfTEYThEP4K6HnEj0mMj/pEzMsl1qxdgBX/+fyI=;
        b=iYTCgltLRCk+P1A0KGRY6giKtCsSgxSoNl2Ltcg5woVobBR/AoLrfH69UXYn9J9CmB
         2j/rNFAyRXne/p8GizE2NsCKFxW3oj4u7GWJCHdIxdNcponK1UtijyE+linGI9g2EcqA
         ylGzfOMNtczdijbq36Ns8CElNLg9CxHEtBwslkJrMibLzFIi/vXn/RBzo/TRFLr5l4v7
         c0NPBbHDMfciOCWBHozMWrc5CGCAPFygjVEAyB8Ng26WOyWxeAdYLydhDmoClcHaygSg
         MfoDrB3I9VmULJuYf6IMRBTdkrif//v9uLvk0LSpUscYsCxA05+O5YIXlpPkPuL49b9h
         FCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789019585; x=1789624385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bOYTxfTEYThEP4K6HnEj0mMj/pEzMsl1qxdgBX/+fyI=;
        b=IJKpt3gDSAV3lyRaktKBHzC0veZsAdUsChd/ftLOwZAg56zOI9WxEynqW70f2cKMXn
         oPNETkWeOxfSgQF3KMboFbWP041+QH7pCbNKcH2wgh459JpnVtZHkI3uK5iRMovssuvw
         kdfR1D56gax8M2sFV9hzQo1u97H19TX0hFyDBR0mlwKDr6ZfVmJDmJEktRs6LQI47aVm
         53tfvtNLpkx+8M5D1GJYjubdsXewPDy/HM3GexbjfiI6vUYRnqmt8ZwBb8RJpum4Fhqf
         jTQwetSuKlzcQyPzGUXRksXEIt+y0E3n+H28CHckT5CV4AKvKjgSvhL9QrUKqbPDJstQ
         3OqA==
X-Forwarded-Encrypted: i=1; AKwUvBwtVRcaHHfDYUFHOMw1U811FMRQofgWeX2hMweMn5wpPfvP9moCVCmo2Ni8myb/IXwtJvubNHGMEqc=@vger.kernel.org
X-Gm-Message-State: AFuF++k2dnVY+GGoZ4e/HoBqu5X5rAMTNleFGnX4vP/glrvFXYkzYSLA
	HpbYvHzos1WSvHGstEgbn/TB05o0N7N74kLL6U9RcGKYqlys27HP1aMxT3XvoDnTogaBGyPx299
	S+6zKzNSdvWGRWWfpln+94sdq4nSFixdn2jgwClrl8Hwdl22goZ8rV2c+Qjz14J4=
X-Gm-Gg: AYBFou0FDR4/RLesi/jTgXA0pGZ2fHo2PnLi117YZi34HJmCKChk2itwBANG153nNtq
	YQO91fZSVNa+j8ERGiF5nv17cx+byq5OXeryBuVH8Ldyqr7Q02nsL0Mc9ggpbhu11wS22iM/OiD
	lgmL5MaSI4DHOwbuoM0rAuewZXPCDXlQupkG7OTZSlIvoFmMB1u0qgfbMPDQbEhnJI2c3ZuvmhN
	iMZqPHtvxsdWH5b1YNRifMkPS3THm3LpmbrfsYDC6eGe4s5S1QB+FSiG5t8tPGF87QyIttbN+rj
	JyqdVPQuA+DFbxmgU0wIPvmMGeVph6gMRIyMsJWhDEumBSIPkafGl3FKSRPGPefEDq1DNp6SUW+
	4dupg2s07oA/vJr5QYy5hjOuD/W7dSrxfL8tsGxsCgTU=
X-Received: by 2002:a17:90b:2ccf:b0:398:a2a3:b631 with SMTP id 98e67ed59e1d1-39b262aaf3dmr62207926a91.19.1789019583650;
        Wed, 09 Sep 2026 22:53:03 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccf:b0:398:a2a3:b631 with SMTP id 98e67ed59e1d1-39b262aaf3dmr62207818a91.19.1789019582620;
        Wed, 09 Sep 2026 22:53:02 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm46173924c88.8.2026.09.09.22.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 22:53:02 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:52:54 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/5] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
Message-ID: <aqJFo3beKde404qd@QCOM-aGQu4IUr3Y>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-5-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-nord-v3-5-b0a82721c547@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA2MCBTYWx0ZWRfX9qyNAd1quRCF
 7nsx9WH8GMF3rwoisBeFCjGQkfH6C8TBQlEIagUJ5VGj9VuP/eZd0r9aga2WmHOJ7altzWqaoHq
 e4vc9g6r615aVD0L4xxHaiPvL69Lazs=
X-Authority-Analysis: v=2.4 cv=UJNIjyfy c=1 sm=1 tr=0 ts=6aa245c1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=u6tm73RZwhgVXX8U8_sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: jc3-hxbF5El-zT-RoXOv1yUDpmsm4uqe
X-Proofpoint-ORIG-GUID: jc3-hxbF5El-zT-RoXOv1yUDpmsm4uqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA2MCBTYWx0ZWRfXytilybCA3Gzc
 ufktH3Hm9LJL0rr69wpUHNzpwIpMzOhKMlYpWnwO1aJTeb4Xp9DFjrQusa/9yIovR9tvmqpFWbE
 tUHKiWoAyGAd0EqJkCDRRXMKxLRiIDIcN/GnA5sEvIss7tgO7SrzjsXyyFUbWfxz1rEVKCGG1Yb
 oQxkyzU1CDDuUQb4hLy5Ci5/h1PBqcXQGrPAIu7XGncM/CSbl/sUIiRwO2RKs3DspITjpyXwxIG
 rEk6Va9WdPpB7XtzU9KhGUT9GDdAUVkGBsxCmfiDkNVX2wCVrFpWYr2lmu4Fr0SERVxvqTOsbmJ
 yWg2stOUFgu1jwyn1jxVy2TUQ0pKq6zEC9v2modbUnhCROy5mGe69Ah6BEqgAQuLDaJ649QArIL
 KFU4d+1g1YsSswnrDU4DdJ3rRxMx4ByGnIe+ZIRcZROX2TMCy5ZFpqE7rLgdBY+ZQqv2nvZXgzW
 JoaD8achQc/ujkQO1Aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100060

On Wed, Sep 09, 2026 at 05:18:20PM +0530, Krishna Chaitanya Chundru wrote:
> Add support for the Nord Gen5x16 bifurcated QMP PCIe PHY.
> 
> Nord has a single PCIe PHY block split into four ports which can be
> used in multiple lane configurations: x16, x8+x8, x8+x4+x4 and
> x8+x4+x2+x2. The active topology is selected through the link mode
> configuration register, and the driver exposes the corresponding PHY
> instances based on that mode.
> 
> Unlike Glymur, where the PHY is initialized by firmware, Nord requires
> Linux to program the PHY registers. Add the PLL, TXRXZ, PCS and PCS
> lane initialization tables, along with the required power-up,
> power-down and soft-reset sequencing.
> 
> Add per-port and grouped PHY configurations for all supported Nord
> lane modes. Also add support for regular PHY resets in addition to the
> NOCSR resets, and attach the PHY power domains using the device
> created for the PHY itself (devm_phy_create()) rather than the parent
> multi-PHY platform device, so each PHY instance's GDSCs are managed
> against its own device.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c  | 938 +++++++++++++++++++--
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h |  56 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h      |  14 +
>  .../qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h |  94 +++
>  .../phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h        | 194 +++++
>  5 files changed, 1222 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> index e93cba4369fb..122136ca9c7e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> @@ -20,8 +21,16 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>

What are we using from this header?

> +
> +#include <dt-bindings/phy/phy-qcom-qmp.h>

Ditto

>  
>  #include "phy-qcom-qmp.h"
> +#include "phy-qcom-qmp-common.h"
> +#include "phy-qcom-qmp-pcs-v6_40.h"
> +#include "phy-qcom-qmp-pcs-pcie-v6_40.h"
> +#include "phy-qcom-qmp-qserdes-com-pcie-v6_40.h"
> +#include "phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h"
>  
>  #define PHY_INIT_COMPLETE_TIMEOUT_US		10000
>  
> @@ -30,8 +39,19 @@ enum qmp_pcie_glymur_link_mode {
>  	QMP_PCIE_GLYMUR_MODE_X4X4,
>  };
>  
> +enum qmp_pcie_nord_link_mode {
> +	QMP_PCIE_NORD_MODE_X16,
> +	QMP_PCIE_NORD_MODE_X8_X8,
> +	QMP_PCIE_NORD_MODE_X8_X4_X4,
> +	QMP_PCIE_NORD_MODE_X8_X4_X2_X2
> +};
> +
>  enum qphy_reg_layout {
>  	QPHY_PCS_STATUS,
> +	QPHY_PCS_START_CONTROL,
> +	QPHY_PCS_SW_RESET,
> +	QPHY_PCS_POWER_DOWN_CONTROL,
> +	QPHY_COM_BIAS_EN_CLKBUFLR_EN,
>  	QPHY_LAYOUT_SIZE
>  };
>  
> @@ -39,16 +59,48 @@ static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
>  	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
>  };
>  
> +static const unsigned int nord_pciephy_v6_40_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_PCS_STATUS]		= QPHY_V6_40_PCS_STATUS1,
> +	[QPHY_PCS_START_CONTROL]	= QPHY_V6_40_PCS_START_CONTROL,
> +	[QPHY_PCS_SW_RESET]		= QPHY_V6_40_PCS_SW_RESET,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_40_PCS_POWER_DOWN_CONTROL,
> +	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,
> +};
> +
>  struct qmp_pcie_offsets {
>  	u16 pcs;
> +	u16 pll;
> +	u16 txrxz;
> +	u16 pcs_lanez;
> +};
> +
> +struct qmp_phy_cfg_tbls {
> +	const struct qmp_phy_init_tbl *pll_common;
> +	int pll_common_num;
> +	const struct qmp_phy_init_tbl *txrxz;
> +	int txrxz_num;
> +	const struct qmp_phy_init_tbl *pcs;
> +	int pcs_num;
> +	const struct qmp_phy_init_tbl *pcs_lanez;
> +	int pcs_lanez_num;
> +	const struct qmp_phy_init_tbl *port_split_pre_pwrup;
> +	int port_split_pre_pwrup_num;
> +	const struct qmp_phy_init_tbl *port_split_post_cfg;
> +	int port_split_post_cfg_num;
>  };
>  
>  struct qmp_phy_cfg {
>  	const struct qmp_pcie_offsets *offsets;
> +	struct qmp_phy_cfg_tbls tbls;
> +	struct qmp_phy_init_tbl **pll_tbls;

Could this be const?

> +	int *pll_nums;
> +	bool port_split;
>  	const char * const *reg_names;
>  	int num_regs;
>  	const char * const *pd_names;
>  	int num_pds;
> +	const char * const *reset_list;
> +	int num_resets;
>  	const char * const *nocsr_reset_list;
>  	int num_nocsr_resets;
>  	const char * const *vreg_list;
> @@ -64,9 +116,11 @@ struct qmp_phy_cfg {
>  struct qmp_pcie {
>  	struct device *dev;
>  	const struct qmp_phy_cfg *cfg;
> +	bool skip_init;
>  	void __iomem **base;
>  	struct clk_bulk_data *clks;
>  	struct clk_bulk_data *pipe_clks;
> +	struct reset_control_bulk_data *resets;
>  	struct reset_control_bulk_data *nocsr_resets;
>  	struct regulator_bulk_data *vregs;
>  	struct device **pd_devs;
> @@ -89,6 +143,10 @@ struct qmp_pcie_match_data {
>  	u32 num_modes;
>  };
>  
> +/* QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN bits */
> +#define COM_BIAS_EN				BIT(0)
> +#define COM_BIAS_EN_MUX				BIT(1)
> +
>  static const char * const glymur_pciephy_clk_l[] = {
>  	"aux", "cfg_ahb", "ref", "rchng", "phy_b_aux",
>  };
> @@ -113,31 +171,19 @@ static const char * const glymur_vreg_l[] = {
>  	"vdda-phy", "vdda-pll", "vdda-refgen0p9", "vdda-refgen1p2",
>  };
>  
> -static const char * const glymur_pciephy_a_reg_l[] = {
> +static const char * const pciephy_port_a_reg_l[] = {
>  	"port_a",
>  };
>  
> -static const char * const glymur_pciephy_b_reg_l[] = {
> +static const char * const pciephy_port_b_reg_l[] = {
>  	"port_b",
>  };
>  
> -static const char * const glymur_pciephy_reg_l[] = {
> +static const char * const pciephy_port_ab_reg_l[] = {
>  	"port_a", "port_b",
>  };
>  
> -static const char * const glymur_pciephy_a_pd_l[] = {
> -	"port_a",
> -};
> -
> -static const char * const glymur_pciephy_b_pd_l[] = {
> -	"port_b",
> -};
> -
> -static const char * const glymur_pciephy_pd_l[] = {
> -	"port_a", "port_b",
> -};
> -
> -static const char * const glymur_pciephy_a_nocsr_reset_l[] = {
> +static const char * const pciephy_port_a_nocsr_reset_l[] = {
>  	"port_a_nocsr",
>  };
>  
> @@ -145,7 +191,7 @@ static const char * const glymur_pciephy_nocsr_reset_l[] = {
>  	"port_a_nocsr", "port_b_nocsr",
>  };
>  
> -static const char * const glymur_pciephy_b_nocsr_reset_l[] = {
> +static const char * const pciephy_port_b_nocsr_reset_l[] = {
>  	"port_b_nocsr",
>  };
>  
> @@ -155,12 +201,12 @@ static const struct qmp_pcie_offsets glymur_pcie_offsets_v8_50 = {
>  
>  static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_a_cfg = {
>  	.offsets		= &glymur_pcie_offsets_v8_50,
> -	.reg_names		= glymur_pciephy_a_reg_l,
> -	.num_regs		= ARRAY_SIZE(glymur_pciephy_a_reg_l),
> -	.pd_names		= glymur_pciephy_a_pd_l,
> -	.num_pds		= ARRAY_SIZE(glymur_pciephy_a_pd_l),
> -	.nocsr_reset_list	= glymur_pciephy_a_nocsr_reset_l,
> -	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_a_nocsr_reset_l),
> +	.reg_names		= pciephy_port_a_reg_l,
> +	.num_regs		= ARRAY_SIZE(pciephy_port_a_reg_l),
> +	.pd_names		= pciephy_port_a_reg_l,
> +	.num_pds		= ARRAY_SIZE(pciephy_port_a_reg_l),
> +	.nocsr_reset_list	= pciephy_port_a_nocsr_reset_l,
> +	.num_nocsr_resets	= ARRAY_SIZE(pciephy_port_a_nocsr_reset_l),
>  	.vreg_list		= glymur_vreg_l,
>  	.num_vregs		= ARRAY_SIZE(glymur_vreg_l),
>  	.regs			= pciephy_v8_50_regs_layout,
> @@ -173,12 +219,12 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_a_cfg = {
>  
>  static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_b_cfg = {
>  	.offsets		= &glymur_pcie_offsets_v8_50,
> -	.reg_names		= glymur_pciephy_b_reg_l,
> -	.num_regs		= ARRAY_SIZE(glymur_pciephy_b_reg_l),
> -	.pd_names		= glymur_pciephy_b_pd_l,
> -	.num_pds		= ARRAY_SIZE(glymur_pciephy_b_pd_l),
> -	.nocsr_reset_list	= glymur_pciephy_b_nocsr_reset_l,
> -	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_b_nocsr_reset_l),
> +	.reg_names		= pciephy_port_b_reg_l,
> +	.num_regs		= ARRAY_SIZE(pciephy_port_b_reg_l),
> +	.pd_names		= pciephy_port_b_reg_l,
> +	.num_pds		= ARRAY_SIZE(pciephy_port_b_reg_l),
> +	.nocsr_reset_list	= pciephy_port_b_nocsr_reset_l,
> +	.num_nocsr_resets	= ARRAY_SIZE(pciephy_port_b_nocsr_reset_l),
>  	.vreg_list		= glymur_vreg_l,
>  	.num_vregs		= ARRAY_SIZE(glymur_vreg_l),
>  	.regs			= pciephy_v8_50_regs_layout,
> @@ -191,10 +237,10 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_b_cfg = {
>  
>  static const struct qmp_phy_cfg glymur_qmp_gen5x8_pciephy_cfg = {
>  	.offsets		= &glymur_pcie_offsets_v8_50,
> -	.reg_names		= glymur_pciephy_reg_l,
> -	.num_regs		= ARRAY_SIZE(glymur_pciephy_reg_l),
> -	.pd_names		= glymur_pciephy_pd_l,
> -	.num_pds		= ARRAY_SIZE(glymur_pciephy_pd_l),
> +	.reg_names		= pciephy_port_ab_reg_l,
> +	.num_regs		= ARRAY_SIZE(pciephy_port_ab_reg_l),
> +	.pd_names		= pciephy_port_ab_reg_l,
> +	.num_pds		= ARRAY_SIZE(pciephy_port_ab_reg_l),
>  	.nocsr_reset_list	= glymur_pciephy_nocsr_reset_l,
>  	.num_nocsr_resets	= ARRAY_SIZE(glymur_pciephy_nocsr_reset_l),
>  	.vreg_list		= glymur_vreg_l,
> @@ -232,6 +278,645 @@ static const struct qmp_pcie_match_data glymur_qmp_gen5x8_match_data = {
>  	.num_modes	= ARRAY_SIZE(glymur_qmp_gen5x8_mode_cfgs),
>  };
>  
> +#define NORD_VREG_A "vdda-phy-a", "vdda-pll-a"
> +#define NORD_VREG_B "vdda-phy-b", "vdda-pll-b"
> +#define NORD_VREG_C "vdda-phy-c", "vdda-pll-c"
> +#define NORD_VREG_D "vdda-phy-d", "vdda-pll-d"
> +
> +static const char * const nord_pciephy_port_a_vreg_l[] = { NORD_VREG_A };
> +static const char * const nord_pciephy_port_b_vreg_l[] = { NORD_VREG_B };
> +static const char * const nord_pciephy_port_c_vreg_l[] = { NORD_VREG_C };
> +static const char * const nord_pciephy_port_d_vreg_l[] = { NORD_VREG_D };
> +
> +static const char * const nord_pciephy_port_cd_vreg_l[] = {
> +	NORD_VREG_C, NORD_VREG_D,
> +};
> +
> +static const char * const nord_pciephy_port_bcd_vreg_l[] = {
> +	NORD_VREG_B, NORD_VREG_C, NORD_VREG_D,
> +};
> +
> +static const char * const nord_pciephy_port_abcd_vreg_l[] = {
> +	NORD_VREG_A, NORD_VREG_B, NORD_VREG_C, NORD_VREG_D,
> +};
> +
> +#undef NORD_VREG_A
> +#undef NORD_VREG_B
> +#undef NORD_VREG_C
> +#undef NORD_VREG_D

Please drop these and just spell the strings out.

The macros don't save anything -- each one is shorter than the string it
hides -- and they cost real things:

- They break grep.

- NORD_VREG_A expands to two comma-separated elements, so it reads like
  one initialiser entry but isn't, and it can't be passed as a macro
  argument. That's a trap for whoever edits this next.

- The trailing #undef means a reader who lands in the middle of the file
  has to scroll both directions to find out whether the symbol is still
  live

> +
> +static const struct qmp_pcie_offsets nord_pcie_offsets_v6_40 = {
> +	.pll      = 0x8000,
> +	.pcs      = 0x9000,
> +	.txrxz    = 0xd000,
> +	.pcs_lanez = 0xe800,

Can we use tabs and improve the alignment?

> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pll_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1,            0x0f),

Can we use single space just like every existing qualcomm phy driver?

> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2,        0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2,        0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2,               0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2,             0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2,             0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2,           0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2,             0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2,             0x1a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE2,             0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2,       0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2,       0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2,       0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2,  0xa4),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2,  0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1,        0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1,               0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1,             0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1,             0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1,           0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1,             0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1,             0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE1,             0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1,       0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1,       0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1,       0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1,  0x52),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1,  0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1,                 0x3c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2,                 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1,      0x3c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2,      0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0,        0xe0),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0,        0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0,               0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0,             0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0,             0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0,           0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0,             0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0,             0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE0,             0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0,       0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0,       0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0,       0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0,  0xd4),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0,  0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1,       0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2,       0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BG_TIMER,                    0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL,               0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER,               0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER1,                    0x62),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER2,                    0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_POST_DIV_MUX,                0xc0),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,         0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_ENABLE1,                 0x90),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL,                0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO,                    0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1,              0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2,              0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL,               0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN,                 0x46),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG,                0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP,                0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_SELECT,                  0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORE_CLK_EN,                 0xe0),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1,                0x86),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MISC1,                   0x88),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MODE,                    0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL,           0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2,                0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1,            0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0,            0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PSM_CAL_EN,                  0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO,           0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_1,                   0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_2,                   0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_3,                   0x60),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_8,                   0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL,          0xaf),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_IETRIM,                  0x0d),
> +};
> +
> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_a_ovl_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x31),
> +};
> +
> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_b_ovl_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x22),
> +};
> +
> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_c_ovl_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x31),
> +};
> +
> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_d_ovl_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x22),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x22),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_txrxz_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_ENABLES,                     0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B0,                   0xcd),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B1,                   0x34),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B2,                   0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B3,                   0x50),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B4,                   0xac),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B5,                   0xdb),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B6,                   0x52),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B7,                   0x3e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B0,                   0xce),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B1,                   0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B2,                   0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B3,                   0x60),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B4,                   0x8c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B5,                   0x9d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B6,                   0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B7,                   0x26),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B0,                   0xfb),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B1,                   0xea),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B2,                   0xe8),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B3,                   0x70),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B4,                   0x9c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B5,                   0xf4),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B6,                   0x6d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B7,                   0x3b),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_SUMMER_CAL_SPD_MODE_RATE_0123,   0x6f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH1,              0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH2,              0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PHPRE_CTRL,                         0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADPT_CTRL,                       0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B0,                0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B1,                0x4a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B2,                0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B3,                0x50),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B4,                0x9a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B5,                0x47),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B6,                0x52),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B7,                0x1d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_1,                        0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_2,                        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_3,                        0x41),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_4,                        0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL1,           0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL2,           0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL3,           0x81),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL4,           0x8d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOCK_CTRL,                      0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP1_DAC_ENABLE,                0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP2_DAC_ENABLE,                0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP345_DAC_ENABLE,              0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP67_DAC_ENABLE,               0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE0,               0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE1,               0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE2,               0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE3,               0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE4,               0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE0,               0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE1,               0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE2,               0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE3,               0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE4,               0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_FLL_DIV_RATIO_RATE_0123,        0x94),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_01,             0x66),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_23,             0x77),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE4,               0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_CTRL,                    0x58),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_MAN_INDEX,               0x0d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_ANA_CTRL,                0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_FUNC_CTRL,                 0xd0),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE0,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE1,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE2,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE3,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE4,  0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE0,   0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE1,   0x15),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE2,   0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE3,   0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE4,   0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CODE_OVRD_RATE_2_3,              0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL2,                  0x83),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL3,                  0x44),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL4,                  0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_0_1,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_2_3,        0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE4,           0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_0_1,        0x33),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_2_3,        0x33),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE4,           0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_0_1,       0x22),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_2_3,       0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE4,          0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_DIV2_CTRL_RATE0123,      0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE0,      0x13),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE0,      0x13),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE1,      0x26),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE1,      0x26),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE2,      0x9c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE2,      0x3d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE3,      0x9c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE3,      0x3d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE4,      0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE4,      0x3d),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL3,              0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL4,              0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL5,              0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_CNTRL1,                     0xe1),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE0_1,            0xdd),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE2_3,            0xdc),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE4,              0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_OVRD_MUXES,        0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE_0123,         0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE4,             0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE0,        0x4b),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE0,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE1,        0x4b),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE1,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE2,        0x35),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE2,        0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE3,        0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE4,        0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_0_1,                 0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_2_3,                 0x22),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_4,                   0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE0,               0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE1,               0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE2,               0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE0,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE1,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE2,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE3,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE4,            0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_0_1,                 0x43),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_2_3,                 0x44),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_TYPE_CONFIG,                0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CTLE_POST_CAL_OFFSET_RATE_0_1_2,    0x67),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_EN_LOWFREQ,                 0x1f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RES_CODE_LANE_OFFSET_RX,            0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE0_1,                 0x88),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE2_3,                 0x88),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE4,                   0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VTHRESH_CAL_MAN_VAL_RATE4,          0x56),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CLKBUF_ENABLE,                      0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE0,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE1,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE2,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE3,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE4,          0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CNTRL,                       0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_LVL,                         0x84),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CAL_CTRL1,                   0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL15,                    0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL16,                    0x52),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_CAL_CTRL,                   0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_POST_CAL_OFFSET,            0x10),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_VREF_SEL,                   0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_CTRL,                           0x3c),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE3,                  0x17),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE4,                  0x17),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG2,        0x3d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG5,        0xe4),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG6,        0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG7,        0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_MULTIPHY_CONFIG2,           0x01),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG2,          0xe4),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG3,          0x30),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG5,          0x05),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG6,          0x08),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG7,          0x20),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG8,          0x20),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG10,         0x40),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG2,  0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG3,  0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG4,  0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ENDPOINT_REFCLK_DRIVE,      0xc1),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_RX_SIGDET_LVL,              0x66),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_OSC_DTCT_ACTIONS,           0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_LOCK_DETECT_CONFIG1,        0xff),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG1,       0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG2,       0x04),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG3,       0x1f),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG7,       0x35),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG8,       0x3e),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG1,                 0x06),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG2,                 0x1c),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG1,            0x03),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG3,            0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG1,              0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG5,              0x90),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG7,              0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG1,              0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG5,              0x90),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG7,              0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG1,              0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG5,              0x90),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG7,              0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_TEST_CONTROL1,              0x08),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_lanez_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL2,  0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL5,  0x00),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_port_split_pre_pwrup_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN,  0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL,          0x91),
> +};
> +
> +static const struct qmp_phy_init_tbl nord_qmp_pcie_port_split_post_cfg_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL,          0x11),
> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN,  0x00),
> +};
> +
> +static const struct qmp_phy_cfg_tbls nord_qmp_pcie_tbls = {
> +	.pll_common     = nord_qmp_pcie_pll_tbl,
> +	.pll_common_num = ARRAY_SIZE(nord_qmp_pcie_pll_tbl),
> +	.txrxz     = nord_qmp_pcie_txrxz_tbl,
> +	.txrxz_num = ARRAY_SIZE(nord_qmp_pcie_txrxz_tbl),
> +	.pcs       = nord_qmp_pcie_pcs_tbl,
> +	.pcs_num   = ARRAY_SIZE(nord_qmp_pcie_pcs_tbl),
> +	.pcs_lanez     = nord_qmp_pcie_pcs_lanez_tbl,
> +	.pcs_lanez_num = ARRAY_SIZE(nord_qmp_pcie_pcs_lanez_tbl),
> +	.port_split_pre_pwrup     = nord_qmp_pcie_port_split_pre_pwrup_tbl,
> +	.port_split_pre_pwrup_num = ARRAY_SIZE(nord_qmp_pcie_port_split_pre_pwrup_tbl),
> +	.port_split_post_cfg      = nord_qmp_pcie_port_split_post_cfg_tbl,
> +	.port_split_post_cfg_num  = ARRAY_SIZE(nord_qmp_pcie_port_split_post_cfg_tbl),

Please improve the alignment.

> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_a[] = {
> +	nord_qmp_pcie_pll_a_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_a_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_a_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_b[] = {
> +	nord_qmp_pcie_pll_b_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_b_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_c[] = {
> +	nord_qmp_pcie_pll_c_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_c_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_d[] = {
> +	nord_qmp_pcie_pll_d_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_d_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_cd[] = {
> +	nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_cd_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_bcd[] = {
> +	nord_qmp_pcie_pll_b_ovl_tbl, nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_bcd_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl),
> +	ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
> +};
> +
> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_abcd[] = {
> +	nord_qmp_pcie_pll_a_ovl_tbl, nord_qmp_pcie_pll_b_ovl_tbl,
> +	nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
> +};
> +
> +static int nord_qmp_pcie_pll_abcd_nums[] = {
> +	ARRAY_SIZE(nord_qmp_pcie_pll_a_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl),
> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
> +};
> +
> +#define NORD_PORT_A "port_a"
> +#define NORD_PORT_B "port_b"
> +#define NORD_PORT_C "port_c"
> +#define NORD_PORT_D "port_d"
> +
> +static const char * const nord_pciephy_port_c_reg_l[] = { NORD_PORT_C };
> +static const char * const nord_pciephy_port_d_reg_l[] = { NORD_PORT_D };
> +static const char * const nord_pciephy_port_cd_reg_l[] = { NORD_PORT_C, NORD_PORT_D };
> +static const char * const nord_pciephy_port_bcd_reg_l[] = { NORD_PORT_B, NORD_PORT_C, NORD_PORT_D };
> +static const char * const nord_pciephy_port_abcd_reg_l[] = {
> +	NORD_PORT_A, NORD_PORT_B, NORD_PORT_C, NORD_PORT_D
> +};
> +
> +static const char * const nord_pciephy_port_a_clk_l[] = { "aux_a", "cfg_ahb_a", "rchng_a", "ref" };
> +static const char * const nord_pciephy_port_b_clk_l[] = {
> +	"aux_a", "aux_b", "cfg_ahb_b", "rchng_b", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_c_clk_l[] = {
> +	"aux_a", "aux_c", "cfg_ahb_c", "rchng_c", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_d_clk_l[] = {
> +	"aux_a", "aux_d", "cfg_ahb_d", "rchng_d", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_cd_clk_l[] = {
> +	"aux_a", "aux_c", "cfg_ahb_c", "rchng_c", "aux_d", "cfg_ahb_d", "rchng_d", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_bcd_clk_l[] = {
> +	"aux_a", "aux_b", "cfg_ahb_b", "rchng_b",
> +	"aux_c", "cfg_ahb_c", "rchng_c",
> +	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_abcd_clk_l[] = {
> +	"aux_a", "cfg_ahb_a", "rchng_a",
> +	"aux_b", "cfg_ahb_b", "rchng_b",
> +	"aux_c", "cfg_ahb_c", "rchng_c",
> +	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
> +};
> +
> +static const char * const nord_pciephy_port_a_pipeclk_l[] = { "pipe_a" };
> +static const char * const nord_pciephy_port_b_pipeclk_l[] = { "pipe_b" };
> +static const char * const nord_pciephy_port_c_pipeclk_l[] = { "pipe_c" };
> +static const char * const nord_pciephy_port_d_pipeclk_l[] = { "pipe_d" };
> +
> +static const char * const nord_pciephy_port_c_nocsr_reset_l[] = { NORD_PORT_C "_nocsr" };
> +static const char * const nord_pciephy_port_d_nocsr_reset_l[] = { NORD_PORT_D "_nocsr" };
> +static const char * const nord_pciephy_port_cd_nocsr_reset_l[] = {
> +	NORD_PORT_C "_nocsr", NORD_PORT_D "_nocsr",
> +};

Missing newline. Suggest to run checkpatch.pl with --strict.

> +static const char * const nord_pciephy_port_bcd_nocsr_reset_l[] = {
> +	NORD_PORT_B "_nocsr", NORD_PORT_C "_nocsr", NORD_PORT_D "_nocsr",
> +};
> +
> +static const char * const nord_pciephy_port_abcd_nocsr_reset_l[] = {
> +	NORD_PORT_A "_nocsr", NORD_PORT_B "_nocsr", NORD_PORT_C "_nocsr", NORD_PORT_D "_nocsr",
> +};
> +
> +#undef NORD_PORT_A
> +#undef NORD_PORT_B
> +#undef NORD_PORT_C
> +#undef NORD_PORT_D
> +
> +static const char * const nord_pciephy_port_c_pd_l[] = { "port_a", "port_c" };
> +static const char * const nord_pciephy_port_d_pd_l[] = { "port_a", "port_d" };
> +static const char * const nord_pciephy_port_cd_pd_l[] = {
> +	"port_a", "port_c", "port_d",
> +};
> +
> +static const char * const nord_pciephy_port_bcd_pd_l[] = {
> +	"port_a", "port_b", "port_c", "port_d",
> +};
> +
> +#define NORD_QMP_PCIE_PORT_CFG(_port, _reg_l, _pd_l, _reset_l, _nocsr_reset_l, _pipeclk_l, \
> +				_port_split)					\
> +static const struct qmp_phy_cfg nord_qmp_pcie_port_##_port##_cfg = {		\
> +	.offsets		= &nord_pcie_offsets_v6_40,			\
> +	.tbls			= nord_qmp_pcie_tbls,				\
> +	.pll_tbls		= nord_qmp_pcie_pll_##_port,			\
> +	.pll_nums		= nord_qmp_pcie_pll_##_port##_nums,		\
> +	.port_split		= _port_split,					\
> +	.reg_names		= _reg_l,					\
> +	.num_regs		= ARRAY_SIZE(_reg_l),				\
> +	.pd_names		= _pd_l,					\
> +	.num_pds		= ARRAY_SIZE(_pd_l),				\
> +	.reset_list		= _reset_l,					\
> +	.num_resets		= ARRAY_SIZE(_reset_l),				\
> +	.nocsr_reset_list	= _nocsr_reset_l,				\
> +	.num_nocsr_resets	= ARRAY_SIZE(_nocsr_reset_l),			\
> +	.vreg_list		= nord_pciephy_port_##_port##_vreg_l,		\
> +	.num_vregs		= ARRAY_SIZE(nord_pciephy_port_##_port##_vreg_l),	\
> +	.regs			= nord_pciephy_v6_40_regs_layout,	\
> +	.phy_status		= PHYSTATUS_4_20,				\
> +	.clk_list		= nord_pciephy_port_##_port##_clk_l,		\
> +	.num_clks		= ARRAY_SIZE(nord_pciephy_port_##_port##_clk_l),	\
> +	.pipe_clk_list		= _pipeclk_l,					\
> +	.num_pipe_clks		= 1,						\
> +}
> +
> +NORD_QMP_PCIE_PORT_CFG(a, pciephy_port_a_reg_l, pciephy_port_a_reg_l, pciephy_port_a_reg_l,
> +			pciephy_port_a_nocsr_reset_l, nord_pciephy_port_a_pipeclk_l, true);

Alignment should match open parenthesis.

> +NORD_QMP_PCIE_PORT_CFG(b, pciephy_port_b_reg_l, pciephy_port_ab_reg_l, pciephy_port_b_reg_l,
> +			pciephy_port_b_nocsr_reset_l, nord_pciephy_port_b_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(c, nord_pciephy_port_c_reg_l, nord_pciephy_port_c_pd_l,
> +			nord_pciephy_port_c_reg_l, nord_pciephy_port_c_nocsr_reset_l,
> +			nord_pciephy_port_c_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(d, nord_pciephy_port_d_reg_l, nord_pciephy_port_d_pd_l,
> +			nord_pciephy_port_d_reg_l, nord_pciephy_port_d_nocsr_reset_l,
> +			nord_pciephy_port_d_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(cd, nord_pciephy_port_cd_reg_l, nord_pciephy_port_cd_pd_l,
> +			nord_pciephy_port_cd_reg_l, nord_pciephy_port_cd_nocsr_reset_l,
> +			nord_pciephy_port_c_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(bcd, nord_pciephy_port_bcd_reg_l, nord_pciephy_port_bcd_pd_l,
> +			nord_pciephy_port_bcd_reg_l, nord_pciephy_port_bcd_nocsr_reset_l,
> +			nord_pciephy_port_b_pipeclk_l, true);
> +NORD_QMP_PCIE_PORT_CFG(abcd, nord_pciephy_port_abcd_reg_l, nord_pciephy_port_bcd_pd_l,
> +			nord_pciephy_port_abcd_reg_l, nord_pciephy_port_abcd_nocsr_reset_l,
> +			nord_pciephy_port_a_pipeclk_l, false);
> +
> +#undef NORD_QMP_PCIE_PORT_CFG
> +
> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x16_cfgs[] = {
> +	&nord_qmp_pcie_port_abcd_cfg,
> +};
> +
> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x8_cfgs[] = {
> +	&nord_qmp_pcie_port_a_cfg,
> +	&nord_qmp_pcie_port_bcd_cfg,
> +};
> +
> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x4x4_cfgs[] = {
> +	&nord_qmp_pcie_port_a_cfg,
> +	&nord_qmp_pcie_port_b_cfg,
> +	&nord_qmp_pcie_port_cd_cfg,
> +};
> +
> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x4x2x2_cfgs[] = {
> +	&nord_qmp_pcie_port_a_cfg,
> +	&nord_qmp_pcie_port_b_cfg,
> +	&nord_qmp_pcie_port_c_cfg,
> +	&nord_qmp_pcie_port_d_cfg,
> +};
> +
> +static const struct qmp_pcie_link_mode_cfg nord_qmp_gen5x16_mode_cfgs[] = {
> +	[QMP_PCIE_NORD_MODE_X16] = {
> +		.cfgs		= nord_qmp_gen5x16_mode_x16_cfgs,
> +		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x16_cfgs),
> +	},
> +	[QMP_PCIE_NORD_MODE_X8_X8] = {
> +		.cfgs		= nord_qmp_gen5x16_mode_x8x8_cfgs,
> +		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x8_cfgs),
> +	},
> +	[QMP_PCIE_NORD_MODE_X8_X4_X4] = {
> +		.cfgs		= nord_qmp_gen5x16_mode_x8x4x4_cfgs,
> +		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x4x4_cfgs),
> +	},
> +	[QMP_PCIE_NORD_MODE_X8_X4_X2_X2] = {
> +		.cfgs		= nord_qmp_gen5x16_mode_x8x4x2x2_cfgs,
> +		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x4x2x2_cfgs),
> +	},
> +};
> +
> +static const struct qmp_pcie_match_data nord_qmp_gen5x16_match_data = {
> +	.mode_cfgs		= nord_qmp_gen5x16_mode_cfgs,
> +	.num_modes		= ARRAY_SIZE(nord_qmp_gen5x16_mode_cfgs),
> +};
> +
> +static void qmp_pcie_init_port_registers(struct qmp_pcie *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
> +	const struct qmp_phy_cfg_tbls *tbls = &cfg->tbls;
> +	int i;
> +
> +	for (i = 0; i < cfg->num_regs; i++) {
> +		void __iomem *port = qmp->base[i];
> +
> +		if (cfg->port_split)
> +			qmp_configure(qmp->dev, port + offs->txrxz,
> +				      tbls->port_split_pre_pwrup, tbls->port_split_pre_pwrup_num);
> +
> +		writel(SW_PWRDN | REFCLK_DRV_DSBL,
> +		       port + offs->pcs + cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]);
> +
> +		if (cfg->port_split)
> +			qphy_setbits(port + offs->pll, cfg->regs[QPHY_COM_BIAS_EN_CLKBUFLR_EN],
> +				     COM_BIAS_EN_MUX | COM_BIAS_EN);
> +
> +		qmp_configure(qmp->dev, port + offs->pll,
> +			      tbls->pll_common, tbls->pll_common_num);
> +		qmp_configure(qmp->dev, port + offs->pll,
> +			      cfg->pll_tbls[i], cfg->pll_nums[i]);
> +		qmp_configure(qmp->dev, port + offs->txrxz,
> +			      tbls->txrxz, tbls->txrxz_num);
> +		qmp_configure(qmp->dev, port + offs->pcs,
> +			      tbls->pcs, tbls->pcs_num);
> +		qmp_configure(qmp->dev, port + offs->pcs_lanez,
> +			      tbls->pcs_lanez, tbls->pcs_lanez_num);
> +
> +		if (cfg->port_split)
> +			qmp_configure(qmp->dev, port + offs->txrxz,
> +				      tbls->port_split_post_cfg, tbls->port_split_post_cfg_num);
> +	}
> +}
> +
>  static int qmp_pcie_pd_power_on(struct qmp_pcie *qmp)
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -268,32 +953,76 @@ static int qmp_pcie_init(struct phy *phy)
>  {
>  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> -	int ret;
> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
> +	int i, ret;
>  
>  	ret = qmp_pcie_pd_power_on(qmp);
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * We can skip PHY initialization if all of the following conditions
> +	 * are met:
> +	 *  1. The PHY supports the nocsr_reset that preserves the PHY config.
> +	 *  2. The PHY was started (and not powered down again) by the
> +	 *     bootloader, with all of the expected bits set correctly.
> +	 * In this case, we can continue without having the init sequence
> +	 * defined in the driver.
> +	 */
> +	qmp->skip_init = cfg->pll_tbls && qmp->nocsr_resets;
> +	for (i = 0; qmp->skip_init && i < cfg->num_regs; i++) {
> +		void __iomem *port = qmp->base[i];
> +
> +		if (!qphy_checkbits(port + offs->pcs, cfg->regs[QPHY_PCS_START_CONTROL],
> +				     SERDES_START | PCS_START) ||
> +		    !qphy_checkbits(port + offs->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +				     SW_PWRDN | REFCLK_DRV_DSBL))
> +			qmp->skip_init = false;
> +	}
> +
>  	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
>  	if (ret) {
>  		dev_err(qmp->dev, "failed to enable regulators: %d\n", ret);
>  		goto err_pd_power_off;
>  	}
>  
> +	/*
> +	 * Toggle BCR reset for a PHY that doesn't support the nocsr_reset,
> +	 * or has not been initialized yet.
> +	 */
> +	if (!qmp->skip_init) {
> +		ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> +		if (ret) {
> +			dev_err(qmp->dev, "reset assert failed: %d\n", ret);
> +			goto err_disable_regulators;
> +		}
> +	}
> +
>  	ret = reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
>  	if (ret) {
>  		dev_err(qmp->dev, "no-csr reset assert failed: %d\n", ret);
> -		goto err_disable_regulators;
> +		goto err_assert_reset;
>  	}
>  
>  	usleep_range(200, 300);
>  
> +	if (!qmp->skip_init) {
> +		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
> +		if (ret) {
> +			dev_err(qmp->dev, "reset deassert failed: %d\n", ret);
> +			goto err_assert_reset;
> +		}
> +	}
> +
>  	ret = clk_bulk_prepare_enable(qmp->cfg->num_clks, qmp->clks);
>  	if (ret)
> -		goto err_disable_regulators;
> +		goto err_assert_reset;
>  
>  	return 0;
>  
> +err_assert_reset:
> +	if (!qmp->skip_init)
> +		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>  err_disable_regulators:
>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
>  err_pd_power_off:
> @@ -307,7 +1036,10 @@ static int qmp_pcie_exit(struct phy *phy)
>  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  
> -	reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
> +	if (qmp->nocsr_resets)
> +		reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
> +	if (qmp->resets)
> +		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>  
>  	clk_bulk_disable_unprepare(qmp->cfg->num_clks, qmp->clks);
>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
> @@ -335,6 +1067,20 @@ static int qmp_pcie_power_on(struct phy *phy)
>  		goto err_disable_pipe_clk;
>  	}
>  
> +	if (!qmp->skip_init) {
> +		qmp_pcie_init_port_registers(qmp);

Have we tested the patch on Glymur? As Glymur's cfgs have either .pll_tbls
nor .tbls, so skip_init is unconditionally false for Glymur. Is it
intentional to run qmp_pcie_init_port_registers() on Glymur?

> +
> +		for (i = 0; i < cfg->num_regs; i++) {
> +			qphy_clrbits(qmp->base[i] + offs->pcs,
> +				     cfg->regs[QPHY_PCS_SW_RESET], SW_RESET);
> +			qphy_setbits(qmp->base[i] + offs->pcs,
> +				     cfg->regs[QPHY_PCS_START_CONTROL],
> +				     SERDES_START | PCS_START);
> +		}
> +
> +		usleep_range(2000, 2500);
> +	}
> +
>  	for (i = 0; i < cfg->num_regs; i++) {
>  		status = qmp->base[i] + offs->pcs + cfg->regs[QPHY_PCS_STATUS];
>  		ret = readl_poll_timeout(status, val, !(val & cfg->phy_status), 200,
> @@ -357,9 +1103,36 @@ static int qmp_pcie_power_on(struct phy *phy)
>  static int qmp_pcie_power_off(struct phy *phy)
>  {
>  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
> +	int i;
>  
>  	clk_bulk_disable_unprepare(qmp->cfg->num_pipe_clks, qmp->pipe_clks);
>  
> +	/*
> +	 * While powering off the PHY, only nocsr_resets needs to be checked.
> +	 * This way, no matter whether the PHY settings were initially
> +	 * programmed by the bootloader or the PHY driver itself, we can
> +	 * reuse them the next time the PHY is powered on.
> +	 */
> +	if (cfg->pll_tbls && !qmp->nocsr_resets) {

Every cfg in the file (Glymur and all seven Nord ones) declares
nocsr_reset_list, and qmp_pcie_reset_init() only leaves qmp->nocsr_resets
NULL when num_nocsr_resets == 0. So the condition is always false, no?

> +		for (i = 0; i < cfg->num_regs; i++) {
> +			void __iomem *port = qmp->base[i];
> +
> +			/* PHY reset */
> +			qphy_setbits(port + offs->pcs, cfg->regs[QPHY_PCS_SW_RESET],
> +				     SW_RESET);
> +
> +			/* stop SerDes and Phy-Coding-Sublayer */
> +			qphy_clrbits(port + offs->pcs, cfg->regs[QPHY_PCS_START_CONTROL],
> +				     SERDES_START | PCS_START);
> +
> +			/* Put PHY into POWER DOWN state: active low */
> +			qphy_clrbits(port + offs->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +				     SW_PWRDN | REFCLK_DRV_DSBL);
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -398,45 +1171,39 @@ static const struct phy_ops qmp_pcie_phy_ops = {
>  static void qmp_pcie_pd_detach(void *data)
>  {
>  	struct qmp_pcie *qmp = data;
> -	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	int i;
>  
> -	for (i = 0; i < cfg->num_pds; i++) {
> +	for (i = 0; i < qmp->cfg->num_pds; i++) {
>  		if (!IS_ERR_OR_NULL(qmp->pd_devs[i]))
>  			dev_pm_domain_detach(qmp->pd_devs[i], true);
>  	}
>  }
>  
> -static int qmp_pcie_pd_init(struct qmp_pcie *qmp)
> +static int qmp_pcie_pd_init(struct qmp_pcie *qmp, struct phy *phy)
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> -	struct device *dev = qmp->dev;
> +	struct device *pd_dev = &phy->dev;
>  	int i, ret;
>  
>  	if (!cfg->num_pds)
>  		return 0;
>  
> -	qmp->pd_devs = devm_kcalloc(dev, cfg->num_pds, sizeof(*qmp->pd_devs),
> +	qmp->pd_devs = devm_kcalloc(pd_dev, cfg->num_pds, sizeof(*qmp->pd_devs),
>  				    GFP_KERNEL);
>  	if (!qmp->pd_devs)
>  		return -ENOMEM;
>  
> +	ret = devm_add_action_or_reset(pd_dev, qmp_pcie_pd_detach, qmp);
> +	if (ret)
> +		return ret;
> +
>  	for (i = 0; i < cfg->num_pds; i++) {
> -		qmp->pd_devs[i] = dev_pm_domain_attach_by_name(dev,
> -							       cfg->pd_names[i]);
> -		if (IS_ERR_OR_NULL(qmp->pd_devs[i])) {
> -			ret = PTR_ERR(qmp->pd_devs[i]) ? : -ENODATA;
> -			goto err_detach;
> -		}
> +		qmp->pd_devs[i] = dev_pm_domain_attach_by_name(pd_dev, cfg->pd_names[i]);
> +		if (IS_ERR_OR_NULL(qmp->pd_devs[i]))
> +			return PTR_ERR_OR_ZERO(qmp->pd_devs[i]) ? : -ENODATA;
>  	}
>  
> -	return devm_add_action_or_reset(dev, qmp_pcie_pd_detach, qmp);
> -
> -err_detach:
> -	while (--i >= 0)
> -		dev_pm_domain_detach(qmp->pd_devs[i], false);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static int qmp_pcie_vreg_init(struct qmp_pcie *qmp)
> @@ -462,20 +1229,37 @@ static int qmp_pcie_reset_init(struct qmp_pcie *qmp)
>  	struct device *dev = qmp->dev;
>  	int i, ret;
>  
> -	qmp->nocsr_resets = devm_kcalloc(dev, cfg->num_nocsr_resets,
> -					 sizeof(*qmp->nocsr_resets),
> -					 GFP_KERNEL);
> -	if (!qmp->nocsr_resets)
> -		return -ENOMEM;
> +	if (cfg->num_resets) {
> +		qmp->resets = devm_kcalloc(dev, cfg->num_resets,
> +					   sizeof(*qmp->resets), GFP_KERNEL);
> +		if (!qmp->resets)
> +			return -ENOMEM;
>  
> -	for (i = 0; i < cfg->num_nocsr_resets; i++)
> -		qmp->nocsr_resets[i].id = cfg->nocsr_reset_list[i];
> +		for (i = 0; i < cfg->num_resets; i++)
> +			qmp->resets[i].id = cfg->reset_list[i];
>  
> -	ret = devm_reset_control_bulk_get_exclusive(dev,
> -						    cfg->num_nocsr_resets,
> -						    qmp->nocsr_resets);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to get no-csr resets\n");
> +		ret = devm_reset_control_bulk_get_exclusive(dev, cfg->num_resets,
> +							    qmp->resets);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to get resets\n");
> +	}
> +
> +	if (cfg->num_nocsr_resets) {
> +		qmp->nocsr_resets = devm_kcalloc(dev, cfg->num_nocsr_resets,
> +						 sizeof(*qmp->nocsr_resets),
> +						 GFP_KERNEL);
> +		if (!qmp->nocsr_resets)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < cfg->num_nocsr_resets; i++)
> +			qmp->nocsr_resets[i].id = cfg->nocsr_reset_list[i];
> +
> +		ret = devm_reset_control_bulk_get_exclusive(dev,
> +							    cfg->num_nocsr_resets,
> +							    qmp->nocsr_resets);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to get no-csr resets\n");
> +	}
>  
>  	return 0;
>  }
> @@ -630,6 +1414,7 @@ static struct phy *qmp_pcie_multiphy_xlate(struct device *dev,
>  static int qmp_pcie_probe_phy(struct qmp_pcie *qmp, struct device_node *np,
>  			      struct phy **out_phy)
>  {
> +	struct phy *phy;
>  	int ret;
>  
>  	ret = qmp_pcie_get_mmio(qmp);
> @@ -648,15 +1433,16 @@ static int qmp_pcie_probe_phy(struct qmp_pcie *qmp, struct device_node *np,
>  	if (ret)
>  		return ret;
>  
> -	ret = qmp_pcie_pd_init(qmp);
> +	phy = devm_phy_create(qmp->dev, np, &qmp_pcie_phy_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	ret = qmp_pcie_pd_init(qmp, phy);
>  	if (ret)
>  		return ret;
>  
> -	*out_phy = devm_phy_create(qmp->dev, np, &qmp_pcie_phy_ops);
> -	if (IS_ERR(*out_phy))
> -		return PTR_ERR(*out_phy);
> -
> -	phy_set_drvdata(*out_phy, qmp);
> +	phy_set_drvdata(phy, qmp);
> +	*out_phy = phy;
>  
>  	return 0;
>  }
> @@ -725,6 +1511,10 @@ static const struct of_device_id qmp_pcie_multiphy_of_match_table[] = {
>  		.compatible = "qcom,glymur-qmp-gen5x8-pcie-phy",
>  		.data = &glymur_qmp_gen5x8_match_data,
>  	},
> +	{
> +		.compatible = "qcom,nord-qmp-gen5x16-pcie-phy",
> +		.data = &nord_qmp_gen5x16_match_data,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qmp_pcie_multiphy_of_match_table);
> @@ -739,5 +1529,5 @@ static struct platform_driver qmp_pcie_multiphy_driver = {
>  module_platform_driver(qmp_pcie_multiphy_driver);
>  
>  MODULE_AUTHOR("Qiang Yu <qiang.yu@oss.qualcomm.com>");
> -MODULE_DESCRIPTION("Qualcomm QMP PCIe Multi-PHY driver for Glymur");
> +MODULE_DESCRIPTION("Qualcomm QMP PCIe Multi-PHY driver for Glymur and Nord");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h
> new file mode 100644
> index 000000000000..4c6859cebd42
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_40_H_
> +#define QCOM_PHY_QMP_PCS_PCIE_V6_40_H_
> +
> +/* PCS COM — power, start, clocks */
> +#define QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG2	0x06c
> +#define QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG5	0x078
> +#define QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG6	0x07c
> +#define QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG7	0x080
> +#define QPHY_PCIE_V6_40_PCS_COM_MULTIPHY_CONFIG2	0x088
> +#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG2	0x0a0
> +#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG3	0x0a4
> +#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG5	0x0ac
> +#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG6	0x0b0
> +#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG7	0x0b4
> +#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG8	0x0b8
> +#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG10	0x0c0
> +#define QPHY_PCIE_V6_40_PCS_COM_ENDPOINT_REFCLK_DRIVE	0x0c8
> +#define QPHY_PCIE_V6_40_PCS_COM_RX_SIGDET_LVL	0x0ec
> +#define QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG2	0x0f8
> +#define QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG3	0x0fc
> +#define QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG4	0x100

Please get the values aligned at the same column. This applies to all
the headers this patch adds.

> +#define QPHY_PCIE_V6_40_PCS_COM_OSC_DTCT_ACTIONS	0x194
> +#define QPHY_PCIE_V6_40_PCS_COM_LOCK_DETECT_CONFIG1	0x1bc
> +#define QPHY_PCIE_V6_40_PCS_COM_LOCK_DETECT_CONFIG2	0x1c0
> +#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG1	0x1dc
> +#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG2	0x1e0
> +#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG3	0x1e4
> +#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG7	0x1f4
> +#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG8	0x1f8
> +
> +/* PCS COM — EQ config */
> +#define QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG1	0x380
> +#define QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG2	0x384
> +#define QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG1	0x38c
> +#define QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG3	0x394
> +#define QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG1	0x3a4
> +#define QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG5	0x3b4
> +#define QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG7	0x3bc
> +#define QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG1	0x3c8
> +#define QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG5	0x3d8
> +#define QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG7	0x3e0
> +#define QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG1	0x3ec
> +#define QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG5	0x3fc
> +#define QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG7	0x404
> +#define QPHY_PCIE_V6_40_PCS_COM_TEST_CONTROL1	0x468
> +
> +/* PCS LANEZ — output signal mux control */
> +#define QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL2	0x0e0
> +#define QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL5	0x0f8
> +
> +#endif /* QCOM_PHY_QMP_PCS_PCIE_V6_40_H_ */
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h
> new file mode 100644
> index 000000000000..c7ac7b3bd97e
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_V6_40_H_
> +#define QCOM_PHY_QMP_PCS_V6_40_H_
> +
> +#define QPHY_V6_40_PCS_STATUS1					0x010
> +#define QPHY_V6_40_PCS_START_CONTROL				0x05c
> +#define QPHY_V6_40_PCS_SW_RESET					0x060
> +#define QPHY_V6_40_PCS_POWER_DOWN_CONTROL			0x064
> +
> +#endif /* QCOM_PHY_QMP_PCS_V6_40_H_ */
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h
> new file mode 100644
> index 000000000000..a7efd3a8718c
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef QCOM_PHY_QMP_QSERDES_COM_PCIE_V6_40_NORD_H_
> +#define QCOM_PHY_QMP_QSERDES_COM_PCIE_V6_40_NORD_H_
> +
> +#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1		0x000
> +#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1		0x004
> +#define QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1		0x00c
> +#define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1			0x010
> +#define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1		0x014
> +#define QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1		0x018
> +#define QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1		0x01c
> +#define QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1		0x020
> +#define QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1		0x024
> +#define QSERDES_PCIE_V6_40_COM_DEC_START_MODE1		0x028
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1	0x030
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1	0x034
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1	0x038
> +#define QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1			0x03c
> +#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x050
> +#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x054
> +#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
> +#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
> +#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0		0x060
> +#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0		0x064
> +#define QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0		0x06c
> +#define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0			0x070
> +#define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0		0x074
> +#define QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0		0x078
> +#define QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0		0x07c
> +#define QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0		0x080
> +#define QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0		0x084
> +#define QSERDES_PCIE_V6_40_COM_DEC_START_MODE0		0x088
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0	0x090
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0	0x094
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0	0x098
> +#define QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1	0x09c
> +#define QSERDES_PCIE_V6_40_COM_BG_TIMER			0x0bc
> +#define QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER			0x0c0
> +#define QSERDES_PCIE_V6_40_COM_SSC_PER1			0x0cc
> +#define QSERDES_PCIE_V6_40_COM_SSC_PER2			0x0d0
> +#define QSERDES_PCIE_V6_40_COM_POST_DIV_MUX			0x0d8
> +#define QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
> +#define QSERDES_PCIE_V6_40_COM_CLK_ENABLE1			0x0e0
> +#define QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL			0x0e4
> +#define QSERDES_PCIE_V6_40_COM_PLL_IVCO			0x0f4
> +#define QSERDES_PCIE_V6_40_COM_CMN_IETRIM			0x0fc
> +#define QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL		0x110
> +#define QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN			0x120
> +#define QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG			0x124
> +#define QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL			0x13c
> +#define QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP			0x140
> +#define QSERDES_PCIE_V6_40_COM_CLK_SELECT			0x164
> +#define QSERDES_PCIE_V6_40_COM_CORE_CLK_EN			0x170
> +#define QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1			0x174
> +#define QSERDES_PCIE_V6_40_COM_CMN_MISC1			0x188
> +#define QSERDES_PCIE_V6_40_COM_CMN_MODE			0x18c
> +#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1	0x1a0
> +#define QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL		0x19c
> +#define QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2			0x21c
> +#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2	0x220
> +#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2	0x224
> +#define QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2	0x228
> +#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2	0x230
> +#define QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2			0x22c
> +#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2		0x1cc
> +#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2		0x1d0
> +#define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2			0x1dc
> +#define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2		0x1e0
> +#define QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2		0x1e4
> +#define QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2		0x1e8
> +#define QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2		0x1ec
> +#define QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2		0x1f0
> +#define QSERDES_PCIE_V6_40_COM_DEC_START_MODE2		0x1f4
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2	0x1fc
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2	0x200
> +#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2	0x204
> +#define QSERDES_PCIE_V6_40_COM_DCC_CAL_1			0x2d8
> +#define QSERDES_PCIE_V6_40_COM_DCC_CAL_2			0x2dc
> +#define QSERDES_PCIE_V6_40_COM_DCC_CAL_3			0x2e0
> +#define QSERDES_PCIE_V6_40_COM_PSM_CAL_EN			0x2f0
> +#define QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1		0x2f4
> +#define QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL		0x2fc
> +#define QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO		0x2b8
> +#define QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1		0x0f8
> +#define QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2		0x218
> +#define QSERDES_PCIE_V6_40_COM_DCC_CAL_7			0x300
> +#define QSERDES_PCIE_V6_40_COM_DCC_CAL_8			0x304
> +#define QSERDES_PCIE_V6_40_COM_DCC_CAL_9			0x308
> +
> +#endif /* QCOM_PHY_QMP_QSERDES_COM_PCIE_V6_40_NORD_H_ */
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h
> new file mode 100644
> index 000000000000..dba8599be1fb
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h
> @@ -0,0 +1,194 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef QCOM_PHY_QMP_QSERDES_TXRXZ_PCIE_V6_40_NORD_H_
> +#define QCOM_PHY_QMP_QSERDES_TXRXZ_PCIE_V6_40_NORD_H_
> +
> +/* Lane mode / LDO */
> +#define QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL1	0x070
> +#define QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL2	0x074
> +#define QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL3	0x078
> +#define QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL4	0x07c

PCIE_V6_40 appears twice. Can we drop one?

Shawn

> +#define QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_1		0x094
> +#define QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_2		0x098
> +#define QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_3		0x09c
> +#define QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_4		0x0a0
> +#define QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_VREF_SEL		0x0bc
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B0	0x0f4
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B1	0x0f8
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B2	0x0fc
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B3	0x100
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B4	0x104
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B5	0x108
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B6	0x10c
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B7	0x110
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B0		0x114
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B1		0x118
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B2		0x11c
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B3		0x120
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B4		0x124
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B5		0x128
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B6		0x12c
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B7		0x130
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B0		0x134
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B1		0x138
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B2		0x13c
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B3		0x140
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B4		0x144
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B5		0x148
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B6		0x14c
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B7		0x150
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B0		0x154
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B1		0x158
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B2		0x15c
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B3		0x160
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B4		0x164
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B5		0x168
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B6		0x16c
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B7		0x170
> +
> +/* VCO / KVCO calibration */
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE0	0x1b4
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE0	0x1b8
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE1	0x1bc
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE1	0x1c0
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE2	0x1c4
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE2	0x1c8
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE3	0x1cc
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE3	0x1d0
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE4	0x1d4
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE4	0x1d8
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_0_1		0x1dc
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_2_3		0x1e0
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_0_1		0x1e8
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_2_3		0x1ec
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_4		0x1f0
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE0	0x1f4
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE1	0x1f8
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE2	0x1fc
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE0	0x220
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE0	0x224
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE1	0x228
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE1	0x22c
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE2	0x230
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE2	0x234
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE3	0x238
> +#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE4	0x240
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CODE_OVRD_RATE_2_3	0x250
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE0	0x258
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE1	0x260
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE2	0x268
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE3	0x270
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE4	0x278
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE0	0x280
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE1	0x284
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE2	0x288
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE3	0x28c
> +#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE4	0x290
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_SUMMER_CAL_SPD_MODE_RATE_0123	0x2a8
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL2		0x2c8
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL3		0x2cc
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL4		0x2d0
> +
> +/* Signal detect */
> +#define QSERDES_PCIE_V6_40_TXRXZ_SIGDET_ENABLES		0x31c
> +#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE0	0x33c
> +#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE1	0x340
> +#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE2	0x344
> +#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE3	0x348
> +#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE4	0x34c
> +
> +/* CDR */
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOCK_CTRL		0x364
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE0	0x368
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE1	0x36c
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE2	0x370
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE3	0x374
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE4	0x378
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE0	0x37c
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE1	0x380
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE2	0x384
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE3	0x388
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE4	0x38c
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_FLL_DIV_RATIO_RATE_0123	0x390
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_01	0x398
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_23	0x39c
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE4	0x3a0
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_0_1	0x3a4
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_2_3	0x3a8
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE4	0x3ac
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_0_1	0x3b0
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_2_3	0x3b4
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE4	0x3b8
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_0_1	0x3bc
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_2_3	0x3c0
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE4	0x3c4
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE_0123	0x3c8
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_TYPE_CONFIG	0x3d0
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_EN_LOWFREQ		0x3d4
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_FUNC_CTRL		0x3dc
> +
> +/* Rescode / residuals */
> +#define QSERDES_PCIE_V6_40_TXRXZ_RES_CODE_LANE_OFFSET_RX	0x3f4
> +
> +/* VGA / GM calibration */
> +#define QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE0_1		0x404
> +#define QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE2_3		0x408
> +#define QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE4		0x40c
> +
> +/* RX equalizer */
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL3	0x454
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL4	0x458
> +#define QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL5	0x45c
> +#define QSERDES_PCIE_V6_40_TXRXZ_CTLE_POST_CAL_OFFSET_RATE_0_1_2	0x478
> +#define QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE0_1	0x490
> +#define QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE2_3	0x494
> +#define QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE4	0x498
> +#define QSERDES_PCIE_V6_40_TXRXZ_VTHRESH_CAL_MAN_VAL_RATE4	0x4bc
> +
> +/* DFE */
> +#define QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP1_DAC_ENABLE	0x50c
> +#define QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP2_DAC_ENABLE	0x510
> +#define QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP345_DAC_ENABLE	0x514
> +#define QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP67_DAC_ENABLE	0x518
> +#define QSERDES_PCIE_V6_40_TXRXZ_PHPRE_CTRL			0x51c
> +#define QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH1	0x52c
> +#define QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH2	0x530
> +#define QSERDES_PCIE_V6_40_TXRXZ_TX_ADPT_CTRL		0x53c
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_CTRL		0x548
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_MAN_INDEX	0x550
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_ANA_CTRL	0x584
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_DIV2_CTRL_RATE0123	0x58c
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_OVRD_MUXES	0x5ac
> +#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE4	0x3cc
> +
> +/* Clock buffer / LDO stall control (used by bifurcated pre/post-pwrup sequences) */
> +#define QSERDES_PCIE_V6_40_TXRXZ_CLKBUF_ENABLE		0x04c
> +#define QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN	0x06c
> +#define QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL		0x0d8
> +
> +/* Restrim / VGA / signal-detect (v2-only) */
> +#define QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_CAL_CTRL		0x0b0
> +#define QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_POST_CAL_OFFSET	0x0b8
> +#define QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CNTRL		0x320
> +#define QSERDES_PCIE_V6_40_TXRXZ_SIGDET_LVL			0x324
> +#define QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CAL_CTRL1		0x32c
> +#define QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_CNTRL1		0x488
> +
> +/* BLW / VCO coarse-tune bands (v2-only) */
> +#define QSERDES_PCIE_V6_40_TXRXZ_BLW_CTRL			0x594
> +#define QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE3		0x5a4
> +#define QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE4		0x5a8
> +#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE0	0x5c4
> +#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE1	0x5c8
> +#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE2	0x5cc
> +#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE3	0x5d0
> +#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE4	0x5d4
> +
> +/* Analog backup control (v2-only) */
> +#define QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL15		0x7e8
> +#define QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL16		0x7ec
> +
> +#endif /* QCOM_PHY_QMP_QSERDES_TXRXZ_PCIE_V6_40_NORD_H_ */
> 
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
