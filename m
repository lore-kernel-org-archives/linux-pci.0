Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862626656D
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972236; cv=none; b=LGWRMKdjaUU0Hv40QzJpVvluY25VeHeFWmHbSibtQLW2q9VWZifeLUEOGFnts8IH8ikI+AWYs/pe0KEvpNWArHXG1G0UYTbLQrRNlhjLHM8JCrJqmwvsF3T3fUz8X/GWJxo+WAn1tLP2JaykJSfihKqKsL14ln0qmuy8eD4nxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972236; c=relaxed/simple;
	bh=ddfn3LbqEOO8JuUkBmmymYxPMCnLmvYpUAoXtX2mPhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nezUNa356oTxCZnc5f+KrSNdIRI6mFKVwy7GlXzaREKvQYUWCViXjD3UPiMFTgExnOgkttyTRroxAaW0rBkH6eHYjJzvOmnWpboPk0q45LScn9+uRM9v2Kmx5/B/hdfsVKcFTcCz2MW9INZXoQxrq2HMfswdZ3G7nBzyeUC0NxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o7MeMR0K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CGQtHowD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o7MeMR0K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CGQtHowD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3Z3683550229
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 06:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gfTLiSXODMZ38Zdtd8E6UO7a
	gf75SjCHxDaJtukqv3Q=; b=o7MeMR0KyxgFqFNtza/daLmBomdhbj4Sn+qtId8R
	K8dt79WyZ06RJi0zGfQyTyL1+Es4Ux/OQyQGbSBEvM2t1uKqPeBjroWkc9c4WggJ
	tUltikZUPcp7i1q5DH99c6fsXh7Mbo561P8CfV/L4qu/T6wYy0hRjVor00550oxM
	LPExgWtFAJYRcwl/dHMpuSMJSoKPV11Dw/mKB2HxFzYhPtUvwXezKV5Mkn+3gd4t
	TVNO3lbswcjMKfibQDBujtr+tnyb/VfPsbLcWQeIsclbKPrkhsX8pYe43+IcN25/
	L4fLmTgsd/zcUCLHpsUDXrsxKCYSKyCyBcJlSqa8awp/Jg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjs84ys4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 06:30:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4afc810bfso3551473a12.0
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789972228; x=1790577028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gfTLiSXODMZ38Zdtd8E6UO7agf75SjCHxDaJtukqv3Q=;
        b=CGQtHowDSOi4RAihz7Ll152JgSiatEADLGz67nsL5H2b8Jm2PA72xOf/xJYh/TLwvz
         dJEQCTGFIYsqK5UPNDKz01Imgjv8lN41dCcnDQqyUe6zux3Vbi2KFDyM8a8HhbcdueuA
         Na9Z5f29QHq1StODfOLGgi95vKp0xARP/hEawZns6ovePST6DfmyAd0bNGpvTl3L+4SL
         KXinn8M0yZt1n7LzSz6/9n1vaeUdbFhh9ztksDVR/AH+VqHNnSMKCWfJnSb+xrmdCBuM
         2kekdcn+2MllI4CNzIgXqfGEyy2kGKpG6hDsOIxxNGsT+OcMe7lScvG12SP71UEa3IFc
         oJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789972228; x=1790577028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gfTLiSXODMZ38Zdtd8E6UO7agf75SjCHxDaJtukqv3Q=;
        b=djwvN+tLu18WZkzRr2Yi/0MrABZB/qXq6mPXMLaf07Qd9T8I2Pc8+M7a5CKvLmS1Jt
         DeqIeEsVLEjxiWlgVv5CwpvQ5RXht8iLmdoHYZbbXnwGls6t1MSeqUc2LZXfuKTz+GLF
         xqJIXFoVDZ748/ux0Muz0rdsNc1A9ezT7aVpxAfAxVsFE6UHSE0bPJpbL1Vdsio0x67G
         aNrcfruiRblOXO9yHft1DSnRxdnHkecB47ej4U5+4XtM15znEKVISwEG+niH5EKvW/1I
         c0T7txG0xczXuz3PXNccTJKl9gaK2lpfsjU+g3pbFAAKJAOc9H2KDtJMlo1kIuGsnbdK
         0TdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqoK6juxIAWYp3MTzcf8zBsgtXkaKuGA3PEJvttvR9/9jkpTo3PBJwDJbSpDGA9QLRGB7Bt4sKh3o=@vger.kernel.org
X-Gm-Message-State: AFuF++mtSblHM7z/bS4EMF9sdG36ICXcdVUJlB4fjJLDYgiSnWqD+vCP
	7jutbgC9f3ZB2J4+KS7ezBIggBA5I4goHn82K0zIkOijC0N8WTt2+hTWz087uBVKEwPCNx8ESF6
	iRDe/Gl280J0EJRElXVJVIsU6ExW8oE7Mn3LkxJ7uRxoB1P/MnF9Ss127ZiDkOaw=
X-Gm-Gg: AYBFou0QCBY0dT2oN3+TtX1NJn1KpJ057oKKkDDxeqTqfCcIurfDSNLNfFciUfmJnJW
	txeX1UrmhfVEm6/IKjc3JvmgGCt+yUnXl87uRNGuhj+bCGlCDfMFIzFpfrUtjMvj+xWU9r05vDD
	zGLMtP5yN8e8LqiXsxSkrMhtsWCAwH00rv6RgpSUxzf9yzWMD1ztKp0AkBjvI4mVR9zyCcHWbBs
	jCOpPakLG+8bk7IX4pbu8/ULQCrkR4abVMtn8yT3YPwNUkOEQbAvwVl3v4gHlAgOky6COQ8oBDK
	NOt3CUWQhWPBIF1CjWx93JR6OX60roERKy8DfLJrRy950qIvQj5YIDHMkJwc/RinHPry2Wf0pX3
	363uIZnjPkWIhQ7JkzDLurMhjxPhjb2hpxNrJd+NITElQ+0c=
X-Received: by 2002:a17:90b:384f:b0:39e:455f:36fc with SMTP id 98e67ed59e1d1-39e455f3d97mr14697472a91.28.1789972227594;
        Sun, 20 Sep 2026 23:30:27 -0700 (PDT)
X-Received: by 2002:a17:90b:384f:b0:39e:455f:36fc with SMTP id 98e67ed59e1d1-39e455f3d97mr14697440a91.28.1789972226826;
        Sun, 20 Sep 2026 23:30:26 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm8871128c88.6.2026.09.20.23.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:30:26 -0700 (PDT)
Date: Sun, 20 Sep 2026 23:30:24 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
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
        Philipp Zabel <p.zabel@pengutronix.de>, shengchao.guo@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/6] Add PCIe support for Qualcomm Nord platform
Message-ID: <arDPABIQl9wKYVKa@hu-qianyu-lv.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: EeeAvXvjjfLbmI15qHYAGOwhJfsRviaO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA5MiBTYWx0ZWRfX4QlRZWgCrF9K
 lb0U4+6kaardbJCMCZBDdTZmYOceRVwEylWdeBsU1DToe+40tQrWoH4PiL1udn/YAyR0C9G5nYg
 +dLWiWzT5/lI/RRkzXjizlMz0vwDHfk=
X-Authority-Analysis: v=2.4 cv=YqWa1IYX c=1 sm=1 tr=0 ts=6ab0cf09 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Tp8Q_eIeZBUexgL1P5QA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA5MiBTYWx0ZWRfX/HPBAGnwlNP+
 AI/12zq7HhYTxBClZzl3bhZXo2Mp+aSuOFbvZMl6glHuwAJ/2P9kA1go3sBe3UUsEZYdv1SLyJ2
 FUEq2vEpp1WwYdVARWp+cENVDCv9VYZnMhffvdpntn2OXT7EObwDfJPGxh3XUATfKpHd6QiI6N4
 9gRgM01eOdSeCsZF5MXOPezEhR0SNR1p8Tp6t/7WaXZluiH3xkMG5LyU1sQQlWHyFr3N1n27Dym
 N9kMrnasmk/7VimKcyYtFm/T8UNMtTZfriQaFcze1Ld1rYU13L+N5RYKJyeHE0NF+Luud2GjY2m
 WKDvYzRw7rFSHPpTOS8v1ObfsifdPDbfW+Jda0emaERa4S43exx46nesq0yXvw1LQ+guMl3/S+0
 /VfDm5do/OaSr9NYIBkuO23WA9uAL4lKCP5X7fWlB8Q7DMHGPMIHWhG2D7vbOJif5a3vqIa5oAD
 NjNfa+ZzXzC7OFiicZQ==
X-Proofpoint-GUID: EeeAvXvjjfLbmI15qHYAGOwhJfsRviaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210092

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

Tested on Glymur CRD and Glymur QCB, devices can be enumerated.

Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

- Qiang Yu
