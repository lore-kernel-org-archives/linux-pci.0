Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424C3815E4
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810981; cv=none; b=YWpFYbUgW9D+VWa2ye2Vwy+a76bGcBEkLaSS+L6fQKT3sYMTXzqlzlEWejaUMZHRUqwDd+N2+N8OQcHgk/qFFVmzDjxjh9AxFsgckcaA23CppdMLpAhkmEZBPXfS2m1Uc+UThazVNEa+1HmhqfAbxa8H2dyYQ4oUv9o1lU/Gak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810981; c=relaxed/simple;
	bh=tojelIR868h5jmnTwtMJ6VGqDTSoivTowZ2OXRc9l6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzXEjA/ol4bmVZ5lm2Wyjo8S8Ortb9d5efVTDYJ+zMdriHt02Yfvp6FPnJ6lSW2jbuEwKubgulqWDPUsyPRvouBP6qlPEfz89rTdGddX/VJIdSsqSb7hDexI79QFHcUNP93HtpRBdpE+vTBJtBUJN7/cimQsdEGE1PC0GzJZUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LnmOXLHa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bIORfHtV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LnmOXLHa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bIORfHtV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC05vh2786872
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 13:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hcQYHXRub/yQ1Dpv5XFYeIcl
	fT91vq0bk4FyY51pAd4=; b=LnmOXLHawspPH+yV4CU3osODIUZArlSJ6m7x3JFV
	+pWloCFpbzmEGo/OZMxeJB3iNNJmErxt3VZHXimNJphcWKbGlhyYN3XTOb8tdPca
	Q6pgb1CDqh1T/XJSZAaEmgE9DHdbCOy/PJyhuorHKatgiJGy2UcV7KjDqVlg0IiP
	Ha1Q9js6pIj+wrkItSDCvHXWf605PaoAZdGW0qSHvj3RZbgV9p1cTudbevrr66Y0
	a2gq6GspAZYDosMDdBu0r/aUX5mrpgtrGsZY7xqZeEoMtN0AidI+94wKoNIIs3n2
	SLL+V2HqfbZCozyYFNN2nt3iLSr9uZ0Ui7Fkih0+svh+Qg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffgtyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 13:16:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3552883bd19so4062352eec.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791810978; x=1792415778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hcQYHXRub/yQ1Dpv5XFYeIclfT91vq0bk4FyY51pAd4=;
        b=bIORfHtVPD+W8vDLpd5AIJN8UERjaOZfq43WKAf12BGucEUHFXzwsBqGxAWHJM6ko/
         dzdB/f0kuO4O2ojhGP3KwU5XIIvRQ7ti8d2e/odsOW7wT4VZLqlhgCs6AQXNRpqjN55A
         QfQn15fzRSUuGVWWJya4M98IzoSx+trtTg5y+MDg2YBacQdkpcwg0x1uRe8vXX0Jscp6
         sdeoYKGzGQhki4CG/iEXIqEjUpoa0XiDGFXIqxi6S0V/fE7KjJXvV+VoGgOqFY0y/lot
         Cppwl+rKigXHieCaGzkcVaHKLY+rIi20fVlsWcceoqPav88DxDWfSj2i+Txj3sPp6hV2
         xVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791810978; x=1792415778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hcQYHXRub/yQ1Dpv5XFYeIclfT91vq0bk4FyY51pAd4=;
        b=qDjjBk62x4GkbsBaO8F5VGZGly1zq9vp8QyPyqDWfcEIk91hWjdOngWIqTV9epZvoV
         2SHDZc89UFBX41hWmKZpL296uwHq+fb44E+Ndtko8940HFwj5igiq9Z1ZHCPqpDB+KA5
         V5kKAOxFHveRIOc/mcZRnjsdSTtiFFpHf2xwCmPXAP4CmiV8CjVbc93EjtGNc1S3IcQE
         J9Wvw/e3Hpy+PghrifSCJ1jfPaF+PVWzIeksv0mNjj9KnvvVEYReegJHnFVujPKsOky4
         WmZdn+1XxG7uy1qiXIRNMVdFL6w66nbh2qOln3vm/rIdNiYieAwQ6YSSC3wgeKYNG57P
         oB3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxo1X39+jUu0W7HAqf7jtU2M9F4+7rCCgEiQ0ILndHdbAeGo87KFrqNwBdX0ntQPCXEYR6os2pvIm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWcil9cW4MCiNkUVD9t6076JPhIFGA8kUgRkmHydgGPpgu396j
	GnAwy7kEl6MfdZXGC7kmedAaCs62RqNWhzXNY5qwAKwyXvWIQXtVXDn4xBN3DmnGKya8ZL5D9rJ
	wHDqao3R222ATYDuf6DuL19qK9o9rWtTniNVtDUtxQmzjAmDridf77LBj5GWGhZw=
X-Gm-Gg: AYBFou3ctehmKePzSBfHs7PRRhG0yf9LOm5bhv0k99bGkuwifUUUPpBhEIZiqN07xjg
	JUUrbV+Pg9PuXSRf8dKxZQ+UQrnhrAnXIpiO9zMojDyAxfxgnTlP5KLnD9yc7+Rh5rAJ2jb5XAI
	U8/dOD376IxYA2CD0mSOoTnG4xNeWuSBahFq9pxlY3sgV/aDqDokZDcb7q9YXVly8JkSFcMZhGw
	Lj+H6Dz8N/CzkkGtfC8SepBxSzgmyU1VDlWpxDnFY7MnTEt+/RNizAa0Pw4gGi0LSh5EqlrWpd+
	S6mAyh0qBrnMmtkntjhSGjlJFOzWiQFKSaRPGJQ9Iel6XLsjnoGoKnaR5qiBRQlAJpMGpHjDigx
	0/heALI43HcL9zxTZJi19zl6bwsP85p0wppZ0tIdlmA==
X-Received: by 2002:a05:7301:25a1:b0:35b:dfde:8779 with SMTP id 5a478bee46e88-35bdfde9709mr314851eec.7.1791810977870;
        Mon, 12 Oct 2026 06:16:17 -0700 (PDT)
X-Received: by 2002:a05:7301:25a1:b0:35b:dfde:8779 with SMTP id 5a478bee46e88-35bdfde9709mr314819eec.7.1791810977176;
        Mon, 12 Oct 2026 06:16:17 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm36303294eec.10.2026.10.12.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:16:16 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:16:09 +0800
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/6] PCI: qcom: Add Nord PCIe controller support
Message-ID: <aszdme-LztWNw1J5@QCOM-aGQu4IUr3Y>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-3-ed05c6e09240@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-nord-v4-3-ed05c6e09240@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX1XQDne5UvS1O
 BjMo+4y2T9wA0H2wd+l757tGg5G/TXi4YQOFQcDF5QeTNL5b+z1hJHICvh8JCD1Giyc4vuPWtNn
 VRskHbJJdbzZ2UHQYEidRz5HUC5TLV+zPEZIYPS9GOu1p8iJ3fsqc9lfiYiWREGn0xN3nWETaUB
 qa5hwk3EkJDt9Z78mzWSed83RLonhAqlmfUeM1Yq1QINfsrr1eHbjlKsKgyssNtCy3pmvMcuCSz
 +if5rvlJngwAupN+pRaUj0V1x5SaBvTow/Ij0WV+z57D2U4AlvQ+JnqpQChFVuzN9ov83gfSfN6
 guc9oBpDBCEw/hXOC66xaEK0VSkVVLqz10GqSqJlkUTWUuMmurjBnoFFxCnRRDzgG34kTfeH6Te
 qLweBjQo6HoZ7oj6Q2QU6KW8JvtQ+ttbbjZrtL5k6X4jYXo0WgvyafGsGWX57l6fSz20GkabZhy
 d3dzG3U+JXjkEngriAg==
X-Proofpoint-GUID: liXL85bgNSJc-35S5yQavbh_pB-3rlMx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX+TCrecCNK4XK
 gCJHdqgErl+Z+fSFGwUkB6rCXdE8qdx3lc2iVov9OhE65/HqGMGzXtkNvl3beAQNYoY+iNJeTor
 KSSUGsljtlXzE1vzvODDUm5hZLVVg9A=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6accdda3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=eXNsmz249v773VhVZ_gA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: liXL85bgNSJc-35S5yQavbh_pB-3rlMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120052

On Mon, Sep 21, 2026 at 11:07:11AM +0530, Krishna Chaitanya Chundru wrote:
> Add the Nord PCIe controller configuration and the platform-specific
> settings required for correct operation.
> 
> Nord requires the NO_SNOOP override and L0s to be disabled. It also
> requires a clock-gating-control (CGC) workaround to address a PCIe
> power-domain timing-convergence issue. Set the CORE_CLK_CGC_DIS and
> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.
> The SLV_ACLK_CGC_DIS bit is already configured by hardware reset.
> 
> This behavior is documented in the private QCTDD11972446 erratum,
> which is not publicly available.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

On Nord Ride and RRD board:

Tested-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
