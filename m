Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF18364EAA
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207105; cv=none; b=QXEBy9hqDuzOewpUQv0iw5/qiSBsefge/sYJ/zgAcgMzjqX5MP7kAsn0lnSHyb2bbel/9sZjZKPqxPTgTPMtZex982P3WO5DyDBmoU1gczQ56FTXYRvkeDRZHUzXLW2z4WOofWTKUPG6OzCfXEO47XFT2e8AMxG0cINABk2PmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207105; c=relaxed/simple;
	bh=01ioWAHb5nCsaIc11XbExlYS4Qk3/qMPjNMVsOpw1as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+drvFKSH6uAUnVhaqAZTVmTrlN1DLxlvgt7MuXCTBds65wgWKmLG7Gb8v1hyeLXZhaii0WFwJdyoFxEOid2Raiuo1iB52qdJyd1hbsCVma3jbfqr/fNLYDWOmdWHwp61rt87Wl2vDMhG35Ns3eoTex0kG3ScnVx+3F1hhAqdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NsgxwsD3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ChWt09wZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NsgxwsD3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ChWt09wZ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3GbV4109850
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 19:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ET6MuyER7wxqL0ASDlEV4k/M
	QK1DNFn9BvrzLC069vE=; b=NsgxwsD3g9/tq9EhZ6i+/tcISCfFF7/04AjnxCFQ
	Ml6KjDCaTQdVQ7/O+jrLiaCqhWqWALIh+4xScFrNXEJjaxa1e99uVeRza6pIO8kS
	6hcsGgFXizRuscbj97lpaijwrWQV32/x0QIgBLPfPHqms3EOJ/heK1CG59rjJks8
	XV6fgwZKlJCHBOm0dRHCYTgP9E+a8EAYjLoul37S9v7b3hIxpOEZW8RMrrxqWjId
	vv3NZrNwStAj/Ls5lRcxQqAhDm2KQ4s1hfuEc5mXEJ+IjcJuAYgagI1a3Cklagkc
	U/PqeV6jk8kaHrttj5udUw1psw4Zas8zGTIZ5y9LooMAnA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er014h3eh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 19:45:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517d766e05aso5181531cf.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781207102; x=1781811902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET6MuyER7wxqL0ASDlEV4k/MQK1DNFn9BvrzLC069vE=;
        b=ChWt09wZlxE5j1/g37hBp5uXGbKO3DITbM5UEWqcp6HjvCdkXcxW5JJ/yGswHUFnoh
         KMICONwmJTHsYjM7qc3gaPB38fzQjhrX8fHA/Gjt2ptoMqQPskck/aLvrF9RdDasNT98
         t6EdtAkki3lZq7TRTvJZ6Yicazt7hDL72Amutc2l2QvGf4zrlx8ScuV6lyhIYP3yJr7h
         gxnNqHzXgTZDW8DNipL5C99ueaWKlMXQbPFdgyzme26GPweMdfDe3uCp7c0R/ZJUF9Ek
         YlAebBhW9AFwK9EMfmBCpwkhYYRkWhOCIfjOhBlmNe4FVrvwuLzk5LkgMgodpnoKpQqX
         ntrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207102; x=1781811902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ET6MuyER7wxqL0ASDlEV4k/MQK1DNFn9BvrzLC069vE=;
        b=AY+8Rvbc4U0HrPh79wifOU3MK0aUvTVgngn/aP37WyaqpTXoRLuTXOLkXL/4+Exfhy
         iCJ2AuCKOLS7f6fL4MZ7uZQT16gBbIrXBdM3HXx6HqzzzomtSCzt8OqxXkjdvlZIQtu0
         El+55eTadLEzT+aO6MA238JGTWnc40Jntkz0n1l43CPDYQVL+4kA5e1TP02oMdLwlstx
         pl8zPNt9rxDeodAoOY222hohBYj9EkMu7DrpcD4uwijlg+gy4fD7N2b8atMCe35l+4de
         2igBhF7BcjiSQo2gE21cTxQiKLRubt44fWf9JdeQnDCuu37KJUgwh3HZbEgzkfPXaGCN
         E0kQ==
X-Forwarded-Encrypted: i=1; AFNElJ9slgQtGsKXQaUXNlo6YT6YIAjm/XPugy6DIuHGcyhHSngGxDnz2s0zYeN1cHqxbpmxPXijTC+RsaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHODRJbjAyx96e4aT+ZzKBgl+VFQ9ywkWi3yz1k/E6J+/a9h22
	pHSGub184OJ84r13ed6mjKtojTOJ1Wg/rWY23MSmwtDd/WhNp091SOgFe1OxbGw4OeoRYEGrEwN
	Sdph973eSB+OMBRWK1mehUCjtRBkmTpzCL4LftnIl2SWc2SUfffC8N0fO7koFO/Y=
X-Gm-Gg: Acq92OHxA8N/ZeyQKCYt79vgZQc9evZi3EvbMthLrdladYzyXxiqsRt6K9XWHEv7TUn
	gKPP6f4Ip9RUYyONKoNYIe88ndtfiXgM5kxr41gSUrL1M9oddXBM9TTHqgKxzhoe/XDPDSw72IK
	lyXXPHQ3m3BYIhGYlr5wST//RpRGte9FIOo9LBIEqKY3R26uLTL5HzbeNgREDlis6grEmCfEabx
	mzZyNT37cYejLM68yXPg2MbtU3mN8vvInCX6WonQ5Xfd1zUhVgecT16ffTxn+kznCaRD/2gznxu
	lAzhH+Uz5ux/xOa2KYV6Oau+4GF18ToWT/AEXuaEKHKgf3WYi2s0GTME+CQyJoKcTvnzWPOIUAB
	s8S4WtnBQWjDWu4zEYHUuy1jnpuz70ddZScPR+5QXMitHFQWommTd9sE6tE5i/jbG6NTA36/k9P
	S9OwJIxNnt9wd7q3uguJP15X0J2JtM5CwGS2g=
X-Received: by 2002:a05:622a:14c8:b0:516:ddfa:b6b9 with SMTP id d75a77b69052e-517fbe619e8mr1984801cf.23.1781207102425;
        Thu, 11 Jun 2026 12:45:02 -0700 (PDT)
X-Received: by 2002:a05:622a:14c8:b0:516:ddfa:b6b9 with SMTP id d75a77b69052e-517fbe619e8mr1984411cf.23.1781207101976;
        Thu, 11 Jun 2026 12:45:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cb46b25sm103098e87.34.2026.06.11.12.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:45:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:44:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
Message-ID: <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
 <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
X-Proofpoint-GUID: 2b4OkPvMCg8Vw7o1dwUp59JtuChFXIkw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfXwv8EnCPDJAE3
 xLtDvDlwKyan54+UdG4oIhVmIRIS8HB2GucRCiIG2ZefZ5j90d3DYW8RLVLU99H9VdDQmGAx8yu
 AeIXb0I34/S4tM4Yvx6970x+Y+0PZJo=
X-Authority-Analysis: v=2.4 cv=Qp9uG1yd c=1 sm=1 tr=0 ts=6a2b103f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NvgA2eVT_OJx7K5CLicA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfX+czlulN2/Mc8
 anMHGMkEys00g44/to4YIeeTGDkChlzQE2j0k38GQHfrSjLxICeBkai7Gpcmwgu8WqRf49555ic
 3odoH1e7hXSHjzZFa8QhLdT4o92+5/wqV05AlIz3zxxzYRTVAU9+uCTQ/phiOjTZKGyQGee9Y93
 zQeHgSufFmSqamwYO2ctkDElN3cTruZ9Cmk+7Wdl0WUapHf7BpzxJqFfV67YoXz7NtxP8y3AVqj
 K2TqKR7t/CjD3T+b49zKsTtP6KzWKjRh3IIqo3GDBOrUJLVa7MDhHvdoSWjuEfQdEjapeR/OO9F
 UbcfIxM5I7iaqR405p64S/9zDtbq7Dg2Kxpa8VGMBT8xIylPRZeaaLAbt/GO+H+xvo6Iui0oIXV
 aCBJrApovprt8b5JlVEWu+ZZGivdFjBv17iKuoNwfLieXiTbo7ByA8SX9MAcGRHjZ/sxnq7hpsZ
 3wghUQiuy66GPeyGF9g==
X-Proofpoint-ORIG-GUID: 2b4OkPvMCg8Vw7o1dwUp59JtuChFXIkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110198

On Thu, Jun 11, 2026 at 02:09:27PM +0200, Konrad Dybcio wrote:
> On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> > The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
> > version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
> > parts of the device.
> 
> [...]
> 
> > +	wcn6855-pmu {
> > +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
> > +
> > +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
> > +		pinctrl-names = "default";
> > +
> > +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> > +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
> > +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
> > +
> > +		vddio-supply = <&vreg_s10b_1p8>;
> > +		vddaon-supply = <&vreg_s11b_0p95>;
> > +		vddpmu-supply = <&vreg_s11b_0p95>;
> > +		vddpmumx-supply = <&vreg_s2e_0p85>;
> > +		vddpmucx-supply = <&vreg_s11b_0p95>;
> > +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
> > +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
> > +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
> > +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
> > +		vddpcie1p9-supply = <&vreg_s1c_1p86>;
> 
> [...]
> 
> > @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
> >  			regulator-name = "vreg_l7e_2p8";
> >  			regulator-min-microvolt = <2800000>;
> >  			regulator-max-microvolt = <2800000>;
> > +
> > +			/*
> > +			 * This is used by the RF front-end for which there is
> > +			 * no way to represent it in DT (yet?).
> > +			 */
> > +			regulator-boot-on;
> > +			regulator-always-on;
> 
> msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
> perhaps?) - what is its actual use?

WiFI/BT RF front-end, a separate chip containing amplifiers, couplers,
etc.

It is a separate chip (or a module), it is not powered on by the PMU,
etc.

-- 
With best wishes
Dmitry
