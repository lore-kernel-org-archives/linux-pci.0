Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32E40EBAE
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785235193; cv=none; b=O32NoA7prqvP4LNK0m0887cZolb4WR1clKsg4j67b9uWLYNmjuSs3oo+QdwL7mXOd4ovAbtQmw4MdOJsGqCMlcO+dTkOwWMGL6qsLeEfYuwDe4umrjnL1nS68sVjfurRbeEvIiV14Yd1NFFrPFWHeSu8I7yZPDiin7N5s+ykFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785235193; c=relaxed/simple;
	bh=mxUQnlQSOxQ+Qt6gXpPnHetW0JqV7Pc0c+ZHgP5GFes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEgMJdt0GGvXPRHoNliYVVXD7iaCoNrQjBDwiJgH5QCRbYVCFm2qwvzejNL+N1NyavbXbGMZX/q+s0ATgu+OzuDb/bbZryCnL5JaLVqCvLmhRLeW5vph8JVlsVl7Qf84oK+k0Elh2IxcBtarssp9kdS5f+QXRXH9IZeSdwe9Wzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iNnNA9ef; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YkTxTDqP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iNnNA9ef";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YkTxTDqP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S823QT1663736
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 10:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tSdcsk71nOjiqCkvXi2nOvJunCqAD9QzbH9nuI5oGcM=; b=iNnNA9efeNppXLMI
	ADfqnOz57Fup/AKKZao5OkovTB2j41hia1B62e6iILnw9Y7pzqFv0wGa10RfB08r
	vxX9GZWNFUdPU/B5D3JzCTlxx8xlvh9dJ5Z8vqPHZDbmfF3bVqgh5iEz2W9zjQta
	LcKdd1FRuxNdlJDfz4e3ynGGSscGi5e5wJyV/FFBfES5TElAacixzs3c5wOIp6jt
	WMFKB3/YaThUZ/7YhzwgW62BP6nQbsPZHRZMUyWxvPEFXBTZpuIGlkZxXbRiOOcL
	rUDpU8K4mSp/iPWhIAiqao5cGwoTXij3eMc81bs9/5NEFEIt/eKHndwsRCOJk7M7
	yJCDtA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpptts4pg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 10:39:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so959782a91.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785235190; x=1785839990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSdcsk71nOjiqCkvXi2nOvJunCqAD9QzbH9nuI5oGcM=;
        b=YkTxTDqPoUEuCYSja0IN4/d+xoJ5mJp0k7RQno5mzAZ9Iu6yXSz4wwZXeC4+58Os5n
         e/5PpMuT9uVrjYbHZrNrRW16G5DT4N/xQaHGSRN3i2t30abfHuqoCkfEY20o6ILWC4H2
         gsJH/ePSBafmNdhHU+Mbf8xjt4lOa5MmlkgSmdYvTv7RN/6Lrh/vfWa6epXYPufKafwM
         DD12pjoFpO5SB2vCZyvL+w6T3FzOKfI3X1leyvCVuVgv/hyKxUL78TiBhCFd1nQzPx4m
         2JktZJLXGmQ3LFc7ZKMjdKvbGAuSXXF52wZ06d9XuyDQt4t8dH/oWOVXu8EOQ/MkDub5
         ovjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235190; x=1785839990;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSdcsk71nOjiqCkvXi2nOvJunCqAD9QzbH9nuI5oGcM=;
        b=hIEpKhZigLK8uCubCcUixh+qhKeTmC0S9cXxwxSapdRH0nD2o6if+ehmNEJRsCNoUZ
         Vq12mEde6Bi8qrO/hhY7p9iIGTkDkCYBYdtE+VCc2iEkJOAwkVLVXRdD0BAZaU1o8XxI
         Na4U7jVnM4qZdXPpa0VWVfDAmpewnIPx2Ab7Ts2/CkrfkLvcIXICzzfclm96P890FlKu
         d0QhMGKivvl37m1UutM0tvTTsrZ/qpzCa5z8o2IJcSpwEgK+qQFSuybx8fZe7d/Is6N4
         RpgjCLbmtWI3lDCiWt2OZjpU7HuejmKo9A3MEjAoTQ6K1QYDr6SGcHc2p/cf35OHR2yk
         6Gtw==
X-Forwarded-Encrypted: i=1; AHgh+RohYTLGqkXhK0kk8mbbiY2J5E6MUYzliZrzFoucVD5l2WTAcVFNWQ+cV1Bl5zmHNW1rs50jjyh/Zmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRLAJgwFblSDES4jLTY/lNhRDGfUByj74WEIjMJrLnyqRbsGO
	q+fK/NKr0FJPgUV6fRPmWI1lWUkLAjxkvwcA0HIomUn5Bb9TjhQ/A//3Mc2103Ns5py/g6m7XJj
	n5f5uMu7m4WVwUwVPXVHyhZSciXrCfCPMaUQXjN/5T0qkLcV8NAHgleOSAIns2bI=
X-Gm-Gg: AR+sD13fSZc6z+dlyCvPay1lthjaaLw1Y2AhBpNdBfIVDWAtC3UXC/NPvLWd2RZk95O
	uKHgVaVV3klOWS7ICf8nVa1Bq7fFXYzKUHjI7xSnXhmh2JI/prY0WmHsdPi1a2rIGPeDS6X8EY/
	I/l6Y7CIg3K0jPws49ZTOud9eX4LaH358RMFRZPm+FqJIqCNyF29ypInbVvzNcxe4QcPDq0jy4i
	neSZqJGa3aRYHgo9cf/G3shtPoEL7bjYWFp86rPSlHRRyhUO5C7ywR06Znzf9llbBMRrfAnmsue
	lQeCDU+n+bsa1UdiQ8NXjymp/Rnp7UHH8Q6nwd/9VyYRqc94+m9Ia4y8bAAzySCQTeMheLeQRzS
	3efygz0QAe/dBrt8gbQheVMkFt2gmoZGYBbFS
X-Received: by 2002:a17:90b:4ad0:b0:38e:4e61:c9e with SMTP id 98e67ed59e1d1-38f6a36a11fmr1788756a91.21.1785235189902;
        Tue, 28 Jul 2026 03:39:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4ad0:b0:38e:4e61:c9e with SMTP id 98e67ed59e1d1-38f6a36a11fmr1788716a91.21.1785235189339;
        Tue, 28 Jul 2026 03:39:49 -0700 (PDT)
Received: from [192.168.1.14] ([103.28.245.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08968de4sm4269200a91.2.2026.07.28.03.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 03:39:49 -0700 (PDT)
Message-ID: <569bd4d8-2d77-457e-a0fb-388180c34711@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 16:09:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/3] of: Respect #{iommu,msi}-cells in maps
To: Robin Murphy <robin.murphy@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nipun Gupta
 <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
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
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
 <20260603-parse_iommu_cells-v16-3-dc509dacb19a@oss.qualcomm.com>
 <3f5c974f-425d-47a5-9fda-e05de1f39d79@linaro.org>
 <0d0896af-a4a5-445d-8db7-fdb9eecd07a2@oss.qualcomm.com>
 <69b1235a-832b-4a00-bcfd-f51991d23488@arm.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <69b1235a-832b-4a00-bcfd-f51991d23488@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MyBTYWx0ZWRfX/B2u470KHIkd
 +mtiFrDNcamAtTwUdDy28mjcWTE3fec1D+0+jo9xGHHKHOghmUcPBRD3v20nV02E0ep12fRMNp4
 QdIZEJb9TeeONfhtaZEf+iUQvdPSCvY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MyBTYWx0ZWRfX2bZzdk41EuK1
 M+hEq+bqpqyNZTfXlJr+TJQbStFwkIhJZQXUgqh8HXgFBpJBg2yfLcKEFNbsN582WCQY6N3t2cf
 Kf/3FCYzQyfnwOJ8Y5rDrd/2D7MT+z0XnXxMZo89mh/4AbBDaCI0BwHsuR37QORNrCFOQLupd9U
 DKZIBM0gOtLptwBgwwU1FbvbsDPl9vBjTKRjHQvDPTYGScmoLzLZ/GzkLuGZUKozU+ydb48okmM
 idnUGIaY7+AGsTOwqp4h1Zeok03Dbh2s95pNELcAWbs9PSgljSq3JOvnboazQTfXCryxlso4vC0
 ThAzPMag5K3hiSvRqHOvDNsFc8OyOv6K8q9JhJyx3/tCM2NaIS4Vg9c+ni5ZsOsyANKie3O1LGX
 MD0L070l7Qtq5BG4wSHhh2LeT2bMgoka5jI2uERHPGuLmK5GtdMfS0m5rtkvUm/ORH/m8zE+ugy
 dYEyY/8U7RLImbmII/g==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a6886f6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=4Zb5+qXS4S4qhaWSJ/zCzA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=g5k_W2lUybaQNBh0X1UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: UJp7hl1HLvlXKAIe9wWLKr2p4NA7UNiM
X-Proofpoint-ORIG-GUID: UJp7hl1HLvlXKAIe9wWLKr2p4NA7UNiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280093



On 7/28/2026 3:34 PM, Robin Murphy wrote:
> On 28/07/2026 5:05 am, Vijayanand Jitta wrote:
>>
>>
>> On 7/23/2026 6:47 PM, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 6/3/26 09:13, Vijayanand Jitta wrote:
>>>> From: Robin Murphy <robin.murphy@arm.com>
>>>>
>>>> So far our parsing of {iommu,msi}-map properties has always blindly
>>>> assumed that the output specifiers will always have exactly 1 cell.
>>>> This typically does happen to be the case, but is not actually enforced
>>>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>>>> cells) - as a result we've now ended up with dodgy DTs out in the field
>>>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>>>> provider, despite that being bogus per the bindings themselves.
>>>>
>>>> Since there is some potential use in being able to map at least single
>>>> input IDs to multi-cell output specifiers (and properly support 0-cell
>>>> outputs as well), add support for properly parsing and using the target
>>>> nodes' #cells values, albeit with the unfortunate complication of still
>>>> having to work around expectations of the old behaviour too.
>>>>
>>>> Since there are multi-cell output specifiers, the callers of of_map_id()
>>>> may need to get the exact cell output value for further processing.
>>>> Update of_map_id() to set args_count in the output to reflect the actual
>>>> number of output specifier cells.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>>>> ---
>>>>    drivers/of/base.c  | 168 +++++++++++++++++++++++++++++++++++++++++------------
>>>>    include/linux/of.h |   6 +-
>>>>    2 files changed, 135 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>>> index d658c2620135..ac7961cbab94 100644
>>>> --- a/drivers/of/base.c
>>>> +++ b/drivers/of/base.c
>>>> @@ -2116,19 +2116,49 @@ int of_find_last_cache_level(unsigned int cpu)
>>>>        return cache_level;
>>>>    }
>>>>    +/*
>>>> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
>>>> + * specifying only 1 cell. Fortunately they all consist of value '1'
>>>> + * as the 2nd cell entry with the same target, so check for that pattern.
>>>> + *
>>>> + * Example:
>>>> + *    IOMMU node:
>>>> + *        #iommu-cells = <2>;
>>>> + *
>>>> + *    Device node:
>>>> + *        iommu-map = <0x0000 &smmu 0x0000 0x1>,
>>>> + *                <0x0100 &smmu 0x0100 0x1>;
>>>
>>> So the sm8650 PCIe controllers has:
>>>
>>> pcie@1c08000:
>>>              iommu-map = <0     &apps_smmu 0x1480 0x1>,
>>>                      <0x100 &apps_smmu 0x1481 0x1>;
>>>
>>> and
>>>
>>> pcie@1c00000:
>>>
>>>              iommu-map = <0     &apps_smmu 0x1400 0x1>,
>>>                      <0x100 &apps_smmu 0x1401 0x1>;
>>>
>>> and apps_smmu has #iommu-cells = <2>, but gets flagged at wrong:
>>>
>>> [    7.538800] OF: /soc@0/pcie@1c08000: iommu-map has 1-cell entries targeting 2-cell #iommu-cells, treating as 1-cell output
>>>
>>> Returning false in of_check_bad_map() triggers:
>>>
>>> [    7.642680] OF: /soc@0/pcie@1c08000: Unsupported iommu-map - cannot handle 256-ID range with 2-cell output specifier
>>>
>>> I don't understand the issue here, we use 2 cells as expected by
>>> the iommu-cells, so why is it wrong ? can somebody explain in
>>> comprehensive words ? I'm super confused, it worked like a charm until now.
>>>
>>> Neil
>>>
>>
>> Hi Neil,
>>
>> iommu-map = <0     &apps_smmu 0x1480 0x1>,
>>              <0x100 &apps_smmu 0x1481 0x1>;
>>
>>
>> Entries here are not 2-cell format, Even though apps_smmu declares #iommu-cells = <2>,
>> this DT only supplies one output cell (0x1480/0x1481) — the trailing 0x1 is the length field,
>> not a second output cell. (<id-base phandle out-base length>)
>>
>> The new code detects exactly this pattern (same target phandle across all entries, length always 1)
>> and falls back to treating the map as 1-cell output for backward compatibility — hence the pr_warn_once.
>> It's harmless and expected, your RIDs still resolve to the correct SIDs (0 → 0x1480, 0x100 → 0x1481).
>>
>> The second message is a different case and shouldn't be coming from this same map — once the 1-cell
>> fallback triggers on the first entry, it applies to the whole map, so you shouldn't hit both warnings
>> together on the same node. That error only fires for a genuine 2-cell output specifier combined with
>> an id_len > 1, e.g.:
>>
>> iommu-map = <0x0 &apps_smmu 0x1480 0x1 0x100>;
>>
>> (<id-base, phandle, out0, out1, length=256>) — which isn't supported, since there's no way to
>> linearly scale a multi-cell output specifier across a range of IDs.
>>
>> Are you seeing that second error on the same pcie node, or a different one?
>> If it's the same node, can you share the exact iommu-map entry that triggers it?
> 
> I think Neil is saying he bypassed the fallback check so that it *did* try to parse the given map with the real #iommu-cells=2 in precisely the way you've shown - so even if it could have got past that point, it would have then blown trying to parse the second "entry" of just <&apps_smmu 0x1481 0x1>, since 0x1481 almost certainly isn't a valid phandle to read an #iommu-cells value from.
> 
> Cheers,
> Robin.

Right, I get it now, so when it tried to parse with iommu-cells as 2,

iommu-map = <0     &apps_smmu 0x1480 0x1>,
            <0x100 &apps_smmu 0x1481 0x1>;

Above tuples would look something like <0  &apps_smmu 0x1480 0x1 0x100>, where 0x100 from next tuple would be seen as length. Hence, the above error log.
And the next tuple <&apps_smmu 0x1481 0x1> won't be able to get parsed as you mentioned.


Thanks,
Vijay











