Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32233936A
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565227; cv=none; b=D0wddM1egDdJYZJ16lQ0yhVP3RfyNzUNJhQm/D+NxBoSEFvCXTVqavkiDgWONZK7uv6V6wHVDBbilCjYXpH3gBreLAwCK/c4vRHbhZ7dhZ682TAIhffQ9h4QS3ipbe4nzcfQEdtatVe6Zpq7tlcekOMfzteG5sfynpsgiBXl8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565227; c=relaxed/simple;
	bh=0MVH1UVmAUe5/J+L/Yf6YJo56Lmvi/jOR7Pmv6KXqjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaMXOdNJJ2asZdUM1xbHmlDpPlwiU1VAcF8IG8VMdw5DrNBd9B0v25PHNLuG4ubYvjHIzy1axD0bumPNjIg0ytCHJfDa2De7dvdyLv9vkRFRE81o1u0IeXbWOOompFDOMYS4rUktF3a1pluwoWssOFNhavy96BfFqC4aCw+wEWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mdcQP4VE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dztp3BoI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mdcQP4VE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dztp3BoI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GDJico2283717
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4MESC1KI0wX6qjB4s98iNgVKHGPJ6KH1ZIsZM1iGaT8=; b=mdcQP4VEcQ2YZ7in
	MjoGc0dkFhF7e1Dv5zwqOWromheFG07ioVoo3k3geil4jNO5TfeAxx8TGU5y1HZu
	2S5kA45hKqN3uVlAdvWOEDA9DjRfgC6bS+2GETOVdeEYfGkhVvztUVhxSV+chKEq
	aE7jNidhypXHnk9ChR+Bu4Va2f6K2fHY5rC9SO2LtcKQxPTGELynf+pImUOz6ax6
	uNenbmdMs/6J1dZVR4GqsvozYFJAuUc8Sds+eikKm5BkiFd4w4eGhgRT7Amyf28w
	uZnLSRZUXZZfz03+eOW7zJDFQeoF0qViAU0pyjG4nYDMV2oVbJNslXVNQqbJtX/Q
	KZejwQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb00xu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 13:26:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-870ec29b035so1167964b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789565219; x=1790170019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4MESC1KI0wX6qjB4s98iNgVKHGPJ6KH1ZIsZM1iGaT8=;
        b=Dztp3BoIeZHfvXudcOEYSml0sUt+Zg6opESAKOF4Oq8OZsq825TGe1UWtZUb7/PNkA
         xBLwNguHSEkw3CYkoQmITvC4QqMg0KC3xdYPexA7YAVYUAMQfv5YBomYZAOVQTK7Nr5L
         K+aEvjGjQi2sh21RAWxXV6voNu7E+JJvLaYjbCxcbpDXdFjFnNiCZjPQf0+IhNQQZp2P
         n9kbkTXnG+B8NSoCHgeSeB6VPx5/qZEmIefy8XRi2hxe1SiVXJhZxGjUS4voNd+7KFIK
         aBIcR2+x0oFGJcUsouMhbHKvW7cqbYt3z3gTvNXiIfYF72tbhh7APK1qxDhCFIax12zv
         gDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565219; x=1790170019;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4MESC1KI0wX6qjB4s98iNgVKHGPJ6KH1ZIsZM1iGaT8=;
        b=byM+wd7USPg5hhMOdaKt+CUpj6Li3HG7EXqMn34U4eZ5UtIzmQEFJ9y1XrwAZ1p7C0
         J34RCbj9RKKTrCRXHZJ5snAQiIH8qlX7Bg7cTJKEI9hHb0UQEVESCQl4HCd8RSso9NJy
         g9V84iqj+shbBf+67jaJMyKextLqMenHX0QxQKcBfU9C8OyUKNsf11p0qkN4gPtj7Gwe
         9zVyI0eVqebl8vZ0XIxLxwM0bH94/5a7Vow6A8PqTk6cYIHCMI1bTdbHU2ahPsciUiKQ
         cmEkIwafIjDM770mJPTKIHoTOkZgC8ilx1TaPcMLEdt7eZYh+GquHN6ySbqctzUPSOOg
         4SJQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5M5dVypsbKVL7Q5CTrZCSiaZgI/iV/RDDK0TyBDZbGNWC1+8GVTQWanG7tyBsIlBJNVuM0xzzVOo=@vger.kernel.org
X-Gm-Message-State: AFuF++k4F2fy+vUahnG5Eh+oagBP1iSIUJhTBNJ3OfRpJEB5iJlJPDTN
	OWu7HxNrSTf4hRqY9pq388N1cI/cokQX2RX+2kmtKIDcZM1BmRDCeyFOc8yiuv52hlUaXdPT763
	4bJgnR9GuG3LG9YmZcTg/TxNswlBCMdmsjB2PuC3RiOxqSQ9zajAKtsjvuuemn3s=
X-Gm-Gg: AYBFou0lLIKHKcJXiTdzSCS/82SKf6CxHXIP1pLerIpZ32ahlp4tO07MLSQSvaHWT+C
	w/H5QElhOY44oWHv9Qjfqk2OdTpvgdvbv71pKwdky6MSIG1byMsh5R2+LSQ/QtQa6/vw1gKw2P6
	DZFnm1Tv4EPxY39Sc9DtPyG1UaoL/2BkJ57Eb3t2JljYlOzeCsjetAYlL2k1tQMUHT5CqTabRLQ
	HtTbcV/4a92TiiZ/uJS3iMNdrqZeFGZJofU2wOAx5m60fbmtJ2i8zG9FHLde8amXMnDFNTx02Bf
	hV64XVs72ZQ9522VaR9SlcM/FnJphQIA9e6VL7335nxxIRa1+/oHbkKiOV5IDkwETOCqJtMgc27
	cjMCYmFcG/GpGub01+D3AmICe+mDB0Ueh
X-Received: by 2002:a05:6a00:3c86:b0:86d:c2d4:f3c0 with SMTP id d2e1a72fcca58-872376bd23bmr5119024b3a.9.1789565218621;
        Wed, 16 Sep 2026 06:26:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c86:b0:86d:c2d4:f3c0 with SMTP id d2e1a72fcca58-872376bd23bmr5118933b3a.9.1789565218017;
        Wed, 16 Sep 2026 06:26:58 -0700 (PDT)
Received: from [10.92.206.34] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201d17e76sm1241562b3a.49.2026.09.16.06.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:26:57 -0700 (PDT)
Message-ID: <5f862178-ba18-4b27-b5db-1732d57d7b47@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 18:56:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
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
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-5-b0a82721c547@oss.qualcomm.com>
 <aqJFo3beKde404qd@QCOM-aGQu4IUr3Y>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <aqJFo3beKde404qd@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aaa9923 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=L3-XMscUPCAweoWNVT8A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: tr2WgfADBs167Pvy-ItzvKo9oN9gcfNC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE3OSBTYWx0ZWRfX5+Kx7pbXAj/N
 LYsXGGSUhJgAmaDv7ZOPSlYzNTR313/oNkiEwcfkJj1tBfoJ2toXEU+VwbWm5FKXw3YGFybEF5w
 yJY1KzqvyZNR1o+V0XYhVDXiLdDH17RC0oJz1OV3LPpcAN/SxV4BcfLMVtPF0e1euwiDnZo+P/+
 I+KhpFnkunbJafj2tMDbto9wU4uyKW/7xO+GbkdDjRKzuTdbOZ3S0cWsgEHqqZTFcA4EIOyCDAl
 EK4fSAbI6Uxt+7Ud/Hy/9QklZ3X90qaYU58PSViJ3Kq+nK+8JEFqhUfMs/858gf53XxtZ/rgTpX
 8ax69H1fJ2U5fC5jXsqR9ogq8OtKi1Cx2Gl9gPaJCmMS5bd5qiuCu6cu10Ogp9cWQFKBikwg+lQ
 vkZdW+fjhOS2iGP2sS2ItwhephViDDoN4YZniGzzr5/HRfFjMK+d5ZhJGgXlC8pG/UgIoFsBvj8
 +r2j5Je8GB159bPXrCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE3OSBTYWx0ZWRfX3dEEofCOyb4x
 ZF62XgbWl//iO7rDXAxEuN9Kwi3JyTLhsWHxGiiMBz6hHcw2uUof5r3eyL/Qyaygr6eKW1SyP5U
 Ucg3oUrREC1vV/dhe95dEMq/mP0WREQ=
X-Proofpoint-ORIG-GUID: tr2WgfADBs167Pvy-ItzvKo9oN9gcfNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160179



On 9/10/2026 11:22 AM, Shawn Guo wrote:
>> const struct qmp_phy_cfg *cfg = qmp->cfg;
>>  
>> -	reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
>> +	if (qmp->nocsr_resets)
>> +		reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
>> +	if (qmp->resets)
>> +		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>  
>>  	clk_bulk_disable_unprepare(qmp->cfg->num_clks, qmp->clks);
>>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
>> @@ -335,6 +1067,20 @@ static int qmp_pcie_power_on(struct phy *phy)
>>  		goto err_disable_pipe_clk;
>>  	}
>>  
>> +	if (!qmp->skip_init) {
>> +		qmp_pcie_init_port_registers(qmp);
> Have we tested the patch on Glymur? As Glymur's cfgs have either .pll_tbls
> nor .tbls, so skip_init is unconditionally false for Glymur. Is it
> intentional to run qmp_pcie_init_port_registers() on Glymur?
Thanks for the catch, I will test for glymur before posting next series.
>
>> +
>> +		for (i = 0; i < cfg->num_regs; i++) {
>> +			qphy_clrbits(qmp->base[i] + offs->pcs,
>> +				     cfg->regs[QPHY_PCS_SW_RESET], SW_RESET);
>> +			qphy_setbits(qmp->base[i] + offs->pcs,
>> +				     cfg->regs[QPHY_PCS_START_CONTROL],
>> +				     SERDES_START | PCS_START);
>> +		}
>> +
>> +		usleep_range(2000, 2500);
>> +	}
>> +
>>  	for (i = 0; i < cfg->num_regs; i++) {
>>  		status = qmp->base[i] + offs->pcs + cfg->regs[QPHY_PCS_STATUS];
>>  		ret = readl_poll_timeout(status, val, !(val & cfg->phy_status), 200,
>> @@ -357,9 +1103,36 @@ static int qmp_pcie_power_on(struct phy *phy)
>>  static int qmp_pcie_power_off(struct phy *phy)
>>  {
>>  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +	const struct qmp_pcie_offsets *offs = cfg->offsets;
>> +	int i;
>>  
>>  	clk_bulk_disable_unprepare(qmp->cfg->num_pipe_clks, qmp->pipe_clks);
>>  
>> +	/*
>> +	 * While powering off the PHY, only nocsr_resets needs to be checked.
>> +	 * This way, no matter whether the PHY settings were initially
>> +	 * programmed by the bootloader or the PHY driver itself, we can
>> +	 * reuse them the next time the PHY is powered on.
>> +	 */
>> +	if (cfg->pll_tbls && !qmp->nocsr_resets) {
> Every cfg in the file (Glymur and all seven Nord ones) declares
> nocsr_reset_list, and qmp_pcie_reset_init() only leaves qmp->nocsr_resets
> NULL when num_nocsr_resets == 0. So the condition is always false, no?
Thats true for current targets, but on future targets it might not be true.
I will remove the check here for now, in future if we have any target with
nocsr then
we can add it back.

Ack for rest of the comments.

- Krishna Chaitanya.

