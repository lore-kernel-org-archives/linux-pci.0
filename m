Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D6413D95
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572531; cv=none; b=d1PJYqoprxWcpiiux7Lb/CktTCsJfMm17yyx4EMh1G5lcS6VB9kgSt/Mad8pLr4dj/ekRro16uIZ56iX0AvyNhjsUipZ56jvXWjcdjZ6bmTPdA3JQrQPFrUoN0PPhWaZSpzVMCcFR08xJXgVxQbxLO3IaPXRBtFr/5ZKD+vgjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572531; c=relaxed/simple;
	bh=01YYHSUuwLuWDVbKswkCkl7XEsN7XLTXDUwsACoJPoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoayNuojB+7rpttB7J3DQY3J0cn63rOnZxwGi3rJj+ENZ4+GAXtaIac4t5B5F8zrBxJ2FFk6Q7B1rM+6BnWOVgZfvZmdH8NYfOwtrWER8/isZrzMbNBVMbTgPv/9aZGYPchsWqieE+eSH6/TpgQBt0zlv8POuAmbr3L33qZMxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NBkelSar; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hCoBT561; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NBkelSar";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hCoBT561"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548a4SW141926
	for <linux-pci@vger.kernel.org>; Thu, 4 Jun 2026 11:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LKnE3tc1RlkqqMOtABkKWPKA
	xR6YYffnuCDYRPtMBwM=; b=NBkelSarYTR2VYSxH8oE1QMBbNGlnftrTasO6eUK
	DHBshzwHZfov+rpmJq4C9dIUdzuIatepAx1hFz3JPHESS41Cn2aLvQggmGCh/ADe
	bhnC0i3+wronf1K29Jj0vqFCKL4seGtcYBrqk7/r7duPYIA7BRFHw+efqGPn56qh
	wWirqA8M6EdBQ3fACZayazdE9LqDOSvQxHvYeCmRjbg+zGCQFYzxfhyLplcjsNLK
	5aeUtlVyz1ey3D4rD8NXXjbbTo0cYtRNpWXgeWlSXhqemznjwvn+WussJiJ5lgQf
	i/KgBRBxusu226OLWW5uhiO15wzk3TiTSlboVm4K5linuw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejyena2nn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:28:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85807671b1so378917a12.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780572527; x=1781177327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKnE3tc1RlkqqMOtABkKWPKAxR6YYffnuCDYRPtMBwM=;
        b=hCoBT561IykoLr+KPuTXzC5dhj4fb+4rrBUDk53h58nYY67KYC2HaBtOnE6TNdxYiq
         Qzt94Omxo8/3z7ApY62e2aV+vsjywdWz1Q0b0J86VwHs22mRwI570Y3ByvrbLkS4cL4m
         xBr8S0obcgrhmQ6DoCnQ1qL5gPz8JoPcLw2Z6HMUnjaCPak7CmYg8IHKAO84D0xWHdI+
         LZzgL7smrOM8faLHFvDZTosEEprST9mpZn+fGKpyuDW47oxGU/Cx2Rzat8RHDFFyBhRB
         ljHzibS09pNSyx6SPHGEqB3u6UvuIAM4RblIzaX/qwNfuUs9Kt1xP3aWx6GEM9Uy11vC
         ++eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572527; x=1781177327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKnE3tc1RlkqqMOtABkKWPKAxR6YYffnuCDYRPtMBwM=;
        b=JlwS2G8EOTiunKARuZsIDALQXTj3fzAvWW7Z0W6VDi19mATlAcbkhtWtfVHd3fQ65C
         frFJ6RVu3wNnDC2y0sMZVM/xrBRkm/0P2jGKyGA68IlYv94rWF09/ZZe8hBoHL85ccFB
         dhOTu+rdEFqo1ODfU9rtnIc3N9xpu+dZQj07Y001jyey1sDw8+y7TWlwYtqmfxQoh8w1
         0ipZOw6xtHXeBPihabvrx5bhHxPb3a3XuTuihUlc9RCpe82R/iJdaFTSbZZ0/R2Lix3v
         tSV1WTpvUuksciS/4/GeHtQnnCDfzE5T3Q6KASXgaUm5nfIEM9UirVIy8pBtGhB3V1cb
         jbnw==
X-Forwarded-Encrypted: i=1; AFNElJ+ggCDwZZ0FacVY/xyT4Dp8MCfYA3XFURlUbpCpd2+KLkvAfv0utpgWFCTD/LJmMdJorNDEUsyY3gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrwDWt7TqAUOcN/Wod9+3rkVCZ6iC1va/KKtuvNcd+z++DbRTy
	U3lzmOe0z4K5FtrBRL+VfVMcL4FJv3D37n4S7Dkx7fyXY0DmQDl+RQdLrMjhXA61WVP86X/CxgF
	nFRtGLulnxo326LaLsEPOGu8ZncVkILrew/eoanTbe0kDgBzxEishMx1hZtetc3g=
X-Gm-Gg: Acq92OG6KztGnMJdMrWAppFVv44lZ/1fRy+1xxWLD27QCvgAEiRauQ7R16QER/YOCVr
	vDZSR/PNWw3lZBSQzYUJoEQZZL/5Haxe3TLXnNo+kw6lHSNFlmk3kwQ6U5Im9Bf2GDp0BiDrGdc
	1fKCo3ftLL19J34cNPhtCn+vZlhBGfKGatztluG6wkgiXuRRpSnalT3IkS+4WRvmqvtts9gB2hJ
	JZWhZhGANuiuEbOgqQrHl8zZH442kpoiZApGxIfw6ymWuOzYUR0sizgeKXj2V+cSo1fsxg+nkJp
	CDgp1UMfYZYUzJarqQsWN4dA/oceYY/jtcg0By7jeA7GgrLw7I9+vuWwLw54Irtg/a2Mp9z3SzN
	CFOjlImRPkqEZG/owqBRf/xaA+PTPYdXEx8z/9M4x9OP2DeKClx9b6WP9mTMx++LKd4LinrlseM
	KqGcD3OR4ImLsN0aaOTWSXiHNkQoVrN6qxd7oigKq4ap4wadGEY+TctKReaKWmeg==
X-Received: by 2002:a05:6a00:3288:b0:82f:1b1b:e166 with SMTP id d2e1a72fcca58-84284f23ab6mr7402408b3a.33.1780572526766;
        Thu, 04 Jun 2026 04:28:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:3288:b0:82f:1b1b:e166 with SMTP id d2e1a72fcca58-84284f23ab6mr7402388b3a.33.1780572526325;
        Thu, 04 Jun 2026 04:28:46 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282374300sm7278706b3a.20.2026.06.04.04.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 04:28:45 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:58:38 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5210: Enable PCIe support
Message-ID: <aiFhZsaZJoXzuMSk@hu-varada-blr.qualcomm.com>
References: <20260514-pci-ipq5210-v1-0-a09436200b35@oss.qualcomm.com>
 <20260514-pci-ipq5210-v1-2-a09436200b35@oss.qualcomm.com>
 <dc7cb371-e94e-4f42-87d6-70f0f94d0d49@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7cb371-e94e-4f42-87d6-70f0f94d0d49@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JaSMa0KV c=1 sm=1 tr=0 ts=6a21616f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XMczTv2Me4NSQKEp8ncA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: dmcr_ze4WFU3IgakSCKYCieT3Y_CI0kY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDExMSBTYWx0ZWRfX1KrBdFdnLr5L
 hB5bSttK/I3H0CfN9X2Mf0QcpB10vEqwhK4fZTmK9w+T7IFxcJS5lGPjuiyjipJEPkKJKGsLk30
 gm3AZe/0ESdya4nFO8/4yDfaEWe5liivS+pobPwzjfAWmWp3ul22AvdvW0AgBSxczIMPRxoeNhb
 XmLzSMimlJHonq6Ttj2oaqBp4C9mcIAQewC6Z+ptY7ytYMU2J8TZCs6/eBpTb8bZdvZaj69pYo6
 h+0AlNJSgOHUXv1Xk16cybYQA0lh4aooP8r60PZO0QLIvoBqwMjxNN64v4PbME0KbQLJCwLFnfm
 q0uXxeQY+Zn1Uu/2s3MWyGsPRKgNH/1KVXI1fsDMJ/RBlytFn5/olMrHJNC74fi6x8yh0xEcf7A
 khwHY9vKj/ei8omyoZvUvDVtgTG5zQdlIIKrNWtu24Zdp59csxbjNjZwRT7WhJX7pu9/QJ0o031
 gaDhJ0aTWKPwWrjzIhw==
X-Proofpoint-GUID: dmcr_ze4WFU3IgakSCKYCieT3Y_CI0kY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040111

On Fri, May 22, 2026 at 02:24:45PM +0200, Konrad Dybcio wrote:
> On 5/14/26 6:13 AM, Varadarajan Narayanan wrote:
> > Add DT entries to enable the PCIe controllers found in ipq5210.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > ---
>
> [...]
>
> >  &tlmm {
> > +	pcie0_default_state: pcie0-default-state {
> > +		pins = "gpio32";
> > +		function = "gpio";
> > +		drive-strength = <6>;
> > +		bias-pull-down;
> > +		output-low;
> > +	};
> > +
> > +	pcie1_default_state: pcie1-default-state {
> > +		pins = "gpio29";
> > +		function = "gpio";
> > +		drive-strength = <6>;
> > +		bias-pull-down;
> > +		output-low;
>
> You shouldn't need output-low in either of these definitions (+ sorting
> by GPIO idx would be extra neat)

Ok.

> [...]
>
> >  	clocks {
> > +		pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <250000000>;
> > +			#clock-cells = <0>;
> > +		};
> > +
> > +		pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <250000000>;
> > +			#clock-cells = <0>;
> > +		};
>
> Why do these exist? Just pass the QMPPHY reference straight to GCC

Ok.

> [...]
>
> > +		pcie0_phy: phy@84000 {
> > +			compatible = "qcom,ipq5210-qmp-gen3x1-pcie-phy",
> > +				     "qcom,ipq9574-qmp-gen3x1-pcie-phy";
> > +			reg = <0x0 0x00084000 0x0 0x1000>;
> > +
> > +			clocks = <&gcc GCC_PCIE0_AUX_CLK>,
> > +				 <&gcc GCC_PCIE0_AHB_CLK>,
> > +				 <&gcc GCC_PCIE0_PIPE_CLK>;
> > +			clock-names = "aux", "cfg_ahb", "pipe";
> > +
> > +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
> > +			assigned-clock-rates = <20000000>;
>
> Is this clock supposed to be fixed at that rate, regardless of the link
> speed? And is the default rate incorrect?

Will drop this.

> > +
> > +			resets = <&gcc GCC_PCIE0_PHY_BCR>,
> > +				 <&gcc GCC_PCIE0PHY_PHY_BCR>;
> > +			reset-names = "phy", "common";
> > +
> > +			#clock-cells = <0>;
> > +			clock-output-names = "gcc_pcie0_pipe_clk_src";
>
> Having a gcc_ prefix here smells fishy..

Followed what was used in ipq9574, ipq5424 etc. Will remove gcc_ & _src.

> [...]
>
> > +			clocks = <&gcc GCC_PCIE1_AXI_M_CLK>,
> > +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
> > +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
> > +				 <&gcc GCC_PCIE1_RCHNG_CLK>,
> > +				 <&gcc GCC_PCIE1_AHB_CLK>,
> > +				 <&gcc GCC_PCIE1_AUX_CLK>;
> > +
> > +			clock-names = "axi_m",
>
> stray \n above, also in resets

Ok.

> [...]
>
> > +			pcie1_rp: pcie@0 {
>
> pcie1_port0 for consistency with other DTs, please
>
> Same comments for the other port

Ok.

Thanks
Varada
