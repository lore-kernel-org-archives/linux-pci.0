Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08339659D
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616869; cv=none; b=ICozMQe9hL9lLmIxDgfoW626aGchKuV4wUnwh048OI7wpXCUvkj4ivjFJpGAognu6MhvBkSfeGSR1VHjl0xovtd8tpC+mhRGjT2gJQg64HCElSAZeYQ65gqf6IjCwhf4Lb75FOsibehOrK8OSXmCTQgmCCK/FNPvRP8MZaunb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616869; c=relaxed/simple;
	bh=6qNs5bvMZfHwnPOBKJIFPFz6WDohu397FZ3wycyW/AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQmXLG/qUwPx8m9tDuIx1hjpKOzenT6UXwlV2q5fOvFNTtcpdr9s30xLQM2gRVpwoNv9UvXkIZBPUcytBNt8Y/jalUeHdY2asKVyeMRbmock+1EMVX5QSO0FXcFbz8pKB+8qB/8pmbk+ZBuC0BvfklPJvWJgCwlhyBXhWWNT104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JFVTiT7l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ST3IwBKJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFVTiT7l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ST3IwBKJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SQJt2861139
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 09:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HgNePX7ca+FZHnkRpuhdJQZhOY6UQv+RvgcyupQpELQ=; b=JFVTiT7lxucAne5+
	vWI+HQTpVk9V3jWmx1PWUucrFvamP0yDOFY034alLz3ZBgzIEfMi0MS4uquN1hh8
	EI7aXuxp6dMz6qO68oU/aQSWUICNJo/sGcNoD0kPndEVtSWs5OCjVP5rcLH80Phg
	ky3wGQTwGMI2mB5E91AT27+H0OF6l0sY8Q3oWToivevSOK2GADQjRFKwWcBWEA11
	9S/eTjbdqGKh/aZMhmaHEf1pdgu2dgjd13zO95DicZf3Ff6fn+rEkPSwwJQABuHd
	scgJ1dbD5faRcuu9tqpogs2bthEi90+/7K8PlySiEJVEWT4ZR/QIh7aqipwVG5tU
	9sDJBA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp2c9kcsd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 09:34:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-359918118ebso7750009a91.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 01:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772616866; x=1773221666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgNePX7ca+FZHnkRpuhdJQZhOY6UQv+RvgcyupQpELQ=;
        b=ST3IwBKJDKvkcO4gaVl+vpAsYFg50mI5DyXwrPMrimek0MXmOXbav8fWZPUd7ADrnn
         DrsORj77LHTYdoTf/iZy6BEKEiKj4ChAE6u0v7DmqDaqVwCVbLw6YXlDNf5Ff6Xia/Y1
         +c6mHMjaTVNScS/oiMd/CdtY3ZK7qlxn4fHw+wDawSLwDFVlM8/2d/b5ypHfogC1ixaR
         SPJ6c36Tai9u7oyinCfgM49DA/2wmt6mdj+6mOb6qAYNGPGlP2pq+LsIkJF/BguiJuEE
         pluvtS5z7eZHheHU+agSBln6irE/giYHyn5B7L59reicQhPSC12zeaCyhrAbrq+rV3j6
         mveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616866; x=1773221666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgNePX7ca+FZHnkRpuhdJQZhOY6UQv+RvgcyupQpELQ=;
        b=WP9gdvABNlEp53YQIuoIJzT7Wz0XzaaS6vxuK8TzcCjb+hRKwd/7G6eewlW+Ba0B6W
         57sCmy+d4FBPTLFlCZkfpzW6sEiCgosiVRrCuAb56tTyW7btluMAZ+pNKVnUjUD6GE3J
         ruziZMnUDzmBaqU2VNC/jngm/oYnRc+35BUDOSrF8PHzWJwK6P+yBzCRo0mYTw2a1p3q
         hOVvpxhPtkWBLsymTwssLZY1OHcgYWmOt7SoyCH8g3Az7O78UanpcuPEbD1/QjeSyKD4
         QD/cr8gqkqjGd+08ZHYmKyyB6rBOPQHRJLOTtUnESq6SWXS39XL3tt0y8wdSj8Vc+Cg1
         hoxg==
X-Forwarded-Encrypted: i=1; AJvYcCUoDhDtRzXFayeA4ksnyXfC6DdzVz59eBaNZsUMw99cEOdZhEekkWqwLhC9BpKcDm8q6wR9vp0wZS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQXGMBtPJa/vclkJWk1SzlA4EhjoGYGsIgwmGw8O4r8uxTJ+g
	3w95fcK2A/+YOgnBEmsc8Zbwl47U7KnttEPQMGUhLKCOq2jGsHe1IidZC9iJ+pO3gOAGUiJr6yU
	vcYI5rg06tSIpp/imeZswTn8KpOZ/3NAMIqmGLNaB5dfYaP+56yBXu15NKyM3YDY=
X-Gm-Gg: ATEYQzyLXYtbdEwk7CfMs58XD/KWFCD5eHAqa2/pWBzom2VpsK9NzmxzPhgnXN0d2BS
	Q+xFnAqqwtsmtpSktJ0TT9M1utEPgCkguTd1tJ18kBGpEspWqxtnnGta5yNQmTLEW76VSHB76e2
	UbToFTLABsPJhSrwkQfJ6S56IZ4S4CbO/+yTwinCI7S1F01MUorcP3qCKuYpluz4nje3pxXXfCd
	o+uU+dpRA8mQ7T3i9MNsXQQ6CKUx9cuKKB1VIY1YMcM2c91uiG0eciXOmOtjOvYygf1fuyMSL3D
	7AwWCtkvqFwadZo5i9a494OzkKytPPlvw9RHThnmGEpQRram2FnZv90c4ZwRu9l0eC0ch3ytOLD
	TWhsbPQxf10V0nbk202qFJEjVMnJIcYhUSHsQ8h5HBZgDzbZrRyO4hLp0
X-Received: by 2002:a17:90b:2691:b0:349:2154:eef4 with SMTP id 98e67ed59e1d1-359a69c0d3dmr1241328a91.5.1772616866187;
        Wed, 04 Mar 2026 01:34:26 -0800 (PST)
X-Received: by 2002:a17:90b:2691:b0:349:2154:eef4 with SMTP id 98e67ed59e1d1-359a69c0d3dmr1241312a91.5.1772616865529;
        Wed, 04 Mar 2026 01:34:25 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8d65b31sm500720a91.0.2026.03.04.01.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:34:25 -0800 (PST)
Message-ID: <4bc86c4d-3a4e-4ece-a01f-dce735ee9bd3@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 15:04:13 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
 <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
 <grcqbs42seqxmes7lm527kwhqf6osherykg6pc3w5voubd72rn@hncfl3oforza>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <grcqbs42seqxmes7lm527kwhqf6osherykg6pc3w5voubd72rn@hncfl3oforza>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3MiBTYWx0ZWRfX7735FWxz98Rz
 t7Y+gllwma9AMKdiN3r5W7XV2wF0n38AAZZN15YkGXNfSIuGiXX1NJQ71kyGsV1wF7VtswsBbsu
 YVBnx8UptGJpaYKnZdy25RheqtVpbc8AEwDLozyfgI1DqlvKwu9h7Qb0AjBHHZwroZGk8fudwvo
 3sKaTCiHpWhjMMLqDY7MSZSYou1bQr7sngauOopRENrAxwjf8+MoP50pyMXjuIK6KUaDuLPxdBs
 kZ4Wy6QsMl3aPJLr2k8+8GWqUA6Pwy9oMxxYDm6iwERekVMWpMd7nGk5SmVdDJmQ6AFpArjBGGk
 +jirY2k9jcOd7UN3xOGtdpdfGG74zUXrLV1e7H8Q9Pz6mDpQZPZBfZ/DggSQu/sQgJcLF5luh6S
 vh9npjL8oPKFnSpLmYiC8pkn66nxtNRxT83ipctQ9BedeoxgP5KI0aAr8nWkv7Bekd9yCtkUFNh
 sWtxMYU2kKKZ+uEB2Jw==
X-Proofpoint-ORIG-GUID: FD16wlcPjv8irSHqvA_Ak61Wiq2Jydwc
X-Proofpoint-GUID: FD16wlcPjv8irSHqvA_Ak61Wiq2Jydwc
X-Authority-Analysis: v=2.4 cv=EefFgfmC c=1 sm=1 tr=0 ts=69a7fca3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=MLUpyK7X_zb698vRSG8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040072



On 3/1/2026 3:32 PM, Dmitry Baryshkov wrote:
> On Sun, Mar 01, 2026 at 02:04:20PM +0530, Vijayanand Jitta wrote:
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
>>  drivers/iommu/of_iommu.c              |  2 +-
>>  drivers/of/base.c                     | 37 +++++++++++++++++------------------
>>  drivers/pci/controller/dwc/pci-imx6.c |  8 +++++++-
>>  drivers/pci/controller/pcie-apple.c   |  4 +++-
>>  drivers/xen/grant-dma-ops.c           |  2 +-
>>  include/linux/of.h                    | 21 +++++++++++++-------
>>  6 files changed, 44 insertions(+), 30 deletions(-)
>>
> 
>> @@ -2193,11 +2193,10 @@ int of_map_id(const struct device_node *np, u32 id,
>>  	}
>>  
>>  	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
>> -		id, target && *target ? *target : NULL);
>> +		id, arg->np ? arg->np : NULL);
> 
> Is it just 'args->np' then? If it's NULL, it's NULL anyway.
> 
Right, will update this.

>>  
>>  	/* Bypasses translation */
>> -	if (id_out)
>> -		*id_out = id;
>> +	arg->args[0] = id;
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(of_map_id);
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>> index bff8289f804a..74fc603b3f84 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1139,12 +1139,18 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>>  {
>>  	struct device *dev = imx_pcie->pci->dev;
>>  	struct device_node *target;
>> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
>>  	u32 sid_i, sid_m;
>>  	int err_i, err_m;
>>  	u32 sid = 0;
>>  
>>  	target = NULL;
>> -	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
>> +	err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec);
>> +	if (!err_i) {
>> +		target = iommu_spec.np;
>> +		sid_i = iommu_spec.args[0];
>> +	}
>> +
>>  	if (target) {
>>  		of_node_put(target);
>>  	} else {
>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>> index a0937b7b3c4d..e1d4b37d200d 100644
>> --- a/drivers/pci/controller/pcie-apple.c
>> +++ b/drivers/pci/controller/pcie-apple.c
>> @@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>>  {
>>  	u32 sid, rid = pci_dev_id(pdev);
>>  	struct apple_pcie_port *port;
>> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
>>  	int idx, err;
>>  
>>  	port = apple_pcie_get_port(pdev);
>> @@ -764,10 +765,11 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>>  	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
>>  		pci_name(pdev->bus->self), port->idx);
>>  
>> -	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
>> +	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec);
>>  	if (err)
>>  		return err;
> 
> of_node_put(iommu_spec.np);
> 

Sure, will add this.

>>  
>> +	sid = iommu_spec.args[0];
>>  	mutex_lock(&port->pcie->lock);
>>  
>>  	idx = bitmap_find_free_region(port->sid_map, port->sid_map_sz, 0);
>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>> index 1b7696b2d762..5f1d6540049a 100644
>> --- a/drivers/xen/grant-dma-ops.c
>> +++ b/drivers/xen/grant-dma-ops.c
>> @@ -325,7 +325,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
>>  		struct pci_dev *pdev = to_pci_dev(dev);
>>  		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>>  
>> -		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
>> +		if (of_map_iommu_id(np, rid, &iommu_spec)) {
>>  			dev_dbg(dev, "Cannot translate ID\n");
>>  			return -ESRCH;
>>  		}
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 824649867810..9d72d76f909d 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -463,7 +463,7 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
>>  
>>  int of_map_id(const struct device_node *np, u32 id,
>>  	       const char *map_name, const char *map_mask_name,
>> -	       struct device_node **target, u32 *id_out);
>> +	       struct of_phandle_args *arg);
>>  
>>  phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
>>  
>> @@ -929,7 +929,7 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
>>  
>>  static inline int of_map_id(const struct device_node *np, u32 id,
>>  			     const char *map_name, const char *map_mask_name,
>> -			     struct device_node **target, u32 *id_out)
>> +			     struct of_phandle_args *arg)
>>  {
>>  	return -EINVAL;
>>  }
>> @@ -1458,17 +1458,24 @@ static inline int of_property_read_s32(const struct device_node *np,
>>  }
>>  
>>  static inline int of_map_iommu_id(const struct device_node *np, u32 id,
>> -				  struct device_node **target, u32 *id_out)
>> +				  struct of_phandle_args *arg)
> 
> Document that it's the caller's responsibility to of_node_put() returned
> node. As it can be seen from the previous comment, it's not obvious.
> 

Sure, will add comment regarding this.

>>  {
>> -	return of_map_id(np, id, "iommu-map", "iommu-map-mask",
>> -			 target, id_out);
>> +	return of_map_id(np, id, "iommu-map", "iommu-map-mask", arg);
>>  }
>>  
>>  static inline int of_map_msi_id(const struct device_node *np, u32 id,
>>  				struct device_node **target, u32 *id_out)
> 
> Is there a reason for chaning the of_map_iommu_id() args but not
> of_map_msi_id() args?
> 
 
Thanks for pointing this out. I’ll update the series to keep of_map_iommu_id()
and of_map_msi_id() aligned.

>>  {
>> -	return of_map_id(np, id, "msi-map", "msi-map-mask",
>> -			 target, id_out);
>> +	struct of_phandle_args msi_spec = { .np = *target, .args_count = 1 };
> 
> Which driver passes something being worth of storing in .np?
> 

You're right, There is no need to store these input args. Will remove these initializations.

Thanks,
Vijay

>> +	int ret;
>> +
>> +	ret = of_map_id(np, id, "msi-map", "msi-map-mask", &msi_spec);
>> +	if (!ret) {
>> +		*target = msi_spec.np;
>> +		*id_out = msi_spec.args[0];
>> +	}
>> +
>> +	return ret;
>>  }
>>  
>>  #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
>>
>> -- 
>> 2.34.1
>>
> 
