Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C9202F70
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369035; cv=none; b=kyd0Qmc7FzIwfrOQhHx+R+giu/9bzQ8koCCffjpi9u9iabeG4x4M9TPl/jPl2vqAu0/kreilpIZtBUKot3dcyBTw6MnK3O+V1u8eTpRrxwWhJdO7sbixtnmH3IkZVnf+Qo3Zv58HHC5QT+8ceYnBBvJOkG+VpUqsr8qNjGcR2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369035; c=relaxed/simple;
	bh=2GSnzV9ciCdURTUIeb8cFpTdA8HTh0lpn3BPxfOouaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbneZ7aTWAJed2VIId7DEjc+l7jH61//9Lc9uZ09MM/djkjJue2IWy4DXPuT5HdAggCoSo/x+FVZhGwPc5DcS9tEugwl3HZclOsgW8IuPwy9F0YmEmSpGIlnMM7xH96JpYP+t61dIPCABrJDSw2JDSvalV8c8GEh2NfB5V6alZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZ756s19; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/8RGTQk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZ756s19";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/8RGTQk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99tfr3009585
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0+u39I4+waHFNk0WDdpK3zNnsyjAzm42aKp+xFiWAMI=; b=AZ756s19SuH7Zxx8
	eZnLorFYVrulqy+ULK57h3tw4swbpVyHyxLX8S9zypcRtDhvvrKzwZLxsTWUZita
	7SpK/XCi+QjWTMfiGKhb+9rZV/U710BoIhUMH7bVASKC7G2QyEAM06SlMLLi0+Iz
	+HobBO01uh9TC1j06Pfa1PcvbAtiazo0L8IRK1NcS1Z3cPFACMFk2dPigjyXdnSP
	zKGFCUtcwijpvsGoUNFGkC9XSEqyTLe+/THVBCXxewhWQGSqgr28GiEhhkeDDD28
	3hwJNcBS5+SKvyPZIig57ap0NZFPRi4lV1d+q+quaxSuAYm6cmKuIgEQAEv3VEDR
	ono+IA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9sr32a86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:10:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b9fe2d6793so142783335ad.0
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779369032; x=1779973832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+u39I4+waHFNk0WDdpK3zNnsyjAzm42aKp+xFiWAMI=;
        b=a/8RGTQktKZSfJWzxpqDq9PNbHzofspD9EwDl9wN+oFEMpKjobK6GIpE82jqNB1tO7
         dCV2lLQ5LbBAP3Mz1rVZilAFLxAotytfnsdCL67IHVaQgMtf+LHknhtyxHOcwDKsBsV4
         wei7hHoCHMhBDDo1GVdt/eAQXmDvRMfT4ABACKuMl3xNpBYPSVpHcunL/p0H83S4jOIZ
         wg0mqpaIjcCvA6amC3l0vJ/8n3yCXtftSr501tb5xtRwi+IPxw0F/Rhe18dYtWb/G5QB
         4YY+DJQgb8Mw1xLmrjTEO/aZ9HOjLqe/aaTM4qgGnf2twr4JN0zU8CpXSoEfu4ZCzyA/
         urwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369032; x=1779973832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+u39I4+waHFNk0WDdpK3zNnsyjAzm42aKp+xFiWAMI=;
        b=JBFHo3Y+ADXWEO+Li94ak+/Zhimci7SRwjhw12fc8EUo7etS1mzOzARCyLeX9Bm/YL
         6yz1j0iH/mW0ZZqL6YeBPpnbP2eLNZV79x4ktG16bpcRInw94aNexIS6GYBVSINMLGOl
         cEy/gKKajtAQnE+kkCWITFVDe/geojh87P7Jc7xXCiMvDHs7fyAnXUOfS1MLSdn5lNMj
         k3sJJzOVqc/1FL/kyiSTkaCf5+82ZEzKqPBSRphy8bvTlIi9ZigMpAi7p1IxKI0N15eX
         JMxiOyfZIuNlNXBA8cupV703B/vjchO+sDT+cYOqMgLcz9erYDF5uegYVeImGGSEnkc9
         4Bww==
X-Forwarded-Encrypted: i=1; AFNElJ9YbqGThuON5cWuazpJJu9qLqkYa4zudOhwfAbh/PSoP/xca08m2y1TsH8bhbdEbxshRmUexwAw6Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzff+9NQqj1t28jZemUS/3CLtIUHk38ObLj8yD+g05k1j46AwQG
	bZlLTdBVwaM7s9qQHRB6xSMD/XIoxrPKJhJL8ZNxF+y2+t07FHI0DuPbYeTbpr5DI8udnHC+011
	MSxwUdAnPIfMVVh3vlkxjY8uiXEgnA4+X3X3GZixJthcmQXPo43yX2HBDgvYkMcEt1gDDgo4=
X-Gm-Gg: Acq92OGm9wflW9OOpQt4P1wU1fSVrx+T3M9Z+JiNkujXncWdogKGz9Hw3LrZ8dNCwOe
	7ais5PfkLlfz/hHgsY6NfHLJrUnD5GFWGPVPbmokSt6LoBAATl49R4oyJKgUxPhS+6wO1VoeX/s
	pYEWhDOGIbPYt1H+GFzWVaeX8uXHExp1p0q0hCbL7KWVcxskflkL26Nwy/8f3EkVsChNCxhuo3y
	YJXX21I4X0APCMWWTgV7TdgQm4GeaJBEgUMtof42yYE7yQaIcXLmqCJIr5U/k+hGpsjBc/l7250
	QB23J90I5iHfHlCzcBTgwnTWFrO3C+S18z+nmPKXnPXsmvNX19KOtj6T+ggdWQ05YvYYs8oMV9z
	b8dCorKdqkUcy9zsxS1Pfk/AhPQmU/+tvpuA9NKC974DsBVLVBtNQvA5JBA==
X-Received: by 2002:a17:903:245:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2bea33c2013mr29524965ad.35.1779369031945;
        Thu, 21 May 2026 06:10:31 -0700 (PDT)
X-Received: by 2002:a17:903:245:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2bea33c2013mr29524355ad.35.1779369031315;
        Thu, 21 May 2026 06:10:31 -0700 (PDT)
Received: from [192.168.1.9] ([205.254.168.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9a3c89csm10065165ad.83.2026.05.21.06.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 06:10:31 -0700 (PDT)
Message-ID: <57ad7943-ab05-4b7d-b55f-3a7da7457137@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:40:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/3] of: Factor arguments passed to of_map_id() into a
 struct
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
References: <20260520-parse_iommu_cells-v15-2-b5f99ad4e7e8@oss.qualcomm.com>
 <20260520085613.9052F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260520085613.9052F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4dGVtZIpaAg_NOScihp0XbrccIPc7uvd
X-Proofpoint-ORIG-GUID: 4dGVtZIpaAg_NOScihp0XbrccIPc7uvd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMSBTYWx0ZWRfX4Sx/CO0HfuVU
 V4HgrQsWmf9mvJOsKwbYFM4aSREC6Rc+ez15F3zckOy8QRC+4aOP9Xg9W0Nw60WBrKi4xJtNuE7
 VH5z7eVkMfAcT2HDfYlQNveS1HBQEpzOcRJqJERd1fvpCGlHlekrlYaB2bwzs/KKH18qt9Xvqe6
 aFPERPt308nv84c/Evo+5YaZDhc7YL8O4oX1pMEtuib4vwuwt9kYAeCN/AKK1Jz5wjk9ckQf/+7
 1Kif/Kf2iz2WFpmPjd09fRe3VXpFFbvY9CgEmVrpcdHGRLyv0Kd4pttjxTUJgwC4P4MCl/uKD1i
 KrtVLLCuZw0fDotaNBUOxHjYV28l7RIQ+DeFTVfWDtBLOXPjpU5as73eIHVoQeYOGfXTlaZAxqs
 kGz7PTvYMMaQqoyCAilJ/D7gVRcr5hv7klKMeU5MbMH7E0FBba104NAW/5feiEANSE5Cu1r++ig
 ySGmmE5bHsrjDgCMjHw==
X-Authority-Analysis: v=2.4 cv=L+YtheT8 c=1 sm=1 tr=0 ts=6a0f0449 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=49gMqqAeKCh39Y98CdGbvA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ysTZoyIZg4-46AWNULEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210131



On 5/20/2026 2:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unconditional dereference of `msi_node` in `of_check_msi_parent` when it can be NULL.
> --
> 
> commit d17879206927f3ee695759bc3559fd04a6a551ab
> Author: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Subject: of: Factor arguments passed to of_map_id() into a struct
> 
> This patch updates of_map_id() to take a struct of_phandle_args instead of
> passing the target device node and translated IDs separately. It explicitly
> separates the input filter node from the output arguments and transfers
> ownership of the matched node reference to the caller.
> 
>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>> index e37c1b3f87362..e63a43be6c4a3 100644
>> --- a/drivers/of/irq.c
>> +++ b/drivers/of/irq.c
>> @@ -796,14 +796,15 @@ static int of_check_msi_parent(struct device_node *dev_node, struct device_node
>>  /**
>>   * of_msi_xlate - map a MSI ID and find relevant MSI controller node
>>   * @dev: device for which the mapping is to be done.
>> - * @msi_np: Pointer to target MSI controller node
>> + * @msi_np: Pointer to target MSI controller node, or NULL if the caller
>> + *           only needs the translated ID without receiving the controller node.
>> + *           If non-NULL and pointing to a non-NULL node, only entries targeting
>> + *           that node will be matched. If non-NULL and pointing to NULL, it will
>> + *           receive the first matching target node with a reference held.
>>   * @id_in: Device ID.
>>   *
>>   * Walk up the device hierarchy looking for devices with a "msi-map"
>>   * or "msi-parent" property. If found, apply the mapping to @id_in.
>> - * If @msi_np points to a non-NULL device node pointer, only entries targeting
>> - * that node will be matched; if it points to a NULL value, it will receive the
>> - * device node of the first matching target phandle, with a reference held.
>>   *
>>   * Returns: The mapped MSI id.
>>   */
>> @@ -817,8 +818,21 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
>>  	 * "msi-map" or an "msi-parent" property.
>>  	 */
>>  	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
>> -		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &id_out))
>> +		struct of_phandle_args msi_spec = {};
>> +
>> +		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &msi_spec)) {
>> +			if (msi_spec.np) {
>> +				/* msi-map matched: use the translated ID and target node */
>> +				if (msi_spec.args_count > 0)
>> +					id_out = msi_spec.args[0];
>> +				if (msi_np && !*msi_np)
>> +					*msi_np = of_node_get(msi_spec.np);
>> +				of_node_put(msi_spec.np);
>> +			}
>> +			/* msi-map present but no match → stop walking */
>>  			break;
>> +		}
>> +		/* -ENODEV: msi-map absent → check for msi-parent */
>>  		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
> 
> [Severity: High]
> This is a pre-existing issue, but does of_check_msi_parent() handle a NULL
> msi_np pointer correctly here?
> 
> The documentation added above explicitly states that msi_np can be NULL if
> the caller only needs the translated ID without receiving the controller node.
> However, if msi-map is absent, execution falls through to
> of_check_msi_parent() with that potentially NULL pointer.
> 
> Looking at drivers/of/irq.c:of_check_msi_parent(), if the msi-parent
> property is found, it evaluates:
> 
> 	if ((*msi_node && *msi_node != msi_spec.np) || msi_spec.args_count != 0)
> 		ret = -EINVAL;
> 
> 	if (!ret) {
> 		/* Return with a node reference held */
> 		*msi_node = msi_spec.np;
> 		return 0;
> 	}
> 
> If msi_np is NULL, wouldn't dereferencing it via *msi_node trigger a NULL
> pointer dereference? Should this be fixed to safely handle a NULL pointer?
> 

I see this is indeed a pre-existing latent bug .

fsl_mc_get_msi_id() in drivers/bus/fsl-mc/fsl-mc-msi.c already passes NULL for msi_np:

return (root_dprc_dev->parent->of_node ?
    of_msi_xlate(dev, NULL, mc_dev->icid) :
    iort_msi_map_id(dev, mc_dev->icid));

In practice it never triggered because FSL MC devices use msi-map, so of_map_msi_id()
succeeds and of_check_msi_parent() is never reached.

I'll will fix this in v16 by checking for msi_np aswell before calling 
of_check_msi_parent() in of_msi_xlate().

if (msi_np && !of_check_msi_parent(parent_dev->of_node, msi_np))
    break;


Thanks,
Vijay

>>  			break;
>>  	}
> 

