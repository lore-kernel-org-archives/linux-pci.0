Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E333F5A0
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091015; cv=none; b=cjg2JbNF15rMbnj7KBf6eTi5PssRXv4QUpGhTJUD1KFbgTGwjcCHNjnCrOeLCabeG3YhkJSXjZkjW8JG6rxHTH7P/A3ok9068zTvbyHeH6dpWZ2whpR1nqY1veAjnIXQC9voghibskK9OoM4gM7blBe3WzcEwvs+pun4ECfva8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091015; c=relaxed/simple;
	bh=9Vi9h/QCYvk5FMh7uKEmgwQ6HQwUbzQlnoVmcbt27Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa7y20fhbWrc6ZHjvhx2msIR6C2w3OBDrK5sYNwQl4jVnVWU8yRYyxnD22RBQitW03VEJoIjsmW0z0HIPmIahnhHcTLPlkiZRMJAwOVSQYt42zcz3sReTk3Jze0BSJ3yN9Yc+LEta2r5KoZ1eg1gXq8DgUkj5QKN4ukt4lXIB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eYrTi12b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YOQKmHPy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eYrTi12b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YOQKmHPy"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBnqS1920907
	for <linux-pci@vger.kernel.org>; Mon, 9 Mar 2026 21:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KLgWRaioXqeIrwHgYBcxPqE/
	kg4Fe+2f2o7A+PfgTZw=; b=eYrTi12bsFRg+Ep63Gvyrpkz6qz+XZZnxJnhHzZ8
	Afqkljn6AGFqwUNG6Hi9uCb6ZzQda58iRJHt3K5YZu6fE5lb/rlDs3LPJDnuIy9X
	R2Y9ER606cwX+ZHgCY8VFLE+xAxUWo2O4Thd+KKh+iYlFQhrYQ0g6GO+JQptJ4KE
	6f0gsKaivSPOXL1lrK/xqQc3elp326ygArdomugL7e78pyCIveo8V0I+Gp/yH752
	qn3L1fJOi+1y8gGG02UGdrOgFKCLS1JmoihvFsIZX4/Br1ShuSsjy4BmL2Iv75+1
	0Iz/BPpRhzYykPy9UUlKCrzFisiTC2PnI1DfQMHXc4YBKg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csxy81kya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Mar 2026 21:16:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-509219f94b0so53448881cf.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Mar 2026 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773091012; x=1773695812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLgWRaioXqeIrwHgYBcxPqE/kg4Fe+2f2o7A+PfgTZw=;
        b=YOQKmHPyNCEu7UMSTQMMsSM4NSdPdeebQCgvuwAdFDDwGJaOtqHee232pMsGUwaxG1
         W9EdcBAx8+znKW1brCb7JnLsAS9Fy2ibNNALZ8H31HqhKlT8yuzkAZRm/TDf2ApZMRmu
         M12RBRvtxftfMAH9pqQpfwn3pPI5NC2ZGbkni49AlY/4O2lu8NiTb1jcm6mWjYCVHzws
         4srZyWij4cUO03vwvMKUcaGe+z1q8rWeHzUeZx4MRwtkiCcDqLZHzah+IY79W6Vq6vNL
         8JP8/CqDX7hooMuR9HLy5seeZJsiECoCV+2c9tn/jBhtnIl+2nn404YHTSHHD1/zIa8H
         nG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091012; x=1773695812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLgWRaioXqeIrwHgYBcxPqE/kg4Fe+2f2o7A+PfgTZw=;
        b=daEW6aRX2595SmqTrA2+ltn2guLaXYGhhyP3WGAmiXWtj5K9Ce/eenlVkXILbOWCyC
         81x94erWScV97WPHgm1EwxGCeQ4+vbP0ZvQFTt+NuneqR12RNMO6NSFe/+1rhQBDIIpN
         cijeegneEJkVfn5V3j5gOHDsV6rk3hGJlbJAh01us2f8Ngt8s64NeFIEqQnwBxd6xd7g
         kG8JPpOZYFJwNpIV/1GOnJdZRjbmtGF5lig5B5fUoSjqz9MLhugL3nFmKn5q9oJ69VCl
         7PnBkcZq5owunzpVjptXDxrnY+nNXY/ALm0Sdt3MnohawXTVd/56T4M3ejMwetbdZENN
         vj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDLOmJgeVBIt8bb1G7Ucu7RMPbhJSxemFUlaYo9kwHZb0GcC4BRmJOUfRtYgpNW0Gcn/KxDJulP2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDLe8fdZzN4fhDt5E9pDuozZzcIaD3d9M8GDgAyLVsx99YbdrR
	/hNyMf5aAk2jQRjIf1uOsyIJ81+T9xNdj1wlwb6VlzLyC2cNudGZPDRfa5nXpkVNhUemDGeKBrK
	HNZg8iCOJgnVdfr/ctuwZ1auvKaDPG/pqcNDPWpAatzdjSOEqJ9RQIdKSIzKqm48=
X-Gm-Gg: ATEYQzygsWJeOREnQKUVt6VqfWiHjXkovZOSV44NqGYo49sRUBCCMNq2Hzw2kmhIgb1
	h5pCf+ERrce+v5Fdp/OM1Tm7/k6KLmdPyKrO8AvhIzuXjfQhxnCY5gpQyAGtaovOstqhPdW6X/w
	bGRQfllZc/gMG6dlrTJCI28uK5tmHs0CzCATt9N6u5dZpl7IV6rQm4Vn9eYA5O/7Wf8WLDOZsai
	pO0ekZPbgIcEyBOgD0GL0sloEi5UddsdZUeJ0PYI+wPuaJ5ZnXJHQwoI2ckA31mMU6iGPxd3jBc
	aN0c/MeZcIEhpqbavNtqvnDjNszhKi7WN3TY0DSWv9GE2Z1lcLsaWCY+++er9RPNyrshN1/s4WO
	MQNig9lOXBLpuzbLlhTQA65I3xL8xtprNt7XLs0w1fQZ/y1pyfNJ7+TO+TNytGSw9lg5b0ZaWJF
	9xSv8qqeybkBU35LacOp/zZOtdxZSVzzJAaQ4=
X-Received: by 2002:a05:620a:2946:b0:8cb:3d7a:c009 with SMTP id af79cd13be357-8cd6d4b5029mr1566977185a.78.1773091012394;
        Mon, 09 Mar 2026 14:16:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2946:b0:8cb:3d7a:c009 with SMTP id af79cd13be357-8cd6d4b5029mr1566971885a.78.1773091011890;
        Mon, 09 Mar 2026 14:16:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d01cbfasm2323612e87.14.2026.03.09.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:16:50 -0700 (PDT)
Date: Mon, 9 Mar 2026 23:16:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 1/3] of: Add convenience wrappers for of_map_id()
Message-ID: <3plcdobbd6teiluzijzk33yepbpsur24tnmjr32sco7a4loptm@xmzmsaurvmvj>
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-1-c62fcaa5a1d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-parse_iommu_cells-v10-1-c62fcaa5a1d8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SvmdKfO0 c=1 sm=1 tr=0 ts=69af38c5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=5ndfpk7zZlG9lj9R3R4A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: jKu21J0YEnBmCAbIMUrjxv_u9qV86J7C
X-Proofpoint-ORIG-GUID: jKu21J0YEnBmCAbIMUrjxv_u9qV86J7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4OCBTYWx0ZWRfXxrfi7KEKgrFI
 Bb+ls67u6xDupF0D0A/HaQTTPrVAOvEnv4NaWNOVVjXfCq4NUIENq3nF339xmANa9f9kTl6AGIc
 WO83VnJM7/yNpWKya6mmZCWmk7JvnOVR+/8ECK4h9S/o8lSmj+adINs5GCQjGk1MtDZQEq+Jnqi
 PgTXpDc9r0GrUEGyFKKdhfXPTT/B840oyV6Pn78WSNkGLSErgmksIGWKwh/TXrXq6w6bw1gvY30
 kABbqqElb3Ti62qbaePtHSY/S69LbrvwuiuPy4x1YzusbTrAX8rcCy1R3arOO1rnpWp8W6oFNvI
 I4I5zwk0Vrf38Oj6K5UUjMhCmtX3o4JhYJJoQrXRtdhvA9jRX2PzDGm3wkmeL4OcTkU0ILk7BHu
 NsW1qZGkk70q70QJTZYZGa2+US0RYSwxHHIyNnuV645Lyt9rZQZrkAuw97LsdJ32bwxKdtWlVJl
 71uFVgxB5lkpy51im9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090188

On Mon, Mar 09, 2026 at 01:03:37AM +0530, Vijayanand Jitta wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Since we now have quite a few users parsing "iommu-map" and "msi-map"
> properties, give them some wrappers to conveniently encapsulate the
> appropriate sets of property names. This will also make it easier to
> then change of_map_id() to correctly account for specifier cells.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/cdx/cdx_msi.c                    |  3 +--
>  drivers/iommu/of_iommu.c                 |  4 +---
>  drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
>  drivers/of/base.c                        | 36 ++++++++++++++++++++++++++++++++
>  drivers/of/irq.c                         |  3 +--
>  drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
>  drivers/pci/controller/pcie-apple.c      |  3 +--
>  drivers/xen/grant-dma-ops.c              |  3 +--
>  include/linux/of.h                       | 18 ++++++++++++++++
>  9 files changed, 62 insertions(+), 16 deletions(-)
> 
> +
> +/**
> + * of_map_msi_id - Translate an ID using "msi-map" bindings.

Which ID are we talking about wrt. MSI interrupts?

> + * @np: root complex device node.
> + * @id: device ID to map.
> + * @target: optional pointer to a target device node.
> + * @id_out: optional pointer to receive the translated ID.
> + *
> + * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
> + *
> + * Return: 0 on success or a standard error code on failure.
> + */
> +int of_map_msi_id(const struct device_node *np, u32 id,
> +		  struct device_node **target, u32 *id_out)
> +{
> +	return of_map_id(np, id, "msi-map", "msi-map-mask", target, id_out);
> +}
> +EXPORT_SYMBOL_GPL(of_map_msi_id);

-- 
With best wishes
Dmitry
