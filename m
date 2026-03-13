Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883033D6EF
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385426; cv=none; b=RdWo13PzpdHMb9U6R554qOB80hY5Ex+TUF8BjlPEpqtv9DcPjeih8J0XQw7dpaflZhXPJ5yO965F7El4WlPkyiOsaaAQdaT76jBCFVKbIdnEmC3g1KDhkv5/STu2+ozGbTBZ+t9FM0it8F1GhZwzp+Q2KpTgELFfmKBEd1vLQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385426; c=relaxed/simple;
	bh=Rn8wHtCLMEv57Olj+9qoKpCygPJwlSOUIiqpDelPERk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoW2ZM3QpDOEDPwt/swpDiN+q1jKaApKc9jK1D5S+I4oQgNGTTR4yWqTtCnS0zo+8I17SFdJr3+7Es6P/S9GPMFYFQzrb3Z31F3D9EctOVNYmoH+ScDfl+rqrt4OpwLbGAMjOa4svvL67JUrzWfxgTbFwMs5D/mO13tQVK1vH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I4QKlM4U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CPzWt83P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4QKlM4U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPzWt83P"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tcab070541
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zEP0RLQ1FcdKjb0SaePafyEpkf9Bx0Hizh3a1ioi+V8=; b=I4QKlM4UymqKZXFP
	PKcF6zPyg9UbFQB1MYYkLiw8zjs/DVth36yYp6nHYC9Bsbn+0TT52kaJ8YyqGOnl
	9NkkemP4jZekyiG9CF1W5hMZzhvJ4A8UXG0WqdGInso3z7QaZr1eEtGNWNq9E8h/
	CRRF+St3t7p16Ku/zcj2rbMB10hgJofduwIhsqWlW1lHIrKM9/y+DKkTvnVPQ0IV
	AKomOC8lIJluZlqDlNOzkYzsIHIXy8pJwFTKjsvrhJjNbjaVtKQ9X7k8fsxT3bN8
	zrAGV2dl9nhRvY5kgZwuXr+v7cKFUiL7csF6Gt1Dfq/wAtaRt9rS0NjbZ/VFn6j8
	AJpQng==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4ymwkr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:03:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aecd4f7c37so4884835ad.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 00:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773385422; x=1773990222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEP0RLQ1FcdKjb0SaePafyEpkf9Bx0Hizh3a1ioi+V8=;
        b=CPzWt83PMwARBsvHOylBdh4EU9BB9bRNMKHvc5vtVxM9GM8n5ncpqaMfWsqDsPleY5
         Scj+uoaHp6gffbUQgIy2Z3iefub05VbPB7f5U0sWqg+WOzXWApW45jzK9G19BZRw7Dj9
         g6ctr8dkUlAUpEXgs2dy68GsyQOP1wcYOZq3r8URDTXaOTmBeyf+I0w7gTO/RS8FO8Ny
         MKFQWxqTEuM5mB6pU3H3fXt/vU6O1ZlaL0Qnj8vEf+qb2rp2epY8D6ZrSEQ6kJTqg/Ou
         U2tpm4dVnEG5XAD5YQTBwgV76ykJd2WH2fgk9l28NmsX8TbqGplIhgwNjCIk6sXtcble
         JciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385422; x=1773990222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEP0RLQ1FcdKjb0SaePafyEpkf9Bx0Hizh3a1ioi+V8=;
        b=py6UOhe8/SaVOccGA7kiYi7bTsi8g5NkFQ48nNRr56S5WHbG+QxLUsjpLL2vCDsdLe
         0yc8eXhDgk3B6hUhu4mmFGgfZnAkU6IRetEzW7Ej8IsYPgnrXz7J0IOdWeb6H0t540d6
         0rIv9r+TBsbUxQ+LFoAMJHVVRbhCw33QqKHpZKIaxUa0s4VSta7esZhQUTx6ULGlYKcR
         j//ISUCeqQA7+yKBfbAmr/15WqVcCBQmyjTCEJMNoM0kHUGhwSU+b8lcc65Vg3OoHRQ9
         +CIrAps8MIETP3rWU5+fzrCqvuab9nvDqVMCw+r1aV5ZlEkIZBiFDCGAv/eo5aT6KleB
         XsOg==
X-Forwarded-Encrypted: i=1; AJvYcCUCYT3zZ95rVs6YATrZRqwhovZyLJL42ejJ1lg1G8idlAgw9f67AiMN9X3rqiiRu9WVF4J27aFGziY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx953HI5dGhI5NAtYeXgvOR/Sip3mrTVNgBasTJJpVj/jV2SslH
	+jUP8TtKeEzH55+hmT+/a7+Ep+uA9UGnlCp4SfS79QM68RwKwFPhTLHc4BgsxkHFVUxiQfa2IwQ
	LC54+/+fwZuPLcw+K0R1J6eJoi5bUzzZVy+XXOIyLhW3Bcha6kFtvIuMnSDMPQ2U=
X-Gm-Gg: ATEYQzyQcBOXUrPrBhpyijR8qYj+IgJPgYKZzInMVcZOpYPyXYveRo6vv+uf84UYA1k
	qXP9VmFt1L5VIdCm4FPb3QUIDrWFmZGz214GZPtxA1JnyZlExIkuXo2XVQ2uUoetIdeCnC6Sw+s
	52DhWTOdZ6FrERFiGfYxNFOrr50+b5oKA3UMIFoPf725nzW0rtuUX7drCvBXMmS+B6POqqfXWbY
	wLFO0SLudDk0rTdqPObtzEe6E/1fZy/AvjbBui8g2CR2NPfSbAJl5OB/gXzx2h2/MUBll1ykAaO
	qYmQ3k3VfLpfRfbZeuau7hY/nOZ7Po7SjmuxEb5qOVqk/oVY7wwUfd59pZ+jCTM7RMm0ZP9Pd0o
	FVryYXqyThAAFNdAk3GorcO0FI9q+Pw6/vedcy5Tm+q/f8+SL/xhwuA==
X-Received: by 2002:a17:902:f690:b0:2ae:5a70:476b with SMTP id d9443c01a7336-2aeca9e0906mr22825655ad.15.1773385421939;
        Fri, 13 Mar 2026 00:03:41 -0700 (PDT)
X-Received: by 2002:a17:902:f690:b0:2ae:5a70:476b with SMTP id d9443c01a7336-2aeca9e0906mr22825295ad.15.1773385421470;
        Fri, 13 Mar 2026 00:03:41 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62d0easm15764975ad.39.2026.03.13.00.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 00:03:41 -0700 (PDT)
Message-ID: <54798338-83b4-4088-b2b1-52c3cde960b2@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:33:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] PCI: Add support for PCIe WAKE# interrupt
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linusw@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
 <CAMRc=MdF92kriuT_-Fbk3pj6YeJiNv6RSiDE7aB0AKL9oFZg5w@mail.gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdF92kriuT_-Fbk3pj6YeJiNv6RSiDE7aB0AKL9oFZg5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NSBTYWx0ZWRfX5pnMS8+L6cRY
 dGZ1Ac7D9DrGYTmJbdidrwCbK2y12JNqmjgrptOEj0TqzwxcWV14yIAYlYI8OxUWY432AfIcCyF
 Zxma2ITbiTlZIjctDOJmWQTxeVwzgCP0zMXOmeUpa7dCBnHDoxBeCNvwakqPwmbqWe+wqT/rktm
 8l6WlXfFcXiPVr02APay+kcT6WNWbPR4rANtvtn78Y18bclq0sRBcYX+bWI4xi3fjDPIjI7oX5x
 XZx0MBNjVDBrsiofw80nR3Vel+TOxlIH9NeyHLueF5WO4o4A5KSvND+dslpBji8O9y0oqiUilfU
 VPKLAQWiNOWAJOVEyJna84A5icLOFFKLrZabxmzodBOYsu1T9s16yld+2z9R3nYsltl0WAzgbEw
 D3Ab9e4P+eUEE2zb4zOYUEn3OXjm9l9rQB8f2Yrn4VUa3dcxaVUofBlxytb5FvczYCKDT/ubGJe
 UvA1sPsfeLOrej/md4Q==
X-Proofpoint-ORIG-GUID: rvPuzvmc07zQTk3K0Nu9QhRpVTyOGV3J
X-Authority-Analysis: v=2.4 cv=C+7kCAP+ c=1 sm=1 tr=0 ts=69b3b6ce cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8 a=s8YR1HE3AAAA:8
 a=XA70DKTrLd0yiFKK3swA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: rvPuzvmc07zQTk3K0Nu9QhRpVTyOGV3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130055



On 2/18/2026 3:31 PM, Bartosz Golaszewski wrote:
> On Wed, Feb 18, 2026 at 9:12 AM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
>> PCIe WAKE# interrupt is needed for bringing back PCIe device state from
>> D3cold to D0.
>>
>> This is pending from long time, there was two attempts done previously to
>> add WAKE# support[1], [2]. Those series tried to add support for legacy
>> interrupts along with WAKE#. Legacy interrupts are already available in
>> the latest kernel and we can ignore them. For the wake IRQ the series is
>> trying to use interrupts property define in the device tree.
>>
>> This series is using gpio property instead of interrupts, from
>> gpio desc driver will allocate the dedicate IRQ.
>>
>> WAKE# is added in dts schema and merged based on this patch.
>> https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
>>
>> [1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
>> [2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> This spans three subsystems, how do you want to get it upstream?
Hi Bartosz,
we can take these patches through pci branch, if all maintainers give us 
the ack.

I will mention this info in the next series cover letter.

- Krishna Chaitanya.
>
> Bartosz

