Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D624078EC
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064859; cv=none; b=FW7mxXQ8MfSJWi5IK4He1OpUlOBxC5I4kkp5/suNM7O8U7z3uHyOj/nxDIzTFgqv8J0Rnekzlm24xLbQTyTn/K9MG/da6NtZssBNHgl8FAwraiO2+d3NJfeD0mKCp0reWYqtQdL9+Mq9LJ3bW6gl6Ib9yw3qhrOlTfBABrepiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064859; c=relaxed/simple;
	bh=4m2du3hgT4GR5DvDaR64vT2WqTaNnm7oa6ZvyC5SLCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9KQ1qZrwsr2ElWV3rDwicBEzpMLtRed2oZJ8tLauxip7/+Vxdr0GnBT9WXwTonLwVW0uyta/3xRr1ze+1Sq7Z3Fw6v0tHAB845CXjcPnJoKJSwrjDMuU33fSk462ldMtQQ772XWndHM2I/pLGjhx80tbffcFR5jYQHoOg0WsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOPhqr58; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/POK2ib; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOPhqr58";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/POK2ib"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M7CrlI3676944
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ep+qvWrcnVbjtwDmimEQJq0arBzRXiRVSsy9QV64YfM=; b=kOPhqr58M7gceaFb
	hzlvB0svdSgKkKZk7b8/OUT7/BmKlUYhQZ3OMIXSvaVEE6FgU7pUYfeG4EUA4Sg9
	LtpbcUvLQ+Zj9Lw1Pup85g0Uh0gQiZBWd66/WSMLva6uIGFpf30VmZcrMv/VT+0i
	MUoejGpy6fqleKbyHmdKie3NNp22agQ0/HI7Z5HiYlAEi5zsaDvT/0sWWmcnZjTP
	YvMdLtsjs40Y5+H8cK2hAm8fDjaC1ePclgYAchwmpyz6MIhQfQZU+/VLWkxwOfVq
	A8Cv2QqNtp58wbftsOJJBEQk3oPlrlmXVFMa3fITbNsftTgCxjgHNwlxoc+QPl6g
	Phtrow==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu85vk6n0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:14:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so3727508a12.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790064847; x=1790669647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ep+qvWrcnVbjtwDmimEQJq0arBzRXiRVSsy9QV64YfM=;
        b=g/POK2ib026oXpUb7mQNBjmHrToF9a8vVqxqEXIDg7MGZFO0RFHlrb4zh7czJQLWRm
         G3QtY/zPuBup2rBfX2EgKF6rlgGSVXClq6NkhsmHPuNKFT7vEkfZC8BWKyx1AeG8UFm4
         o1hI9VuyXlVv1U4Fzq5D582zdzTflTblr7xvW+mPPSuX6MXNi9R7cGQhOsJLzreW43BV
         KF6I3eoULNOJ5y/W/uE6dEGgodFWyPAm1BMe1duYkKocQ8bGvVKsxbrVbPtXJrzlcSBF
         oncp9YMsFEXQwwjydeMffRIYmX9ZQ3S+MHYY8sii8hHMxWDMjwxRVYDzLpBTs5tp/Rxq
         rq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064847; x=1790669647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ep+qvWrcnVbjtwDmimEQJq0arBzRXiRVSsy9QV64YfM=;
        b=f5S0MEoaRBTxAPGlFBgWSmcYf64b/gE2xIbwfBcSPpN1FsTjzGMwRXwus68O3E+fW9
         9ZAY6BFAjv3HHWq3kt69stepKtwJTt7I2xG8f/SEbExiX/G3vMKzDUIurSpQMREovJ37
         aZxYFRXlC00JeWevbeA+JM8qCxt4/vaynezMyH/3yWGAZkbNmJz3d1tfgq+ftFiJFcMI
         OblrTQiB1HRtMfpodXpDRZvL8Pwo55MUmixAEoUnD+22aPVPsjTgEas3lujlrWwvVc2C
         yCFCavPWzutIIW1DQS/JIuUyRCjjP7TSRAqQ6wK3tlP8sruhgAsm30eLvUQW5Kwy40hn
         8Rvw==
X-Forwarded-Encrypted: i=1; AKwUvBxk6x4E42Vp1HQpfJAvHRRN4X2rFh59gB0IW95zAh+Xc1CF5qF5frrr0scRx/XoR6Gp/EXk4bGdNag=@vger.kernel.org
X-Gm-Message-State: AFuF++kOONqrXxREIT/6yW9frV0aQI4zLalyeyFvmdhe/HaFqO7ajM1D
	yr/87f1MnijWB/rfW2w1gFEjCBgfCPloPouJIHfhkOPq8mqz4oWVppppPEtBytpN/t7DlocIXCF
	HKHfcyXY9bi8418sza64txHuYTcjx8cU8ylHfa0BEmND1PNcEzPeGedtaW+oc0sw=
X-Gm-Gg: AYBFou23iSenQ+twJG2o5U7PQin/FFKyM37L8anG6fPNMuCeqx4nNzLqSyFqj1ZPgXB
	MV2gvWs4n3vgoLp4ujngMWTVDz0OSe0Mbbgn5TGGNSifvOjkEPlK+CEHKzYJ8k/bIxSujfDmpMA
	JVWrUllJkJvmwhi+AhyS6ey2B1Ea3hlJI9G0oua5W7CkYGCPPsHTBDQO4qeIIENKcr1if+uRNhg
	nBAjgKj4DPkKPDPzEUGNafgXCXGUweN5rXLVKEcr7BM+UAYi17M4+zBdxc28y+WpHl9JMeYjUmi
	enLdP+3TyNhbFypoDX02CJk358fw64413G7xRnGJDJb8P+Giw4S/b01dBJ9aYBK5VrP+mZZpia1
	mxOtLKuFyFptEtC3GMb1ELg290z2vWfZR6MqAVCg2EA==
X-Received: by 2002:a05:6a21:3a94:b0:3dd:a196:3091 with SMTP id adf61e73a8af0-3ddec80d83fmr438650637.65.1790064847253;
        Tue, 22 Sep 2026 01:14:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a94:b0:3dd:a196:3091 with SMTP id adf61e73a8af0-3ddec80d83fmr438584637.65.1790064846273;
        Tue, 22 Sep 2026 01:14:06 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f294d894sm5341693c88.2.2026.09.22.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:14:05 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:13:57 +0800
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
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/6] Add PCIe support for Qualcomm Nord platform
Message-ID: <arI4xchgg0ym4fzm@QCOM-aGQu4IUr3Y>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDExOCBTYWx0ZWRfX0F7TlMFvvhzU
 o/nh2KM3ztKlemIInMnw3B3/OUjsJtRppuCQv9iDrBepTRHsn2YcYLh2KtuWVaq6A6lU2AN3Sc2
 P2y5BALz+mIK7k+GHK+O/eRdC3vAUpE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDExOCBTYWx0ZWRfX0ARgteLCylRy
 eUuO5WFTLQCbhZGWU/j+vvvVW+LAGRr8TOAar2courFiUWpFjyIe3wZrOP7XN6I09AU4MnrioPY
 v+T5Bp86xHdbWWEA/HX8sk0LUfLD5ydqZ06amevR4bsqUGWPcQjneuVdxt3Lmx+v7ru8UonBNdu
 MLiZVYdOUsZda6yKyLGvVo9N06CYISvUvj4jzBD9XFymveZIaoHC2/XzrLSrsadQA56zXaN4W4g
 U7ezPGnrg704sWqX+xuYJRJOeAHA4W2exmctTEvATuIbeny9CpDhRRPNKn/PV2o7VtcY3h1x9tj
 sL2Rm85xqRDBtVSFqu5pKseZM13NHzAP4zRMEnA+RMCAzk+38CvTGEZkpojfySInxtbAHWgomC/
 OjgyAbYr0lwMNONbOM+pFm7agw8LEJleZ4tse2uVB9HXyBR1mteInM6ZioNMFLdte0RHBQo95rP
 yD8gWgsMDMD8m5qLV+w==
X-Authority-Analysis: v=2.4 cv=E8FYNqdl c=1 sm=1 tr=0 ts=6ab238d0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=1XWaLZrsAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=Arp2LTHWbRu_ztUwPq4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: c7iLddIO0pBYLfF9FjP1yrLNEefPlQg0
X-Proofpoint-GUID: c7iLddIO0pBYLfF9FjP1yrLNEefPlQg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220118

On Mon, Sep 21, 2026 at 11:07:08AM +0530, Krishna Chaitanya Chundru wrote:
> This series adds PCIe support for the Qualcomm Nord (SA8797P) platform.
> 
> Nord has a single Gen5-capable QMP PCIe PHY block split into four
> independently-clocked and independently-resettable ports (A/B/C/D).
> Firmware selects the active lane topology at boot via a TCSR
> configuration register, and the same PHY block can appear as a single
> x16 port, x8+x8, x8+x4+x4, or x8+x4+x2+x2 depending on that mode. This
> is similar in spirit to the Glymur multi-PHY support already posted,
> except Nord's PHY registers are programmed by Linux rather than by
> firmware, so this series adds the PLL, TXRXZ, PCS and PCS-lane init
> tables along with the power-up/power-down/soft-reset sequencing needed
> to bring each port up.
> 
> The series also documents and wires up the qcom,nord-pcie compatible
> (reusing the existing SA8775P PCIe controller binding), and adds a
> CORE_CLK_CGC_DIS/AUX_PWR_DET workaround required to avoid a timing
> convergence issue in the PCIe power domain.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> To: Vinod Koul <vkoul@kernel.org>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kwilczynski@kernel.org>
> To: Manivannan Sadhasivam <mani@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Maxime Chevallier <maxime.chevallier@bootlin.com>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: shengchao.guo@oss.qualcomm.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: shengchao.guo@oss.qualcomm.com
> 
> ---
> Changes in v4:
> - Couple of nits in dt binding & phy driver (shawn, Mani)
> - Add proper description for link-mode & phy-cells
> - Remove soc node and address cells from example (Mani)
> - change cgc_dis_workaround to disable_cgc (Mani)
> - Split common changes and nord changes (Mani) 
> - Link to v3: https://patch.msgid.link/20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com
> 
> Changes in v3:
> - change the name to quadfurcated phy (Konrad).
> - remove min items and change clocks order (Krzysztof).
> - Factor out the common config and create overlays & try to use common
>   symbols for glymur and nord (Konrad).
> - create  qphy_setbit and qphy_clrbit (Qiang Yu).
> - and in qmp_pcie_exit() apply settings only when nocsr is present (Qiang Yu).
> - Link to v2: https://patch.msgid.link/20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com
> 
> Changes in v2:
> - Fix dtbinding errors (Krzysztof)
> - Link to v1: https://patch.msgid.link/20260825-nord-v1-0-7c02f2b8765a@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (6):
>       dt-bindings: phy: qcom: add Nord QMP PCIe PHY binding
>       dt-bindings: pci: qcom: add Nord PCIe controller compatible
>       PCI: qcom: Add Nord PCIe controller support
>       phy: qcom: qmp: Move qphy_setbits/clrbits/checkbits to common header
>       phy: qcom: qmp-pcie: Refactor common multiphy handling
>       phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe multi-PHY support

On Nord platform:

Tested-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
