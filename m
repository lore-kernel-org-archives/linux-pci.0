Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3751A75A
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950088; cv=none; b=Pc4xeHp2OaEEay4ZjFagP7cspVLwUb9f2sniuD6E0jXEQkQvIJ5fJY8c4gpmn215HVfF5EUCEIz7wEBv4kUCruPOADj2oOrEb8Bgmy4lOQH/nJJSsB7lxWYEzQTRojAhPnrCLiQJkSRzpe2zjELGgXeo1JGBAYdn7NsBNJDkluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950088; c=relaxed/simple;
	bh=LoO5gn01gfezHtGjXPfiDLXoxIMYzzFedBzH9A9uNzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQzoRwsi54WhDKXtDx2R9+Z3IODKtKjwwnPPJFMOP0N1n5Z6u9wpFMpD1l5EUzyFYGbRv/QWI8A0Tv5T6Vr4CWUf1N+IfeniEhTs57qDjvGg4gxW3vxWChEeIHsdCSvf1Cia1gowSc2Pd0YBJ9oKsRxtYv2zEBSZ7rPA+1TK7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JK45oSTs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UAI+yMcH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JK45oSTs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UAI+yMcH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689AS1X51587315
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 10:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HZKVqevr+f4SDFFILyDyA+pIAcubl2UEnmbSuspgO+g=; b=JK45oSTsJ0wg95ez
	xCg9H3qQjP4Bf84O8GiFItFrCc51HsaYPiKXLgRyhRA1YPxxKm/yI+zrSOWVLkG6
	za7AMmCmsmAxi24dUYg4KA9rT4PLMeNFTa+MpmiSqZeSOYToIctP1K/sUydXX7N6
	ftGiKso/jyAM0k7LAIJCeapK+2VpUkXTruZS0BliBMNg8f6mr4KocYL3WZbFs/4B
	C9naOi+L/WG3J3VnLX8dL3qRfEmrdmiabpn5/YGiRH2DxX3nVLD6MDjylQriHbbC
	yxXM3qwljICA5Syg8Ktl6rn6tG4GE4ktUR26AxeFlfhnHg59RPITCJUT6a8NMhMi
	VlanXw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5cnr3vx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 10:34:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86886f0d8a6so723394b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788950082; x=1789554882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZKVqevr+f4SDFFILyDyA+pIAcubl2UEnmbSuspgO+g=;
        b=UAI+yMcHD83pgGOJIz5WLQEgKdesBi+P8vFvTgLwaDWhjc7bLihyTbetZKoTztnhVe
         fDDWqPD9q/QpJACk5DvKp+X4PyLj65MkL7leU8rbUVWLo8zLS3r1+f/su+toLIiZUM5q
         RoYbB95N7k6GOd8bMgbpdMtXuLFnydRaa8+ubirNFUHJZfMhg0vNxsyULmyoBU4YOdUg
         0FXPDVLBYVOL7eVOZZcid7VPCEwNE9TQA/u+skd+yms7AL7CcOS3xjdd4Hosqa4bzfom
         L30opKDpSvtC+smsUgfGnCNoRzKBYjo1GxbEKl1YYFadyIosyPtoj34xtlUzLCEb+ZBm
         iEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950082; x=1789554882;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZKVqevr+f4SDFFILyDyA+pIAcubl2UEnmbSuspgO+g=;
        b=gPo9B41WGVoOFDMPfuwycdAsufao1amvtiN3SzhM/t7cnr/d8XhMTCi/+jpk68+gFf
         umOcVDwX1+9eZ62TGWIcn3Kj5regDwJIr61kaS0fQAY+h9gBYS2iREz3QlPPyGchZNPD
         u7K/6gHOVdGHYONZHyPkC2CtjKSJVowMlEVprtBlSCheaX+JzDz7A2UcdtYSJCfVkfGz
         L3W0ZQesR8KQ6HKHzc5O9ZnPXY6lDCqycI2DnXtK9Tju28TmY8XDnJ/0sUtadOf/vh1J
         gbE4RtVH0c65+pXdijxI6aYwD7C6NNDHXNSb5LIhamOxHTGg/Y0lFDK8RFbC9sw/8kLx
         tWFQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1km3CzXzkekKGbhBJauE+66gjciQ54VTZ+fWnq9q71K+RSemzu03x2sJvSDCmClMtbrPJ+83/Puo=@vger.kernel.org
X-Gm-Message-State: AFuF++meNoEeCwY6wXXJhWaWAKnPXbf7aLAMjvRKKo1VE55udaYprBuj
	dI6HwrGwtoxSoUepGnijscmDf7XTcZDWvGyihqAI51jaF1JdRZr7iCtYPZPokgU0dwGemT+0Vgb
	pzLyFGXl1dmhQwmFBos5dTkrROVD63W7J1wUXQLsubAXfsF57cv44dSGbUu/mxgE=
X-Gm-Gg: AYBFou2VBhl63s80wfzV1KTiHK25Y4aWjh7NJI6E+9zwpsOkmouGJKGQoTtn5UXRRrE
	E/7VyU85mN1mpLhj8l10BO5ErjX+Ayoq/hLkK+TNCCTa2pkTkPU0Vx40XHH1qMlhLnD7Hk33LQ0
	eTDTygHQGgbCOwmMJwH8+sn1IY01aXTBIXOKJFR2FFCE4Rw0UbsGFQhnV9a+Y033MZAZ6xmHQhy
	LkvC3WSicGTiwnfOUtkgTzKg2a0Aj+Ax/Y7kgvDq3ZLeMkXkPFxSsanYuDqeTDVxVqgmois+i7L
	aQV3M3D2j8yq5LIPRcItgrts7fYJbF9NCvBP4TMotLMGB2H10wQ7XBk3ypUA7qgQr0GQLhFmck0
	JVTT5eGVfYs+74eIUDg7kMEtMGL6QYKwR
X-Received: by 2002:a05:6a21:4014:b0:3c4:3767:adb2 with SMTP id adf61e73a8af0-3da39b71be4mr58124006637.1.1788950081526;
        Wed, 09 Sep 2026 03:34:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:4014:b0:3c4:3767:adb2 with SMTP id adf61e73a8af0-3da39b71be4mr58123846637.1.1788950080660;
        Wed, 09 Sep 2026 03:34:40 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm40217298c88.11.2026.09.09.03.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 03:34:40 -0700 (PDT)
Message-ID: <791eef12-5c83-4202-8c79-6a6b82fec4e8@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 16:04:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-4-18bf59d19d6f@oss.qualcomm.com>
 <ap5V5H921HmtZ8GT@hu-qianyu-lv.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ap5V5H921HmtZ8GT@hu-qianyu-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: haL5BPKd3Dfj5aFYt5rg7CJ2XVURcJgT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDExNiBTYWx0ZWRfX2+Y+ZZcVbvt/
 wo8tU5B9WmwIXjJs41g/sDHS8bIjIWrbGcvP+3SSkhNsl0N/jTZwPR5EcklgGATiJrNTh31Lu7r
 jCJHZ8/2diHpXlsN2zJY2MtT7ytxTGQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDExNiBTYWx0ZWRfX1VYj+y944oI8
 X5Eu+c7s9bt5l5lhjYpsre990tRyBlAvNnzWWfgnX1XCXKjhIDmWpB4QtFoWLLcft4TJ7m/8gon
 wZKXka7JLCYhAYpDlBM3GmDfb+3vRVwRnkapYz6KW42nGvN6y7BhnhCx74POh1cd0IyEnQG8wgR
 qEwOSiwwo4oSY7PTAxWq82ZQOaru9FowTvSLzjOIBDCSarKJxbq8FyEPAxSArTCgFZQLuRWMNvc
 KfV0q9yQeJIud9vMtHXEahoIDA2xseEbk5ielXHXNVdUsiTYivdcncueCctU37dopyJk3GV7zJa
 POgIXTn81pGUDlLLsL2BPuj6t6lSHAXczGCaUFVcNrnVvHmCTHqBpKrr6l7bcpScYzR51WBkl9N
 ysv300/BC0dHAKhXVROKQjBDMVoJnfw36W4DgRWHLDqXkTGRPRyYgGUGXxLGeCDHOWUG+clhAhi
 6n8yyvnTkaZkvp9DEJQ==
X-Authority-Analysis: v=2.4 cv=S+jpBosP c=1 sm=1 tr=0 ts=6aa13643 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aYOKuShIqjJ3fs-7b4MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: haL5BPKd3Dfj5aFYt5rg7CJ2XVURcJgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090116



On 9/7/2026 11:42 AM, Qiang Yu wrote:
> On Fri, Aug 28, 2026 at 02:13:38PM +0530, Krishna Chaitanya Chundru wrote:
>> Add support for the Nord Gen5x16 bifurcated QMP PCIe PHY.
>>
>> Nord has a single PCIe PHY block split into four ports which can be
>> used in multiple lane configurations: x16, x8+x8, x8+x4+x4 and
>> x8+x4+x2+x2. The active topology is selected through the link mode
>> configuration register, and the driver exposes the corresponding PHY
>> instances based on that mode.
>>
>> Unlike Glymur, where the PHY is initialized by firmware, Nord requires
>> Linux to program the PHY registers. Add the PLL, TXRXZ, PCS and PCS
>> lane initialization tables, along with the required power-up,
>> power-down and soft-reset sequencing.
>>
>> Add per-port and grouped PHY configurations for all supported Nord
>> lane modes. Also add support for regular PHY resets in addition to the
>> NOCSR resets, and handle the shared PHY power domain by attaching it
>> once at the multi-PHY level and reusing it across segment groups. The
>> GDSC init is now done using the device created for the PHY itself
>> (devm_phy_create()), rather than the parent multi-PHY platform device.
>>
> The commit message says the shared PHY power domain is attached at the
> multi-PHY level, but I couldn't find any related change in this patch.
> Is the change missing, or is it not required here?
This is not required, I will remove it in v3.

Ack for remaining comments.

- Krishna Chaitanya.
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c  | 1077 +++++++++++++++++++-
>>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h |   56 +
>>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h      |   14 +
>>  .../qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h |   94 ++
>>  .../phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h        |  194 ++++
>>  5 files changed, 1395 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
>> index e93cba4369fb..076b86bf9953 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
>> @@ -3,6 +3,7 @@
>>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>   */
>>  
>> +#include <linux/bits.h>
>>  #include <linux/clk.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/delay.h>
>> @@ -20,8 +21,16 @@
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/reset.h>
>>  #include <linux/slab.h>
>> +#include <linux/string.h>
>> +
>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>>  
>>  #include "phy-qcom-qmp.h"
>> +#include "phy-qcom-qmp-common.h"
>> +#include "phy-qcom-qmp-pcs-v6_40.h"
>> +#include "phy-qcom-qmp-pcs-pcie-v6_40.h"
>> +#include "phy-qcom-qmp-qserdes-com-pcie-v6_40.h"
>> +#include "phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h"
>>  
>>  #define PHY_INIT_COMPLETE_TIMEOUT_US		10000
>>  
>> @@ -30,8 +39,19 @@ enum qmp_pcie_glymur_link_mode {
>>  	QMP_PCIE_GLYMUR_MODE_X4X4,
>>  };
>>  
>> +enum qmp_pcie_nord_link_mode {
>> +	QMP_PCIE_NORD_MODE_X16,
>> +	QMP_PCIE_NORD_MODE_X8_X8,
>> +	QMP_PCIE_NORD_MODE_X8_X4_X4,
>> +	QMP_PCIE_NORD_MODE_X8_X4_X2_X2
>> +};
>> +
>>  enum qphy_reg_layout {
>>  	QPHY_PCS_STATUS,
>> +	QPHY_PCS_START_CONTROL,
>> +	QPHY_PCS_SW_RESET,
>> +	QPHY_PCS_POWER_DOWN_CONTROL,
>> +	QPHY_COM_BIAS_EN_CLKBUFLR_EN,
>>  	QPHY_LAYOUT_SIZE
>>  };
>>  
>> @@ -39,16 +59,42 @@ static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
>>  	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
>>  };
>>  
>> +static const unsigned int nord_pciephy_v6_40_regs_layout[QPHY_LAYOUT_SIZE] = {
>> +	[QPHY_PCS_STATUS]		= QPHY_V6_40_PCS_STATUS1,
>> +	[QPHY_PCS_START_CONTROL]	= QPHY_V6_40_PCS_START_CONTROL,
>> +	[QPHY_PCS_SW_RESET]		= QPHY_V6_40_PCS_SW_RESET,
>> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_40_PCS_POWER_DOWN_CONTROL,
>> +	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,
>> +};
>> +
>>  struct qmp_pcie_offsets {
>>  	u16 pcs;
>> +	u16 pll;
>> +	u16 txrxz;
>> +	u16 pcs_lanez;
>> +};
>> +
>> +struct qmp_phy_cfg_tbls {
>> +	const struct qmp_phy_init_tbl *txrxz;
>> +	int txrxz_num;
>> +	const struct qmp_phy_init_tbl *pcs;
>> +	int pcs_num;
>> +	const struct qmp_phy_init_tbl *pcs_lanez;
>> +	int pcs_lanez_num;
>>  };
>>  
>>  struct qmp_phy_cfg {
>>  	const struct qmp_pcie_offsets *offsets;
>> +	struct qmp_phy_cfg_tbls tbls;
>> +	struct qmp_phy_init_tbl **pll_tbls;
>> +	int *pll_nums;
>> +	bool bifurcated;
>>  	const char * const *reg_names;
>>  	int num_regs;
>>  	const char * const *pd_names;
>>  	int num_pds;
>> +	const char * const *reset_list;
>> +	int num_resets;
>>  	const char * const *nocsr_reset_list;
>>  	int num_nocsr_resets;
>>  	const char * const *vreg_list;
>> @@ -67,6 +113,7 @@ struct qmp_pcie {
>>  	void __iomem **base;
>>  	struct clk_bulk_data *clks;
>>  	struct clk_bulk_data *pipe_clks;
>> +	struct reset_control_bulk_data *resets;
>>  	struct reset_control_bulk_data *nocsr_resets;
>>  	struct regulator_bulk_data *vregs;
>>  	struct device **pd_devs;
>> @@ -89,6 +136,10 @@ struct qmp_pcie_match_data {
>>  	u32 num_modes;
>>  };
>>  
>> +/* QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN bits */
>> +#define COM_BIAS_EN				BIT(0)
>> +#define COM_BIAS_EN_MUX				BIT(1)
>> +
>>  static const char * const glymur_pciephy_clk_l[] = {
>>  	"aux", "cfg_ahb", "ref", "rchng", "phy_b_aux",
>>  };
>> @@ -232,6 +283,890 @@ static const struct qmp_pcie_match_data glymur_qmp_gen5x8_match_data = {
>>  	.num_modes	= ARRAY_SIZE(glymur_qmp_gen5x8_mode_cfgs),
>>  };
>>  
>> +static const char * const nord_pciephy_port_a_vreg_l[] = {
>> +	"vdda-phy-a", "vdda-pll-a",
>> +};
>> +
>> +static const char * const nord_pciephy_port_b_vreg_l[] = {
>> +	"vdda-phy-b", "vdda-pll-b",
>> +};
>> +
>> +static const char * const nord_pciephy_port_c_vreg_l[] = {
>> +	"vdda-phy-c", "vdda-pll-c",
>> +};
>> +
>> +static const char * const nord_pciephy_port_d_vreg_l[] = {
>> +	"vdda-phy-d", "vdda-pll-d",
>> +};
>> +
>> +static const char * const nord_pciephy_port_cd_vreg_l[] = {
>> +	"vdda-phy-c", "vdda-phy-d", "vdda-pll-c", "vdda-pll-d",
>> +};
>> +
>> +static const char * const nord_pciephy_port_bcd_vreg_l[] = {
>> +	"vdda-phy-b", "vdda-phy-c", "vdda-phy-d",
>> +	"vdda-pll-b", "vdda-pll-c", "vdda-pll-d",
>> +};
>> +
>> +static const char * const nord_pciephy_port_abcd_vreg_l[] = {
>> +	"vdda-phy-a", "vdda-phy-b", "vdda-phy-c", "vdda-phy-d",
>> +	"vdda-pll-a", "vdda-pll-b", "vdda-pll-c", "vdda-pll-d",
>> +};
>> +
>> +static const struct qmp_pcie_offsets nord_pcie_offsets_v6_40 = {
>> +	.pll      = 0x8000,
>> +	.pcs      = 0x9000,
>> +	.txrxz    = 0xd000,
>> +	.pcs_lanez = 0xe800,
>> +};
>> +
>> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_a_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1,            0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2,        0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2,        0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2,           0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2,             0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2,             0x1a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE2,             0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2,       0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2,  0xa4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2,  0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1,        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1,        0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1,           0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1,             0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1,             0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE1,             0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1,       0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1,  0x52),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1,  0x0c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1,                 0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2,                 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1,      0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2,      0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0,        0xe0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0,        0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0,           0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0,             0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0,             0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE0,             0x41),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0,       0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0,  0xd4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0,  0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1,       0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2,       0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BG_TIMER,                    0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL,               0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER,               0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER1,                    0x62),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER2,                    0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_POST_DIV_MUX,                0xc0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,         0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_ENABLE1,                 0x90),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL,                0x82),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO,                    0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1,              0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2,              0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL,               0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN,                 0x46),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG,                0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP,                0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_SELECT,                  0x34),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORE_CLK_EN,                 0xe0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1,                0x86),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MISC1,                   0x88),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MODE,                    0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL,           0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2,                0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1,            0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0,            0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PSM_CAL_EN,                  0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO,           0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_1,                   0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_2,                   0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_3,                   0x60),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_8,                   0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL,          0xaf),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_IETRIM,                  0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x31),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x31),
>> +};
>> +
>> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_b_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1,            0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2,        0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2,        0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2,           0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2,             0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2,             0x1a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE2,             0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2,       0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2,  0xa4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2,  0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1,        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1,        0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1,           0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1,             0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1,             0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE1,             0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1,       0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1,  0x52),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1,  0x0c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1,                 0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2,                 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1,      0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2,      0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0,        0xe0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0,        0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0,           0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0,             0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0,             0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE0,             0x41),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0,       0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0,  0xd4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0,  0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1,       0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2,       0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BG_TIMER,                    0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL,               0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER,               0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER1,                    0x62),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER2,                    0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_POST_DIV_MUX,                0xc0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,         0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_ENABLE1,                 0x90),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL,                0x82),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO,                    0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1,              0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2,              0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL,               0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN,                 0x46),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG,                0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP,                0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_SELECT,                  0x34),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORE_CLK_EN,                 0xe0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1,                0x86),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MISC1,                   0x88),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MODE,                    0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL,           0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2,                0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1,            0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0,            0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PSM_CAL_EN,                  0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO,           0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_1,                   0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_2,                   0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_3,                   0x60),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_8,                   0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL,          0xaf),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_IETRIM,                  0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x22),
>> +};
>> +
>> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_c_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1,            0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2,        0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2,        0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2,           0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2,             0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2,             0x1a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE2,             0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2,       0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2,  0xa4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2,  0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1,        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1,        0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1,           0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1,             0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1,             0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE1,             0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1,       0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1,  0x52),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1,  0x0c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1,                 0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2,                 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1,      0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2,      0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0,        0xe0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0,        0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0,           0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0,             0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0,             0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE0,             0x41),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0,       0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0,  0xd4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0,  0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1,       0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2,       0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BG_TIMER,                    0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL,               0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER,               0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER1,                    0x62),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER2,                    0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_POST_DIV_MUX,                0xc0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,         0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_ENABLE1,                 0x90),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL,                0x82),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO,                    0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1,              0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2,              0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL,               0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN,                 0x46),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG,                0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP,                0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_SELECT,                  0x34),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORE_CLK_EN,                 0xe0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1,                0x86),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MISC1,                   0x88),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MODE,                    0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL,           0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2,                0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1,            0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0,            0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PSM_CAL_EN,                  0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO,           0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_1,                   0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_2,                   0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_3,                   0x60),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_8,                   0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL,          0xaf),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_IETRIM,                  0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x20),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x31),
>> +};
>> +
>> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_d_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1,            0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2,        0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2,        0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2,           0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2,             0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2,             0x1a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE2,             0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2,       0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2,  0xa4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2,  0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1,        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1,        0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1,           0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1,             0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1,             0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE1,             0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1,       0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1,  0x52),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1,  0x0c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1,                 0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2,                 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1,      0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2,      0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0,        0xe0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0,        0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0,               0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0,             0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0,             0x36),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0,           0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0,             0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0,             0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE0,             0x41),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0,       0xab),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0,       0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0,       0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0,  0xd4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0,  0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1,       0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2,       0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BG_TIMER,                    0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL,               0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER,               0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER1,                    0x62),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER2,                    0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_POST_DIV_MUX,                0xc0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,         0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_ENABLE1,                 0x90),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL,                0x82),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO,                    0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1,              0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2,              0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL,               0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN,                 0x46),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG,                0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP,                0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_SELECT,                  0x34),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORE_CLK_EN,                 0xe0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1,                0x86),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MISC1,                   0x88),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MODE,                    0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL,           0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2,                0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1,            0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0,            0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PSM_CAL_EN,                  0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO,           0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_1,                   0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_2,                   0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_3,                   0x60),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_8,                   0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL,          0xaf),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_IETRIM,                  0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7,                   0x22),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9,                   0x22),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl nord_qmp_pcie_txrxz_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_ENABLES,                     0x1c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B0,                   0xcd),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B1,                   0x34),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B2,                   0x55),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B3,                   0x50),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B4,                   0xac),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B5,                   0xdb),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B6,                   0x52),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B7,                   0x3e),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B0,                   0xce),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B1,                   0x55),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B2,                   0x6d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B3,                   0x60),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B4,                   0x8c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B5,                   0x9d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B6,                   0x6d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B7,                   0x26),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B0,                   0xfb),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B1,                   0xea),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B2,                   0xe8),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B3,                   0x70),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B4,                   0x9c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B5,                   0xf4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B6,                   0x6d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B7,                   0x3b),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_SUMMER_CAL_SPD_MODE_RATE_0123,   0x6f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH1,              0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH2,              0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PHPRE_CTRL,                         0x20),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADPT_CTRL,                       0x30),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B0,                0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B1,                0x4a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B2,                0x77),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B3,                0x50),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B4,                0x9a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B5,                0x47),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B6,                0x52),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B7,                0x1d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_1,                        0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_2,                        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_3,                        0x41),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_4,                        0x0f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL1,           0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL2,           0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL3,           0x81),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PCIE_V6_40_TOP_LDO_CODE_CTRL4,           0x8d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOCK_CTRL,                      0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP1_DAC_ENABLE,                0x1c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP2_DAC_ENABLE,                0x1c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP345_DAC_ENABLE,              0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP67_DAC_ENABLE,               0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE0,               0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE1,               0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE2,               0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE3,               0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE4,               0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE0,               0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE1,               0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE2,               0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE3,               0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE4,               0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_FLL_DIV_RATIO_RATE_0123,        0x94),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_01,             0x66),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_23,             0x77),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE4,               0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_CTRL,                    0x58),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_MAN_INDEX,               0x0d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_ANA_CTRL,                0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_FUNC_CTRL,                 0xd0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE0,  0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE1,  0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE2,  0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE3,  0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE4,  0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE0,   0x15),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE1,   0x15),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE2,   0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE3,   0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE4,   0x0c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CODE_OVRD_RATE_2_3,              0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL2,                  0x83),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL3,                  0x44),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL4,                  0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_0_1,        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_2_3,        0x11),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE4,           0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_0_1,        0x33),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_2_3,        0x33),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE4,           0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_0_1,       0x22),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_2_3,       0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE4,          0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_DIV2_CTRL_RATE0123,      0x7f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE0,      0x13),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE0,      0x13),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE1,      0x26),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE1,      0x26),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE2,      0x9c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE2,      0x3d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE3,      0x9c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE3,      0x3d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE4,      0x09),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE4,      0x3d),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL3,              0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL4,              0xaa),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL5,              0x0a),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_CNTRL1,                     0xe1),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE0_1,            0xdd),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE2_3,            0xdc),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE4,              0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_OVRD_MUXES,        0x11),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE_0123,         0x55),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE4,             0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE0,        0x4b),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE0,        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE1,        0x4b),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE1,        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE2,        0x35),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE2,        0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE3,        0x28),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE4,        0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_0_1,                 0x11),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_2_3,                 0x22),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_4,                   0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE0,               0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE1,               0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE2,               0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE0,            0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE1,            0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE2,            0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE3,            0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE4,            0xff),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_0_1,                 0x43),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_2_3,                 0x44),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_TYPE_CONFIG,                0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CTLE_POST_CAL_OFFSET_RATE_0_1_2,    0x67),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_EN_LOWFREQ,                 0x1f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RES_CODE_LANE_OFFSET_RX,            0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE0_1,                 0x88),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE2_3,                 0x88),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE4,                   0x09),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VTHRESH_CAL_MAN_VAL_RATE4,          0x56),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CLKBUF_ENABLE,                      0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE0,          0x1e),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE1,          0x1e),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE2,          0x1e),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE3,          0x1e),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE4,          0x1e),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CNTRL,                       0x2f),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_LVL,                         0x84),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CAL_CTRL1,                   0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL15,                    0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL16,                    0x52),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_CAL_CTRL,                   0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_POST_CAL_OFFSET,            0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_VREF_SEL,                   0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_CTRL,                           0x3c),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE3,                  0x17),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE4,                  0x17),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG2,        0x3d),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG5,        0xe4),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG6,        0x1f),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG7,        0x0d),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_MULTIPHY_CONFIG2,           0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG2,          0xe4),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG3,          0x30),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG5,          0x05),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG6,          0x08),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG7,          0x20),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG8,          0x20),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG10,         0x40),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG2,  0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG3,  0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG4,  0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ENDPOINT_REFCLK_DRIVE,      0xc1),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_RX_SIGDET_LVL,              0x66),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_OSC_DTCT_ACTIONS,           0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_LOCK_DETECT_CONFIG1,        0xff),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG1,       0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG2,       0x04),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG3,       0x1f),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG7,       0x35),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG8,       0x3e),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG1,                 0x06),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG2,                 0x1c),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG1,            0x03),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG3,            0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG1,              0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG5,              0x90),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG7,              0x0d),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG1,              0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG5,              0x90),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG7,              0x0d),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG1,              0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG5,              0x90),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG7,              0x0d),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_TEST_CONTROL1,              0x08),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_lanez_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL2,  0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL5,  0x00),
>> +};
>> +
>> +static const struct qmp_phy_cfg_tbls nord_qmp_pcie_tbls = {
>> +	.txrxz     = nord_qmp_pcie_txrxz_tbl,
>> +	.txrxz_num = ARRAY_SIZE(nord_qmp_pcie_txrxz_tbl),
>> +	.pcs       = nord_qmp_pcie_pcs_tbl,
>> +	.pcs_num   = ARRAY_SIZE(nord_qmp_pcie_pcs_tbl),
>> +	.pcs_lanez     = nord_qmp_pcie_pcs_lanez_tbl,
>> +	.pcs_lanez_num = ARRAY_SIZE(nord_qmp_pcie_pcs_lanez_tbl),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl nord_qmp_pcie_bifurcated_pre_pwrup_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN,  0x80),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL,          0x91),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl nord_qmp_pcie_bifurcated_post_cfg_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL,          0x11),
>> +	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN,  0x00),
>> +};
>> +
>> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_a[] = {
>> +	nord_qmp_pcie_pll_a_tbl,
>> +};
>> +
>> +static int nord_qmp_pcie_pll_a_nums[] = {
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_a_tbl),
>> +};
>> +
>> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_b[] = {
>> +	nord_qmp_pcie_pll_b_tbl,
>> +};
>> +
>> +static int nord_qmp_pcie_pll_b_nums[] = {
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_b_tbl),
>> +};
>> +
>> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_c[] = {
>> +	nord_qmp_pcie_pll_c_tbl,
>> +};
>> +
>> +static int nord_qmp_pcie_pll_c_nums[] = {
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_tbl),
>> +};
>> +
>> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_d[] = {
>> +	nord_qmp_pcie_pll_d_tbl,
>> +};
>> +
>> +static int nord_qmp_pcie_pll_d_nums[] = {
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_d_tbl),
>> +};
>> +
>> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_cd[] = {
>> +	nord_qmp_pcie_pll_c_tbl, nord_qmp_pcie_pll_d_tbl,
>> +};
>> +
>> +static int nord_qmp_pcie_pll_cd_nums[] = {
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_d_tbl),
>> +};
>> +
>> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_bcd[] = {
>> +	nord_qmp_pcie_pll_b_tbl, nord_qmp_pcie_pll_c_tbl, nord_qmp_pcie_pll_d_tbl,
>> +};
>> +
>> +static int nord_qmp_pcie_pll_bcd_nums[] = {
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_b_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_c_tbl),
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_d_tbl),
>> +};
>> +
>> +static struct qmp_phy_init_tbl *nord_qmp_pcie_pll_abcd[] = {
>> +	nord_qmp_pcie_pll_a_tbl, nord_qmp_pcie_pll_b_tbl,
>> +	nord_qmp_pcie_pll_c_tbl, nord_qmp_pcie_pll_d_tbl,
>> +};
>> +
>> +static int nord_qmp_pcie_pll_abcd_nums[] = {
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_a_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_b_tbl),
>> +	ARRAY_SIZE(nord_qmp_pcie_pll_c_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_d_tbl),
>> +};
>> +
>> +static const char * const nord_pciephy_port_a_reg_l[] = { "port_a" };
>> +static const char * const nord_pciephy_port_b_reg_l[] = { "port_b" };
>> +static const char * const nord_pciephy_port_c_reg_l[] = { "port_c" };
>> +static const char * const nord_pciephy_port_d_reg_l[] = { "port_d" };
>> +static const char * const nord_pciephy_port_cd_reg_l[] = { "port_c", "port_d" };
>> +static const char * const nord_pciephy_port_bcd_reg_l[] = { "port_b", "port_c", "port_d" };
>> +static const char * const nord_pciephy_port_abcd_reg_l[] = {
>> +	"port_a", "port_b", "port_c", "port_d"
>> +};
>> +
>> +static const char * const nord_pciephy_port_a_clk_l[] = { "aux_a", "cfg_ahb_a", "rchng_a", "ref" };
>> +static const char * const nord_pciephy_port_b_clk_l[] = {
>> +	"aux_a", "aux_b", "cfg_ahb_b", "rchng_b", "ref",
>> +};
>> +
>> +static const char * const nord_pciephy_port_c_clk_l[] = {
>> +	"aux_a", "aux_c", "cfg_ahb_c", "rchng_c", "ref",
>> +};
>> +
>> +static const char * const nord_pciephy_port_d_clk_l[] = {
>> +	"aux_a", "aux_d", "cfg_ahb_d", "rchng_d", "ref",
>> +};
>> +
>> +static const char * const nord_pciephy_port_cd_clk_l[] = {
>> +	"aux_a", "aux_c", "cfg_ahb_c", "rchng_c", "aux_d", "cfg_ahb_d", "rchng_d", "ref",
>> +};
>> +
>> +static const char * const nord_pciephy_port_bcd_clk_l[] = {
>> +	"aux_a", "aux_b", "cfg_ahb_b", "rchng_b",
>> +	"aux_c", "cfg_ahb_c", "rchng_c",
>> +	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
>> +};
>> +
>> +static const char * const nord_pciephy_port_abcd_clk_l[] = {
>> +	"aux_a", "cfg_ahb_a", "rchng_a",
>> +	"aux_b", "cfg_ahb_b", "rchng_b",
>> +	"aux_c", "cfg_ahb_c", "rchng_c",
>> +	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
>> +};
>> +
>> +static const char * const nord_pciephy_port_a_pipeclk_l[] = { "pipe_a" };
>> +static const char * const nord_pciephy_port_b_pipeclk_l[] = { "pipe_b" };
>> +static const char * const nord_pciephy_port_c_pipeclk_l[] = { "pipe_c" };
>> +static const char * const nord_pciephy_port_d_pipeclk_l[] = { "pipe_d" };
>> +
>> +static const char * const nord_pciephy_port_a_reset_l[] = { "port_a" };
>> +static const char * const nord_pciephy_port_b_reset_l[] = { "port_b" };
>> +static const char * const nord_pciephy_port_c_reset_l[] = { "port_c" };
>> +static const char * const nord_pciephy_port_d_reset_l[] = { "port_d" };
>> +static const char * const nord_pciephy_port_cd_reset_l[] = {
>> +	"port_c", "port_d",
>> +};
>> +
>> +static const char * const nord_pciephy_port_bcd_reset_l[] = {
>> +	"port_b", "port_c", "port_d",
>> +};
>> +
>> +static const char * const nord_pciephy_port_abcd_reset_l[] = {
>> +	"port_a", "port_b", "port_c", "port_d",
>> +};
>> +
>> +static const char * const nord_pciephy_port_a_nocsr_reset_l[] = { "port_a_nocsr" };
>> +static const char * const nord_pciephy_port_b_nocsr_reset_l[] = { "port_b_nocsr" };
>> +static const char * const nord_pciephy_port_c_nocsr_reset_l[] = { "port_c_nocsr" };
>> +static const char * const nord_pciephy_port_d_nocsr_reset_l[] = { "port_d_nocsr" };
>> +static const char * const nord_pciephy_port_cd_nocsr_reset_l[] = { "port_c_nocsr", "port_d_nocsr" };
>> +static const char * const nord_pciephy_port_bcd_nocsr_reset_l[] = {
>> +	"port_b_nocsr", "port_c_nocsr", "port_d_nocsr",
>> +};
>> +
>> +static const char * const nord_pciephy_port_abcd_nocsr_reset_l[] = {
>> +	"port_a_nocsr", "port_b_nocsr", "port_c_nocsr", "port_d_nocsr",
>> +};
>> +
>> +static const char * const nord_pciephy_port_a_pd_l[] = { "port_a" };
>> +static const char * const nord_pciephy_port_b_pd_l[] = { "port_a", "port_b" };
>> +static const char * const nord_pciephy_port_c_pd_l[] = { "port_a", "port_c" };
>> +static const char * const nord_pciephy_port_d_pd_l[] = { "port_a", "port_d" };
>> +static const char * const nord_pciephy_port_cd_pd_l[] = {
>> +	"port_a", "port_c", "port_d",
>> +};
>> +
>> +static const char * const nord_pciephy_port_bcd_pd_l[] = {
>> +	"port_a", "port_b", "port_c", "port_d",
>> +};
>> +
>> +#define nord_pciephy_port_abcd_pd_l nord_pciephy_port_bcd_pd_l
>> +
>> +#define NORD_QMP_PCIE_PORT_CFG(_port, _pipeclk_l, _bifurcated)			\
>> +static const struct qmp_phy_cfg nord_qmp_pcie_port_##_port##_cfg = {		\
>> +	.offsets		= &nord_pcie_offsets_v6_40,			\
>> +	.tbls			= nord_qmp_pcie_tbls,				\
>> +	.pll_tbls		= nord_qmp_pcie_pll_##_port,			\
>> +	.pll_nums		= nord_qmp_pcie_pll_##_port##_nums,		\
>> +	.bifurcated		= _bifurcated,					\
>> +	.reg_names		= nord_pciephy_port_##_port##_reg_l,		\
>> +	.num_regs		= ARRAY_SIZE(nord_pciephy_port_##_port##_reg_l),	\
>> +	.pd_names		= nord_pciephy_port_##_port##_pd_l,		\
>> +	.num_pds		= ARRAY_SIZE(nord_pciephy_port_##_port##_pd_l),	\
>> +	.reset_list		= nord_pciephy_port_##_port##_reset_l,		\
>> +	.num_resets		= ARRAY_SIZE(nord_pciephy_port_##_port##_reset_l),	\
>> +	.nocsr_reset_list	= nord_pciephy_port_##_port##_nocsr_reset_l,	\
>> +	.num_nocsr_resets	= ARRAY_SIZE(nord_pciephy_port_##_port##_nocsr_reset_l), \
>> +	.vreg_list		= nord_pciephy_port_##_port##_vreg_l,		\
>> +	.num_vregs		= ARRAY_SIZE(nord_pciephy_port_##_port##_vreg_l),	\
>> +	.regs			= nord_pciephy_v6_40_regs_layout,	\
>> +	.phy_status		= PHYSTATUS_4_20,				\
>> +	.clk_list		= nord_pciephy_port_##_port##_clk_l,		\
>> +	.num_clks		= ARRAY_SIZE(nord_pciephy_port_##_port##_clk_l),	\
>> +	.pipe_clk_list		= _pipeclk_l,					\
>> +	.num_pipe_clks		= 1,						\
>> +}
>> +
>> +NORD_QMP_PCIE_PORT_CFG(a, nord_pciephy_port_a_pipeclk_l, true);
>> +NORD_QMP_PCIE_PORT_CFG(b, nord_pciephy_port_b_pipeclk_l, true);
>> +NORD_QMP_PCIE_PORT_CFG(c, nord_pciephy_port_c_pipeclk_l, true);
>> +NORD_QMP_PCIE_PORT_CFG(d, nord_pciephy_port_d_pipeclk_l, true);
>> +NORD_QMP_PCIE_PORT_CFG(cd, nord_pciephy_port_c_pipeclk_l, true);
>> +NORD_QMP_PCIE_PORT_CFG(bcd, nord_pciephy_port_b_pipeclk_l, true);
>> +NORD_QMP_PCIE_PORT_CFG(abcd, nord_pciephy_port_a_pipeclk_l, false);
>> +
>> +#undef NORD_QMP_PCIE_PORT_CFG
>> +
>> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x16_cfgs[] = {
>> +	&nord_qmp_pcie_port_abcd_cfg,
>> +};
>> +
>> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x8_cfgs[] = {
>> +	&nord_qmp_pcie_port_a_cfg,
>> +	&nord_qmp_pcie_port_bcd_cfg,
>> +};
>> +
>> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x4x4_cfgs[] = {
>> +	&nord_qmp_pcie_port_a_cfg,
>> +	&nord_qmp_pcie_port_b_cfg,
>> +	&nord_qmp_pcie_port_cd_cfg,
>> +};
>> +
>> +static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x4x2x2_cfgs[] = {
>> +	&nord_qmp_pcie_port_a_cfg,
>> +	&nord_qmp_pcie_port_b_cfg,
>> +	&nord_qmp_pcie_port_c_cfg,
>> +	&nord_qmp_pcie_port_d_cfg,
>> +};
>> +
>> +static const struct qmp_pcie_link_mode_cfg nord_qmp_gen5x16_mode_cfgs[] = {
>> +	[QMP_PCIE_NORD_MODE_X16] = {
>> +		.cfgs		= nord_qmp_gen5x16_mode_x16_cfgs,
>> +		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x16_cfgs),
>> +	},
>> +	[QMP_PCIE_NORD_MODE_X8_X8] = {
>> +		.cfgs		= nord_qmp_gen5x16_mode_x8x8_cfgs,
>> +		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x8_cfgs),
>> +	},
>> +	[QMP_PCIE_NORD_MODE_X8_X4_X4] = {
>> +		.cfgs		= nord_qmp_gen5x16_mode_x8x4x4_cfgs,
>> +		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x4x4_cfgs),
>> +	},
>> +	[QMP_PCIE_NORD_MODE_X8_X4_X2_X2] = {
>> +		.cfgs		= nord_qmp_gen5x16_mode_x8x4x2x2_cfgs,
>> +		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x4x2x2_cfgs),
>> +	},
>> +};
>> +
>> +static const struct qmp_pcie_match_data nord_qmp_gen5x16_match_data = {
>> +	.mode_cfgs		= nord_qmp_gen5x16_mode_cfgs,
>> +	.num_modes		= ARRAY_SIZE(nord_qmp_gen5x16_mode_cfgs),
>> +};
>> +
>> +static void qmp_pcie_init_port_registers(struct qmp_pcie *qmp)
>> +{
>> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
>> +	const struct qmp_phy_cfg_tbls *tbls = &cfg->tbls;
>> +	int i;
>> +
>> +	for (i = 0; i < cfg->num_regs; i++) {
>> +		void __iomem *port = qmp->base[i];
>> +		u32 val;
>> +
>> +		if (cfg->bifurcated)
>> +			qmp_configure(qmp->dev, port + offs->txrxz,
>> +				      nord_qmp_pcie_bifurcated_pre_pwrup_tbl,
>> +				      ARRAY_SIZE(nord_qmp_pcie_bifurcated_pre_pwrup_tbl));
>> +
>> +		writel(SW_PWRDN | REFCLK_DRV_DSBL,
>> +		       port + offs->pcs + cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]);
>> +
>> +		if (cfg->bifurcated) {
>> +			void __iomem *bias_en = port + offs->pll +
>> +						cfg->regs[QPHY_COM_BIAS_EN_CLKBUFLR_EN];
>> +
>> +			val = readl(bias_en);
>> +			val |= COM_BIAS_EN_MUX | COM_BIAS_EN;
>> +			writel(val, bias_en);
>> +		}
>> +
>> +		qmp_configure(qmp->dev, port + offs->pll,
>> +			      cfg->pll_tbls[i], cfg->pll_nums[i]);
>> +		qmp_configure(qmp->dev, port + offs->txrxz,
>> +			      tbls->txrxz, tbls->txrxz_num);
>> +		qmp_configure(qmp->dev, port + offs->pcs,
>> +			      tbls->pcs, tbls->pcs_num);
>> +		qmp_configure(qmp->dev, port + offs->pcs_lanez,
>> +			      tbls->pcs_lanez, tbls->pcs_lanez_num);
>> +
>> +		if (cfg->bifurcated)
>> +			qmp_configure(qmp->dev, port + offs->txrxz,
>> +				      nord_qmp_pcie_bifurcated_post_cfg_tbl,
>> +				      ARRAY_SIZE(nord_qmp_pcie_bifurcated_post_cfg_tbl));
>> +	}
>> +}
>> +
>>  static int qmp_pcie_pd_power_on(struct qmp_pcie *qmp)
>>  {
>>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> @@ -280,20 +1215,37 @@ static int qmp_pcie_init(struct phy *phy)
>>  		goto err_pd_power_off;
>>  	}
>>  
>> +	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>> +	if (ret) {
>> +		dev_err(qmp->dev, "reset assert failed: %d\n", ret);
>> +		goto err_disable_regulators;
>> +	}
>> +
>>  	ret = reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
>>  	if (ret) {
>>  		dev_err(qmp->dev, "no-csr reset assert failed: %d\n", ret);
>> -		goto err_disable_regulators;
>> +		goto err_assert_reset;
>>  	}
>>  
>>  	usleep_range(200, 300);
>>  
>> +	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
>> +	if (ret) {
>> +		dev_err(qmp->dev, "reset deassert failed: %d\n", ret);
>> +		goto err_assert_reset;
>> +	}
>> +
>>  	ret = clk_bulk_prepare_enable(qmp->cfg->num_clks, qmp->clks);
>>  	if (ret)
>> -		goto err_disable_regulators;
>> +		goto err_assert_reset;
>> +
>> +	if (cfg->pll_tbls)
>> +		qmp_pcie_init_port_registers(qmp);
>>  
>>  	return 0;
>>  
>> +err_assert_reset:
>> +	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>  err_disable_regulators:
>>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
>>  err_pd_power_off:
>> @@ -306,8 +1258,19 @@ static int qmp_pcie_exit(struct phy *phy)
>>  {
>>  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
>> +	int i;
>>  
>> -	reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
>> +	if (cfg->pll_tbls) {
>> +		for (i = 0; i < cfg->num_regs; i++)
>> +			writel(0x00, qmp->base[i] + offs->pcs +
>> +			       cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]);
>> +	}
> Could these three registers — QPHY_PCS_POWER_DOWN_CONTROL, QPHY_SW_RESET
> and PHY_START_CTRL — be handled together in a single place, rather than
> being written separately in qmp_pcie_exit() and qmp_pcie_power_off()?
>
> In addition, when nocsr_reset is supported, I think we can skip these
> writes entirely: the PHY would then inherit the configuration programmed
> during boot on each resume from suspend, instead of being reprogrammed
> every time.
>
>> +
>> +	if (qmp->nocsr_resets)
>> +		reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
>> +	if (qmp->resets)
>> +		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>  
>>  	clk_bulk_disable_unprepare(qmp->cfg->num_clks, qmp->clks);
>>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
>> @@ -335,6 +1298,15 @@ static int qmp_pcie_power_on(struct phy *phy)
>>  		goto err_disable_pipe_clk;
>>  	}
>>  
>> +	if (cfg->pll_tbls) {
>> +		for (i = 0; i < cfg->num_regs; i++) {
>> +			writel(0x00, qmp->base[i] + offs->pcs + cfg->regs[QPHY_PCS_SW_RESET]);
>> +			writel(0x03, qmp->base[i] + offs->pcs + cfg->regs[QPHY_PCS_START_CONTROL]);
> Can you use qphy_setbits here and in qmp_pcie_exit? Move qphy_setbits to a
> common file and reuse it.
>
> - Qiang Yu

