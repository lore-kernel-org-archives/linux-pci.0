Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D73F23DB
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064790; cv=none; b=QJHQ0llwq74ISrz5jZ4ihrksLu8/S/U4O2l/+vwtXBr/Mj5ceh7qiI6vjHqgVmnuSX5Qyj94CLYnRRQuh0/1cbRaBp3YQXAjt4Gyxbvr/S5vu4d+0UsJSIrtDJPHsY3KOwXyLLctRHrTYdXDjTaku0l0eVWXh6AgoZqDqf3Sys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064790; c=relaxed/simple;
	bh=omLLYoBrKLOzbalzOhPdQtYottoHpwv7uf1NSl7g44I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXdg0gMhhnEsNmIJdIRWWpej/cLIY6NViuDhxrImSToo0iy6WS/JXVmynvCDBMM3MPx4V+8uiGhk/Ho1mvK307/VkFabZO3lvsaxV8shL4w38DZfmyhu3z2VM1P8hwJbWPsTqjSKXZVrhKsK8414O6tK5NUX6nurZMHMx/nKX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VunhVUXC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EJA7oBO8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VunhVUXC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJA7oBO8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M7pIJt2173113
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ITZ7U9bHx3O3ChSLQaPRjkc6
	o4GzrK34Wvd9RlYR2g4=; b=VunhVUXCitPOFSsygH8ooVCxBlRkr5e57uV/NM++
	MKo2syKt1EaVJzTkxbwFakrD6UkSCUyzzWAtxv6MxYlWrao/YzUKZz/AolFTARkI
	/Jomp+R/9tfFEkcudRzDEqeEd6FMtTDL75JdjIYonxFW/RjbSY5KIF6Z8OKhzBdC
	lVaSTjMu3xWWD6Go+Hl0yJiBrGR+9vljxzJJRwDz9Rg8Mh/y+Hyv+hI6Reort0cY
	Qr4N9QpbAPlejQariDGciAKUDrKuhPbyDAvw11XOwSJU0DORiTcPDMZja1gWd5N+
	a+ciYu3Gtd9p5mAo7LR1WZbJYOe3K/csEH3ZnPqPqOfHRQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsq9djf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:13:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d02df2bf09so37278825ad.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790064786; x=1790669586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITZ7U9bHx3O3ChSLQaPRjkc6o4GzrK34Wvd9RlYR2g4=;
        b=EJA7oBO8vBVYNE+OnlVDSnoANJ8vraEdtAJnTR4mlZfrMSwaXjK8/8Wf91izObieNh
         AspUV5uPpOLg1vrebueUCf7BAHLudIhzpl5ZvFUlsnVpOb2xxM7/zNL8CjSYOoM1M5+Z
         JJ1I/VmNYq17H9J9gafVf3+Plj+9oiIxHaGz3xo/OMG17wEqS6WVZq9/INaBUuQQJQKV
         99DjyqTnRthe1YGLUAEyzspW/rznrX5ffdhQnNS3APrVLKSlGDkPof/FSQfdav/LopOI
         bkAAarTLMHO2nADsJDIVT0VfadzsH9CNyolANj9OfLjpqs0yRIZfYO+oSf4lonmLz0Gb
         OzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064786; x=1790669586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITZ7U9bHx3O3ChSLQaPRjkc6o4GzrK34Wvd9RlYR2g4=;
        b=xOU7s32RqzOwmR1/gPmZKrM8zhTYLdnR/yYKV2r/3FSoGfKbnu66AOEa92axHk87PM
         mshfjNE3LQWDsVf+tok7gjwMtcplSiqbfPBb2Z6gDtLBFvRZQ/RUwTes2ULVGhFzNiJ/
         wf/BwO5IgGeDMadgl/VPaUqyHBrOET4mb0XqWTnUm2O530GyGBu5wgZ7894qT0xmTzYl
         bMahIdYRvgobmw0djgAZrerazC9ovjLiJyT54QErVUbmNODWUefDJfxXodn957ERZLQz
         EUE5OS/LqtNEGRDwB69h4ZznQX7IGPi/trlxANFb5mPl1EPS5+heOPyc2zlTvadWui3/
         vLzA==
X-Forwarded-Encrypted: i=1; AKwUvBztwvKPwUnr7f87vVqLStoVE9vXggtIT+H80uA3lBxklSYgXwQlGvkwRY7wW10DeVXPWCoT9IwdDUs=@vger.kernel.org
X-Gm-Message-State: AFuF++k1WDCrC1YgMk7JGaHpqkfRlrlkaPPrHt4WN66jDFkuYlwi8lc8
	jWogn2M0PYUZ3hDel9Vhvp4mDK93SzXFpEmedtJRe+xESMui0JTUgkoVqlRgv36KGuuCFfmwQ3s
	lzCGaUkAWPTxd3qcWnqzs7D+Rb+yPnVnPOf7NrBsiuM6C2PcskynDHrbuTd/p/Gs=
X-Gm-Gg: AYBFou0fxQ4AWFOGycePjWx5Z7W1nL13nStoUREdl2gyydpiY8Udz1ww22g48OSWBxJ
	xYlEgpdAk6oAQaDtIBw07JXMyspuWZHUczOM37hNPgsTh+chrTecQZrDrgX2S2+z6c/KTXbNWWR
	nLjXYD2HX+NwbvHxBcorFagJHhdePfb3kMOWBnNs1iKxL9QRXnFTr5WZ030tp7o1BQMw+jWrmlI
	RMuSampA/hRHbCYvwps0QggfK/zA1SYn/VoqUfoRtlMkR/aDjKa3q7S1jtWjk4qQ9lYk6BGCrgk
	J9GheFP6ACyN+UvlO5xUfCHNdYvXYZAG5doJ/J5Q/iOeK4T8b1FJeJDa4SmgFGTaDZTwZDXPMv3
	bgtIqF3lGD6iPzvscMfiXgsZFHvK7cKHGBlmxYu37CQ==
X-Received: by 2002:a17:903:1987:b0:2dd:ad73:c98a with SMTP id d9443c01a7336-2df60b471c5mr4789785ad.34.1790064786286;
        Tue, 22 Sep 2026 01:13:06 -0700 (PDT)
X-Received: by 2002:a17:903:1987:b0:2dd:ad73:c98a with SMTP id d9443c01a7336-2df60b471c5mr4789505ad.34.1790064785891;
        Tue, 22 Sep 2026 01:13:05 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129b37csm3678940eec.15.2026.09.22.01.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:13:05 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:12:58 +0800
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
Subject: Re: [PATCH v4 6/6] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
Message-ID: <arI4imcmjEyVzTOo@QCOM-aGQu4IUr3Y>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-6-ed05c6e09240@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-nord-v4-6-ed05c6e09240@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 9dCsTl95A8SArEVr5kD0Hs8_iXbJTc48
X-Proofpoint-GUID: 9dCsTl95A8SArEVr5kD0Hs8_iXbJTc48
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDExNiBTYWx0ZWRfX7hBxcRDAfu6+
 jDBS/kEHNHB7CA81P4+tBY28tt6RbEjZ3ysywg17ry8dFVOzj5SHhaRWafQwGzPR7GTPKmhAaZO
 wjvLyAtgwMTetQ0DePEkwo5J1fH0Qds=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab23893 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Y4sVft1UDeOkrP7wHAgA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDExNiBTYWx0ZWRfX6DlU6dqjLFh6
 4Zu8tYKPQ6sK4PuoMJoO1SLAxg1sxMqIW0EuopEtSirQNbu6l1t3qBcl1mY1ypGkyLDBXnMpPvn
 HRJ+I3bh4snD9wERDxIC5PNCEXmE67Q0hnWKVpAmgS/ZIVTLr/+BmdvWWicHCFGSfTA527/ynza
 J+ybT8N/VXZt4Sa2IgZobcGmtjbNngrQFGCoYTAKNmummpjEOjHLhwH8iTOkXuY2hQ+f9Zwo5CH
 Wfu3/b4o8QFeHb7lUfEUWkLIuGvuyZYZNqm5oaqRL7PamUNIeDeZrS68tAUKW5sk34dh+soQERL
 cfTbETZcFSWaA7I9fONz1rEkYdfOzguAL4UMHqSOwy5tnMbxZbHOMvvNUoVZyMDw579Y8NPBeD+
 OlNFCYpTuFOpdvUe4B2WMrSDeolKRKYk/vOHaAdkuKso+ezrmOAIiQhCawazquLN8n8Tht99Pq1
 hU1O+tApv0UHWz15lZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220116

On Mon, Sep 21, 2026 at 11:07:14AM +0530, Krishna Chaitanya Chundru wrote:
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
> NOCSR reset.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
