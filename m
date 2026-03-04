Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6803932C5
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616915; cv=none; b=SAvQkoI5taID89W2vjgMq0zzeNa8nvy3gUjinJYtvqXzMQ8FePSgQa0/7GCqwvEsMrs3dEpwLQizwIrV0qonKdYSdh4HIcMw5+ReHuS/OB82DaUyk3JyZ9S+MrS2pClzUz4sZ1PE6yvx2sotS+PLZ4A5AMILxTcG93+7XIQS6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616915; c=relaxed/simple;
	bh=EzXD64F0RyH0zPAC4K6xzonp165P7LLftsQuyrIMX/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7kjlYp++/BO1uE0nsKHKJLR2fWZS0n9nvornICyanznc+eg/4iSg0F1H0c2TJD2YoqQ1hTKldzJGxjXNtofLMer0JBdaqXjShzpgCZbrEnHyKw3dPV1xme98xr3ZyXnvNZNaEU8b/UW6nvnFSOSwWQcU5QmrI3qhuTy8a18L0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g1/MgbWp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1y1eNiw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1/MgbWp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1y1eNiw"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SWRv1678050
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 09:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t80u5LhNs8dedbnLQe3vnPgp0bI1VMt5bD83HvKUNdE=; b=g1/MgbWp9GnnXzTd
	dYgjmB5pE0P9xO0EdT20U1vIXpi5wS3RFe61V/EBK+qRPr9eONuDqjb9UYV2umU/
	XCP7CoOKVrwU57sHnaAy4LUA4efHqaLUfjweLNBhhI7Q2qzZR8QazjyrvWniEyPb
	QQYK28Z1sRZka2ZE29KDYJXFNg/0EdRPi/TmeNbb4jH6w3G5fmFZKHC+H/PiUrdc
	PTgx64nHg5jzDRyyzQ51s1Le/VaT5IGp7W8hsfQ7Yb6zp3JOAUrD3gO0jK5zYDmi
	9lS2S2AOKeuSXQde+RvkHYShPDF/QlA7jTobiMPM3THAv1Ntk1wMS10nDiGYvKV5
	Hm/DGg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp73ha95y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 09:35:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35449510446so6346545a91.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 01:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772616912; x=1773221712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t80u5LhNs8dedbnLQe3vnPgp0bI1VMt5bD83HvKUNdE=;
        b=L1y1eNiwCBa+ZZtQCgTXBXCs+rmukmXwFehzBpg7wuwYDD8TGvzJqe9XRnfYuKYEAL
         Y5hmpRLXVg3mdKgyjZLyOBQrka4YQMwM2m497tpeLzqTVEf+8BGWlUDMiM0ntYcBzCQs
         v7jnu+72DZW5EDOsO+H51MNE/NcKFXyBqYzGkoIux49q3DiDjIo0o8IxEOd9jj1kS98G
         0nf1J9qX4vXCxd7StuMDpA3xnJ8BZZsLCCX9Ufb2o4I8k1XN9eSaxYQTn9IK8D4Ifcvw
         YQwsLlIIIRj3wcJPcRRdye1Wsdk2YWKBwQbszg4AjErIcqopW195iKcy+IzF/SQ95eDs
         zsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616912; x=1773221712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t80u5LhNs8dedbnLQe3vnPgp0bI1VMt5bD83HvKUNdE=;
        b=JkEFFS1ULoI/m2drvxxHYXGXjfhKkjKQAPg3Az3wSi+yQGLPX9xBT07ta9OP2S7cTY
         UywjxJrw6V+eLqmJjQ5LXjrPZwEn0lk16snPakdmM6mZ3wq1yVFYL1Iy29wZlII7xQh6
         3ft5UUe9pFdf4I7Sp4LXzlgBRVf+4mGEHCexm64ityjQm/uCVjObJz84M0ibHPtv9E1x
         AgWubIo5liVb3O9tA2wx6JmMEf55cvSj48YGSyLoZywfQI5wcjI0fBBCP5yinodfD9Tb
         jrebFmU5uSTkYnvolM2CTofwwPsdGMKz3gY56LJZXJPX4SzK4YIYA3iCMZjsj4GZSX46
         gWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCURUfGOBUbRKn7OtCnRWGbFmFgJ1xKVtRSqBlYAxCcBHRhruPMtAmdMAiWqhoUGQz3HITBROIJeBpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hS/OiBq6cB+YCBGd2zwOljhpwc2+1jeXo+CQZPN9nIgoht9J
	6O18uw/zz7vebjbn6iVu2uPyeS6uJiPdquCBhxuggeimDlwq0iU8nM9aMInmY0pek8RvPI/YVUH
	sNmKSZAC/2sJmmpq1a3e9YWaKzUL62jt7c4ZcrXuzoN4MgTa6IDH5wUWH2t5r76Y=
X-Gm-Gg: ATEYQzy2TfFpevbFa5DY+KFzY1CnnQh0XNPMoDBuvBOvmJ/ljrDleVkCTkJadEx+imJ
	RsnWlSDSjLy4dnyjufce1D9oqyyR3pCpy3lwVXht9+GQ+h1/WAJoCySVTkR96Xo4/2l8HOjW8LM
	zz1EiOb3nOnn/UTaFPNM41p3dgi20yNQum7/bLFa2c1j65h9emn4tR5NOadA6gCYKUrJvDOjs2J
	MJEovWuMYMy4G/dt0nJuxUNDXFeuNVtvpYsdXXe9E6vU8GW3QNPVDBMBmo3dpZSF034dril8sXX
	32TipyAyMdpebEE2V4eQt0V3XaJnPd0tnQ8fJpQBEBIjaxw36fmOnwy75vT/YM/E7ksEOzN0ytx
	p/bErba7q5x2meBcdSZxvlZ0Y9WPMFJzl0O/M9Bms97GHuZ+QVLhgckUF
X-Received: by 2002:a05:6a21:608a:b0:35b:9ba2:8cd5 with SMTP id adf61e73a8af0-3982e2036d4mr1560366637.56.1772616911569;
        Wed, 04 Mar 2026 01:35:11 -0800 (PST)
X-Received: by 2002:a05:6a21:608a:b0:35b:9ba2:8cd5 with SMTP id adf61e73a8af0-3982e2036d4mr1560306637.56.1772616910991;
        Wed, 04 Mar 2026 01:35:10 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73790f881esm1186795a12.10.2026.03.04.01.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:35:10 -0800 (PST)
Message-ID: <9aa4c1d3-713e-4137-8042-a73bea8e8f34@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 15:04:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] of: Respect #{iommu,msi}-cells in maps
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
 <20260301-parse_iommu_cells-v9-3-4d1bceecc5e1@oss.qualcomm.com>
 <laif6gacqyacvchnfuyhu4w3f4746xlrlxrr23klrgtkbn7dn3@rracfqemavwd>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <laif6gacqyacvchnfuyhu4w3f4746xlrlxrr23klrgtkbn7dn3@rracfqemavwd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7aT_wwgbOSg_Aoc-llXIkmre4A_7E2op
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3MiBTYWx0ZWRfX07K1/yg0T9YA
 +XAcjuf3ocmBtbWRdVmPkH4AGM0HGIUdfgta2txdznccE/zvEzoQ0IPc/efGtcMXNZkt5yvKY7d
 IBdX8vvcGorx5PzVfutzdKP8u1vagV3nhg6YG3QQOfMyWzHj3pELcc4Vo9j5kytCPPh1zxZbekK
 CgPjlLDSJFui0VSIWIZSeqMj0Br4DaZ6swWHYRTdq93is0B6WTQTM6VEkCqbxPd5hY2sim0XddV
 4L/jwZp7oyLPpwvs1bOmo1C+NKp7mv+TGuQ7rksMqOdrWZgWwkp+lFAdHhfqHhqK+PHrISg+CAA
 E32kvlWihGVAwZO3wBRd3SNR8GTgTigbe3a/K1FNvt3QnTuRJM2vLj40M5QY4AorE39ilpPcRa+
 /16Wfcaa7LomUX3nTfhR4jjNtGDlr02pHfe9Ngo4da03Y3YY9+U5QW/CuoIrI7ytmoZ1+08iv7b
 HNojeVsz4LnrZQ1+9tQ==
X-Proofpoint-ORIG-GUID: 7aT_wwgbOSg_Aoc-llXIkmre4A_7E2op
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=69a7fcd1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=FlLgGEtdp7AnL9SkOqcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040072



On 3/1/2026 3:44 PM, Dmitry Baryshkov wrote:
> On Sun, Mar 01, 2026 at 02:04:21PM +0530, Vijayanand Jitta wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> So far our parsing of {iommu,msi}-map properites has always blindly
>> assumed that the output specifiers will always have exactly 1 cell.
>> This typically does happen to be the case, but is not actually enforced
>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>> cells) - as a result we've now ended up with dodgy DTs out in the field
>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>> provider, despite that being bogus per the bindings themselves.
>>
>> Since there is some potential use in being able to map at least single
>> input IDs to multi-cell output specifiers (and properly support 0-cell
>> outputs as well), add support for properly parsing and using the target
>> nodes' #cells values, albeit with the unfortunate complication of still
>> having to work around expectations of the old behaviour too.
>>
>> Since there are multi-cell output specifiers, the callers of of_map_id()
>> may need to get the exact cell output value for further processing.
>> Added support for that part --charan
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>  drivers/iommu/of_iommu.c |   2 +-
>>  drivers/of/base.c        | 117 +++++++++++++++++++++++++++++++++++++----------
>>  include/linux/of.h       |  16 +++----
>>  3 files changed, 102 insertions(+), 33 deletions(-)
>>
> 
>>  /**
>>   * of_map_id - Translate an ID through a downstream mapping.
>>   * @np: root complex device node.
>>   * @id: device ID to map.
>>   * @map_name: property name of the map to use.
>> + * @cells_name: property name of target specifier cells.
>>   * @map_mask_name: optional property name of the mask to use.
>>   * @arg: of_phandle_args structure,
>>   *	which includes:
>> @@ -2118,18 +2145,19 @@ int of_find_last_cache_level(unsigned int cpu)
>>   *
>>   * Return: 0 on success or a standard error code on failure.
>>   */
>> -int of_map_id(const struct device_node *np, u32 id,
>> -	       const char *map_name, const char *map_mask_name,
>> -	       struct of_phandle_args *arg)
>> +int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>> +	      const char *cells_name, const char *map_mask_name,
>> +	      struct of_phandle_args *arg)
> 
> Some extra whitespace-related noise in here. Last line wasn't changed,
> so there is no need to touch it.
> 

Thanks for pointing this, Will fix it in next series.

>>  {
>>  	u32 map_mask, masked_id;
>> -	int map_len;
>> +	int map_bytes, map_len, offset = 0;
>> +	bool bad_map = false;
>>  	const __be32 *map = NULL;
>>  
>>  	if (!np || !map_name || !arg)
>>  		return -EINVAL;
>>  
>> -	map = of_get_property(np, map_name, &map_len);
>> +	map = of_get_property(np, map_name, &map_bytes);
>>  	if (!map) {
>>  		if (arg->np)
>>  			return -ENODEV;
>> @@ -2138,11 +2166,9 @@ int of_map_id(const struct device_node *np, u32 id,
>>  		return 0;
>>  	}
>>  
>> -	if (!map_len || map_len % (4 * sizeof(*map))) {
>> -		pr_err("%pOF: Error: Bad %s length: %d\n", np,
>> -			map_name, map_len);
>> -		return -EINVAL;
>> -	}
>> +	if (map_bytes % sizeof(*map))
>> +		goto err_map_len;
>> +	map_len = map_bytes / sizeof(*map);
>>  
>>  	/* The default is to select all bits. */
>>  	map_mask = 0xffffffff;
>> @@ -2155,27 +2181,63 @@ int of_map_id(const struct device_node *np, u32 id,
>>  		of_property_read_u32(np, map_mask_name, &map_mask);
>>  
>>  	masked_id = map_mask & id;
>> -	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
>> +
>> +	while (offset < map_len) {
>>  		struct device_node *phandle_node;
>> -		u32 id_base = be32_to_cpup(map + 0);
>> -		u32 phandle = be32_to_cpup(map + 1);
>> -		u32 out_base = be32_to_cpup(map + 2);
>> -		u32 id_len = be32_to_cpup(map + 3);
>> +		u32 id_base, phandle, id_len, id_off, cells = 0;
>> +		const __be32 *out_base;
>> +
>> +		if (map_len - offset < 2)
>> +			goto err_map_len;
>> +
>> +		id_base = be32_to_cpup(map + offset);
>>  
>>  		if (id_base & ~map_mask) {
>> -			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
>> -				np, map_name, map_name,
>> -				map_mask, id_base);
>> +			pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
>> +			       np, map_name, map_mask_name, map_mask, id_base);
>>  			return -EFAULT;
>>  		}
>>  
>> -		if (masked_id < id_base || masked_id >= id_base + id_len)
>> -			continue;
>> -
>> +		phandle = be32_to_cpup(map + offset + 1);
>>  		phandle_node = of_find_node_by_phandle(phandle);
>>  		if (!phandle_node)
>>  			return -ENODEV;
>>  
>> +		if (!bad_map && of_property_read_u32(phandle_node, cells_name, &cells)) {
>> +			pr_err("%pOF: missing %s property\n", phandle_node, cells_name);
>> +			return -EINVAL;
>> +		}
> 
> This will trigger the cells_name property check even if later we
> discover that we have a "bad" map. Is it intended / required?
> 

It’s intended. We need the cells value here because determining whether
a map is “bad” depends on it, as mentioned in description of of_check_bad_map
this is specifically for the case where the DT has an iommu-map pointing to
a 2‑cell IOMMU node but only provides 1 cell in the map entry.

>> +
>> +		if (map_len - offset < 3 + cells)
> 
> of_node_put(phandle_node);
> 
>> +			goto err_map_len;
>> +
>> +		if (offset == 0 && cells == 2) {
> 
> ... if it's not required, then the bad_map check can be moved before the
> loop.
> 

Given that, the bad_map check can’t be moved before the loop, because we only
call of_check_bad_map() when cells == 2.

>> +			bad_map = of_check_bad_map(map, map_len);
>> +			if (bad_map) {
>> +				pr_warn_once("%pOF: %s mismatches target %s, assuming extra cell of 0\n",
>> +					     np, map_name, cells_name);
>> +				cells = 1;
>> +			}
>> +		}
>> +
>> +		out_base = map + offset + 2;
>> +		offset += 3 + cells;
>> +
>> +		id_len = be32_to_cpup(map + offset - 1);
>> +		if (id_len > 1 && cells > 1) {
>> +			/*
>> +			 * With 1 output cell we reasonably assume its value
>> +			 * has a linear relationship to the input; with more,
>> +			 * we'd need help from the provider to know what to do.
>> +			 */
>> +			pr_err("%pOF: Unsupported %s - cannot handle %d-ID range with %d-cell output specifier\n",
>> +			       np, map_name, id_len, cells);
>> +			return -EINVAL;
>> +		}
>> +		id_off = masked_id - id_base;
>> +		if (masked_id < id_base || id_off >= id_len)
>> +			continue;
>> +
>>  		if (arg->np)
>>  			of_node_put(phandle_node);
>>  		else
>> @@ -2184,11 +2246,14 @@ int of_map_id(const struct device_node *np, u32 id,
>>  		if (arg->np != phandle_node)
>>  			continue;
>>  
>> -		arg->args[0] = masked_id - id_base + out_base;
>> +		for (int i = 0; i < cells; i++)
>> +			arg->args[i] = (id_off + be32_to_cpu(out_base[i]));
>> +
>> +		arg->args_count = cells;
>>  
>>  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
>> -			np, map_name, map_mask, id_base, out_base,
>> -			id_len, id, masked_id - id_base + out_base);
>> +			 np, map_name, map_mask, id_base, be32_to_cpup(out_base),
>> +			 id_len, id, id_off + be32_to_cpup(out_base));
> 
> Again, having whitespace changes doesn't simplify reviewing.
> 

Will fix this in next series.

Thanks,
Vijay
>>  		return 0;
>>  	}
>>  
>> @@ -2198,5 +2263,9 @@ int of_map_id(const struct device_node *np, u32 id,
>>  	/* Bypasses translation */
>>  	arg->args[0] = id;
>>  	return 0;
>> +
>> +err_map_len:
>> +	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
>> +	return -EINVAL;
>>  }
>>  EXPORT_SYMBOL_GPL(of_map_id);
> 

