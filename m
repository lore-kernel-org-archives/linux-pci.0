Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4723A1699
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315791; cv=none; b=fZbORcxCQIrz37qaOF8a+XZEBFIdGntR//JgtVKoHU9F+O41FzWYPxIb/uLQKV+Iofd9ebiPQ055GV8KsL1arfyEi7TIjolYwn9Jox25VfcAfuoP8L6nT9CgZF5xpMy4hiSKAJZ9+3lu07ExLFU09mRozIlo3tWHbTCCZUke9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315791; c=relaxed/simple;
	bh=J5rItIOIM0lENJfGiWQDdbQDu2LdQwomu4iLQymPMio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1eLWGMz+6rHN60X7k3C3YY0WrLb2ybWRK4u4AjZvW8B+LwrlvYc1OoFF69hATAsvPgOeootm/IDSy5Zp34Vft5xDZum/T8CXqt3dr0VdFXppdlKA7qhP7T/zh+00fYe5m0RtLtRNfDJAPBskKqsh212WGQcpWh7SVM24nN24Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cuIgsaPD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OJq4PMCu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cuIgsaPD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OJq4PMCu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C9XRDC4028372
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pVihyfEVv9KoFRyaGUgwYSBE5ZXMKxbsi+xWvdEgydE=; b=cuIgsaPDCpjPQizt
	0NHBv5jjn/jXISGW57UxIf1k5Xu0iyORYIMcUYWeJlBRrGKhgI9pL4FmIBwf5DVl
	3tt9dW7MlCfSbQewK2BKinwVtG7lWXhVA5ZFrESWS8JhlhPNGtLeQxoiYWsgRfhF
	sPdiL7e/lWx9qs/2aCRoDvzK8fz15IG3gIlIPdt/kFsccxqEy5hNrJWWjZ8GrNnm
	bNdsjFPw8GqmLOyQxZllHdvttI3qeaEYgEurG3+f/2l7q8Csv+y8bwlOn3soN2cb
	E2ycM89HWorASgLc2zbrjNBGYojkHubOksbBAUykTaErSiimLefagq23R/1Z3AU5
	H63GgA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh54swse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:43:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae50463ba8so80727375ad.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773315788; x=1773920588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVihyfEVv9KoFRyaGUgwYSBE5ZXMKxbsi+xWvdEgydE=;
        b=OJq4PMCuSU61ARrecr7vSq9MV4hVJHL+Cv7bcr3VvAtHco0lJJoEDIH0Bsaplhm+D4
         8v4nxn+BWjc4wXJOF0epSYG4nyinN47B4TRzM1g5Ouqo5+L067clQ5Id8gMrf6fSZTG3
         AE6vHM67WD5QRJSTEDi+N+9kuqYj5PSmQsGTOFo/6sVex0niIq14hK4uLFoew7cYLRA/
         yNVsff6XKSe7IMiTs1fjMjBWtGUIlBYdvaVDukSC2KJ2dX2pDRDDeEO8V5UCfSl1w+Uz
         +JwQOeAOV36g5HB338B3y7ypGhC8OvxnWc/OHRK5oQOvJH+3wnHxI4+aXBbS9WhSSpfN
         6xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315788; x=1773920588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVihyfEVv9KoFRyaGUgwYSBE5ZXMKxbsi+xWvdEgydE=;
        b=PkM4B/3pR5nNDlsr/NbDfHd/v3y+WWwyzP46/ivgz5sTeKc6IV0El5F47iFTUlL0ry
         yKm+MkdmH8OX8YvYjk80jv1TeQQIFV9W+njxSBWRrZoiP+tZTJEz+bQJwdFzubjh85w0
         53cVlz/HzTDAiCdgmMQXlb9ahpwt1JCzqb9cGN5+WE9xInQP3VDFWRA70Im69akzTKvC
         eO+57GMdnbNxsipcfmxwlY1e468XCYGTmUgX3He4PN+NzB97Voh2JUGt1pn5GgckVIhR
         OXVKmsCzyAeh8euzMgFAfSybSLfX2FBpKaopMaIBJaHlsjlhcb2mqzmHx7gPmoM+Iv3/
         Ps9g==
X-Forwarded-Encrypted: i=1; AJvYcCUUjwf7FzW8SrF8dctFLyYAyDUvY3B+4D8b+hXUO4sL1kpVAeR+Gv7yc6JPRHWQozgCPr2MRtRmzQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6eqQYp07ABBAcr0ViTyKUceYa4sB9Vy8cVQFmwQy55MHhjAn
	O1IaqkS4dax4BOO1qhbBngKc8yKd2ed8zuu/Dw5qrtBKA287nLQrcDtpjskZcJAZpZnHlgcqtgp
	6D8ejS2AhMV9SO4d3xTAPa4u7Ez4Z69Py4JLKzq9LBPzsczVl5xwLhwjzS7HFGV0=
X-Gm-Gg: ATEYQzwfBsT91zk9Yys9FLt9rH6srq+/9767x4My7enDEe/kZc9XyzpEyMuY03Nrl5s
	kUfF+OYm1UMUxTMZEgiBTq+hx9Bq+8G55pSPMcm4rSJ1d2XPWKdHU9z+Sp+oWyLkEk/t6aNjrbA
	7NhcJ/CMrymX0OOvfuZMJ9Dp2jlJnGvoa2f+NyHmoSsitUbnEvHK21WbF1MGHUqnNOWCUbkNZLO
	2cqDkASacih7wY9IKnxa/zdLPb3puR437ewBKGdCZw2aYpW9dJg7TviWzsVWxfgMAmEvjx+0sXy
	p0zvkX5xoMOEDtkGqn8dHqff/hyx3hBE3NUkr9eK3JjRFXkPklsVDeLAKP8OzmuFKmV/jjGDunH
	aNwZONbVuRIEgfk0eJKb3h2xbFMbNcGZTb21xK7Q4EtcFEEfwRwWrpKP1ZA==
X-Received: by 2002:a17:902:db11:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2aeae7b4ecdmr63852235ad.19.1773315787484;
        Thu, 12 Mar 2026 04:43:07 -0700 (PDT)
X-Received: by 2002:a17:902:db11:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2aeae7b4ecdmr63851865ad.19.1773315786884;
        Thu, 12 Mar 2026 04:43:06 -0700 (PDT)
Received: from [192.168.1.10] ([38.254.186.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae25cd67sm56194955ad.38.2026.03.12.04.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 04:43:06 -0700 (PDT)
Message-ID: <27edd195-b0d3-4214-9df3-74a84da1e3e1@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 17:12:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] of: factor arguments passed to of_map_id() into a
 struct
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
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-2-c62fcaa5a1d8@oss.qualcomm.com>
 <esfzpgpgenydif2sxahsetkglz6kewsgjhkmzr6ulrrkctnkbq@a4zsfdmhbxui>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <esfzpgpgenydif2sxahsetkglz6kewsgjhkmzr6ulrrkctnkbq@a4zsfdmhbxui>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9p2DMAh3iodkh1cIaf_0yDMucATqvSpb
X-Authority-Analysis: v=2.4 cv=BNG+bVQG c=1 sm=1 tr=0 ts=69b2a6cc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=FuYIH7Xx0xzBSkYrynBYgw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=tICBgMK4MGcbsJ-UzjAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 9p2DMAh3iodkh1cIaf_0yDMucATqvSpb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5MiBTYWx0ZWRfX/9+JhhfORM8v
 WFG3UscL4TA23Mke1c8wo5Jh08kvwRBfP5KAicVq5f6EkSb0WKGovpiGLOV98upCCe2FxwzA4ZT
 cQnlqpF4t9++3Saa2L9OcgiDbn5SOCZSKvmdrEqOD5HdQXFoOk11duVwbyTAAC13Ml3wGKcaIQB
 DjVy0y5hzm6Y1+OTB4AShW1VnUzI1YT2nyTVSDUuT0Sl48bkBmPE4wzzYTTUOWqGO2Gah83FkIM
 7EMOmyZFpa8QYQnbHilUShlCtg6YSKLAtYqNsLbiahq45aAtp4hfMlyX7Oeu7MPmuftnJrh0BoS
 TP8yD8D/4yoO3J5KrH+rh1jxo/1dkK7hUO3Otb7w/vmY0xaj75ejHznxPJ83idf0/i15gvR5EsR
 OKjCmOBUWEXGpCO5sK3QGD1MCHbdZCP8JrKOQz2isJmZA1HkoD7Nh+oOsj/HiF5OttdczIx5IOr
 rC1Glmgh1FrLFnfHM2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120092



On 3/10/2026 2:53 AM, Dmitry Baryshkov wrote:
> On Mon, Mar 09, 2026 at 01:03:38AM +0530, Vijayanand Jitta wrote:
>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>
>> Change of_map_id() to take a pointer to struct of_phandle_args
>> instead of passing target device node and translated IDs separately.
>> Update all callers accordingly.
>>
>> Subsequent patch will make use of the args_count field in
>> struct of_phandle_args.
>>
>> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>  drivers/cdx/cdx_msi.c                    |  5 ++-
>>  drivers/iommu/of_iommu.c                 |  2 +-
>>  drivers/irqchip/irq-gic-its-msi-parent.c | 11 ++++--
>>  drivers/of/base.c                        | 63 ++++++++++++++++----------------
>>  drivers/of/irq.c                         |  8 +++-
>>  drivers/pci/controller/dwc/pci-imx6.c    | 16 ++++++--
>>  drivers/pci/controller/pcie-apple.c      |  5 ++-
>>  drivers/xen/grant-dma-ops.c              |  4 +-
>>  include/linux/of.h                       | 12 +++---
>>  9 files changed, 76 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
>> index 63b3544ec997..03232b5ffbca 100644
>> --- a/drivers/cdx/cdx_msi.c
>> +++ b/drivers/cdx/cdx_msi.c
>> @@ -121,6 +121,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
>>  			   struct device *dev,
>>  			   int nvec, msi_alloc_info_t *info)
>>  {
>> +	struct of_phandle_args msi_spec = { .np = NULL };
> 
> Why do you need to set it? Parse functions ignore passed args, don't
> they?
> 

The parse function does check arg->np on input — if it is non-NULL,
it is used to match only entries targeting that specific node.

Also, there is this existing path in drivers/pci/msi/irqdomain.c which
pre-sets the node and passes it as input to of_msi_xlate(), so the node
pointer is not ignored by the parse code:

u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
{
        struct device_node *of_node;
        u32 rid = pci_dev_id(pdev);

        pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);

        of_node = irq_domain_get_of_node(domain);
        rid = of_node ? of_msi_xlate(&pdev->dev, &of_node, rid) :
                        iort_msi_map_id(&pdev->dev, rid);

        return rid;
}

>>  	struct cdx_device *cdx_dev = to_cdx_device(dev);
>>  	struct device *parent = cdx_dev->cdx->dev;
>>  	struct msi_domain_info *msi_info;
>> @@ -128,11 +129,13 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
>>  	int ret;
>>  
>>  	/* Retrieve device ID from requestor ID using parent device */
>> -	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
>> +	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, &msi_spec);
>>  	if (ret) {
>>  		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
>>  		return ret;
>>  	}
>> +	of_node_put(msi_spec.np);
>> +	dev_id = msi_spec.args[0];
>>  
>>  #ifdef GENERIC_MSI_DOMAIN_OPS
>>  	/* Set the device Id to be passed to the GIC-ITS */
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a511ecf21fcd..d255d0f58e8c 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -48,7 +48,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>>  	struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
> .args_count = 1 should be set by of_map_iommu_id now (and dropped here).
> 

Sure, will move it.

>>  	int err;
>>  
>> -	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
>> +	err = of_map_iommu_id(master_np, *id, &iommu_spec);
>>  	if (err)
>>  		return err;
>>  
>> diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
>> index b63343a227a9..729fa2f9f758 100644
>> --- a/drivers/irqchip/irq-gic-its-msi-parent.c
>> +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
>> @@ -152,6 +152,8 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>>  static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u32 *dev_id,
>>  				phys_addr_t *pa)
>>  {
>> +	struct device_node *msi_ctrl __free(device_node) = NULL;
>> +	struct of_phandle_args msi_spec = { .np = NULL };
>>  	struct of_phandle_iterator it;
>>  	int ret;
>>  
>> @@ -178,9 +180,12 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
>>  		}
>>  	}
>>  
>> -	struct device_node *msi_ctrl __free(device_node) = NULL;
>> -
>> -	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
>> +	ret = of_map_msi_id(dev->of_node, dev->id, &msi_spec);
>> +	if (!ret) {
>> +		msi_ctrl = msi_spec.np;
>> +		*dev_id = msi_spec.args[0];
>> +	}
>> +	return ret;
>>  }
>>  
>>  static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 959305a84748..b6e07c5fe715 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -2102,36 +2102,37 @@ int of_find_last_cache_level(unsigned int cpu)
>>   * @id: device ID to map.
>>   * @map_name: property name of the map to use.
>>   * @map_mask_name: optional property name of the mask to use.
>> - * @target: optional pointer to a target device node.
>> - * @id_out: optional pointer to receive the translated ID.
>> + * @arg: pointer to a &struct of_phandle_args. On input, @arg->np may be
>> + *	set to a target device node to match, or NULL to match any. On
>> + *	success, @arg->np will be set to the matched target node (with a
>> + *	reference held) and @arg->args[0] will contain the translated ID.
> 
> Is this part being actually used (and useful)?
> 

Please refer the above comment. I see there is existing path in
drivers/pci/msi/irqdomain.c which sets np.

Thanks,
Vijay

>>   *
>>   * Given a device ID, look up the appropriate implementation-defined
>>   * platform ID and/or the target device which receives transactions on that
>> - * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
>> - * @id_out may be NULL if only the other is required. If @target points to
>> - * a non-NULL device node pointer, only entries targeting that node will be
>> - * matched; if it points to a NULL value, it will receive the device node of
>> - * the first matching target phandle, with a reference held.
>> + * ID, as per the "iommu-map" and "msi-map" bindings. If @arg->np points to
>> + * a non-NULL device node, only entries targeting that node will be matched;
>> + * if it is NULL, it will receive the device node of the first matching
>> + * target phandle, with a reference held.
>>   *
>>   * Return: 0 on success or a standard error code on failure.
>>   */
>>  int of_map_id(const struct device_node *np, u32 id,
>>  	       const char *map_name, const char *map_mask_name,
>> -	       struct device_node **target, u32 *id_out)
>> +	       struct of_phandle_args *arg)
>>  {
>>  	u32 map_mask, masked_id;
>>  	int map_len;
>>  	const __be32 *map = NULL;
>>  
>> -	if (!np || !map_name || (!target && !id_out))
>> +	if (!np || !map_name || !arg)
>>  		return -EINVAL;
>>  
>>  	map = of_get_property(np, map_name, &map_len);
>>  	if (!map) {
>> -		if (target)
>> +		if (arg->np)
>>  			return -ENODEV;
>>  		/* Otherwise, no map implies no translation */
>> -		*id_out = id;
>> +		arg->args[0] = id;
>>  		return 0;
>>  	}
>>  
>> @@ -2173,18 +2174,15 @@ int of_map_id(const struct device_node *np, u32 id,
>>  		if (!phandle_node)
>>  			return -ENODEV;
>>  
>> -		if (target) {
>> -			if (*target)
>> -				of_node_put(phandle_node);
>> -			else
>> -				*target = phandle_node;
>> +		if (arg->np)
>> +			of_node_put(phandle_node);
>> +		else
>> +			arg->np = phandle_node;
>>  
>> -			if (*target != phandle_node)
>> -				continue;
>> -		}
>> +		if (arg->np != phandle_node)
>> +			continue;
>>  
>> -		if (id_out)
>> -			*id_out = masked_id - id_base + out_base;
>> +		arg->args[0] = masked_id - id_base + out_base;
>>  
>>  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
>>  			np, map_name, map_mask, id_base, out_base,
> 

