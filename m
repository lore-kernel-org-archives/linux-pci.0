Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1817375AC6
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068722; cv=none; b=ZLRu+BCA2hkRpC/mPAeItcEm77yOwZ5w8SAHBjIN2ChvqP2wuydRVKZV9l1p6HRiLLq9tB2NoItsjRRPkIs1SGtvyqdKdMpMYfZa6obrFotu0cpG8VgA4yIBF0WiqJ2N0m07nfu+ws/GtMljrSLH5hme6XHT2+Snr7T9TjmdCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068722; c=relaxed/simple;
	bh=mcUzmsbUZQq4E2knB8VSH8G45CFD6tZ2tH8mnwbjETQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHePBiA9J3V8zwSA5W6lQhHIg7TUwhEqliqGe2hWERMQZCm4/YcPtum22r0nE+FAftVnT9IPnyvbPuKkHOKJkVj64zdLr81+IuhZ6lE2iIDFapzK9FRKrItquI4qzlrawKKoF5MKsYwFm8a/gQG0TzM0iAAxncoOIR7uD7S3GQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O19lbRdH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PDcljAxb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O19lbRdH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDcljAxb"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M72E8M1978557
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 09:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XKotZtMS7ewKcsV6iJ09kjS/
	F3R0guDpSO4Eq1SOvq4=; b=O19lbRdH/itxZvGtSA8IL73kRkl2nvs+YbsiRnuy
	EGRjefwsJ2ML/300gL+cpQxQX3O1bNw+7gho1CvCGEbu5L/z/vjeVEGGMiPY5Xts
	EeVw9CyPcDkUUIFNNYd0smVh0kO0kCVT2rVYQZRKkmJdfBpFBBGUBHcEe5C2/D9i
	qJqE57fr6MsBrDYsjZVnkLgMMN4JCW9rRREuvl4Elf2pM2AAiEPbj93zapYYpXpq
	dvYNMZbxa4MUtZ+3HPNlFJdygIn3oz6vn5aEHywqk8xK0qwPlACv720ZzSBODi40
	fyRPhYC4afTzukbvXhoViXgPpWVGqCCaQAlM0cpo37oaHQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gudw0j35h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 09:18:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-385d2703b64so717504a91.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790068718; x=1790673518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XKotZtMS7ewKcsV6iJ09kjS/F3R0guDpSO4Eq1SOvq4=;
        b=PDcljAxbsD05EF76VTutfKYl3LdREPRgPg6xk30ZriOm8KDz3PmsFC3jARzt3WjfNk
         ucoEVVCgUMm3bGLC2cfCMV3BaXbLnaNV4+Kc8JdwL28xZeOI1qR2P4aBrY6Y2k1oqABs
         MrXgKsVjcuP5aikXhsnNN1tA/WoJMP+mG8sBTk5kkz2DkhWE6+TK9N0aI4GJTucPqlvJ
         PoDHDe29ggohgBExuoe0Ta7/MREHWS4DUwqNV7NP37fU8jP1MQHRBpTV90a6tYx4WLlS
         SxSJJ7bMLoEQftfgNxNg+gLZMlbWOEjZdn7cRcy7pLs8Akheg8YYA1JUj860nZUEBHsV
         oOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068718; x=1790673518;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKotZtMS7ewKcsV6iJ09kjS/F3R0guDpSO4Eq1SOvq4=;
        b=ftrplQPb0mPfm6j7tCF0aMdsWDo34RvpTwYpe3BvUiaQxlYYaKNhnXiSVGJAI/kAjx
         M/labUKWANr4rc5BaYKuJ8qRz49E6Md/zFET+CJ5OhVfWBzypFqkHPXSi0i5ww1Qaj4l
         B6UAMcsor/mUPByYZdlzsXHSWeop0m4Fu6T8aq7/AnXnHIqC8fjZVFJ2zo+OQwZvcSqQ
         GXgl0JiIMp1fe4IK4csLcxoi7aSG2OQHIZsAJ9GgM7fNgCQTd54to6xC5NFlqYqAu1TZ
         f5Q4XXCWJZ52kdN1h3MBoWiMZEUCpWDP7hSF1x9zrAbTmkg/ZXy7AWajKkgeahqjd4Ns
         6Nuw==
X-Forwarded-Encrypted: i=1; AKwUvBxxq/qtVPRhumWDNbE/UI22FbCgSnt7ZS2xzWpunwNJgXUhtxmn1mdtKMHE2K3IsAleMXrw/BRRxEA=@vger.kernel.org
X-Gm-Message-State: AFuF++m3zYroXUnS6DJgfs12CDvGgdXVDEo977D+0BX9kywRYohWA7Wz
	KQBdNcOQ9iOQJgYeqIn86NYkXMJfeJFSAgow60WID4QGNLd+DwwvTifCch5zeoOm6bT80CZF++N
	b83lu6E2NvRs5m7Zz7aiuG8wJ1OEI6wQJFYZ4/OHgDUw+Uql4Gt2ym2Mgq6kRsK8=
X-Gm-Gg: AYBFou31QtQQeb6dhxLwk2NBHBJdbhXbTyrQc73lsXru6Bv7ru1HqProvdX8I7x7dxB
	MZEVby+fw3TRXdaLKqi4Gd2Pj2Qr4dCe/9YGu7UzJAlNoP7/CE96azLaJOXUNKykGBi+YYYGzMy
	IJIfsOUwusrOU4LhNZGOxCheWrVGaabBHOTjSikQG9jrn/sjJDBIVhQ9TqdTXz0JLxk0wawsOi7
	r1rNBJUEEWTok8tykbZ3HN5PcBbWFcsmg3DzCwb41o4MFTzS/EmRtbg8BFVOUf1AMqCX9CrXUN8
	FMZ3kIGLa6nGbz+CDEI6wO3+COkJ0KyLsq27gZamE99mTK6Iqrzu8bf2TvQWAJ7iiN2esg3LhJQ
	R+Y/zlJSH+/WBKjs6fit6Oah0RU9spWnZ3BCPePN1mBxr/cA=
X-Received: by 2002:a17:90b:554b:b0:3a0:5c17:642d with SMTP id 98e67ed59e1d1-3a07326e7acmr483723a91.52.1790068718278;
        Tue, 22 Sep 2026 02:18:38 -0700 (PDT)
X-Received: by 2002:a17:90b:554b:b0:3a0:5c17:642d with SMTP id 98e67ed59e1d1-3a07326e7acmr483681a91.52.1790068717620;
        Tue, 22 Sep 2026 02:18:37 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e610e786dsm4762429eec.1.2026.09.22.02.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:18:37 -0700 (PDT)
Date: Tue, 22 Sep 2026 02:18:35 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/6] Add PCIe support for Qualcomm Nord platform
Message-ID: <arJH64UqwPYfg5c+@hu-qianyu-lv.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <arDPABIQl9wKYVKa@hu-qianyu-lv.qualcomm.com>
 <dfad8320-5a92-4398-83bd-3e796faa24a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfad8320-5a92-4398-83bd-3e796faa24a1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 0mmf7RqtAfapMQLTkTGfWXj1BC-9ZYT_
X-Proofpoint-GUID: 0mmf7RqtAfapMQLTkTGfWXj1BC-9ZYT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEzMyBTYWx0ZWRfX+bg5lByX7pfn
 Nk8jlljYgn6LxuVa5/O6UoFvJlolkXtiDpEd+IsBNgYAN73jwqQhBXAsPS7ztuXDk0LOKzpYri7
 +kAAuDOA9WZYU/mFM/i7MBDzturrkhAOG8hSVVc3Ct0Cd1kNh1HLjgOtUzGpZ3N3xMBQECmAoCj
 3w8y9ZxZwFCuCOgsEHeMBT8qH4qiIMgVHzOCkQpuC3oKdlnnUR4kt8uIxLpCWw8yZITo2Pgv88n
 m0V1M8Ndb5ZGOWbr86Bz8o/1+191IdmfvWA33OY05Fmn/oqAKVl+YUTLRLA05jeQGWsp6tITxje
 L6J8yRde1eNpyO5sw0s94XQvtC5/cx8xCt5tYJtUAdv+KATpd0fk0WQJJNiRXpeZtZsIsQLi32J
 sGzmatEgTHKCIKSMEq1Gk+qElL9hB6PbuzaByjYygBlnvrgt2X9IKWyqJZVRjCBphLiX//V5664
 XNUMgZ3tIHs1HlSKFbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEzMyBTYWx0ZWRfX+Qqo3mVQJFMT
 Mh88CgPuovE9apcteVOlKJwMr33Tqx1NmxBFdmxWN/+m8Oibl+tB5YkPrLZsv9mDmSvGp2oEfOq
 +UCX31ah3dSFEu73KJXb846rAK17Wgk=
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ab247ef cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=LSDu2nEps--MNvHFjqkA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220133

On Mon, Sep 21, 2026 at 09:37:10AM +0200, Konrad Dybcio wrote:
> On 9/21/26 8:30 AM, Qiang Yu wrote:
> > On Mon, Sep 21, 2026 at 11:07:08AM +0530, Krishna Chaitanya Chundru wrote:
> >> This series adds PCIe support for the Qualcomm Nord (SA8797P) platform.
> >>
> >> Nord has a single Gen5-capable QMP PCIe PHY block split into four
> >> independently-clocked and independently-resettable ports (A/B/C/D).
> >> Firmware selects the active lane topology at boot via a TCSR
> >> configuration register, and the same PHY block can appear as a single
> >> x16 port, x8+x8, x8+x4+x4, or x8+x4+x2+x2 depending on that mode. This
> >> is similar in spirit to the Glymur multi-PHY support already posted,
> >> except Nord's PHY registers are programmed by Linux rather than by
> >> firmware, so this series adds the PLL, TXRXZ, PCS and PCS-lane init
> >> tables along with the power-up/power-down/soft-reset sequencing needed
> >> to bring each port up.
> >>
> >> The series also documents and wires up the qcom,nord-pcie compatible
> >> (reusing the existing SA8775P PCIe controller binding), and adds a
> >> CORE_CLK_CGC_DIS/AUX_PWR_DET workaround required to avoid a timing
> >> convergence issue in the PCIe power domain.
> >>
> >> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > 
> > Tested on Glymur CRD and Glymur QCB, devices can be enumerated.
> 
> A test of "this didn't break my completely different board" is
> welcome, but looks a little confusing without you saying that
> was the intent specifically - unless maybe it wasn't?
>

Yes, I only confirmed that there is no regression on Glymur.

- Qiang Yu
