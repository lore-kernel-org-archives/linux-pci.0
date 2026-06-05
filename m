Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA33B4EBB
	for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2026 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622882; cv=none; b=brAHPociMjIHZfZJ+YRq/qCGqiNOF/QJdhuSIZgxkBiMX+5kj9l+FEF3Z6WE9opa90DzzlmxCagAuK36J4Fcj5RvV28vh+eOQqjt4s1U11sEUVDNPm3EOrj3r4S2QfUi6pwdOXqV+8PkPsgiioQdcFRRoBOa8iXBSfX7/xhWZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622882; c=relaxed/simple;
	bh=BPZVrj40PVQeeFYswAnpcpt11XBFHkwvZ6MLK/ulGc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1ZXllKpy11egkwNX706aq6ITlFgZ1kKZ92dcZE7ii7IgDTZL9ZojaDHBYSdqQt8K5VGujSSGEFkGlOJGioaCVkZaIBHLNa3LsPuSyAiJqicWpt5+GeV3DhttLwowun9Nz5uPLHDb3h4kFLy8hNNuZs3Ks9UfWlUqdvnYHc0Sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fCSuqVjD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NMdPwyZ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fCSuqVjD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NMdPwyZ9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654IQBkH1813865
	for <linux-pci@vger.kernel.org>; Fri, 5 Jun 2026 01:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YKl6JvG/MrQiHrQ3H0zajo7ZT+v04oiaR1ECHAlix/I=; b=fCSuqVjDBJ6//uZ8
	FWdCZLm1q9CeCNkW2Z/XVi29RNAnlvkL5kfsvSdtMOoHKldgtiSGE4cXzkrz2aSq
	E8gTmAyWle3wgxeNaox9pNoCPSZqRlhNMihGzDqDgBAnsmgPU9Pm67glBhNw8JpT
	JUa4zY99ScBBV972Hnalkhk+UkTt3d5w4fEzXZS+3dJ+mlocVr4un//F09Vkq9bM
	qvYMp4Vyc2AlcrrXrt+G3UnDbPSw6JbdHAx4+orAPdKueoLjme9atT/UHgoGjvoa
	JofjWnRrKWOwxOLawcThqPSSURnJBF8szNronotaDkrfCnQXUwCMiE7R/NV8IVDy
	5Xk78g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eken01h65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2026 01:27:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304f23c55b2so1200676eec.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 18:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780622872; x=1781227672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKl6JvG/MrQiHrQ3H0zajo7ZT+v04oiaR1ECHAlix/I=;
        b=NMdPwyZ9P+YlxhKOwqbTVv+UNMr58djzEHSDpa0fxrFNkT5w76O7vKp03fm+5T5rKX
         FDvW4ul/Ys408RyJXV+defAHrWwdkL5P9IEmCJEoiG+vpyFuFWtusQrTIhOg+PtmZuGA
         /El3ueAO+PCcZooBh/WpSf1tHWYskJh619bseny9Z+9xfVn0/pKTddstVyRCoCWREVPy
         iTUa65GLObR2CSlfB/oWNxJIEtSIWs0eQu19n2SmoaOk/vwP5lK2Ts/2w3Hn7qx4Jcat
         +sKNULSoVlPtIgiwPpgpli2S6GuWYJIpnrmC78rKL//6yqDTHMfiB2NbsRFg0XmyxJWt
         rfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780622872; x=1781227672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKl6JvG/MrQiHrQ3H0zajo7ZT+v04oiaR1ECHAlix/I=;
        b=VGlBXzGQWBKfcl8ZLWxKUIyWfVOrQCckfpcPXCv/1fu1V84IMlEkiD8Lp8YOj8GoRd
         +BpQsgKglVWfAtGAait3jnaTuFMSF5rfN4TMu4+blB/RxrzxCFpI+FE3qUHe9MOCy1Ce
         edPdfvwvwv+gm9ecNED/mHQ9ZWj9FkPDH4ownRaE7RLX+Nuub6rlq5L+tj1/6L0fn3KT
         RFQvL+DJgeBm3l+/2BPRC0JVTygaOGWjGcarueKW8QcKwiqQh/MaPFzqPX6OgBIG7BVA
         FLbz3KtbqmzdwvuE8hP/rhfssn4wkI/k1+MqnX5Cta7x903IWbkG2pFGIgFtnydOYdVU
         XKmA==
X-Forwarded-Encrypted: i=1; AFNElJ86DiEO5RXmzlFDG6yUGQZMONbFEuNWixuDhaabI8JmrYUoxn7zRVxH/GG1KoqXMoPxd/5pn2Qx650=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyV/XTVtkkyGVF1FkyxyUAAzImWj2rB4KeEAfD/RWhOA7dcfnG
	b2JQ9qQP23jkqP85AQ3dYqvrX7nA2ccGH5fAkAr9ccslCWniXMXIx5xwx47BvdfAgVHInU+3aI3
	fY4RKxbrcqisx5D17JgiRP5aCP97mICrFgHAFqaQaFh+slbxfayMZvKB0fHEqpvg=
X-Gm-Gg: Acq92OEwqnXEqApYGKkZkNXDqeIE3Pv5a3qsNAvzQhRKRglDz6EwtIjSzlOCw89uKWD
	a3QYa41Zrkt/ziABpbHI7HHhyp8HVpgThu5rDfOfm+J5B0rdQ6MyOvMhE778E6OaJmXpEpT5hpp
	1NfDLm4AxuKr2KIKUBbc/LY8gLTSFQq/sA+glDQ2M0+WNuHnTYDz7lzECJPhDDxlnoxyISfui8M
	Wnjic4eJo/KOf+5UrblDh81mub21bJtVWVhvB/b+np5hzlgTqv6nctkiPUWqbhT6MYYc8CUW9qC
	w8a7Whl/aLaVF70ORS728msjjHmUdBqWAvQwk/Dm5UPOfIydhZzBHYzOAQ2Hd78zGhg07wP2elE
	l/yPt0nhpuQLIIEmY4Ok3xXvyX9tNOP/rflUg8IpAd3B6LUpjGBsWB4Q2hkxUe94ssgDNva+R3T
	CbPhn3a4KiaZQkZA==
X-Received: by 2002:a05:693c:2c01:b0:2d2:96e8:1bf5 with SMTP id 5a478bee46e88-3077b32a4ddmr630085eec.3.1780622872434;
        Thu, 04 Jun 2026 18:27:52 -0700 (PDT)
X-Received: by 2002:a05:693c:2c01:b0:2d2:96e8:1bf5 with SMTP id 5a478bee46e88-3077b32a4ddmr630068eec.3.1780622871935;
        Thu, 04 Jun 2026 18:27:51 -0700 (PDT)
Received: from [10.71.179.79] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm8526270eec.8.2026.06.04.18.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 18:27:51 -0700 (PDT)
Message-ID: <078551b4-049a-477a-a538-a02c8c7c18d1@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 18:27:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add PCIe support for upcoming Hawi SoC
To: Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
 <20260530-mutant-gecko-of-anger-ce8803@quoll>
 <76bb3e5b-e4fa-400c-b7fb-98f95c7a068a@oss.qualcomm.com>
 <CAGyK6coCyziKzffGmj+fGs4U+mXEeYJ0Q2+z6xHCA+i=gop2oA@mail.gmail.com>
Content-Language: en-US
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
In-Reply-To: <CAGyK6coCyziKzffGmj+fGs4U+mXEeYJ0Q2+z6xHCA+i=gop2oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxMSBTYWx0ZWRfX7OvuZwvUB+XP
 iHi8qGGFJYxZzRGx4LR57a/HFNancPzl6hMmbysE3yYZT7mBEqJlP2r5f4aF86HqT5uSdAI7Gfk
 BW5HzivJ5jx3OJbUQk2bVtUjwSEZwbjoTZhyO3NtZWsmC8wzUKOz+vS3taLkAwAmm10yVOTUSKI
 k9IAyIwLN5FtVZjLwLtR5bLtGu93kpl6zvoWCIS4MYRpjPvIOgTxw1jmZgwaAgsIIOj7LpaVVy4
 OGxCq4bCPL5osMAKyyLYT9iKwSRShrPOlP7+1CZewYDwOzVnHY1SmjbJrckYg2t+d4zyHCF0JDl
 2RBOBauuvpijTLXAvIHhCIFUGMBI/OBdRRKgKl2qVMCyt6M8zJXBde5iUyg3Di9/HYuVAiq8AWE
 XJo9tWwGhS27f5tKP+ndE1afYZDw4v+NJxTkQ4egef7UifW+SNbj42we89MiC851dbRikP0R0CF
 DQOAkvs6nwyY0pebQEw==
X-Proofpoint-ORIG-GUID: MZlyhqIi-_IsjrMfE1F1-Xa9cZsLgFJm
X-Proofpoint-GUID: MZlyhqIi-_IsjrMfE1F1-Xa9cZsLgFJm
X-Authority-Analysis: v=2.4 cv=B96JFutM c=1 sm=1 tr=0 ts=6a222619 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=U4w5n6qQ5FTTLL6fV5IA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050011



On 6/4/2026 5:09 AM, Manivannan Sadhasivam wrote:
> On Wed, 3 Jun 2026 01:26:53 +0200, Matthew Leung
> <matthew.leung@oss.qualcomm.com> said:
>>
>>
>> On 5/30/2026 3:06 AM, Krzysztof Kozlowski wrote:
>>> On Fri, May 29, 2026 at 01:10:07AM +0000, Matthew Leung wrote:
>>>> This series adds PCIe support for the Qualcomm Hawi SoC. The Hawi
>>>> platform features two PCIe controllers: one capable of Gen3 x2 operation
>>>> and one capable of Gen4 x1 operation. The first patch adds the device
>>>> tree bindings documentation for the Hawi PCIe controller, and the second
>>>> patch adds driver support by enabling the Hawi compatible string in the
>>>> existing qcom PCIe driver.
>>>>
>>>> This series depends on the following series queued on linux-next:
>>>> - [PATCH v3 0/7] clk: qcom: Add initial clock controllers for the
>>>>   upcoming Hawi SoC (Change-ID: 20260316-clk-hawi-1ad4cad36d6a:v3)
>>>> - [PATCH v4 0/2] interconnect: qcom: Add support for upcoming Hawi SoC
>>>>   (Change-ID: 20260311-icc-hawi-d6dc165f8935:v4)
>>>
>>> It cannot depend there it makes it unmergeable and untestable. I skip
>>> review in such case, please follow standard documented practices about
>>> decoupling independent works.
>>
>> Thanks for the feedback. On checking the dependencies, the changes are
>> applied in their respective maintainer trees:
>> - clk: applied to qcom/linux.git for-next, commit d6cd9d5692ba
>> - icc: applied to djakov/icc.git icc-next, commit 07548b04dc36
>>
>> Both commits are present in my linux-next base-commit and have checked
>> dt_binding_check passes cleanly.
>>
>> I can resend with the dependency references updated accordingly.
>>
> 
> No. It will still break the pci tree when this series gets merged. Please
> resubmit after v7.2-rc1.

Okay, I will resubmit after the dependencies merge on mainline.

> 
> - Mani

