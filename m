Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1852329E6C
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586240; cv=none; b=YI3KkvOYpt82SXvsPoaB1IC5PQBztO8ewyo51J4bQLtAz/i8B1+mV8RRCCPpu4X08cvcQ5hyQy5NABOiWqCAlCRVTcOJ5ZuJV+LtEmtc7soIk5mSukPEHb736Xsfft24BeroInTsm/rKn6QXsBT71QqYukzxLwHfkydO7+Z23ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586240; c=relaxed/simple;
	bh=55eRzc49XQKfDWS1O8dxkPsHVhg/QwtdOvqGU6X75Ys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jsZLrOFTjjMA6E2cBkJ/oFJ+q/bBx8uJVFz3J3tDwc2gXkFZVUUYhXav39NLdbLrPrx7dOYtKWfmMzI15dgLTrUizb9yX0iDe1Mz+XToLAw2+DClBE4MCP5syGDORPrDcDbaQcZGI8xIMBQwWL32uSdXFGWEhgNO/WPYd8zVyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AUgM11EW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KUC+Hbwm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AUgM11EW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KUC+Hbwm"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654CpGae2477902
	for <linux-pci@vger.kernel.org>; Thu, 4 Jun 2026 15:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bFw7BY85jww+07T2JWkvw4wi2HmXdSajOuwYTRkQLFg=; b=AUgM11EWzaUpyFeW
	a/OQc4yjCOmDKPqU78As5F4myfGzoLHBKrbYLSI0nHK+2FSGTPy3n1YZ6h7l29kW
	EvNYbmoxR8AHrnEf5lX31xn5Mgfc8ViK1XZL8xvrsFHLUK6b2nWVrIlOQbt1C0BG
	9/gTryi3LTiEyJvEfbkD35XC81IYdtiJhPmMKV2CYTsSjQOt2iVv1cXkFgiFerPi
	KuqtEkqv0A06u11rGWhFLhsuu4qyQixIvUfJZV81LW9TAPKw07d/gsJ/F0k6JCG7
	5o/6AZhRtaBbYTc5ewHGf8QjSc54gSjpKHPxuhq+FFMZs0ejbS5kq+qO51EIdN//
	Yy9T0w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvj1fb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 15:17:19 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59ece6adf0cso723422e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780586238; x=1781191038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFw7BY85jww+07T2JWkvw4wi2HmXdSajOuwYTRkQLFg=;
        b=KUC+HbwmNnoe+BxqUqTtjHCeW2/BE9OeqjFsMACeiztUVOtL2Q4c0EJJl6euDtTzGG
         eAftvDFSbj404fR/AnmTy23UhjJweLAAPbKcjwOeXFijMm07tjtKUc+8Sl6oB7rsOnwS
         LnptYwFMOZ9iGmGRW2GNVINrJ2CjMMYZ8c8Ic6OgcvCg5+uG3Eq3yBAu3NjTTDgOr6pw
         WaPZWSsw/q2NZwfZBo6lQz8GuaZoDZScJpj8aC0fpC/AQBHxm9jCDhesl4/5SfS+Uxtb
         bnK0wEX5FB03/uy/2J85AaDbhtrHgCYD/OxIfdbasNuoMCsOlXvIZkijmfkDd2HPu89Q
         v7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586238; x=1781191038;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFw7BY85jww+07T2JWkvw4wi2HmXdSajOuwYTRkQLFg=;
        b=UOQNZhaI1+lg5Ar64AlTC/imIIya6DcTVU05D+SPJCVsYA6jNCXy+V1FysRpCqADSO
         cURQcicvMhrFhygV0Z8SDgVAMYl1TzdoZvYFR1IaQ0iLGtQcdvQs+6xOkZ7kgokfzNwl
         DBteqOEX5VNxFae3LvV8VxYv9JKlUT1GzfPUZ4nLngiHnjTOqHDMCo5h5QJ6daxS/Xjq
         x6GzlwfgbKiyr/mywE+8W/k1FHA+3C7BYmao5P9QUBkJ/Q4fC64J6AEF9vmqoQNmFbW4
         fyNOaNKvU1IMbEOnNC8hcjN5As7dVVqMtyiY3YorFvVnX+BArIkOS+xu4FvtqIuJEExA
         qVWA==
X-Forwarded-Encrypted: i=1; AFNElJ+c7Ll0g/ImOXQyJS48ei6lZ13J0PegCGpNlhK0arU+w/OlwU0WCcFDhvlFtgNfZm2OfwFQp8sPa/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvTvUTU0OeAtLmSe7gh8X5M/n2XW3aH4oOBP/A7yQr3BEQO6Z
	VcF/jxDwFyrg4dn4SsRPXh8KRAgQVND02XVcwXxZzTqzhqf9r6Jbg0lBXOXpDU65nR1wzPvPppa
	E2R6fjW3Wbne3Hyk5N9E+/9MTln5arQR8qxI4tqhuOivO9+dT2sX7uNFoQf8tglo=
X-Gm-Gg: Acq92OHlnvkgh863RXCE3NL8eGPAwwBCFkc1/4+abipighJYGb6aHv3qydYKpZGvVMe
	O7yHXakXCZu91DxPfsrlxNcGqlmSFzMywBiIWAP/fChuZVvDHD9jpK95VPoY/wmzOxJn505u0zX
	WyTJv2hKPVwYz6Q3iZGy+WOXx3DkuzMaQzjBTMFzHbn+lK86p5gD7jZJeE38Yw1V3S3N+prv2it
	Du7S4D4k5c1+HJciFfJnvqLJTCuZM8x8+4oZx8ToQKn+2SqQ6lUKReOCf983Ar1O1kmxFszFOVZ
	0od5nP+VpsAbMCVCKXTB51gbsKkLwvzHPk1oO9HgkrF943sx7g9ecziyVT7Wswkb5voCq/NHIwn
	BT2rZwEe46bWfNrgAvyjowe09JJVibqfvfsJ1pLmt3+B1j9BDEm6GLegs0mff
X-Received: by 2002:a05:6122:d0a:b0:5a4:6680:64f0 with SMTP id 71dfb90a1353d-5a6e521209fmr4600064e0c.4.1780586237850;
        Thu, 04 Jun 2026 08:17:17 -0700 (PDT)
X-Received: by 2002:a05:6122:d0a:b0:5a4:6680:64f0 with SMTP id 71dfb90a1353d-5a6e521209fmr4599998e0c.4.1780586237214;
        Thu, 04 Jun 2026 08:17:17 -0700 (PDT)
Received: from [10.128.1.107] (2-228-54-83.ip190.fastwebnet.it. [2.228.54.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm85165085e9.1.2026.06.04.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:17:16 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Yadu M G <yadu.mg@oss.qualcomm.com>
Cc: shawn.lin@rock-chips.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260604122418.727274-1-yadu.mg@oss.qualcomm.com>
References: <20260604122418.727274-1-yadu.mg@oss.qualcomm.com>
Subject: Re: [PATCH v3] PCI: qcom: Initialize DWC MSI lock for
 firmware-managed ECAM hosts
Message-Id: <178058623569.8794.8357357263848810603.b4-ty@b4>
Date: Thu, 04 Jun 2026 17:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: d-ahoanKNS8zSCp8fjoiHWBvb92wokl-
X-Proofpoint-ORIG-GUID: d-ahoanKNS8zSCp8fjoiHWBvb92wokl-
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a2196ff cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=F4J0OHcPalsv3C1teIDEwQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=sfCulqXE5xkfyo85eKEA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0OSBTYWx0ZWRfX2aJNeY2+F12T
 Kcu8jQtOEV3ZNxHG4/VKuQgj91X5H/QbrjcncZ2XaPYovepMZHmeHCT67Opiey9GuRHJz6pdGP0
 NRHNrhUqzbHz3X/6NIx0vqKgzQpVFv8Rq47dYBfYP3jMrjkZ+v0mbu5warCg0Y7U7lM37Mmbwlh
 MgXrFxRmiYemeWAZDADt3ZBIkKtoei6i4jPG1AXse2CCerz6Uke/yZnc7rsBopB3iQMQo2Tq0gc
 RSG0d+CwSuFgeQeKrMxi1pvPppxK9e9AU01t5GEbmfbCVlSb9FtjAgs5yRel9kOWGtUYXibyom+
 8Mtn2fi9V3k+cX0yHa1SmNPSXLbKxEjf7EckxTKOUiI3j4fpdcmft0910nXuGShS2sPkOlQp+kb
 2xLARJv20enWNvbwQBuKU7nFTzjE6gB0bcExPneuBDLZVaf13J8B4r55w69tRaiSogXZURk6tsx
 Vis8EApiTq7JNWzB6zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040149


On Thu, 04 Jun 2026 17:54:18 +0530, Yadu M G wrote:
> A lockdep warning is observed during boot on a Qcom firmware-managed
> platform:
> 
>   INFO: trying to register non-static key.
>   The code is fine but needs lockdep annotation, or maybe
>   you didn't initialize this object before use?
>   turning off the locking correctness validator.
>   ...
>   Call trace:
>    register_lock_class+0x128/0x4d8
>    __lock_acquire+0x110/0x1db0
>    lock_acquire+0x278/0x3d8
>    _raw_spin_lock_irq+0x6c/0xc0
>    dw_pcie_irq_domain_alloc+0x48/0x190
>    irq_domain_alloc_irqs_parent+0x2c/0x48
>    msi_domain_alloc+0x90/0x160
>   ...
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Initialize DWC MSI lock for firmware-managed ECAM hosts
      commit: e0779713a1e2f891aeec53e629dbbd33f423c629

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

