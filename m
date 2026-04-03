Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9F3CD8D9
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234108; cv=none; b=khvwTyjV4VvybHpjYsixrI4VZM02JGgkxj/QMImrwQjmF7NaBRdnoY5vEE8VMfG3o1XgHFpn/jgLqPqJmrzSubnhMIxO8/np7nRONE5WminR/995PVqkV+r6gOjgIEEHZi274Y+CX+IzXl+zG8/QkMo6BYlnvaN2lE64jLN6Zg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234108; c=relaxed/simple;
	bh=cR/GamS/b3tqpcCuo8lHfWBw519F2+IdR6BWuzSVm24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U2iSQ0LSmjSwBAPFIhKRmfVjI+bzVYhWKFGI65J1k+36wwABKJ/X8/tQ15eAZuB8HMVJH4jvGt4CdobVoqy616TOjvMPyT2hvYVFJzSf0IbOof+V/Iyi7mblb3kBJIR0Dt19eD0/LBL+AbtCFWXUnWlxoILR1rSNicQWEBSrU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BuobADqh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KV+Ur2Eh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BuobADqh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KV+Ur2Eh"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633B1odr1455852
	for <linux-pci@vger.kernel.org>; Fri, 3 Apr 2026 16:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cbS8GZqvSlCb6lcNQW5Llz9ietDLiqoLV7BexWkx298=; b=BuobADqhEZZsGpCQ
	PZg6ieVSTne5/JK3Q+JWc+bsd336+uD4JyukhbH4ND2/23TnZCeOiY0lLpLdgGnO
	+0wcNk1st9epk3X0vdnSBk/MA6ix3x/HaFEDghp/U6N3b1CvJpcLtXJ9Tz2XZtzr
	5zIiPMtFR66j+6LDHV0sLuCFhl27McsYV1hg8/VL1pp0D43GVLiAvN5GxVuhNUqG
	RWwHUGS1nZ+6CMv+OVUiLKrKWOstCEt9iCi89oLk7neno2U77Hhoxgq24FyS0lHp
	Uzyt/sfdjZ+3T8J+PiDno8liATLmXDyA7WaXT3gmvwayjfAZnQAMzml3w1EEuMiS
	oNvKwg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dacam8wdm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 16:35:03 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso851938a12.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775234102; x=1775838902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbS8GZqvSlCb6lcNQW5Llz9ietDLiqoLV7BexWkx298=;
        b=KV+Ur2Eh2L1pDQKjRVHpX4PdWXr3AUnE0nxWPIidcpE/BeW16t+ZlGI/C3GYWIAXDx
         3Z46Tbc1QwTcTZ2OST3zKxEi5ILZziK5MVb+uxc4BiBRqicwMu/8SoV/umqoAnP+J2fv
         2ji+yVZDdZL6L9oJ+ZuJa5byi+d1Y1bQ+61DeAauFJ5mZIB7TydM4/ln/UFaxDpXy/bf
         tsXOT43Y70uzfLCq70b3gFfk7/LkX12+hAHl83E6oVu6IyP+kGXsNqcSNRnmohQOCAPe
         UV4v5XLhUERj8wc/OL8gMcFHsSjr2w9hwbc8m1QO2SSqI3eHtKBPYkxRqaf2iS7XdF3z
         CxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775234102; x=1775838902;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbS8GZqvSlCb6lcNQW5Llz9ietDLiqoLV7BexWkx298=;
        b=GVdaTUj5xT2fOhXnRPPDEr54X252RkAdYZO3T2UyeuB4K28oxywW+OIjTUFzKPGht4
         u54vTCUod3Cemn3FUeJjOoJFqX5yhfhWqAOAOBH/O6e2okI73RpOgvL/quSA16YH8fyF
         WnOMsFd4ecy4BEzXeEDzYjbnDgygSS5ZpepuO+q70/HlN+/KeXZRhophLvDZvJE+VckU
         5LXTZZ3oqVLNtRd9n4MSnMG9Gs66pNWu1TnduTnZznMtpEQnLnAErnTFRZl15j76xdmL
         KgeBw7/xbh9MFjCMUtfYwmbGE8rXCDuF2B35u8B4uEIZj2Fs1gohfydRajtQMIqgv8Jf
         IqJA==
X-Gm-Message-State: AOJu0YyPgmbAU2e3/CqLcB2vpSlc3rJoUcvsOTVJhH03Tk9ZKFo+a/bZ
	B7eiqxu3h83gHLRP59cLLLvVo3/X6WLVryq0xCySGxlOygFzxbiHl6EHbsrWzeKNxlpw2Wu9DEg
	aqRZfs7hpWSEdLC+mRGHGR0iJS4rcQxZbV7JDdQ7ew0OrOxHLpWgLj3sVwDhKd3A=
X-Gm-Gg: ATEYQzyPH5mUMhitc5OgRWvnATJ9URSTQsKTQOk1861s3NwmigG1qDDETX6Shhw8KmP
	Sie69iVZatF/W0oU/kiIYJsNRkufW5lkW/cVxQVY94yF8++lOECRMotu8hJy2qp+5m7+D0HAqQR
	9FEqsnkRpwOe3QkU1be6ruSF/p9gBHAQ+gdntShWBkbpm36vaQ8aWiciP1CeuI7cci2k/8RUYgQ
	mmXEpdQXHoLM1y/HoYGIZ7FyU3XYMKppDQqS4MCD4KMO1jSWBoq4bYaY/YJxGkeHB9CEapCBKXh
	waOLArw2FvV9lkHJvTMy8DnhA6HjuT8FCQFxOFsYn5jfFaWkP0Prl8CQhSW4g6LbSuzQITHNvz2
	FvVBfRwYuVkzOs4zg
X-Received: by 2002:a05:6a20:9145:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-39f2eff3894mr3681025637.18.1775234102364;
        Fri, 03 Apr 2026 09:35:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:9145:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-39f2eff3894mr3680998637.18.1775234101743;
        Fri, 03 Apr 2026 09:35:01 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:b185:e953:2f4c:9987])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm5717506a12.26.2026.04.03.09.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:35:01 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Niklas Cassel <cassel@kernel.org>,
        Christian Bruel <christian.bruel@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260320140139.2415480-1-den@valinux.co.jp>
References: <20260320140139.2415480-1-den@valinux.co.jp>
Subject: Re: [PATCH] misc: pci_endpoint_test: Use -EINVAL for small
 subrange size
Message-Id: <177523409827.9954.17230555595149654159.b4-ty@b4>
Date: Fri, 03 Apr 2026 22:04:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: QrHmyICCV-v3vrHbTlpL0EaQZ1u5Mpq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE0NyBTYWx0ZWRfX76MrHCrDdeNS
 WQhot78mbkd4XDsqx7WssI53DZeFB5b7jZWmSaptvKZWlRDdsP7IYjRVNI55ZKkEczy8X35pId0
 EUcH0E80LScYvH19WxJXqmQdCcITi4beZtpmo+hhOk/3AJb70K5TI9qI1f5ayI+DDDxKIOQxMas
 LYLnUuL4aFNnGkM2Ao1XBIsTgUgLnuh3L4lvkegkD19TI7jvDJF42SkHmnPIoVXlYnjJaBb6RG5
 NCW6AtSjvW5em12rf14Qda7IIbfdjP2xPdPsaf0eIV3l64gInialcXxxsMsKR2uM+6FMgNRJMeb
 tLuhgGhwuq9/bkFuE+VZ4E20NUTpUObgC0MdVqwEJDCep6QUMsvKdPsI+hafbmFwgEd8bwk2b9m
 P8PN6LSAPmLj/iNOD/2F1LUKyADIyNf/Cr2ndW2ALEzZduuGNBbvDXLvleeNv7tZh5tvVpQpVDs
 9QNR3qiPuVMCzBKliyQ==
X-Proofpoint-ORIG-GUID: QrHmyICCV-v3vrHbTlpL0EaQZ1u5Mpq5
X-Authority-Analysis: v=2.4 cv=ULXQ3Sfy c=1 sm=1 tr=0 ts=69cfec37 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=yy5Nr2LnOgTKAi12c-EA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030147


On Fri, 20 Mar 2026 23:01:39 +0900, Koichiro Den wrote:
> The sub_size check ensures that each subrange is large enough for 32-bit
> accesses. Subranges smaller than sizeof(u32) do not satisfy this
> assumption, so this is a local sanity check rather than a resource
> exhaustion case.
> 
> Return -EINVAL instead of -ENOSPC for this case.
> 
> [...]

Applied, thanks!

[1/1] misc: pci_endpoint_test: Use -EINVAL for small subrange size
      commit: 9c55d0eb4e9d1bf229d691363fb0641a9b05d904

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

