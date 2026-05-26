Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D83D75B6
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788771; cv=none; b=jKGNypPux+wQfRCr/veHsm0LcIrF3Uv1Qo/0RoA7xQpgLIKbO1/ZvFC62ZgpWyNrf01Vohwy/J61UP6+RqlELa2div5Eo+p9Cbs/5E3bWTBUM+bMnudOHWuniQxezFur0JzStZ3WLEqjEZdxkLf24I2kBB1Ae0I3fkDdVy/uZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788771; c=relaxed/simple;
	bh=ZCAvrcBAJIXTnHEvSKz8Yq0JKkscj5TsSoJRyS3heaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMtDVNmtVCxmCMofd4UVgZS+Of4xZizRHoqNETOz4BGgaTEoqwN9vZTDMqVUweGD0VxfOJuGKD7JjIhoN0SZf0Qy/HivgwXY5FdjJJ4AIabeAFbhEZI5ov0SDZuLnNBfwKXiJXyECJ+0zR/Zff5eG+yeHOZhB3yO3PrNsvp7WxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fr1+vbDE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VnBuMI1T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fr1+vbDE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VnBuMI1T"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q632YZ2146247
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 09:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+tNWCjXxY3vDlbxeyc6dAiioLTzJiUtHmEfK77uv8QU=; b=fr1+vbDENVQY5Zkc
	AWKEyhljX0yFvxH6I1SvWUMTfp19xN/S0yh+TGoyD9Cl2mMP1B+cxYr4CMbB+3HK
	i6mgb6GJt0ChQnVW/edYstQ2ZQ/3qEyz7787O7HhTjAw4XPZE3hs5gii8npI7Amv
	SV4YTLdzF9yQsyRYbZhe8MXQpEJ8I1OBPDETlM0oT+VsBZIO/86gjRfEn9vRxRhD
	fa7RK+Fn5PB0Yls+1QT2cAgdVoCp2+ET9/qfV+TNX1+bxgF2y68cg7pgqK+nzx0o
	z9PP/dkyTpf4v2k4Ml/cIFZEvKeM5ltrMipw4x5NALhFjWWhKMw9d8b7GJjlf880
	lK0fmQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv428c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 09:46:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba268cb5e6so109787155ad.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779788768; x=1780393568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tNWCjXxY3vDlbxeyc6dAiioLTzJiUtHmEfK77uv8QU=;
        b=VnBuMI1TbZBKQ34ChVJFTVJ581pMrscHMt/ZxDDDtXbNvdk+5dbGI6vVcHo/krt1Lr
         l6Xo9bnGE5zvJWHOAzMEaUM9fyCGrQaeJxeV70X8y0LsjEDY36lhXnI14EEHu7QBIKkD
         ypPdArXCTba+KbIIamJ+5M9so4EI3mjhzWntGGE/F5lfszIRuRabmBe4W9NDLgtJV+mf
         ICHUASGVX9Bb2pYSNhlR223M1LOrjsOnTyeO7IvRliTW0KquZqj/tq5LD7k4Lg37MyFa
         /SUTerOC80RbmOqA+v1gVaDTWKic2CHqwCqoaRGReMDpb7qaiq9Nda79xIByORjrPOYJ
         hzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788768; x=1780393568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tNWCjXxY3vDlbxeyc6dAiioLTzJiUtHmEfK77uv8QU=;
        b=Mpvzhl+yBHtkKTdvgK8yaAOriaae5qrpJp3dtqH3ur56OsA7gv6z3h4ewaUlkRiz+6
         3ppD73KVkSQfUoaNPwMNJgYFuBmTpE81vrhkDl3MX+ub5Fg0pmfG868l5sRhJZFfR7Ok
         /LH9yBzY0pLCLygaQS/Ir8XfTJRzQwX4/AqFfUykr7vbUd+sUyS/oMlU7yMo29lX20Ce
         dUqix8jl63UtopFEgz4c50cG1p6yrH0zLTD28OcAeSZ3jyvYrLdrm4+Zs7+6CphGRQSk
         fA0OeM5g7x7X5ImuLSGuKlvcLn+c0sUSRD0/ihZ+Jba+TUO3VxsW5UTHW9VII6Qdciou
         nh3g==
X-Forwarded-Encrypted: i=1; AFNElJ9dv9AHiCyLkyULvrb021yM2Mmh+YFBxCi/FoId59Iw+BwrM3fiRltUphsiKzdWzsetQv9sAxjG1mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mBZ87+Y1691f1o+fFCXDPlQpjms8hz8xjzN9+wI01f/Lv0k/
	U3ejsGkgXOmRfZa9pgdtViZ6Zu48eeMs5ydVhHW1vSmlYmXrBGvoVIn767XhgDGmw3ZqMAC4HaW
	+MQgoCPL75ffJpmzXNJmEsAdM4LUdvJ1BW3GFGqKAHZueDVSEpqcdrarCz2nKo98=
X-Gm-Gg: Acq92OEFAMToJng+2Iub6oCM/Lj3el653H0cxzk8QsKHtCy1z+rU9uFwrXN/lPEnzSO
	tcjTD9hJNtc9uSuJqKazq7aPPytiNDKAOPezSA9ckkdMxpXGD4YD4sp3HNIOqgyMrKjkUX3IZDb
	cqlkX/giqk2TIDkZh3E/oRyp/HwCcruMVMi8q2rMBQ3AWuLdXzEm7oRf0xJLFAlx8UzLOX+0WD8
	zQ7ydFTda4N742ycSeDUC0vmJsfkR4cUtGmYbwXBmZxdFirRhF97UbGxNwSoGPHchT/OD0fe56h
	zXSNloMjRHzwCDd3OlE5RcuUOd7RDkdZxis/e/hpkvQTFK9Kk1mrTj/9n91coiwed/APnt7Z1jq
	jdjnZbE0oJUBOL6hPRjIbtXqmqQHHf1nJOrDdu31DqLLViwV6mqwB1Tkm
X-Received: by 2002:a17:903:41c2:b0:2ba:e42a:231e with SMTP id d9443c01a7336-2beb064837dmr200645615ad.37.1779788768358;
        Tue, 26 May 2026 02:46:08 -0700 (PDT)
X-Received: by 2002:a17:903:41c2:b0:2ba:e42a:231e with SMTP id d9443c01a7336-2beb064837dmr200645035ad.37.1779788767805;
        Tue, 26 May 2026 02:46:07 -0700 (PDT)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ebcsm121223885ad.49.2026.05.26.02.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 02:46:07 -0700 (PDT)
Message-ID: <f2eb5c9d-a78b-401c-8796-f7ef7a8d7386@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:15:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/3] of: parsing of multi #{iommu,msi}-cells in maps
To: Krzysztof Kozlowski <krzk@kernel.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
References: <20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com>
 <20260526-finicky-crafty-hare-eae27c@quoll>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260526-finicky-crafty-hare-eae27c@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA4NCBTYWx0ZWRfX0t/HpOUieNEF
 ho0dhusStI0SvXVnk31UuGF/SgtJfIv01bh1hx6JtE80O57hQZjpoNbgukngzn1Hm8b2OnJHWAc
 j6IT96GhQJoKTD2gLqrt1or5ykppINLBcinJaiSA/UI8FKKrdQPB0jLqpAourdwc4DRZZ1WTx8h
 BRlzIcL67dFLE0gl8XOqd024EHH4Qb/a2DbGGjp0e/kx5Y5cUQeSMXwV3Xh2g2T2g6i/RN/L9Wm
 w2OGI5PxZvl69ACciMncWS9nN6JT46toeVusfmpgZmZvS4mEY6r8YptM/NvVZwoXgIVq7vGZuN/
 vtFDMAEv51jjJR9/2RqGPCMZH7MGlnMogE4orQAFN4xwfV22zPkr3o0XTTPxT5qk7vbd4wmAv8A
 E8XvqrEk0rUD5SmfVs7O8D4K4ccNZ2cx8Yqk638PruWQaqmRs8b3BiuOSXJIArTy8sTGzZnZqvV
 sG5LnVu2CBF1wMjWLQQ==
X-Proofpoint-GUID: wokfF_BiHxmUlJDCOTHiDD_dxTlDtqny
X-Proofpoint-ORIG-GUID: wokfF_BiHxmUlJDCOTHiDD_dxTlDtqny
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a156be1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Jo8nEopC4ZUABtMbiE8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260084



On 5/26/2026 11:42 AM, Krzysztof Kozlowski wrote:
> On Wed, May 20, 2026 at 01:32:39PM +0530, Vijayanand Jitta wrote:
>> So far our parsing of {iommu,msi}-map properties has always blindly
>> assumed that the output specifiers will always have exactly 1 cell.
>> This typically does happen to be the case, but is not actually enforced
>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>> cells) - as a result we've now ended up with dodgy DTs out in the field
>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>> provider, despite that being bogus per the bindings themselves.
>>
>> Since there is some potential use[1] in being able to map at least
>> single input IDs to multi-cell output specifiers (and properly support
>> 0-cell outputs as well), add support for properly parsing and using the
>> target nodes' #cells values, albeit with the unfortunate complication of
>> still having to work around expectations of the old behaviour too.
>> 							-- Robin.
>>
>> Unlike single #{}-cell, it is complex to establish a linear relation
>> between input 'id' and output specifier for multi-cell properties, thus
>> it is always expected that len never going to be > 1.
>>
>> These changes have been tested on QEMU for the arm64 architecture.
> 
> So there is no real user for that. That's unconvincing. I would assume
> that at least you have real user where you test it.
> 
> If you want to speed up acceptance of your patches, then also I would
> prefer to see at least one more user, beside Qualcomm. IOW, show how you
> solve other people problems, not only yours.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

Thank you for the feedback.

The upstream user for the multi-cell iommu-map support is the Lemans
platform's VPU device, which requires iommu-map entries targeting a
2-cell IOMMU node. We are currently working on the glymur series [1]
and once that is finalized we will post the Lemans patches as well.

That said, I think this series can go through independently for the
following reasons:

1. Correctness fix: The iommu-map/msi-map bindings have always
   specified that the output cell count is determined by
   #iommu-cells/#msi-cells on the target node. The kernel has been
   silently ignoring this and assuming 1 cell. This patch makes the
   kernel respect the binding specification.

2. Backward compatibility preserved: The of_check_bad_map() workaround
   handles existing deployed DTs that target 2-cell IOMMU nodes with
   1-cell entries. This series has been tested on the glymur platform
   [1], which uses iommu-map with 1-cell specifiers, and the existing
   parsing continues to work correctly.

Thanks,
Vijay

[1] https://lore.kernel.org/all/20260515-glymur-v6-5-f6a99cb43a24@oss.qualcomm.com/
