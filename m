Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60B3ED119
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690176; cv=none; b=dYrFNjrQZnj5yG6j5Qy0Xuc3CZw3o9Zd90Yo4i64usg0KSoOixAHIg7SVJ2wAt5aK5EvhjRCPnRR2f4pqOUNkCPaamUtL9LexBfpPhMcHG7uHk/tn424uoSJqonys1DBVLZMMlVyx0KTiMOqBzv/rFXa0y/co8L4Gc6yHO57MTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690176; c=relaxed/simple;
	bh=8pKSoyetPXKpNKLPG0IjYbFaZYicC2/GSi26W65ckfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKJz+kcNja1pXUYqxN1GiHjJvq9LQ9CmpZ/fsPJ6z4NhF0mE3keohNdSHUdUfPJMMApzw5/YUn9nXvjLSJYADeeufH/7rp8FMU6Cx2BlKN8AWol7SF6qFVFkHNf4bz36QiL6d+51mxq5jwR5cGaGmIlgDxD+/jZy+o+PhI3H5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZMBzrho; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jadgepID; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZMBzrho";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jadgepID"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GF4VPl795536
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 19:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+cnQIkFDXwporw30NasLf4kS
	q8rzFR+Uzt/PemH3SE8=; b=TZMBzrho1ZI9j3MecyDJMrQhyfYnbp7F+HbgPg7R
	mqfG+xh/rvJqlW2mwKsCyVLwfzrC53QO8yBljjCYZZZjYabFv0bm9U5n4/bMcabq
	YF91ns+etwVEXWpgUnVfpVioCHWVnw7Cx0EpIQWBBbaQQV+X0Z4FCLk/ECUB2gu9
	IFz9s4XLYnswCOPX/A5G3JbjNPfwmH51uRI3xjMeiVaFLgWnjFPeSppW8kGt/5db
	2TR/0eQePYHL75VvPioyDrfUy4lTd5GC02JHxagrRGm3bXDSnk3HmHyicFSh+ZvW
	B756UKaOFmyJet8cUhVlEyPQtuuFGVvOCTwZLpwxvLTArw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm6d10dq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 19:42:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5091327215dso728771901cf.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773690174; x=1774294974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cnQIkFDXwporw30NasLf4kSq8rzFR+Uzt/PemH3SE8=;
        b=jadgepIDAZ17KapALilKQc8TAxfR06ksj5lAjiNHEWhcLOEcvU/U0qyYcQ7ynwFYtg
         WrVvNoFK45vfS5qz5E5RH8yHubHGi1ZW7iB3eoldZ0pG6n4F9219pIcC92tRdnBPbHt6
         m1wWmAGf3aeslyduvF+s4WvA+qHkyIsc7NBIxNWccB98knw/pB8ZpABjwKQhji9hdHNo
         nYrJD6cuLsQFhY+7Bg7JBLm7MWHGCz5zpkUEhJF5deN6jKUHk1SSI77x67D5GIENXfgo
         hUDYY9ref5qSXxcTmBr9+Lh5yyuS3hOcVY/4ldQI1F58zf8fOkLG1YhFPKhfCU0tSAu9
         IhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690174; x=1774294974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cnQIkFDXwporw30NasLf4kSq8rzFR+Uzt/PemH3SE8=;
        b=qzXQ+gSeFx23mORYC1uoS3WdSnInajRT51etOl5y05l3kmDXgjC4qbflCfnVIpPPDI
         0pzDzYRnLEFmdrtQiELWW025JV1TjAzXx9rWzCEhp0iVqluvxNKKuKYK8ho9a+mCLoKo
         ozmU/INA2GnmJ8ViURZMw9RezXslqzi1r2Ue3cIMqIBJh1F/huX682tT5kO1mOUkIDlK
         WKOc/WUZl63FsMQAOvoYWkRfyH+/fM3NCphsMNKyph2OHMXPb/unNXGW6tkQ3lIMgN3z
         tE4rLOrv6Sde+uoRox8ONLZ1ERPT/jXhRCm7b4si4of05K4V+Bst0uLrp+80boh4jsWc
         y32A==
X-Forwarded-Encrypted: i=1; AJvYcCVhLL7L4pKT57Xu4Iytv3EGfWa9yDqOcGHyYW9FUz1iADP7D+qaQ/PcA9AklLccwc1frtgcOGK4bxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlK6z5Pjh9+xYom4dX2mOpPZ3iYUH6MXeW1gejPMEsyHFuv5SM
	XWyI+sfUqmgIb+mJDuB2tpt3rJqEAooZ98/AsxQGqkncNTRlALHy05TvyOTqgabqcGEWp1TIfk0
	39LBgmNSC3UAX5Cvm4Hcw6XadRWbKJCsc/+iP/PkXnHsaLNnEVYew05q+A1oBClE=
X-Gm-Gg: ATEYQzxUgRLx8KGLquzMZYlB0AA8h6Li53ITTggYss/9J6Me5Pto/M8GDWtlIvKCzfE
	PluYFBdchxrd1mGkRg3AAett10thogBGTdKIE7j1ZXPpmg1lzEmDn3iqZvETYgMgK2LXnX/LIXc
	cFS5o5rtDG3Qi6tw33MuFVtFwggxvks9yv5bdHDe8kO15zeI2UJqeYA6+SkbPYqXcsmkne7SBZt
	h0kMG+mV5TBXgudZ4CzISW+Xl7HADmRsldhfWNzp5G5HwokfsRqieKPfriMBDCmWas8hiJEebMn
	03jKVeiKQbj0c/G9uE2+cDH3/lq81qAB2qRDsUKRxJZKRAUuLiCpQB0O8c3h2clymcCLUd2BGIz
	TWIT38y71s/0Gr5/qrShYzMzeOPIPvL3XfPkDPhM8PZu4IZpS1nAQpTTs91RglpTkyf/QF1L3BP
	NAxVCGZw7CbiHPdct9PknSyJ3UrY/1fuhNWa8=
X-Received: by 2002:a05:620a:28cc:b0:8cb:72b2:2a14 with SMTP id af79cd13be357-8cdb5a4b8f1mr1825088685a.16.1773690173118;
        Mon, 16 Mar 2026 12:42:53 -0700 (PDT)
X-Received: by 2002:a05:620a:28cc:b0:8cb:72b2:2a14 with SMTP id af79cd13be357-8cdb5a4b8f1mr1825082085a.16.1773690172393;
        Mon, 16 Mar 2026 12:42:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33be6sm3676665e87.7.2026.03.16.12.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:42:51 -0700 (PDT)
Date: Mon, 16 Mar 2026 21:42:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2] of/iommu: support multiple iommu-map entries per
 input ID
Message-ID: <z4eqsfnxiprfktxi5g7miqqukhjsqqbivs4jqmox6r75x6pbyd@hgtkiy3ltyzu>
References: <20260315-iommu_multi_map-v2-1-51b98cb79331@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315-iommu_multi_map-v2-1-51b98cb79331@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c7+mgB9l c=1 sm=1 tr=0 ts=69b85d3e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=b47Md4NF8ZsVKqcXDakA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _R1QPS3VaIU-IbkYzKRJ9op8Oh7FOUmR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1OCBTYWx0ZWRfX7kpnKrFhy+tP
 qBMaAX0xBJS38UyNBS1amOj+ZN8KcEbclo/cNPIzcGRkTJZT/Wmef+fSTQgZCZTU3Nw1MQ/opRN
 rUTWmK1YBDqzGBnp6+fo+I7qIs8bG39SWCUiQj8T8Yv2OKyCYjVCBUylCGahL4MzGpWs6/OaV0Y
 QSi9NaVUefPkkhsKaKHMjD2sOWwpbLZYzvQxScORC0TQleCE1rHPmNNUeqYY9OiLN+KxLJ4TR1M
 MettethJ0J8hKRiOwQxa2RQd5dY1KMioH+PuoNMG19N81pLA1sVAeCWdHho3zX/4NiNdcFQQlXy
 U/kx0tFu7swvet6hAIUBYLzn9+p1ItySGnv8jypgCMAu43o4EJAlSTH928ldcY+oyTkDifwvckq
 OfoC95d8BzOLZM6ojGqnuKZ4krUN9Rn2iPDICMiFQClGt7Jm9HU/wGSQozQHB/bdudoQfM1apec
 a9zl2PFDgPngeWcDv2w==
X-Proofpoint-GUID: _R1QPS3VaIU-IbkYzKRJ9op8Oh7FOUmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160158

On Sun, Mar 15, 2026 at 10:37:43PM +0530, Vijayanand Jitta wrote:
> When multiple mappings are present for an input ID, linux matches
> just the first one. There is a usecase [1] where all the mappings
> are to be maintained in parallel for an iommu-map entry of a same
> input id.
> 
> Add a next_offset iterator parameter to of_map_iommu_id() and
> refactor of_map_id() internals into a static helper to carry it.
> Update of_iommu_configure_dev_id() to loop over all matching
> entries to support this case. All other callers pass NULL and
> are unaffected.
> 
> [1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> 
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
> On Qualcomm kaanapali, the VPU hardware has multiple internal blocks
> that generate different stream IDs for the same input ID. The device
> tree encodes them as separate iommu-map entries sharing the same input
> ID:

Vijayanand, even I would not understand what you mean here. What is the
"input ID". Please describe the issue _exactly_, which blocks, what do
they genrate and when.

> 
>   iommu-map = <0x100 &apps_smmu 0x1940 0x1>,
>               <0x100 &apps_smmu 0x1a20 0x1>, ...
> 
> This requires multiple iommu-map entries per device.
> of_iommu_configure_dev_id() currently stops at the first match,
> so only one stream ID gets registered with the IOMMU.
> 

-- 
With best wishes
Dmitry
