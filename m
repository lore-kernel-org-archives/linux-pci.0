Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071D3346A0
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768998; cv=none; b=Ov4lhGAqOij1O2jDNi6K1IewCawzONwxtE9t73GzpsnJTFbGUFSb/yCrlVHwmGPcUS2U7S73e3IxzMTuU93OAv6q0duEvNipi81fAeuHsTxOWv1rXE/xSudUzcsp5UlHmhYrjYFYdcQcVFGfNMRJWl8/yTjaF1XXJvUBp84eysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768998; c=relaxed/simple;
	bh=3rwjPmHOSwY4XTSgIu6O+LE+Rr7mCg58/5IvLB1zFOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gaz+jXVjOOGDXMmki8sWgua9LceYKeA4lj8q/yod2Buzq23L1J14AwJ74FoFCTFgjhCdB4QdML4X4YeUzsV+Bce6NYu3cJytPTVYBRTvSiAtpA1AVQOTrAcV+sxPcmDnhKegqfCsBivwXrirJC6iWHVAFdKF+B0s2iP+qWhVsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDNrKG6T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QQz7rI1K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDNrKG6T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QQz7rI1K"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HEHoYk2188302
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 17:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zytiUP8Xce3T94fCwbA24WE4ff9eD1E8/ytUb5yxkwI=; b=DDNrKG6TBGPThpBu
	Qyx6FFRxPlo9Lsw9cg7D1U2tm8zxL8j42xvmYJAy8i0iWCAzgnYY0vH7Ul9raj6Z
	HwxUqbkaynZU+WVWdLr+MRDq4tz5iJzOfAFFTHtkdpJPhbSqh1/UMsdv4OMIufdB
	CvX5TsvYNSq4goCEBNHBJRVHgWt74xDg8XJsMHx9HGYEGWXYd4gS/ozpnjbkVYGC
	QnHJ/bTannKFVM7Z/DLt8BomcdqaqKYgFGrYJkse2i7sHtxmK6ZTs/FbkI1hFi3T
	brQEIdXMSyoL7duC5cni/eKj+yoGMQCFnf5reegtKcrLp16GOY3KvF58shbTVtD+
	sTIEqA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy8kjrtsv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 17:36:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae3badc00dso87928475ad.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773768995; x=1774373795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zytiUP8Xce3T94fCwbA24WE4ff9eD1E8/ytUb5yxkwI=;
        b=QQz7rI1Kc1KgUe6tSTMJxZ2Gj3Xqh7K9BulS4TxZdKVj/uR+seg1NYA2iNls44Sbby
         6qd0qzU/F+Tqr5USlOxbnMiolpkfiAKvHuAVKSk7sy3ld+NmRJU674EAvsD9ET6SR36/
         4PDK6BeqOqXUquZn2y5OwDTdE0gGXLnILpi80h9J/2LU/7rRyPWWQwrwXx/lx3UioXXT
         G9aMDGeO6d1Niwq61CUarcbR3lC7LNuN3jSAsugZ8/iLvwr/sbSxVl5oKWPRHetHb8bL
         RYD9QiSYdvM4NZj0ysUxItR4eo7Ya77LYBsKsI3r4EBZf/pKMfFUd76TmlAK/DszWpJg
         hdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773768995; x=1774373795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zytiUP8Xce3T94fCwbA24WE4ff9eD1E8/ytUb5yxkwI=;
        b=F/KhSZNuShD9i1+gXB+RbTeHHxaklSKa/xE5hhKYxAYkMSv8PabDbZOW5ED/Fn8gZg
         VJpdn8UpZVfU/BwGTzaCQkkN707+OEve9ntjsrrAFeHf/0OigEicVpVRu6qXiUm96HBy
         LWNIt4DQCqxfUd3wD2Kx6aD8iPzfVGR5QMnl7tYXADQATot9UETnfRn4q/ujT8pFLXDz
         cT37hrQr81jeXyrkxMofkObgM2s8eAXV/LtaJdpJ0HwNz3O4dCEi1M+etepi5d8LYRdj
         r1Fw+E3ccxWBgNvAxz+t5VKLz29Fy4Cg7KD3UFjIuuUp1tmPcRP2ikvx3pWt8T36zR2M
         iUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW900jsOe75wO4jDUvzhnYO0WSibqKLHi6tgHV5UJdX58YjantKSjnEL5XD4cFNFdWni0zhlPR2UqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8loXiq96w2GUObEt86C5qJ6W8/nUs5mFalan8GxSXrEAQ4JXJ
	cRXkCsv4tpPq+TNTMhIyzYszzsrqmEhDsJPWto/nOC/KPXO3rIQYSd/qh1o1wEb+wFO8G2eV3V0
	JlvfX/piFtgnqo7d4/O9nbqr1MSZVLGLPzLlCK/UuoiHkuSj04/2oI1RkxG0DigE=
X-Gm-Gg: ATEYQzwgIM9v+AyCffTPbL67EA2pgM2qdwQ2SFXtowhm4mYdFd2xDiStLkTGLPS3XqD
	NCVyayQ9CBhtooaNKsRmWs1Mt+X3426FFWH0lrZwhxLgDC7P+U9X6+1eoGGT1OoxGN6ouaUtfQj
	dIwvBorsTL16a9nzQ4s/Tyc+QpZTRAZaFJ8zc3VNH+rDYPrfaY8M1zizZe7f+FqOfUgkuKG+e5x
	DexDxol1pbsMn5CYl5MWZ9zw4Omrl2dr917b0lePuskV6qI2e63KVLgQePzJRlYCAlRKrJgZ5So
	cbSBrKk8S8FtBlGlWIGnvCqXO1fUFuBCbz0caqf88y4rAg1fq7H002OE5rrRQgGEk7usK8A2zd9
	LWR3uMaumdYVRetnMDmcwTmr+4UTlJDnMw8V+/i27XhmGG3AU+iVdMqjN
X-Received: by 2002:a17:903:1a67:b0:2b0:5a4c:726a with SMTP id d9443c01a7336-2b06e41afc9mr2520695ad.43.1773768994511;
        Tue, 17 Mar 2026 10:36:34 -0700 (PDT)
X-Received: by 2002:a17:903:1a67:b0:2b0:5a4c:726a with SMTP id d9443c01a7336-2b06e41afc9mr2520265ad.43.1773768993782;
        Tue, 17 Mar 2026 10:36:33 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.248.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e603937sm1236095ad.57.2026.03.17.10.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 10:36:33 -0700 (PDT)
Message-ID: <e2f5a1ab-2b1f-484c-b476-6c453abf0087@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 23:06:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] of/iommu: support multiple iommu-map entries per input
 ID
To: Robin Murphy <robin.murphy@arm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini
 <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org
References: <20260315-iommu_multi_map-v2-1-51b98cb79331@oss.qualcomm.com>
 <be41a533-46a8-411b-bf6c-d56b550691a7@arm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <be41a533-46a8-411b-bf6c-d56b550691a7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1NCBTYWx0ZWRfXyu7Xpxi1qOO4
 b3WW6UJ+PTx2uBzROXOhqs8kRQvFwMNoAcu3OMrAalGGnlxfZ2DnRCb+Oho7L3gwAR+zYIpNRFO
 EaNc8nb8nZ0y87QVrdmIv4kLkGB3kAxf144r/oPIt7El3VXww4v70A5DlLCuZQTgaD9JvFIa3aE
 NpXkgxG0vtGlgyuPOu3Q7iRtPHoMcl6BTJdvnsarti5dNeMNZjX2V5os3WL9w3fOnEqCYXjzxx4
 ixRTWu+oORlhFlVRCCYECILR1iV/HeEXeX8flxOEV/nNlS6lkDfXOrIGOl4RL2Fvq1OtvhzpOWb
 iwX5PmF8mdBEeWD4pGGYai8WPdhltiVHXtMtY66AKhpPZb9Ow/RXchct6LeZDMAFYBuAFT8ubWH
 X9FMmW5c7VPOqXAV214js6hhgotIBuztgQMhpxGCES2pIYo3Rj5eA1cyN07BcRSID0TgaaaUD4A
 r9DJ+8Z9JUuj4CnloGw==
X-Authority-Analysis: v=2.4 cv=P8I3RyAu c=1 sm=1 tr=0 ts=69b99123 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=L0D9IIo8dDxUtxRzEGqq2w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dbrUTAiK8tO8QfTRFOUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _LAXAAQeUzK_xfyvak8M-p3GZXUGkpxH
X-Proofpoint-GUID: _LAXAAQeUzK_xfyvak8M-p3GZXUGkpxH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170154

Hello Robin,

On 3/16/2026 5:18 PM, Robin Murphy wrote:
> On 2026-03-15 5:07 pm, Vijayanand Jitta wrote:
>> When multiple mappings are present for an input ID, linux matches
>> just the first one. There is a usecase [1] where all the mappings
>> are to be maintained in parallel for an iommu-map entry of a same
>> input id.
>>
>> Add a next_offset iterator parameter to of_map_iommu_id() and
>> refactor of_map_id() internals into a static helper to carry it.
>> Update of_iommu_configure_dev_id() to loop over all matching
>> entries to support this case. All other callers pass NULL and
>> are unaffected.
>>
>> [1] https://lore.kernel.org/all/20250627-video_cb- 
>> v3-0-51e18c0ffbce@quicinc.com/
> 
> That series doesn't even reference "iommu-map" though?
> 
> Once again, NAK to this - the purpose of "iommu-map"/"msi-map" is to 
> describe a translation from one hardware ID space to another, where a 
> one-to-many mapping of IDs to a single target would never make sense. 
> While it is in principle possible for a single device to map to multiple 
> different *targets*, that is ambiguous as to what it means - is it 
> giving the OS a choice to use whichever one it prefers, or implying they 
> must all be configured identically at all times? - so depending on how 
> you prefer to look at it, we either do not support that, or we have 
> chosen the first option.
> 

Ideally that should be the way to have unique hardware ID should be 
mapped to unique single target. In case of VPU hardware, there are few 
sub hardwares blocks, 2 of them would be bitstream engine (BE) and 
tensilica (XS). They generates unique ID as 0x1940 and 0x1a20 
respectively. There is a *single register interface* to program a mapped 
device address which both these hardware would access and processes on 
the data. To accomplish this, these unique stream-ids are being mapped 
to single target so as to generate single device address.
We can call this out as VPU hardware limitation, but thats how it is 
currently designed.

If you could please suggest any alternate way to acheive this, it would 
help us conclude.

Regards,
Vikash

>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>> On Qualcomm kaanapali, the VPU hardware has multiple internal blocks
>> that generate different stream IDs for the same input ID. The device
>> tree encodes them as separate iommu-map entries sharing the same input
>> ID:
> 
> And all that means is that your invented notion of "input IDs" is 
> clearly wrong. Please stop this abuse of common bindings and just come 
> up with a proper way to describe your hardware appropriately for what it 
> actually is and does.
> 
> Thanks,
> Robin.
> 
>>    iommu-map = <0x100 &apps_smmu 0x1940 0x1>,
>>                <0x100 &apps_smmu 0x1a20 0x1>, ...
>>
>> This requires multiple iommu-map entries per device.
>> of_iommu_configure_dev_id() currently stops at the first match,
>> so only one stream ID gets registered with the IOMMU.
>>
>> The v1 series [1] addressed this with a callback threaded through
>> of_map_id().
>>
>> This patch uses a next_offset iterator on of_map_iommu_id() instead,
>> keeping of_map_id() unchanged, and updates of_iommu_configure_dev_id()
>> to loop over all matching entries.
>>
>> This patch also depends on iommu-cells series [4].
>>
>> Changes since v1:
>>        - Split patches 2/7 [2] and 3/7 [3] out into this standalone 
>> series.
>>        - Dropped the callback (of_map_id_cb / of_map_id_arg) entirely.
>>        - Replaced with a next_offset iterator on of_map_iommu_id()
>>          only; of_map_id() public API is unchanged.
>>        - of_iommu_configure_dev_id() now loops explicitly; no
>>          bus-type heuristic (dev_is_platform()) needed.
>>
>> [1] https://lore.kernel.org/all/20260126-kaanapali-iris-v1-0- 
>> e2646246bfc1@oss.qualcomm.com/
>> [2] https://lore.kernel.org/all/20260126-kaanapali-iris-v1-2- 
>> e2646246bfc1@oss.qualcomm.com/
>> [3] https://lore.kernel.org/all/20260126-kaanapali-iris-v1-3- 
>> e2646246bfc1@oss.qualcomm.com/
>> [4] https://lore.kernel.org/all/ce25b963-0e8e-4411- 
>> a406-7b466eadb1f9@oss.qualcomm.com/
>>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>   drivers/iommu/of_iommu.c              | 20 +++++++----
>>   drivers/of/base.c                     | 65 +++++++++++++++++++++++++ 
>> +++++-----
>>   drivers/pci/controller/dwc/pci-imx6.c |  2 +-
>>   drivers/pci/controller/pcie-apple.c   |  2 +-
>>   drivers/xen/grant-dma-ops.c           |  2 +-
>>   include/linux/of.h                    |  4 +--
>>   6 files changed, 75 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a18bb60f6f3d..947eedd9a88b 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -46,14 +46,22 @@ static int of_iommu_configure_dev_id(struct 
>> device_node *master_np,
>>                        const u32 *id)
>>   {
>>       struct of_phandle_args iommu_spec = {};
>> -    int err;
>> +    int offset = 0, err;
>> +    bool found = false;
>> -    err = of_map_iommu_id(master_np, *id, &iommu_spec);
>> -    if (err)
>> -        return err;
>> +    while (!(err = of_map_iommu_id(master_np, *id, &iommu_spec, 
>> &offset))) {
>> +        err = of_iommu_xlate(dev, &iommu_spec);
>> +        of_node_put(iommu_spec.np);
>> +        iommu_spec.np = NULL;
>> +        if (err)
>> +            return err;
>> +        found = true;
>> +    }
>> +
>> +    /* -ENODEV means all entries exhausted; success if at least one 
>> was processed */
>> +    if (err == -ENODEV && found)
>> +        return 0;
>> -    err = of_iommu_xlate(dev, &iommu_spec);
>> -    of_node_put(iommu_spec.np);
>>       return err;
>>   }
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 9c44eb6d445d..71175e670757 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -2146,13 +2146,13 @@ static bool of_check_bad_map(const __be32 
>> *map, int len)
>>    *
>>    * Return: 0 on success or a standard error code on failure.
>>    */
>> -int of_map_id(const struct device_node *np, u32 id,
>> -           const char *map_name, const char *cells_name,
>> -           const char *map_mask_name,
>> -           struct of_phandle_args *arg)
>> +static int of_map_id_next(const struct device_node *np, u32 id,
>> +              const char *map_name, const char *cells_name,
>> +              const char *map_mask_name,
>> +              struct of_phandle_args *arg, int *next_offset)
>>   {
>>       u32 map_mask, masked_id;
>> -    int map_bytes, map_len, offset = 0;
>> +    int map_bytes, map_len, offset = next_offset ? *next_offset : 0;
>>       bool bad_map = false;
>>       const __be32 *map = NULL;
>> @@ -2161,7 +2161,7 @@ int of_map_id(const struct device_node *np, u32 id,
>>       map = of_get_property(np, map_name, &map_bytes);
>>       if (!map) {
>> -        if (arg->np)
>> +        if (arg->np || next_offset)
>>               return -ENODEV;
>>           /* Otherwise, no map implies no translation */
>>           arg->args[0] = id;
>> @@ -2262,9 +2262,16 @@ int of_map_id(const struct device_node *np, u32 
>> id,
>>           pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out- 
>> base: %08x, length: %08x, id: %08x -> %08x\n",
>>               np, map_name, map_mask, id_base, be32_to_cpup(out_base),
>>               id_len, id, id_off + be32_to_cpup(out_base));
>> +
>> +        if (next_offset)
>> +            *next_offset = offset;    /* caller resumes from here */
>>           return 0;
>>       }
>> +    /* no (more) matches found in the map */
>> +    if (next_offset)
>> +        return -ENODEV;
>> +
>>       pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, 
>> map_name,
>>           id, arg->np);
>> @@ -2276,6 +2283,38 @@ int of_map_id(const struct device_node *np, u32 
>> id,
>>       pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, 
>> map_bytes);
>>       return -EINVAL;
>>   }
>> +
>> +/**
>> + * of_map_id - Translate an ID through a downstream mapping.
>> + * @np: root complex device node.
>> + * @id: device ID to map.
>> + * @map_name: property name of the map to use.
>> + * @cells_name: property name of target specifier cells.
>> + * @map_mask_name: optional property name of the mask to use.
>> + * @arg: pointer to a &struct of_phandle_args. On input, @arg->np may be
>> + *    set to a target device node to match, or NULL to match any. On
>> + *    success, @arg->np will be set to the matched target node (with a
>> + *    reference held), @arg->args_count will be set to the number of
>> + *    output specifier cells as defined by @cells_name in the target 
>> node,
>> + *    and @arg->args[0..args_count-1] will contain the translated output
>> + *    specifier values.
>> + *
>> + * Given a device ID, look up the appropriate implementation-defined
>> + * platform ID and/or the target device which receives transactions 
>> on that
>> + * ID, as per the "iommu-map" and "msi-map" bindings. If @arg->np 
>> points to
>> + * a non-NULL device node, only entries targeting that node will be 
>> matched;
>> + * if it is NULL, it will receive the device node of the first matching
>> + * target phandle, with a reference held.
>> + *
>> + * Return: 0 on success or a standard error code on failure.
>> + */
>> +int of_map_id(const struct device_node *np, u32 id,
>> +          const char *map_name, const char *cells_name,
>> +          const char *map_mask_name,
>> +          struct of_phandle_args *arg)
>> +{
>> +    return of_map_id_next(np, id, map_name, cells_name, 
>> map_mask_name, arg, NULL);
>> +}
>>   EXPORT_SYMBOL_GPL(of_map_id);
>>   /**
>> @@ -2285,15 +2324,23 @@ EXPORT_SYMBOL_GPL(of_map_id);
>>    * @arg: pointer to a &struct of_phandle_args for the result. On 
>> success,
>>    *    @arg->np holds a reference to the target node that the caller 
>> must
>>    *    release with of_node_put().
>> + * @next_offset: if non-NULL, on success it is set to the map offset 
>> just
>> + *    past the matched entry. Pass this value back on the next call to
>> + *    resume scanning from where the previous call left off, allowing 
>> all
>> + *    matching entries for the same @id to be iterated. Pass NULL (or a
>> + *    pointer to 0) to find only the first match.
>>    *
>> - * Convenience wrapper around of_map_id() using "iommu-map" and 
>> "iommu-map-mask".
>> + * Wrapper around the internal iommu-map scanner using "iommu-map" and
>> + * "iommu-map-mask". When @next_offset is non-NULL, returns -ENODEV once
>> + * all matching entries have been exhausted.
>>    *
>>    * Return: 0 on success or a standard error code on failure.
>>    */
>>   int of_map_iommu_id(const struct device_node *np, u32 id,
>> -            struct of_phandle_args *arg)
>> +            struct of_phandle_args *arg, int *next_offset)
>>   {
>> -    return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map- 
>> mask", arg);
>> +    return of_map_id_next(np, id, "iommu-map", "#iommu-cells",
>> +                  "iommu-map-mask", arg, next_offset);
>>   }
>>   EXPORT_SYMBOL_GPL(of_map_iommu_id);
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/ 
>> controller/dwc/pci-imx6.c
>> index 5f8a11774eb5..0d7f5e6d037a 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1146,7 +1146,7 @@ static int imx_pcie_add_lut_by_rid(struct 
>> imx_pcie *imx_pcie, u32 rid)
>>       u32 sid = 0;
>>       target = NULL;
>> -    err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec);
>> +    err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec, NULL);
>>       if (!err_i) {
>>           target = iommu_spec.np;
>>           sid_i = iommu_spec.args[0];
>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/ 
>> controller/pcie-apple.c
>> index 2e86f8fd300b..c780e3f9d14d 100644
>> --- a/drivers/pci/controller/pcie-apple.c
>> +++ b/drivers/pci/controller/pcie-apple.c
>> @@ -765,7 +765,7 @@ static int apple_pcie_enable_device(struct 
>> pci_host_bridge *bridge, struct pci_d
>>       dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
>>           pci_name(pdev->bus->self), port->idx);
>> -    err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec);
>> +    err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec, 
>> NULL);
>>       if (err)
>>           return err;
>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>> index 36547d7cf1d6..062beb5825f5 100644
>> --- a/drivers/xen/grant-dma-ops.c
>> +++ b/drivers/xen/grant-dma-ops.c
>> @@ -325,7 +325,7 @@ static int xen_dt_grant_init_backend_domid(struct 
>> device *dev,
>>           struct pci_dev *pdev = to_pci_dev(dev);
>>           u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> -        if (of_map_iommu_id(np, rid, &iommu_spec)) {
>> +        if (of_map_iommu_id(np, rid, &iommu_spec, NULL)) {
>>               dev_dbg(dev, "Cannot translate ID\n");
>>               return -ESRCH;
>>           }
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 953f2dbe0e86..990849f00e74 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -467,7 +467,7 @@ int of_map_id(const struct device_node *np, u32 id,
>>              struct of_phandle_args *arg);
>>   int of_map_iommu_id(const struct device_node *np, u32 id,
>> -            struct of_phandle_args *arg);
>> +            struct of_phandle_args *arg, int *next_offset);
>>   int of_map_msi_id(const struct device_node *np, u32 id,
>>             struct of_phandle_args *arg);
>> @@ -943,7 +943,7 @@ static inline int of_map_id(const struct 
>> device_node *np, u32 id,
>>   }
>>   static inline int of_map_iommu_id(const struct device_node *np, u32 id,
>> -                  struct of_phandle_args *arg)
>> +                  struct of_phandle_args *arg, int *next_offset)
>>   {
>>       return -EINVAL;
>>   }
>>
>> ---
>> base-commit: 9e94742cffb7541f55fa904a40c1ca9d836d303d
>> change-id: 20260315-iommu_multi_map-8c9b78490ace
>>
>> Best regards,
> 

