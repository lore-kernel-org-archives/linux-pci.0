Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085E3D75B1
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238485; cv=none; b=t8QOJG5ilnh6fC6hg7r1dU3Bt9QkePz8ltxhnnc61AjqLv7HQEw5e6ytQB2kckcb7ZkYbgvh/Z9nBdlHZ4vxQaKnCHTFUMVnpxDWdOsAmuuk3KI2YnAGXc7fxrUYkLDiEN58HvhXaw9/m5nc6nHNgn5pI2xckERfKcvYQ8jaYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238485; c=relaxed/simple;
	bh=6sB90ShbfkUg+i7d6BM/f+tRM4OKgYiuHbS+si00ZpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3g948vuJ/8wRRyiaf62CoTW3ilMNVBF7aXHVjer5tabc/5tXwETNU6Qtr9Rn35mLDTeN2NA8uA9Jnq9L22bCWG7IGLLGI4ensJpkQchoNn+zOiDuxZCvkQCW9T+rAZZLoUpUyPO9F2rZwer3n0jL/wnTLugdN/edRzqh4x7zRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TpNp3W2O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IonQLDky; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TpNp3W2O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IonQLDky"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBHZYt2483151
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 11:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Gbo+tER6P2agi65+IoK11DMG
	JudcKhnoP053vnEPwzE=; b=TpNp3W2Oolckm9QwP32Ki0zrr3+eXlkVSRJxgTpc
	dOvS4kJVGPq8EpW3KdYCXMC6GL21HF1+SUxsIUEY+50un8chx1Q20NBl0s/w2lpb
	tdMvRzHZuuYefLKBTi/YahSW9JEBDT3i9Fn4e/bqTnn13ikgHOnw2oCky9nfjykS
	iOgcNvdevzotQWJXvlG9qz7WUQTpv/Y51/bss4rCCAW45ipiUdj2eBeybrv7qr5t
	AWbKT+X+x++79ZHApw0NKIP/IK0MjrDEbruHOHP5Ew7tmrTiuUiG5YyOntpDHsKu
	sO+oYyE+1kH+pPVHC9jns2tXo5A3YU2Ky2cNf7TtxYzvgg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpq9hh68a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 11:34:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c19493ac2so55059861cf.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785238482; x=1785843282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gbo+tER6P2agi65+IoK11DMGJudcKhnoP053vnEPwzE=;
        b=IonQLDkyaJ0RzKr8jLzy52AU5U/kA7Vw9OaA1LyrUiv3LeosJHyLbxmvKOG69Ye0Pu
         6zjgEurUsLAYzvGI5oIbW9t0/kJTOJ756o4Xo8DuaKfyytOB5L6rlIoc+lZxQK5WTuha
         /9eNV8XzuqArdD7auegeRO9kuCuxtuVEc37dRZdeOmPIn52FOj2wtjF6muO0sigoAPvy
         Gclw9r5D7AztiDwfBhtLFUD4ZfqVgLS3yai7h9IsHrkAVH/vqegnj1FN8/Ip9OigRhhN
         fnw9T9wSF/G765WBEdBu5VPJDyGmlkCPLq7OCz5L4TTZd2mZeKHguc553sCidzo2i/+L
         AGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785238482; x=1785843282;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gbo+tER6P2agi65+IoK11DMGJudcKhnoP053vnEPwzE=;
        b=lWlkq5CmEOYiIlqS+8qXC9kAPQVMXykmgHIWRo/l26UHtku3bxnRwTZJGx5nAkYfVl
         hNO9sZgwzBwYZEgjSQEOZ3KNKJOyDs/p19aZx/Ao8PnTpClisqslBN9ovtFn8s9seBLQ
         Ts0mIvQ/iqWdFUNSgKDJGcN+wNiH2ofFrOICAkJXv+GgWyMoRgfEI97CDqZ7Y1L8nbfc
         lnGzAQiUz+2VTXoiaUM3PejuVALCG9K6S7i1W9QMBA6WMrCGi8if8oAJ91daQKLH2SWe
         3J08MJuEJkGigU6NbWcO/9rursahvOEf+yXWrq9Ump0LgIWxet1JhMsWoAC4aHnGrEGH
         1GTQ==
X-Forwarded-Encrypted: i=1; AHgh+RolCfRuk8+G/5pQzbzCx0wOxmsVFvzc/epvbJGCl5/8Vkm4DkkXEEukuxQsiCSwjJ3m9yYz+JDguv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEYROFcTx8o8ClCwr/5BArPCeHVkWYABrUPGdCJfFPh1MOWzQp
	u47ejOgjczax/A3Ij6ZX7yfKrcZwKMD1pyRf+bWIDqWePpF2SzDc9cfiBdfc41UYIDYLj+9O/9t
	U+sb/zG4z7pmIimQuugdHIQ0x0wA41wGD/jiXcYXmGVYumon5JhLdMYNxxTnP26A=
X-Gm-Gg: AR+sD107RPSySro8Qh7mSOCYOZpKwSY3duXtRpVoU64LrKrVFaWQ9TfIUEFj5CRxHeH
	/3EiipVGLozraM5t8yi0Lqu85jAd+mZ4juAscJp5LXab6eYHVOjlYUjJWz018X70qKbIpy6pXvp
	duQKKPPL2sGZUIk4UN1fG3OxSaxN2oupcCSpMPR7IobCigAN4h3WWMEWtrjRQ8L845eMFDv7iUa
	h3WRky4Yz2MTTsPS/6p0N7bjXKHkAfjXGvZrFY7NbweeL8yora3YOAOO7QmuYgm8N68xBVASiJA
	TP1R4dC0111F2Lg/4hJrtk776PCgi8tM/beWy+eeR22yjrOJtErxLH4VU8CezbbK1UG/VBPQZ1k
	71cdI8f/1v4JU1sWqGxve3Yt8bGaZqgY8lTpSGzij8cHo80dnge6Oo/dlO64+8iB0D+7Lbttk42
	eY57AUYzEhe6cvkA==
X-Received: by 2002:a05:622a:138e:b0:528:320b:305e with SMTP id d75a77b69052e-529d6feab04mr15912511cf.35.1785238481979;
        Tue, 28 Jul 2026 04:34:41 -0700 (PDT)
X-Received: by 2002:a05:622a:138e:b0:528:320b:305e with SMTP id d75a77b69052e-529d6feab04mr15912161cf.35.1785238481464;
        Tue, 28 Jul 2026 04:34:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be090b6asm1974708e87.36.2026.07.28.04.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:34:40 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:34:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH v16 3/3] of: Respect #{iommu,msi}-cells in maps
Message-ID: <fuqnxdknkajqotzmmlknwnthqpku7as5kpvmgogexl5bi7x6y4@tthbasf5lqvc>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
 <20260603-parse_iommu_cells-v16-3-dc509dacb19a@oss.qualcomm.com>
 <3f5c974f-425d-47a5-9fda-e05de1f39d79@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f5c974f-425d-47a5-9fda-e05de1f39d79@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEwMiBTYWx0ZWRfX7AlCrQh1u+qL
 cswteWJgoghn3V/5xnT4GfL7oYTqpGPW+kF8j6CFfNHAbNdFwtNQrf4YjIHG53Mw0ne1pERwo4r
 J+wRA9V3zIfTn95LgEcqARyWcLCCvKM=
X-Proofpoint-GUID: AF0guw4G2Mcnsd4K4X1ea_P-Zap8JvnA
X-Proofpoint-ORIG-GUID: AF0guw4G2Mcnsd4K4X1ea_P-Zap8JvnA
X-Authority-Analysis: v=2.4 cv=Aa6B2XXG c=1 sm=1 tr=0 ts=6a6893d2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=wdqIz0_Y7svv89iKmCwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEwMiBTYWx0ZWRfX0UMpSUStba7a
 8pATVgmXuaongr60FT/efRv2MBxl8cQBmDq3AUc0nP9F0SdP1b0K+Wd/oxDtZF4X+DNnN0dkThi
 CNqaGBvqcq2Ng0HAx6UpyVM2OeYAxDxatablB7V9W4eQIlnJSJQ163bjFbk9CRXlGu5OEe8nM0g
 yMBuSKraDSROrx4ab1Nvb+/BBmPqc1qCYnoH5yawun/gJc2UKB5vFO1xTybJlyxIoyW2Ay2VE4E
 ST/qbyM/HHwbS8F+3T7mTeNyL/7wl3+zUTJpG+pJ76S5NxTjY79oeVvrfD4uraDuN5mh4qoEuHi
 R8nLhSxAPGVExuC0F4lMlH5aN7XRoHKitCMShwY6g0BAf7i+q1zCTMNJCkZ2sQUDOqQDF0cT3pd
 3oESU/OdzkW9XL7yNDRpyYjAgUG59ntI95csHt3k+K3KHLXbS6Xy+ShXEkIh/lzl2lkVzy6DAYp
 9eYhtMk9NH54ZijKEmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280102

On Thu, Jul 23, 2026 at 03:17:24PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 6/3/26 09:13, Vijayanand Jitta wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> > 
> > So far our parsing of {iommu,msi}-map properties has always blindly
> > assumed that the output specifiers will always have exactly 1 cell.
> > This typically does happen to be the case, but is not actually enforced
> > (and the PCI msi-map binding even explicitly states support for 0 or 1
> > cells) - as a result we've now ended up with dodgy DTs out in the field
> > which depend on this behaviour to map a 1-cell specifier for a 2-cell
> > provider, despite that being bogus per the bindings themselves.
> > 
> > Since there is some potential use in being able to map at least single
> > input IDs to multi-cell output specifiers (and properly support 0-cell
> > outputs as well), add support for properly parsing and using the target
> > nodes' #cells values, albeit with the unfortunate complication of still
> > having to work around expectations of the old behaviour too.
> > 
> > Since there are multi-cell output specifiers, the callers of of_map_id()
> > may need to get the exact cell output value for further processing.
> > Update of_map_id() to set args_count in the output to reflect the actual
> > number of output specifier cells.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> > Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> > ---
> >   drivers/of/base.c  | 168 +++++++++++++++++++++++++++++++++++++++++------------
> >   include/linux/of.h |   6 +-
> >   2 files changed, 135 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index d658c2620135..ac7961cbab94 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -2116,19 +2116,49 @@ int of_find_last_cache_level(unsigned int cpu)
> >   	return cache_level;
> >   }
> > +/*
> > + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
> > + * specifying only 1 cell. Fortunately they all consist of value '1'
> > + * as the 2nd cell entry with the same target, so check for that pattern.
> > + *
> > + * Example:
> > + *	IOMMU node:
> > + *		#iommu-cells = <2>;
> > + *
> > + *	Device node:
> > + *		iommu-map = <0x0000 &smmu 0x0000 0x1>,
> > + *			    <0x0100 &smmu 0x0100 0x1>;
> 
> So the sm8650 PCIe controllers has:
> 
> pcie@1c08000:
> 			iommu-map = <0     &apps_smmu 0x1480 0x1>,
> 				    <0x100 &apps_smmu 0x1481 0x1>;

To silence the warning, update the iommu maps to:

			iommu-map = <0     &apps_smmu 0x1480 0x0 0x1>,
				    <0x100 &apps_smmu 0x1481 0x0 0x1>;


-- 
With best wishes
Dmitry
