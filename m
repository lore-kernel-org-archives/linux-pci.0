Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBD3382F6
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332329; cv=none; b=NEkqRZEwfNoCgvP0yEqQCrNEF4/WGQRcx3tqFlGRFfMSG7EpVoONDwMrduh1mHZQ6ICgceVCZoBHkvkVJH+QMX6GByCsoZ90TijItYJtg1sOOymlRRO33S+09x/FYUv8jIrlOTHv14xJjL0+QQOGC6EmlxPozzXqHBnMi7RyNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332329; c=relaxed/simple;
	bh=hUPkT1zhYpLYkAp7boG9pkyg6+c4IVnIGGteN7l4LzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBhqVHOonJ95Dl8aZZx+wh7Yea6FXGN7laQX7iHixmCRdsvt7ib7ZquLv67BUAhupjbXM8EkZdCG1nm9NHx2YpW8fMV9x0PlMOFDVXTBvp1C5f4Mgp96IPD85Ld6r6J7jwHlGJLhRhXVAr1jSJAThg7djqwBCJ8ZTpOkxiLpVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SuBilnJU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idMFpQJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SuBilnJU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idMFpQJV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H6PN6E3392901
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 12:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C9wjG6wIt2pyRz3ySlbKKk4GcR27MIK8syv6fU161Mg=; b=SuBilnJU9kXq9Evz
	u0s1L9Rgj7fklgit1G4AClJjR5zmG5Cd0ajwWdRAqpgsW+gXjARITf0LALKqHp2W
	b/PjFgo1UsMq9M11+Bn5+dVwW3nfiuvPeeEyw0Y0Y2/JFtkwGn9cMJjBKjf7bN5S
	Ha1hg7afCH1ay+guGveWIHZS4y5V7jO/4BHAuVc5XIpWadsMIidRPz8+btzyylEd
	TGPCy9NwgqETcuYh9JZH9wmdDkdNnLxLg7wx4zoxkRRpJQlBhgen9nvboKtPSYr8
	EypsZYF/MLPnAWot7B7HNttgQrWbjDKIsUGa/j5mfJKi+KVl2FNmLH+5vEP66G66
	4p08lg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc5khaja6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 12:45:27 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c56848e6f53so2749919a12.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 04:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771332327; x=1771937127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9wjG6wIt2pyRz3ySlbKKk4GcR27MIK8syv6fU161Mg=;
        b=idMFpQJVVtx65h5kkDEm3kYHp7OkPg4WUbxyT5aqIG4EZR+BFuZksKLBTasNg2pOTz
         +t8KBKoeiYstemeYuK6v03+xcmqH1CtCDTmKEXCCBQckbmlHSvuCjXJ4KSp1v9iCK5gl
         HL40qHuJ/u6yBzMXnAHKNykBR/quZrBCtFOMQmOyr4ke1wZ38FIoUYUWdxYLT98T0LUC
         DGxq/0VmKyMcptWe53Ff55CdKWL9Ue9YQ4BOFxbeZ9CxcE+dTnaaAht4s93vuBbeBV5e
         9Lqz+QGZZkGB2guVHt/bNurA0mjeoeEfsqlqMa72rIYDZ6bnJImylO+skzZrcccby4bX
         ivFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771332327; x=1771937127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9wjG6wIt2pyRz3ySlbKKk4GcR27MIK8syv6fU161Mg=;
        b=INN1q2EaU2VJYQKxl9AmJER9/7WfweqYcQHBcvF/g4pz7DwORDWuSS2CKMVJniTWSf
         2Lb+QnxUM6hhqvewWcVXA2NhAe/QNZ/yzoFLY8CJepZhhjJJcCzLrR+b3SyWdJa+u2yA
         DVoaBeIuvLCQhf4U7RFi5gkkH6Gfgz8ySt2xjEJoZpJImxoTUV0G8hLpDTZl+IZXyXiO
         mdwHhiWnPa2caCSRn7CFhflLyz9cpWjrZ6+2H392SlnVML1mCGXt9ydiHGRJN/gBGEQo
         nDwkRkGkoH8bv1U2TKm2KdQIQvw7zsk48qJ2SkcmHLkEjaobziLnMabNtCQUxj6mDkm3
         pYBw==
X-Gm-Message-State: AOJu0YwWAs/LExtm1qaHHQfBhe73I+9QUv0loBPyyqT4xBGE9KNfhgJt
	0CoLpLxRZ/I/eby2QMDmp9BVMbq2umArR4N2tN7d/g6J+NYcytrxOpW4vczmCaxCmOL28jauTZq
	u7fhI0+JBYJfzHz01BhH9j4NkMGHGMFDV2jqKDJ/ik7wC13/ByvKerac9bApE05SPaZAyMag=
X-Gm-Gg: AZuq6aLlIACgu9Ar98eS24/5ZLdtRe/lRPka+fTL4ys88id3tSX45HuG0/OE169+/Ac
	LFu0NQ4JtVidLAH4zn7a+ZDJVwMJa+G9lCymB/CUfcS6tbPnovFYNNsfVJspncbYlBlzemQ51I6
	XqjCjYdveicfVOsrVCfxTEO0uC3zAAk5dRkbSj5Qe2OUewll/IWzdD3Pv2b8s3pikkECQqW5VSH
	49/+AGeF1tB0NCyRLhnRT6fJYQvlhUFdsz9BCsh/OmILE6LcK1ATRZJWrCoqk8tIkhJH6yep9TB
	FnELsZK5n/p0t7zUqBR0q8xeA7RTjbhdGKRPGWNSt+J9sxW7HJHYzfxS0wop4IMQYsSfP7reKYx
	CgxJVOfbM3JAhyBDszwULaAksBZlnZBkmo/bIWOZUTXlbhRv+Tg==
X-Received: by 2002:a05:6a00:439b:b0:81f:394a:4897 with SMTP id d2e1a72fcca58-824c95c129bmr14600360b3a.44.1771332326486;
        Tue, 17 Feb 2026 04:45:26 -0800 (PST)
X-Received: by 2002:a05:6a00:439b:b0:81f:394a:4897 with SMTP id d2e1a72fcca58-824c95c129bmr14600329b3a.44.1771332326026;
        Tue, 17 Feb 2026 04:45:26 -0800 (PST)
Received: from [192.168.29.33] ([49.37.209.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a4316fsm18224761b3a.23.2026.02.17.04.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:45:25 -0800 (PST)
Message-ID: <dcad2753-d57f-46f7-b756-564a9fa33f2a@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 18:15:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/pwrctrl: Ensure that the remote endpoint node
 parent has the supply requirement
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
 <20260217-pwrctrl-fixes-7-0-v1-1-b5671e58934f@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
In-Reply-To: <20260217-pwrctrl-fixes-7-0-v1-1-b5671e58934f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Coyys34D c=1 sm=1 tr=0 ts=699462e7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=GKJRcqtVwLtxJzZ0uxByqA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=NxiB_FYLZp7XA1DtkAQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: -ddu4_K6a6gYSUdtRakdL0A6y-vkXoWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNSBTYWx0ZWRfX59KkqOiZNOIN
 3nMvfA5KeE1X4IhD20HoCi0BZn6DDF4zWNxA1GmXZ2YiIpCOc6QHsvfRLKNYqL1mr9lIgILvQvW
 +QNLpJ1+TqNtMoYt/72eF1tgMyyzUKOmOQ005RqhO/c+CP1qLZ5IG5f7+cVsmWacTvx8baJNcD1
 OgEV9dWKkCwUCE/VWgJ0+hsl+UZAKwOH9//rddgZnOex1L0gmfd9mabZVbh0FnxN1g2JUZwzwrQ
 8cHYqkiY2AbGcXTsBmdPjncctWdGQKEDxomCmuRkZlKRJwX1hCGaoCL5QYuFdO36SfYn7iiZd6d
 dzwAOZ4cFN5POk4k2Wv+WPicz2qqdOGKW0VFuQLQJq804c+uyAyypRKi8WY/VMsC/SMmuy6W+c8
 Y74qH9K/gg7jFWxxizjR3ISjXxPYX9iyMgUzv10dQEEUh17A3BLiSsTwVdkVOm2KifVhIuLsKrO
 IavuG5N2Hx20EbOY78A==
X-Proofpoint-ORIG-GUID: -ddu4_K6a6gYSUdtRakdL0A6y-vkXoWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170105

On 17-02-2026 15:48, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> If OF graph is used in the PCI device node, pwrctrl core currently creates
> the pwrctrl device even if the remote endpoint doesn't have the power
> supply requirements. Since the device doesn't have any power supply
> requirements, there was no pwrctrl driver to probe, leading to PCI
> controller driver probe deferral as it waits for all pwrctrl drivers to
> probe before starting bus scan.
> 
> This issue happens with Qcom ath12k devices with WSI interface attached to
> the Qcom IPQ platforms.
> 
> Fix this issue by checking for the existence of at least one power supply
> property in the remote endpoint parent node. To consolidate all the checks,
> create a new helper pci_pwrctrl_is_required() and move all the checks
> there.
> 
> Fixes: 9db826206f9b ("PCI/pwrctrl: Create pwrctrl device if graph port is found")
> Reported-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Verified it on QCOM IPQ9574 RDP433 with ath12k devices with WSI
interface attached.

Tested-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
