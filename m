Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473133ACA7B
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504519; cv=none; b=QWbQenmTCOms3CDoUzvx7LYHSUqHOprK2OuAw1vXds65pS6cL//iN28mWTx4OYRpEs84Fjzy3S46WujG4Xo7kocZIdsp4thDa0HAbXKGZ7omavrUTBxNCCpatqhEInnVuvXxNsidPYmhfT1GvZl4kxOQg1K5hyv3PvQn+ZLkAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504519; c=relaxed/simple;
	bh=YtzAog2iT7qRYMNdO36y/DjGGvleNLJf4g9GCKshuTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EavlORgVA6nLkx0EwYa9Be7khFcNSuuIe0Z4dpql7IBpCMBCLDydqeIfPrmVuqcWx/1RqO3FPOGRlUOwk4gkyNLw4cMInkKpLp1d78VEE7RJMQ9ArzlG0HrXRO7PiJXrkjsapy0hw21VB/TQrCbBc+8fPPc0uCwu+qivSV7juxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6USjlaG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fUdGj/lQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6USjlaG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUdGj/lQ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q0nnnE1811861
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 05:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	808xdNmKLCaAFJRD8fSiUQE9ujHk0+F2A04hZAqckLw=; b=g6USjlaGedJfM+6c
	sh043EGNYzelCOV0izT4tNV/QLb3n01n46Bcfmfqhk0dekR80UJbYOv+ECiKyqF5
	hDGBoDW4HjYW1FAnHB6HQjPL6wiU4HzOonNQwpb/m8z7iZT58NXSi3dOBPrIjoKw
	wuQ+A2qImDN45is0qhRImk0Fg9/VXYXt4bbMo7IOL2woERqueHmWAt0hrmhyhiv0
	JLF5Kd2kqXU71weN+dS35T63ejg75uq5aWodNW+gv5W1MJbCfegg49wHfqx8ROk+
	Zh+yu0VCeaDvVnApliD+U5Gk5SVWVPwHYOe3DC9JmVtMZhekVG/bxeogXSihbsCE
	J0PCCw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4tkn0tbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 05:55:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aeb90532f6so7590855ad.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 22:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774504516; x=1775109316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=808xdNmKLCaAFJRD8fSiUQE9ujHk0+F2A04hZAqckLw=;
        b=fUdGj/lQkRnW7eFg1qUkUHehc+jKJkx9JToNGkn7y7LELusw/36nQ5kA6fD+P68dXE
         WwFcr+cRX+0qo0ar9rW8TrjchrfQyPAq8qkMk6x7VEnL8eoj6UieboFFlvPE/8t/M42/
         lro4idjahJozrDj771QKVH+GGajUcLRTy8kxN1+kbjbmOL3IsmkrbJc27O2Vnf9gFB0p
         2yVe6Vx7/XZVLBclvnWFqWEnDSUBqEtT1P4aQ6wbroGs3/9t+fvDwDQA0XF+grVdWEiQ
         wL4hZgh+aFQf6WUVXVoWx1+FjoFmvuPOBGsj+TPNB7EqAn5Rfgc4EB65BIOljo+Z07Yk
         r8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774504516; x=1775109316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=808xdNmKLCaAFJRD8fSiUQE9ujHk0+F2A04hZAqckLw=;
        b=Likudy61c1EwewmImxl3q84fWmfeb10W4eRBBvR8hBaRC4yrlsjFmcVJw2MZl+Gjhk
         OXGNBPfkU7iHN7dJ9MQ4HGzzFIxXY69P/p8PNY1BW0zrSstutKLuBfpv90oIRMz1FjX3
         H8gJLNRxYWIwqWduMOIm5FgIkMUpyNZe7yDQJfRaVmTowbT/tSLOLGV9oP/+fqSUu/mk
         ii+svxKfmJ7kAYMfNFOAs27JDrmxqyXDp9ihAxubErOW85fsttO7ZNcIXzx7BoOsm5H+
         92qFqZrB+fkhQH07e5C5XHWFQ3QpHuwrIGQ7XzyAjtHi2iN0cjA9ataMnCkaQtR8nw5S
         2XhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjBlOemIKp6h6QAyzPaVNEKV39AuT1K9TZfDLhslNDWmM9B1wSp6tkRGxKF1HXq/HOmR5VbOdfojM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFF32j8yR07tYwCOWCqR1qUzQxjH8LAhtRYcS2RZbZnkvjne7
	i88j3A7bnAtL2IU8Unm3IRP5Dy3kPryUDL4eKcNsMDnC6Y7T1Ptlw3K3D+yNTfikCG0PFkxweCc
	1XljxDa3OEMH9ZZdBVtuQ0lxkoCPydk+N14pmWIZ3Nqj8ufioDi1iaLbdhZn6LD0=
X-Gm-Gg: ATEYQzw5O1yuk3JTqdsAKzWiJ4mdefHAmVbKjgnVwD1M344TNmDoxRiUx2VyMC9M0Ni
	HHhJd6NQsilWfNzH47q+jmij3MDerWCtXZxybVRgESG4+rv4Yfqqlgo2k683bsZkccN7b8G5BUy
	fnKYreE9knlNXWof3mhLk+P/T/jkyl3Hd6KebddAV+DTWndxSI9Zp+h9QxSop4YqVxtLoKcVP6h
	kIZ3bM7zmu8i9PBDU59Nso0YBlkHGa7N9bMNECRJKO6MsS1V6026WcEbIydvaLOC8zvuu5dvRnk
	sITnTHQF8Exmx117Xqd6Hq8kFEwbchuU3F+2ajsgtwYVIprwMv2ZTL5D0jKH+ywFi6omyK3HTqe
	eBLijURuj/E2qzXR2/1Z2ItZ3ujI9w0WqngoLh63YQQQ2Vus45k6zelBG
X-Received: by 2002:a17:903:1b10:b0:2b0:673a:7c90 with SMTP id d9443c01a7336-2b0b0aad881mr74442935ad.28.1774504515838;
        Wed, 25 Mar 2026 22:55:15 -0700 (PDT)
X-Received: by 2002:a17:903:1b10:b0:2b0:673a:7c90 with SMTP id d9443c01a7336-2b0b0aad881mr74442365ad.28.1774504515275;
        Wed, 25 Mar 2026 22:55:15 -0700 (PDT)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e820sm17098715ad.50.2026.03.25.22.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 22:55:14 -0700 (PDT)
Message-ID: <65f76d05-1474-46d3-aa71-4acfe86c5718@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 11:23:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/3] of: parsing of multi #{iommu,msi}-cells in maps
To: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260325-parse_iommu_cells-v11-0-1fefa5c0e82c@oss.qualcomm.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260325-parse_iommu_cells-v11-0-1fefa5c0e82c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA0MiBTYWx0ZWRfX7sui9BQsGi/h
 G9gNr9mVNBwTud3ZD37a7pfRVx/Db65btBdvaIwTKFLs+nOa43uZtxIHo27QGVw9cX4kSTwWulz
 boQ0CThV/tWUwonIsgt/K6OD6nERwMpIjwc0dKQWyzeNUcnIqWCE/3xGg9FVwAFOcdlWbpi8/2/
 khfjyQCUbne87Ul3HVV+OYpF1w4gFl0SgMq7hl43AypKZmXTGjtBc9vVa1ZufVYxBAzthURwFpT
 iMrUya5gNvHxxjm1twYwVgrSxsb9fBIb45CLmIZ7/CYafFAqK26itVkBT6cCCrdQeEc1cZj0gyU
 QNwncyTUGMqsI9/aDfHlO/vv53uPBGjbcWfEExi280eRda5hQhApYh/JZQnQtXvX72+DTu/IYxw
 sNbbM53DgxQrS/MHCrEQVwyAFbe5tlECurE83NeAj+FXVevtyyp5c9b7cjDVbxaikohK3YwhKGs
 pfumi7uDTKzlIHGqo3w==
X-Authority-Analysis: v=2.4 cv=It8Tsb/g c=1 sm=1 tr=0 ts=69c4ca44 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=G4NFmJWIaiRLgIwbil8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NNtveYU1_3PkDNp-4DXO-EswUTrumdyv
X-Proofpoint-ORIG-GUID: NNtveYU1_3PkDNp-4DXO-EswUTrumdyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260042



On 3/25/2026 4:38 PM, Vijayanand Jitta wrote:
> So far our parsing of {iommu,msi}-map properties has always blindly
> assumed that the output specifiers will always have exactly 1 cell.
> This typically does happen to be the case, but is not actually enforced
> (and the PCI msi-map binding even explicitly states support for 0 or 1
> cells) - as a result we've now ended up with dodgy DTs out in the field
> which depend on this behaviour to map a 1-cell specifier for a 2-cell
> provider, despite that being bogus per the bindings themselves.
> 
> Since there is some potential use[1] in being able to map at least
> single input IDs to multi-cell output specifiers (and properly support
> 0-cell outputs as well), add support for properly parsing and using the
> target nodes' #cells values, albeit with the unfortunate complication of
> still having to work around expectations of the old behaviour too.
> 							-- Robin.
> 
> Unlike single #{}-cell, it is complex to establish a linear relation
> between input 'id' and output specifier for multi-cell properties, thus
> it is always expected that len never going to be > 1. 
> 
> These changes have been tested on QEMU for the arm64 architecture.
> 
> Since, this would also need update in dt-schema, raised PR[2] for the
> same.
> 
> [1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> [2] PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184
> 
> V11:
>   - Added explicit filter_np parameter to of_map_id() and of_map_msi_id()
>     per Dmitry Baryshkov's review feedback, making the filter explicit
>     instead of overloading arg->np as both input filter and output parameter.
>   - Removed of_node_put() from inside of_map_id(), making the caller responsible
>     for reference management. Updated of_msi_xlate() to properly handle reference counting.
>   - Collected ACKed by tags, and fixed minor typos.
>   Link to v10:
>   https://lore.kernel.org/r/20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com
> 
> V10:
>   - Move of_map_iommu_id()/of_map_msi_id() from include/linux/of.h to
>     drivers/of/base.c as out-of-line helpers per feedback from Marc Zyngier
>     and Rob Herring.
>   - Add kernel-doc to document both helpers for discoverability and
>     usage clarity.
>   - Fix of_map_msi_id() wrapper and all its callers (cdx_msi.c,
>     irq-gic-its-msi-parent.c, drivers/of/irq.c) to correctly use the new
>     struct of_phandle_args-based API with proper of_node_put() handling
>     as per feeback from Dmitry.
>   Link to v9:
>   https://lore.kernel.org/r/20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com
> 
> V9:
>   - Updated TO/CC list based on feedback to include all relevant
>     maintainers.
>   - No functional changes to the patches themselves.
> 
>   Link to V8:
>   https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V8:
>   - Removed mentions of of_map_args from commit message to match code.
> 
>   Link to V7:
>   https://lore.kernel.org/all/20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V7:
>   - Removed of_map_id_args structure and replaced it with
>     of_phandle_args as suggested by Dmitry.
> 
>   Link to V6:
>   https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V6:
>   - Fixed build error reported by kernel test bot.
> 
>   Link to V5:
>   https://lore.kernel.org/all/20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V5:
>   - Fixed Build Warnings.
>   - Raised PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184
> 
>   Link to V4:
>   https://lore.kernel.org/all/20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V4:
>   - Added Reviewed-by tag.
>   - Resolved warnings reported by kernel test bot, minor code
>     reorganization.
> 
>   Link to V3:
>   https://lore.kernel.org/all/20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V3:
>   - Added Reviewed-by tag.
>   - Updated of_map_id_args struct as a wrapper to of_phandle_args and
>     added comment description as suggested by Rob Herring.
> 
>   Link to V2:
>   https://lore.kernel.org/all/20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V2:
>   - Incorporated the patches from Robin that does the clean implementation.
>   - Dropped the patches the were adding multi-map support from this series
>     as suggested.
> 
> V1:
>  https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/
> 
> RFC:
>  https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r
> 
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
> 
> ---
> Charan Teja Kalla (1):
>       of: Factor arguments passed to of_map_id() into a struct
> 
> Robin Murphy (2):
>       of: Add convenience wrappers for of_map_id()
>       of: Respect #{iommu,msi}-cells in maps
> 
>  drivers/cdx/cdx_msi.c                    |   8 +-
>  drivers/iommu/of_iommu.c                 |   6 +-
>  drivers/irqchip/irq-gic-its-msi-parent.c |  11 +-
>  drivers/of/base.c                        | 213 ++++++++++++++++++++++++-------
>  drivers/of/irq.c                         |  11 +-
>  drivers/pci/controller/dwc/pci-imx6.c    |  18 ++-
>  drivers/pci/controller/pcie-apple.c      |   6 +-
>  drivers/xen/grant-dma-ops.c              |   5 +-
>  include/linux/of.h                       |  30 ++++-
>  9 files changed, 237 insertions(+), 71 deletions(-)
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260301-parse_iommu_cells-1c33768aebba
> 
> Best regards,

Hi Robin,

Could this series be pulled into an immutable branch/tag, if it doesn't
make it into the v7.1 merge window ? There are client changes dependent on it,
So it would help to get them moving forward rather than waiting another cycle.

Thanks,
Vijay
