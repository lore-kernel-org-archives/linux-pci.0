Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198383DCDAB
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369434; cv=none; b=gXRL4AEL7ouFj0dbvc3WTPlG9lpdWBZX4fi1Sw+obcHdKqRZGwR8dUIKR37QocWw4SBVw7QeyqE5Noux6I5qeeLvdsasd+vzeNCCYNYNxoxA/4qNzFvXB32mMyGruhGQeRha/bJ7dpaKVnb0MSYhX5wbz4GWa8U0D1DqiUIO8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369434; c=relaxed/simple;
	bh=rEhgf+plDqfF1iHQj2avM/Yea3aAhqW3nHftW6pqB74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l11Vt223Jxuq18xYANfUf8kYymj082VQDclfgtvIFpg6pEAJh5MXFVLoqfMyQ0ge0Wynv6swRTg5nZNK0FzJSScNtk1Z8RijPkdCB9ZBb8zu5oWatgNDA3kQqHKmv63Rs6oRu4GAG7aZLKr0oF269T0quc2sTf0IGm8xBi90hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ea734BEK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dnd055Jv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ea734BEK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dnd055Jv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99j7D3343451
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmO7s4tc6H15glCVZR685KG1G1WPxtrKnGHzx/C+V+o=; b=Ea734BEK4zzY8HN9
	dRe4nY6EwO5Of9FRXTucovvLoxFUPnte+pxxMav2GdWaRujH5HbfraS4yvQ1OmWh
	nn5mBu8OX4R2nMlW1OhviVXvAss93qKoYXXzZ+ynfv65bpdCwWTrgtfpst5pXtAu
	hsjsL+8iCG+wglqEmBf7fsfwELEvE1N95VwS3B8PgyzzMtYhBzIEu5NjafEopK67
	mmr5VJD7xmHMFJzXqr/FNFtMK3bNDuzTSHZlJOiC1AePUV2WHaHqU6wZyPegal8h
	gEpNIVDnuCa6lhdn0wp5dJnxf9ExgcX9GVZiNW14LFXDtox4ldqx+KMiunXb2aFX
	XtqEdg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahseyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:17:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b4654f9bb6so59754955ad.2
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779369431; x=1779974231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmO7s4tc6H15glCVZR685KG1G1WPxtrKnGHzx/C+V+o=;
        b=Dnd055Jv6/aDuFFzvfoH0x5ZaNvRdnBSeblzkSSledC/hQgKRwtaoPlEm6zfkoRq+R
         DMpn72qBl9G2gI4R6vuMVqcdFLSY2dwQrX7dHKZSl/xpzka7rxI9g4F22Nrxcua9dchD
         yF+WxtdwUfkKJJfBZNiVJfG75PxgC++hJqPUTLBSCemcKnK4tpgoCznwrWJRj5eygZcS
         hLBY4rwI1DIuJsNmH9Jd9CPHmxAJ6iHGCMjh3aNlvKMrEq1QS0CbcaEstfigc090+uF7
         j9PvtlTn0rc9A8SYN4SYjB46lvAZcCZy2LvNf2Lc+3lBEp2NCAbvHfVba8slCyJwMG5D
         5Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369431; x=1779974231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmO7s4tc6H15glCVZR685KG1G1WPxtrKnGHzx/C+V+o=;
        b=SJotEH0TBAImcl2tgfiQFhavqjgdygKfqZtv4TG5OJf173xHsGkjBt37HN9c8Xsg8A
         2WGZrKgVGGkv7vkTM/gNdzW0QRmSaNr12CNSAS6guQTkUpVXK/i8w8UFvbpFoNrsiOD7
         ziGjXqIphySsRxq5POewLd+QZu+oIDA3wCG8Z9U0lxRCdbl+pXhPW1uFKBoAPBJmYC4U
         iOScgV32Mg3uvdDFp0diCCgzRu494mGoUj335lnE6B4IgO9HPihHh2K/k80EPatUOcfG
         lpaD4Zfcj81VNwtzZBUlz98ZwIxsxNVd7Q9n2+zqtf9loM6jA1Xmd1DwYNVPmMHdlhhr
         Hb9w==
X-Forwarded-Encrypted: i=1; AFNElJ/4tgc0YXiAGOz2MQbeh/Tb+SSlkmyUF6Cf+u6VIpCq1bBctUuGo5VgGZQLMm7FdZqTdBUqPi8xDao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqDfAHLKNOGHeFfNKuc5tP27Ud4cXmA34yGdmrMXn1LXd0Ed1
	qKGlvRFr75RMg7W3WiyX4GGFzXbVJ7hi6UTZm27T2i+O2Be3gfXMn/qK3mK5LxgypLTI0LR4x7T
	SW7rR/mSgVZiMtN/EjFBseDeu/Feb33mZl6NtpLTXU4kp7iTQDOtms/V1ouUcSMI=
X-Gm-Gg: Acq92OEM2N3LuDXPBAHZ8TlUB36OvqE19G6UTRL/E6eY7WNvIy9okpUSESoAgyFjq1c
	qkdM6OuW4uhUih/aro16XHXlJlKVkmiGxfgVR39zTpfardpth6ggXeYbxQB5qVEiTYboliL1BLY
	3sFergnWmT+QT2NWOkHyyovC+nIKFF+KL3tIV1s6kOMr71nz/yRM/5u/8EalK1PEqTXGA8DrysF
	HCpksQ0u12Cpt/4vdPSVI5YF3Qf9R0yqS8ICNvH0ui/mxtxIaBxbsGDHBm/zsS46JziDze/lXjL
	p0NkwIV4SkM4+gYXyOFuARDDCW+BT1V/dp8EkfwHnxhvDRmWSUiQtz6Ub8KJ3WvDfpXOfoFqd16
	XXWZIvZfvxquFU7geIQFYDmokd+d4dmzh4B3OYHKBRnTro+Dc/PfOMqCP2g==
X-Received: by 2002:a17:90b:3c89:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36a4561a294mr2766050a91.15.1779369430695;
        Thu, 21 May 2026 06:17:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3c89:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36a4561a294mr2766023a91.15.1779369430119;
        Thu, 21 May 2026 06:17:10 -0700 (PDT)
Received: from [192.168.1.9] ([205.254.168.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cb3b3edsm3705303a91.3.2026.05.21.06.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 06:17:09 -0700 (PDT)
Message-ID: <4eab296c-1b5f-4767-9e66-22af3474bf67@oss.qualcomm.com>
Date: Thu, 21 May 2026 18:47:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/3] of: Respect #{iommu,msi}-cells in maps
To: sashiko-reviews@lists.linux.dev
Cc: imx@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
References: <20260520-parse_iommu_cells-v15-3-b5f99ad4e7e8@oss.qualcomm.com>
 <20260520092923.0EDD11F000E9@smtp.kernel.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260520092923.0EDD11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMiBTYWx0ZWRfX1qu3ydBp+qNP
 45aUqF5HcB7qT+lkkwMTgmCebz3rnkEvDn5In165N5naZK4GekqaLuzQcBLr+jcvoNY+VSKD4IZ
 BODUMG1pkp0ePdoCRpKa7P4AFBvC0+OpRMax6N8RvNyMEFsRRr6yehBoqxyVJMNkuvBq+4Wq9tG
 oiy+g1zKXopSpV8Qj2SdHSzRazsHi9k5Gu3Hh4+FNQuNWZcSe1fwS+zUhQBc+rYItTs47ZdXAhU
 7AnsC6asC9KYRr21oU7ZydOvbNkp2ak3d4biyZ9DDxZS39sSffaSELUAIP8lqM6d7W8AfFmMEJt
 yxoMPHRZmdQyJQXUPZK8ZVczIzaWwt8W8YijoxqY1PtnKVRNys7OANYa5FC3GJKsxJqKDfPA66Q
 CiVVOJl/bAi5SDYOWMkpJOcnSZmWo3+VLF/w578QBjYniQ26L3thxIJLvx7ySbuyuIzopRZ2NB5
 oIR1XEmo7uD2cry+CkQ==
X-Proofpoint-ORIG-GUID: eG0fUA-VSP3BvjZlj8-AK7O-2SSuMAuU
X-Proofpoint-GUID: eG0fUA-VSP3BvjZlj8-AK7O-2SSuMAuU
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f05d7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=49gMqqAeKCh39Y98CdGbvA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=h-5JRy4KEujm8fWzgV8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210132



On 5/20/2026 2:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Strict requirement for `#iommu-cells` or `#msi-cells` breaks MSI allocations on standard-compliant controllers.
> - [High] Array desynchronization when parsing legacy 0-cell maps padded to 4 words per entry.
> --
> 
> commit 23cece64ecb1dcea6290dbab34facbdac53ff293
> Author: Robin Murphy <robin.murphy@arm.com>
> Date:   Wed May 20 08:02:42 2026 +0000
> 
> of: Respect #{iommu,msi}-cells in maps
> 
> This commit adds support for parsing target nodes' #cells values for
> iommu-map and msi-map properties, instead of assuming output specifiers
> always have exactly 1 cell. It updates of_map_id() to parse multi-cell and
> 0-cell output specifiers and reflect the actual number of output specifier
> cells.
> 
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index d658c26201353..f436e26763818 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
> 
> [ ... ]
> 
>> @@ -2176,39 +2206,93 @@ int of_map_id(const struct device_node *np, u32 id,
> 
> [ ... ]
> 
>> +		phandle = be32_to_cpup(map + offset + 1);
>>  		phandle_node = of_find_node_by_phandle(phandle);
>>  		if (!phandle_node)
>>  			return -ENODEV;
>>  
>> +		if (bad_map) {
>> +			cells = 1;
>> +		} else if (of_property_read_u32(phandle_node, cells_name, &cells)) {
>> +			pr_err("%pOF: missing %s property\n", phandle_node, cells_name);
>> +			of_node_put(phandle_node);
>> +			return -EINVAL;
>> +		}
> 
> [Severity: High]
> Does this strict requirement for #iommu-cells or #msi-cells break MSI
> allocations on standard-compliant controllers?
> 
> Several MSI controllers validly lack a #msi-cells property. For instance,
> arm,gic-v2m-frame nodes do not require it. In
> arch/arm64/boot/dts/qcom/ipq5018.dtsi, the pcie0 node defines:
> 
> msi-map = <0x0 &v2m0 0x0 0xff8>;
> 
> but v2m0 does not have #msi-cells.
> 
> Prior to this patch, of_map_id() implicitly consumed 4 words per entry and
> succeeded. Will it now fail to find #msi-cells, print an error, and
> return -EINVAL, propagating the error through of_msi_xlate() and breaking
> MSI initialization on affected platforms?
> 

I see both arch/arm64/boot/dts/qcom/ipq5018.dtsi and ipq5332.dtsi both have
msi-map pointing to arm,gic-v2m-frame nodes without #msi-cells.

The new strict pr_err + -EINVAL breaks MSI on these platforms. I'll fix this
in v16 by defaulting  cells to '1' when #msi-cells is absent.


>> +
>> +		if (cells > MAX_PHANDLE_ARGS) {
> 
> [ ... ]
> 
>> +		if (map_len - offset < 3 + cells) {
>> +			of_node_put(phandle_node);
>> +			goto err_map_len;
>> +		}
>> +
>> +		out_base = map + offset + 2;
>> +		offset += 3 + cells;
> 
> [Severity: High]
> Could this cause array desynchronization when parsing legacy 0-cell maps
> that were padded to 4 words per entry?
> 
> Prior to this patch, of_map_id() mandated that the map property length must
> be a multiple of 16 bytes:
> 
> if (!map_len || map_len % (4 * sizeof(*map)))
>     return -EINVAL;
> 
> Consequently, if a legacy device tree targeted an MSI controller that
> explicitly defined #msi-cells = <0> (such as RISC-V IMSIC nodes), it was
> structurally forced to pad the 3-word map entry with a dummy 4th word to
> satisfy the kernel's length check.
> 
> Since the new logic computes the entry stride dynamically as 3 + cells,
> when parsing a legacy padded map with cells=0, does the code advance by 3
> and incorrectly interpret the 4th dummy word of the first entry as the
> id_base of the second entry?
> 

I see there is no real in-tree DT combines #msi-cells = <0> or #iommu-cells = <0>
with msi-map/iommu-map. All in-tree #msi-cells = <0> nodes (RISC-V IMSIC) use msi-parent.
If such DTs appear in the future, they would need to use the new 3-word entry format
(without the old padding), which is correct per the binding spec.

So, No changes are needed here.

Thanks,
Vijay

