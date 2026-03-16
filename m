Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF323E5EFC
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687008; cv=none; b=XAn9AkzVGdR9acx0UDZuKE94Gr2/8ix1VbhCXIcWxiDASziL5BviPvTmwysZUk49aHwJzj0MgeffTVu6AXxww/BMpv17VHWOcZHORAVQb8aAx7GKUBAGOs/zDmDxmJAspR7tkJv+TPdt3wNsW5N9seUWL35B6oR0BVGdd9p/JyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687008; c=relaxed/simple;
	bh=ORllslclmOecdR8jjJRilEN0RM9ZfL3iRuzznWlzXDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjTCFxiirT6RS+dkuq0TBElUG+YD+VrzUDb/ckRSeaTKfckoABJUQrRpI/KHDEpC2FSt8cyCwNjdAERnm1bt7XU/Cmtg2cmCkYBx4yLAMxUtWkbyKk/qyODXsdfXs5MmcWxkCc7Dknqh64rnE5SissuSebRgaIZF4FouRKokGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeiJiSl5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CtGi80yC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeiJiSl5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CtGi80yC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GECUUx1639416
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 18:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hl0a6sUmp0DkvLU0LqWwqkjbWyZqCa4rM7hGljELxLU=; b=YeiJiSl5ylcjuBqo
	JLCCCjdfyaY0P7hSHeH9IsIXsowGuZ7DxN4Hw0YYDQAfI5pKIsvUrizF79RnYmA3
	xKqITLewGKcEa6O7/m5ptwZevfgf5vi8dU9mxQKcf4xE3fwUee4s2YVwZC2t5PRp
	X9EbLF0gW0P6ZfJBdslzoZzfh/1VmhUfqNekM1VO9F991759geoCm/DY9HC+GJ39
	bFGi3McuYPJ2rYewW580PglNRMztWqV9a604wjvJ/ixY7SW7Y7QXt1PfTdi0L9zY
	NyLtR0ACN+inYv6Z3RgaP7jAmTbrFwvlZ2bxwI8fMoHknW5edwWeONwWeFmMJPSY
	KTKvVQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxke092yn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 18:50:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd81506677so3147263285a.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773687004; x=1774291804; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hl0a6sUmp0DkvLU0LqWwqkjbWyZqCa4rM7hGljELxLU=;
        b=CtGi80yCc/Y+FaFVeHNcB+QLx7E6ZigoMT/oosG3/6odiP75d5raDkwzVXIB5Y/QSl
         IrukxEZF+BZxrWepu2mpi1btuFBHvE80MTllFs7wROcuBzjqQnx4ygpm3UW7Ju1XAWmM
         uQBusNuKI5LJNTWOfusGxLTfVezV/RSwBfPltJpnSTLO9syNKavfA6ghpZ+2IPfJjsUp
         utw0lCJOhAKnQ8UskCkDRFfhjpBTByQn3YNXLcjv5O04EgUoJ4h2Ps0MsdoWJpe8ZC4g
         a4WPU/bEON2PXwk9B48GrhFVg7ZKm6tbwbrKvGmbr9RQnnoMeLXCc+YFmTM8tGolshcg
         M1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773687004; x=1774291804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hl0a6sUmp0DkvLU0LqWwqkjbWyZqCa4rM7hGljELxLU=;
        b=ZMb5NYX9uo76pVJaLYlsvgQ47/GyRIW7FMpqwaaA1sl109lqahyGvVteU1Q6PeJbJ6
         TgEF0k/hE+4sEmqppjJCzkUfZKAdx5xTXoEihtnwCAL8TGwPPcVsZ0cVpFzxkT6lGWHh
         OmRgitvXitdSHi0iDmDU6DPwbXbBJP29QRJQsquLo5ojXKv+QX4Qdr5I96wONG3LFP/B
         xSiSS1fM9gQIaF++rJ2DmVjb3X2kJZN2uHUm82/iOYnKxXCgfwj8xLo18JGTi6i8Pa9H
         G+Z7Vz4e2OslCPq1MBRNKdb4s9vl2fMEHEFM6bADnhGDEyL6NSv7o3uFIHffv8pXL6EC
         pXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR2tS/q0rw0tderO72hl/NT3kE7WrpzVKUiKZ9hTUFUhPW9TdEovs/qQaxmIqVKvCOxqBGCXbFq+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YykayGWk8WAQSa7lN6iZ98Qd8fTsRaoP2M6dSOJdjZX4M/xYYKz
	2TDvQBCBLSFeL0IMlkkbsTCCrPqkN81TUmdsiUxZZoZbvIOMdXTmFBj6oZRwOAMn/QBgTC4tC22
	bd28qV7TB7QPzNX/Zv90KOYvPVoCjduEldj8EcXhHl5saXGobEh5rydfVSM6AFQ0=
X-Gm-Gg: ATEYQzycXdL+jkrnXCeJHFzpchQRPXSuIHe0byQf93GPRqKILpRjDwKOGDPxtdsnoJl
	ibFqgTSKP4i4rWgT0PC1yy7BrxP8MxpN3FBvIt4ZFCzG8Z17UV3lDBm1SfUIs2YYpQK++x1aZCA
	jJ5IeHwYXhsQCE3AdM2+i8k6wqvu9er3EpE19Zy9bpFtl+VJ62l1RcE7PvjVX4K8a32scwPYu/2
	DDNMRoK8q2ViDTWSrJSkTa/rcYmBMwSTwzWdpkQ/50vSXruEJR97NOUKiablRl4Ae68+JpZxvTo
	bhc7+mgSV0Z2zIQDhXrVAh+ztnpP8UA9yFbeJ71OyWI542/jdMoOJ5LpR8+Kf0NkYhVcTJPw/yO
	u68uI4aXewsgNhhssXLuT3LiJG/EEnxBR9fOobi7XHmYb7P2eAb8NCiFzT07wP2eKr9quEnXxea
	sXAiocaRneiJ6nOGAaxbjtHkGco8YXvrTP9xE=
X-Received: by 2002:a05:620a:711a:b0:8cb:62c3:3690 with SMTP id af79cd13be357-8cdb5a4fac5mr1890959885a.13.1773687003777;
        Mon, 16 Mar 2026 11:50:03 -0700 (PDT)
X-Received: by 2002:a05:620a:711a:b0:8cb:62c3:3690 with SMTP id af79cd13be357-8cdb5a4fac5mr1890952785a.13.1773687003057;
        Mon, 16 Mar 2026 11:50:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ec94sm32925111fa.22.2026.03.16.11.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 11:50:01 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:49:59 +0200
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
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH v10 2/3] of: factor arguments passed to of_map_id() into
 a struct
Message-ID: <scvvpx72isnlqm4f4eub7syezmhtw5xd3agj34lonhcc5s5zj5@nsbfsbgidnw4>
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-2-c62fcaa5a1d8@oss.qualcomm.com>
 <esfzpgpgenydif2sxahsetkglz6kewsgjhkmzr6ulrrkctnkbq@a4zsfdmhbxui>
 <27edd195-b0d3-4214-9df3-74a84da1e3e1@oss.qualcomm.com>
 <dyjdwxaq4oc7ahri3iuhnmobh3gwmn6drhox7t2elep4rlqhuq@fe4gp5t7q5r5>
 <dbfcbc9c-2175-49a3-aee4-434b69cbaece@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbfcbc9c-2175-49a3-aee4-434b69cbaece@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 38ttyUv7buCH564K0LglMquq6gGPhlPf
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=69b850dc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=VXU4VRlCQCtIJetfhaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MCBTYWx0ZWRfXwF37k/b2i178
 2mjbf0fNy10W/aTmcDDwXMVtYWKcxTuo43KjY06c9vHn5rOsAqKoAIlQRlk+ydDqkzJQb+ywB2W
 +Udxfn/CGC3/SugvmK+Wv6lHsHA7oqBXZvYsixRXHCIQMbtYY3fb00+2BeIhQfdLIO+3M3XrVUb
 7YMLpA3/c4hKIKeCz0mOi3PYlV+hS/y0+MvTsYu6LK/XzBDE6GnphU6Y7bwAsX77U6wdwX80wyd
 0mUe8xn2Hwa5HNxeub8HVXd8zDwHE+7G3LGmpt0jctaf6JvpRSH73TUbwdBGjAqdbiqUsS37tdk
 hWZSz0MiSQMvEnDQ/mLvJdK+doyzEjxOiwxArCQ/3LYc8HYm7j+eUC5Rw19OlpLNmudYizyqPFG
 9ToNBgfpNF6OGwqe3+mzicvwWPOBh5cRug2qQuT3qiEtshm5FooQyyqFqI+V7UEG46TbnsOV0fK
 2y6TR+ka8KzM292TocA==
X-Proofpoint-GUID: 38ttyUv7buCH564K0LglMquq6gGPhlPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160150

On Mon, Mar 16, 2026 at 10:37:25PM +0530, Vijayanand Jitta wrote:
> 
> 
> On 3/12/2026 7:48 PM, Dmitry Baryshkov wrote:
> > On Thu, Mar 12, 2026 at 05:12:51PM +0530, Vijayanand Jitta wrote:
> >>
> >>
> >> On 3/10/2026 2:53 AM, Dmitry Baryshkov wrote:
> >>> On Mon, Mar 09, 2026 at 01:03:38AM +0530, Vijayanand Jitta wrote:
> >>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >>>>
> >>>> Change of_map_id() to take a pointer to struct of_phandle_args
> >>>> instead of passing target device node and translated IDs separately.
> >>>> Update all callers accordingly.
> >>>>
> >>>> Subsequent patch will make use of the args_count field in
> >>>> struct of_phandle_args.
> >>>>
> >>>> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> >>>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >>>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> >>>> ---
> >>>>  drivers/cdx/cdx_msi.c                    |  5 ++-
> >>>>  drivers/iommu/of_iommu.c                 |  2 +-
> >>>>  drivers/irqchip/irq-gic-its-msi-parent.c | 11 ++++--
> >>>>  drivers/of/base.c                        | 63 ++++++++++++++++----------------
> >>>>  drivers/of/irq.c                         |  8 +++-
> >>>>  drivers/pci/controller/dwc/pci-imx6.c    | 16 ++++++--
> >>>>  drivers/pci/controller/pcie-apple.c      |  5 ++-
> >>>>  drivers/xen/grant-dma-ops.c              |  4 +-
> >>>>  include/linux/of.h                       | 12 +++---
> >>>>  9 files changed, 76 insertions(+), 50 deletions(-)
> >>>>
> >>>> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
> >>>> index 63b3544ec997..03232b5ffbca 100644
> >>>> --- a/drivers/cdx/cdx_msi.c
> >>>> +++ b/drivers/cdx/cdx_msi.c
> >>>> @@ -121,6 +121,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
> >>>>  			   struct device *dev,
> >>>>  			   int nvec, msi_alloc_info_t *info)
> >>>>  {
> >>>> +	struct of_phandle_args msi_spec = { .np = NULL };
> >>>
> >>> Why do you need to set it? Parse functions ignore passed args, don't
> >>> they?
> >>>
> >>
> >> The parse function does check arg->np on input — if it is non-NULL,
> >> it is used to match only entries targeting that specific node.
> >>
> >> Also, there is this existing path in drivers/pci/msi/irqdomain.c which
> >> pre-sets the node and passes it as input to of_msi_xlate(), so the node
> >> pointer is not ignored by the parse code:
> > 
> > Is it only being used for MSIs? If so, can we make that explicit in the
> > API by having the 'filter' device_node pointer?
> > 
> 
> Yes, I see this is used only in the MSI path via of_msi_xlate(). 
> 
> By filter do you mean the below changes ? here of_map_id() and of_map_msi_id() would accept the filter
> as a separate parameter so that arg becomes a pure output:
> 
> 
> int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>               const char *cells_name, const char *map_mask_name,
>               const struct device_node *filter_np, struct of_phandle_args *arg);
> 
> int of_map_msi_id(const struct device_node *np, u32 id,
>                   const struct device_node *filter_np, struct of_phandle_args *arg);
> 
> of_msi_xlate() would then pass *msi_np as filter_np down to of_map_msi_id
> and IOMMU callers would pass NULL to of_map_id. 
> 
> Does this look fine ? I can include this in v11.

As this changes the params, you will also need to change the semantics,
removing the of_node_put() from the function and making the caller
release the reference (as it should be).

-- 
With best wishes
Dmitry
