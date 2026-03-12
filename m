Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089E3947A2
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315722; cv=none; b=mQK5lr+Ve8T/zsqog9I9xjxUns+6MIJZqtpdw78tag18KfotEmHZIyy4Yedrfd7Ji/ThgjH96Y2cnzKJ7ubtzZ93ztBZgQ8jTKXEysNR5oZv+H5E3pJUiaxV/nlEHgAYakXDmaLH6rAK7hudj7epawy3Zk9QlhPAQpWhHpmfYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315722; c=relaxed/simple;
	bh=nwaZTsNWKtiAy3M+myiu//8Q2UY2tqa7VUs/W+GtYLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS0zvX7twAWPI0PxLhzQSgAOFY9L98n0+7+zCEppBI+8SxOO7sf0QDRlRgjtHGhr/Y+tmufl10eiBw54IqI+TsxBSoJavBaaI8CaAibFCecat4qC3BEqL6hlUTVFDsIXkCXakSTPvw/+JWTaSDaTl6Mm6K94naixItA4/r8LK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTWDR23r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ryzj9rwH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTWDR23r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ryzj9rwH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C9NW0u3136568
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O6HJTG517rx7BZNC+Lqbxk38jHNOTKDXfitY+fGl2Qg=; b=cTWDR23rSNC6RXYv
	NYm5xAfJP6JIuBegbdJxesqHYjbPVMpbyoaplrYspybiURpA1Trs2IBBicGX/68c
	/5p+bLJWsmwM5nkoINvohPNjkwnCV2Td1WLJKuiQev/oeNlwdMwm/GB45fgFyHxJ
	HBiAKD73NnOBoytDQFweyjSwkRPfJWCUyj7pEosaMeJDL4V+7DNFEgrEfn/EASZJ
	6+Gx97SZIgZENJcFW2XKZ7T0QIf+zW3nzwfP8DgMViWz3ZckUTqhX36WvwMOPypt
	LWOJsODEoFAaVja57lITwPwa+tEi6nJkKgY1F91wyXAO/nJARSgaUFBOp4o2h3W9
	cdmcuA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4w9y34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae57228f64so10247825ad.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773315720; x=1773920520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6HJTG517rx7BZNC+Lqbxk38jHNOTKDXfitY+fGl2Qg=;
        b=Ryzj9rwHx4/L9W/95j18RQLyN36VmXh7hrBX885U/DVRYKg0KS2q5yHnfGUrJn9Y/m
         25qed/Xs5eXNZgFtV807uvntAaJeEh7eOJNyDn782Fq+UmKAbX54+ZRzwOy9XpbwIWe+
         CKwY6712Y626UQUtjjX4BXYdqRWX1LJCWl7YwcBglN1gyM2HDIIWFlIIwgEnxfzA1Snv
         Tfb6WUfKsiqmADqiEDDF6Q74SbX9EMyABBwcxNzIJjaDMCs1QWCungJZvNIdtiCZ0KIa
         bpYr9QoQ9obNvyXVvaDxjG7Cn27m2UYUo36FXp3FVxiuhqQam3e/vZypo9FgENHuTWbX
         efWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315720; x=1773920520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6HJTG517rx7BZNC+Lqbxk38jHNOTKDXfitY+fGl2Qg=;
        b=SjvNIM6ouSVWvBS54iH1ZEinmOwIMl3ZlamjnLYZuyhr9O0fJpRoC57qk3plN+NG25
         5nZvEDEr7VYd28QzsSWlQRVqCRGnJuCC/9iPkWqBDvmhNfgB7XQW8xdtNsPdqOGO5gdc
         o86odfoqz3leTUIBZevWw4UnI8b2ANBvomOciqhRxf5oVkv4VGsqkpTILFiFlwH692OF
         hz8HoGdegUHuaXS1zV4LEN0PAN81fHsd5DmO2tCoCpzgWWJlju/TKJIXh1qh8NpFPbqW
         Bi3AsuVL67YIT3dDna8wI7cvMlMFilZDKFAoKD5tdB+y/kibWSW0ZvxwQ6to1YH16E4R
         izpA==
X-Forwarded-Encrypted: i=1; AJvYcCWYkCqfwin3lG9dXIvAFZ+Xa/TBF0bjcLRT7bWgRTpru5VXLzCFBWcOqHkLJjlSDfUGYr3Rl/CGUho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Q9loT/iaIiXepaCo90cnSWrXjfwCNg16BRtyZOhPRKE+/SwC
	dPcAba/2hIpaPd5AY5t39k9HQGQUfRZ7AbXw1qD1Nqc03ZAjtsVrR7JAj/xWptZJ/LQQb029Veq
	13xp7QBe32KyrYC5rxDScPkXbBAiTv0z0PYsAnoIvLdK6WP3qKQ3uxowgebX518w=
X-Gm-Gg: ATEYQzz25wveJMDcpDC4r87eR5d01zm9A0ilX1Q+370+5LnroA2nMGwnW9eJGXqCRgg
	NRqiLmInkAZ5l/U5ELbtzlVvp2HQVD6B9qVh08SuummsyTJEMNmsNvaVLlkWxcjj01VVB4SMusI
	piHXiLRjEZhGH0IoBPJ+4VBtiiWTzKO8MUI8W+xoFO3tKQl9OoTG2rHGX1QLLFx8utSTZT3IOYt
	JFbOh/0oFtbXFZi6bwEbP5cVePUwOE6fsx/i2vC2QiWpk5O3Ts+1RCPv3OsL9CAOba+R0kOz4YJ
	vXPK7QxZXwLtZRkpR2QO6k+CItUlzi9tO3Y46NLZ0ajDG+BaamNx3zVb+a8Av5VnzrnsFdXuxJP
	ErqZb0WqC83awtSx/SfSZBLoPVW1O4sj01Y8xUqW2qwVSzaOOOZnkuRUjDg==
X-Received: by 2002:a17:902:e807:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2aeae89119emr62683485ad.29.1773315719575;
        Thu, 12 Mar 2026 04:41:59 -0700 (PDT)
X-Received: by 2002:a17:902:e807:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2aeae89119emr62683115ad.29.1773315719067;
        Thu, 12 Mar 2026 04:41:59 -0700 (PDT)
Received: from [192.168.1.10] ([38.254.186.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae22217dsm53886225ad.4.2026.03.12.04.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 04:41:58 -0700 (PDT)
Message-ID: <57537059-4989-4704-ae6a-72576d031216@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 17:10:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] of: Add convenience wrappers for of_map_id()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
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
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-1-c62fcaa5a1d8@oss.qualcomm.com>
 <3plcdobbd6teiluzijzk33yepbpsur24tnmjr32sco7a4loptm@xmzmsaurvmvj>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <3plcdobbd6teiluzijzk33yepbpsur24tnmjr32sco7a4loptm@xmzmsaurvmvj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z43A3z7-DwK1uJ9rYksZC4gimmH4mBWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5MiBTYWx0ZWRfX8LDGT7gYOh5a
 5EekVJOylITykZoUYPc8bHZx7gBIVadYsd7lbZ1ERwCuSVomwwdGwInP2aF23aN0UFNSWny2bSx
 FZqcXHJPNUCHxww7S0n3wjGulcQcZw3athv7IZgp4RHPbUtOklgu5T8zqsbr40JYNqRFZljDwBi
 r5m+WK0m12o3Dnjk1KeAPTv83zRkqlbX6s2dUUAEJ1WUkNMGj3ms8PN/zLNR+/1lgeaR0XpLFOh
 6KVszdpGOOG0fZRJaQ2TS6ZQzFIoTW9ajd/czBOJF2gxL+zjf7rw9D1DhKeiM/u4T9Kk7s2DYGx
 xIg4Ov86ZNHkc2GAxDm5+i5uSoHFNZOonAdqH+/kC2GrpAelZIEwnXjOazW7o23dMVPPPK8d4H5
 R6JjAgUpiOnp1kdBvhSZOekADspCGgkokMI0eMS/tlAwLaEa9+uDnqB61VORIPFBt0dJG1XlOyX
 YmwvZPKVB/RDkbAVbOg==
X-Authority-Analysis: v=2.4 cv=YucChoYX c=1 sm=1 tr=0 ts=69b2a688 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=FuYIH7Xx0xzBSkYrynBYgw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=6wy38kV5EeFARYyu09AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: Z43A3z7-DwK1uJ9rYksZC4gimmH4mBWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120092



On 3/10/2026 2:46 AM, Dmitry Baryshkov wrote:
> On Mon, Mar 09, 2026 at 01:03:37AM +0530, Vijayanand Jitta wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Since we now have quite a few users parsing "iommu-map" and "msi-map"
>> properties, give them some wrappers to conveniently encapsulate the
>> appropriate sets of property names. This will also make it easier to
>> then change of_map_id() to correctly account for specifier cells.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>  drivers/cdx/cdx_msi.c                    |  3 +--
>>  drivers/iommu/of_iommu.c                 |  4 +---
>>  drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
>>  drivers/of/base.c                        | 36 ++++++++++++++++++++++++++++++++
>>  drivers/of/irq.c                         |  3 +--
>>  drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
>>  drivers/pci/controller/pcie-apple.c      |  3 +--
>>  drivers/xen/grant-dma-ops.c              |  3 +--
>>  include/linux/of.h                       | 18 ++++++++++++++++
>>  9 files changed, 62 insertions(+), 16 deletions(-)
>>
>> +
>> +/**
>> + * of_map_msi_id - Translate an ID using "msi-map" bindings.
> 
> Which ID are we talking about wrt. MSI interrupts?
> 

id refers to the device’s requester ID (RID/BDF or platform stream ID),
not an MSI interrupt number; it is the key used in msi-map to obtain
the translated MSI device ID (id_out).

I'll update the kernel doc as below to clarify.


* @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
*      stream/device ID) used as the lookup key in the msi-map table.

Thanks,
Vijay

>> + * @np: root complex device node.
>> + * @id: device ID to map.
>> + * @target: optional pointer to a target device node.
>> + * @id_out: optional pointer to receive the translated ID.
>> + *
>> + * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
>> + *
>> + * Return: 0 on success or a standard error code on failure.
>> + */
>> +int of_map_msi_id(const struct device_node *np, u32 id,
>> +		  struct device_node **target, u32 *id_out)
>> +{
>> +	return of_map_id(np, id, "msi-map", "msi-map-mask", target, id_out);
>> +}
>> +EXPORT_SYMBOL_GPL(of_map_msi_id);
> 

