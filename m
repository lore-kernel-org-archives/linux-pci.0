Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83F451981
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136355; cv=none; b=XZ94N3E+1FcA7gXXeoSsH0003uvJ5p8d6vRBkEMmcrazLDZlFbpBbQSUFNvz0cvmtb7NW1Baxa/GL2dNsV2RY7RFQvuHRqMRXXOibgztZTwZ9qOdN5DdroKOCGQQMeYE4aw1lnCtmF5t/pOMUTwZDYdJLp1gfLNxJmQP8zfzCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136355; c=relaxed/simple;
	bh=7okmRphLqV8C5vyS3WimCvmgoZ6DsPPFI9j8IvYB7uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIvoV5H8BxvgD5TNO4ZcSU2vVywcXS05oMspuJslWt1Jgk98RNaa4ZtaOiJpFqhrpSQ0PxBjFnkU47Y1GF1PUSUMOx21cTQ4HksvIRmpsfDTa+NM5NQ0YlAd1whoycYsC/k/dx4vougEbXWiPsANW5cDQy5qGp8A7e61fg40dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Co46MBwD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WP0h6+O7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Co46MBwD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WP0h6+O7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JA7ol22947193
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 10:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7okmRphLqV8C5vyS3WimCvmgoZ6DsPPFI9j8IvYB7uM=; b=Co46MBwDfoTthz9H
	QUJcEP7G1NtTj/GjNlYPAmkJ4C23VHtndBZeLywQoTUXEJhm1KdLSPcefv5OtiMm
	kytkQfJjol1dhzLJjl7Vjsjwa4nNTFYH1bZ+EgVK3D3uwBQS0RMnUla2pPXGnSPf
	rTWIbigDOKCPKlzFPCfC6zFURKvyCHNJK7Hrw8xRz9nFSowDEpNvccqc+NKUuZ0l
	LVDR2iXxf8Rr9gNa8Cw7qk3tTOeNRQAdpba4GUGqEOIXG39waoPwiEcY0f6R2Iqb
	c9HhuohQxoqq5hY+zO9zY4dstT4rwIjsie8F0lt7CUrfJQRSjCDPTNsooCpzJvHw
	zSxYbw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkasbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 10:45:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93495488976so20714285a.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787136352; x=1787741152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7okmRphLqV8C5vyS3WimCvmgoZ6DsPPFI9j8IvYB7uM=;
        b=WP0h6+O7Ja6vL0jj3f44DmPt0JNRCRwcVgTm9AJizilDwt9fA7sg93iy9XWzXS2YI+
         lvIjhvc+7r8XtBnWu7qRb9VvPG5svDiG70LdDxbVdW8qYvHOeBCDT2RUy8JgchlHvsLg
         4bo64pEv72viYkUZqaCP0MLM2V2AvFEIvNPMmm6TR0gjgLJ906EYzyNlzqOmWzSW3bR5
         Y3WuGqYlN6MeebJ9Xu8ATE6avCqihJhTMpPAaSrzBufNAQZjhy7h1kOaG/O1LXgrnazF
         PXSv1JJXrOizAnGKfT1TyT7HjJag0aGnwPc7ZQG2J1bT9Pow1rrmlu5otFqXrD7NhYLG
         i1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136352; x=1787741152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7okmRphLqV8C5vyS3WimCvmgoZ6DsPPFI9j8IvYB7uM=;
        b=q5nU5kBHjPxN0d5DOVeai1+rMlTdH6AGgBC7LD6eS6ZpqBUVlvHNFGBtyNSeicJuFf
         7quD0dkzusnCVjJrvdM2zgUG19TACdaW3AaeBGY1n5Rxu54FIuISloEpI7IXWA1iC6qX
         KxU+Mazt6ciuxsanu9kDppxy8jVJo2uMsWWehFp+uFE8jImi5aTh5ye1fpyIQKAxXosW
         v9XZSRE0tj1CYV8vJyIq/i8vg7syW/u0uC5JrgiER2pPBzS+7dNhVwAERvte4bza2+/M
         39UGWQDO+hXRhLBecf/dvnVh2NybI8TkNVo8VDAoko2w/oxb5HLjhXmAenQaFtLlOOPL
         o2LQ==
X-Gm-Message-State: AOJu0YwuMPPnT3xPk7tDdXAifpDm1pOCOvQjHuIm/mNn8w+ItNbqiqOu
	oCydAo9G7HcKjMN3DyF2sUMdyIjX5gH9PNUHf+GncRfmFjyfZmN3tBeMLCR6Jc+PR0ntHoceDe9
	bwl3TScvn0HKo40PnZ/PDAfXlVsPndSgKCW1lW7PvaSltOePCsd6MbctcA0vXCWQ=
X-Gm-Gg: AR+sD10obcboyGkBmTL6L37TElNYvPYqTvPWWnV9pjQdZGxd5/6ik2QjmRodkX+tuPD
	BGFtlZr8EyrpZNJWJN60EbF2nDrXnv4IemAeXgTYF6NgEszI+K47L9IND4flXY+sRrQVaXJGiUv
	ZmTDRTdtWwUeUDUkQM+kE2b/5s8eP0CeqCwAZLq1r8/MLm/yiXV0wxBHsj0Su4eZZYft/lGcTad
	uSzG5s9vXVkhho64HLDv6j6KIQyRhsgh4UuJD7LY8pLtB/7kA0vwpHvRJeJnWz70H2B0UTiSgEt
	+JR8WsAlmfqivaezPpbqDH+3o+QkBSAv9dDUczArx5v8X5X3zw9UMHOg362XWKA36ZdOAY/ILmv
	yIVbJyeY758VB1ccDg+GfHrIr
X-Received: by 2002:a05:620a:4614:b0:92e:6485:f640 with SMTP id af79cd13be357-9371e7024camr222458685a.4.1787136352016;
        Wed, 19 Aug 2026 03:45:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4614:b0:92e:6485:f640 with SMTP id af79cd13be357-9371e7024camr222455785a.4.1787136351495;
        Wed, 19 Aug 2026 03:45:51 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9f4asm749470a12.3.2026.08.19.03.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 03:45:50 -0700 (PDT)
Message-ID: <f4f25633-668f-4217-8e64-d77a38e4770d@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 12:45:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Add register dump support for PCIe Link Down
 events
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260811-regdump-v1-1-f22db3fb37c2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260811-regdump-v1-1-f22db3fb37c2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PoGjqQM3 c=1 sm=1 tr=0 ts=6a858960 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6SV30oLp8BWL7HE82y8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4MiBTYWx0ZWRfX0usKRBuKxdEH
 kGd1pGucTKFgfuTAPlTL4yd4YnRlFvFltQFNMf/wYpyWhSZBT4PQuaRMwvgKXrCC9obkBdo3TZ4
 08hsgUUmDP83x4arvkGXcb6uT9HzIp9PBCW96HUOarumjml/7CiTsi/dWUo57/ogr7jv48v39ab
 2jDZqnugDdYHlBh//dSCb4oWQJU8msb8fs0HpcII0slCxaRHEzcOLzJf3ECAdYC+i0tnKbORDFz
 22AGwvIE0A4agZJmXJw6WM3v/W8EBw9ebPNb3PDseftRHKg3kGUk6nrCAtfwPxx02SREbC4YiAy
 ElDtNBuf1VlDH19AR2SANcPU2qEJ9/vXBqx1Z2Gte6Gpd1yH9w9W/MBROv9OP6Tu2pDx+OIzlu9
 Ge4D5UilhQrFmohzbHarZpAXEfCM7or419QoNqtgHUH7KE7/cqbekOL0Vm2WlpgKtcA5yET7rpl
 93EKwwz1Szo8p3yCpmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4MiBTYWx0ZWRfX8OamOecD6Znc
 frmd01XHnehzWUkcLCc1gngOk7tXcdf684Yhbo/AiqE0siIn7ZGCYY9dyba6UjeivAPtQtQG89S
 LgJzgK6umyXwl37tVvGkhu7chwJPOuE=
X-Proofpoint-GUID: J-EvWSPXaXUnlp64xBvcKERRyHrg8FqQ
X-Proofpoint-ORIG-GUID: J-EvWSPXaXUnlp64xBvcKERRyHrg8FqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190082

On 8/11/26 6:12 PM, Krishna Chaitanya Chundru wrote:
> When the PCIe link goes down unexpectedly, being able to inspect the
> state of key controller registers at the time of failure is valuable
> for root-causing the issue.

In this current form, does this patch not cause the splats to appear
for non-fatal linkdowns (e.g. hot-unplug)?

> If a storage endpoint is present downstream, the dump is printed
> directly via dev_err() so it is visible in dmesg immediately, since a
> devcoredump read from userspace could otherwise race with a storage
> failure. Otherwise, the buffer is handed to the devcoredump framework
> so it can be collected from /sys/class/devcoredump/ for offline
> analysis.

I think this is a bit too much, a single implementation is enough.

Konrad
