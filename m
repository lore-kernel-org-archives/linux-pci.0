Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0691EB1AA
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453847; cv=none; b=n/Zg//CtEelItKsNGXn+gOxfY3cryJ5dKI1i6dCaZZ1HM5jn/mIaApwwLdH/yU+e9RfMuv3s4zw0xEMKmRhhhRVvgdAcCvyC5Hk006MYtcWFTmHpxtWj49xyp+MXFL6Xb9mw5wqlmMp6oQJMC4aytsc5c1l68PM+8ivdNFW+N3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453847; c=relaxed/simple;
	bh=25G2yw6jj2EvNYdCltrkWC2HXBkP6dZCFTuPZCS7vmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c65aKc+R7xqtWgfqqKtp7UwLx2r2ibFVfZOZ6gbN1eeNHmUfaMQQe2Di896JmwIGVBHjSByj9QpRxkR8oc9l7SqiKo48ZFS/hv7gJLTAfnwY8TF1RB7SaJv/LyDf/XV/itGcVNN+h8A/JwPKHTPPfRZPrhtrcnuEAOJDBtCepK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n7ChwxLV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bKR80QEj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7ChwxLV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bKR80QEj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2jb7t3735402
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 06:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vx7zN3bDpScdIB38pyZ0lgQB2zi3GAXEa8gzzkwSobc=; b=n7ChwxLV30K2NIq/
	35PsMoKDQ+QH5bDtD7v+YlQrW2Ewlzytkl8k7k3vbP6RJr/FU0wC9m8wBXrcxMvf
	Kby2W4k9+Y5ab68dmCC//uPiLvtxiyHZ4r4ZFx5lkssJZZYTor7yERRzuimvEuzz
	FOrnjwQquQU+fxQaORJdYGqPF0lmHl/2kzPcDOhCgHVr/4xpti6cfcGzLRvlCEZt
	U1CHNb9jC4q9EZZhUmmOS0a6l++kZyTw3AXUqkoC9GfTd1jLdrltBjVVLHHMMMmf
	nHHCVdhXUETBxPiqSdBpwjdZfbBLtVE09wYWJG8QBH9H11LK0J5p3ivA9a8BwIQN
	RUQA1w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f16ukb9kx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 06:04:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c7f4d28c66so6945705ad.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 23:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782453845; x=1783058645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vx7zN3bDpScdIB38pyZ0lgQB2zi3GAXEa8gzzkwSobc=;
        b=bKR80QEjcd1o1s7Lh3654PsyWYG1bTG6udH8p4SH+e6eZ+SarULSOAVIayeZYEtTTj
         h+HENAFhy27wU6Hrl7cfQrNyj/j934o79t7Fx6w2GaK89UqkOdWiZiyK43qop/HF12Ib
         Yos3CUnxur4zgz9k4IM0CzlglaT6TmlDeGYyHroL9kNeou34b03tF/8Gr1iXJTz4I/M5
         SveeNPK4wuB0RqJhq6whUADPdmSgKzaQpRtFQ21gW+JWvPvNL5kRyBcYcWhnurHN4S8h
         bZFdKswog3zHBZbrUIn02M24ly3LY2f5qcdZCkvPFY3Jlqw1+ezxd/mO9yBBPGQu9J5+
         Lmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782453845; x=1783058645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vx7zN3bDpScdIB38pyZ0lgQB2zi3GAXEa8gzzkwSobc=;
        b=VoBXfL5YVKn7ItxyN6kO28dF0fp/iWcWLUz+wilKg7pSIm819pB/aF5m6yHy3XzoU4
         cM5cC950qEtytp42Wz8eP/Lsr953GLo1Cq1N0s7Q2wYeh0a5eTezSz5uJOEkX+auk6a5
         Yp2eU8XUGa3D8QLKtih6veld0qSUmJLWnYs9P4QXtKxDTKTTlpLDSGt1WivWXCL5zkRz
         EWKXR7l6+E+4xiBWasQTFcqyyMu5yNKE45BOcG60e+p/nAMEHtcLivUDSurURkbjGocY
         texru9L/G8ND5COxYzrXdohqRXA+q7KdwsKOampfK62Uv+j7dZvz8Fhd+WffPpWSS9jJ
         ch6A==
X-Forwarded-Encrypted: i=1; AHgh+Rqq9ks/O/ZWO5yM0Cu2Gkt8FPIacCkcgLVJ3dPxIDJMK6zBxcQF+5Cl6IoiPuFiptMBZ4GjU8sMPgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJrTbVg6t8FROZcq9j0JebBSXLQvC3J3n2oG6gPKoxD1gEilg
	bEcSTsz8XVConrjtTcJT2oEf4RgWtNsOTBR6LiieTBlzKBDwDeJXx9DPZmDlcnEWmk1tVsihqz5
	w2VXhQr3dQnrOLZ/J3buVPasOcASLHisiXMWs9KC8A5H0kwA+6wwUDoWZKH7IPPA=
X-Gm-Gg: AfdE7cn3AI2MTb7pBI0uc+YYoiac8quUcaVl2KLflg+4AZhpu4UD43+4kC/I3nOaBMh
	rl5TEg9wQ3qcgUp767CLluG7h2juHMCab4hx9ETrF1AoLnxSsukIoP1S4APHLHuamNS0FHusJkG
	xXQ3gGx0XJ16EF+75gzXiuvt/cllzuQAQhcq099EEibkjeFiAO2gt0UZDBLzetrRILXSwgxcokX
	zZBJdq/j3MwwmrSBhYK7j2a7XZESkSwdHoHA7Yd7J1Jga1MBh9WYR2HBgY1brvq+DcVhlm708ol
	NLYaCH/ngkK3DMDEvdWtO5cP2+lZLUxs7SRdfvVGrB2hLx8yUte+nmD+UI12Dxis6Ii2On39bzb
	VE11KkFUtuCbBWbrXihX1sv98EynJ/6r+rKy7aZ8vEdc=
X-Received: by 2002:a17:903:1b4c:b0:2bd:d6f1:3388 with SMTP id d9443c01a7336-2c7c41180e4mr116099445ad.28.1782453845128;
        Thu, 25 Jun 2026 23:04:05 -0700 (PDT)
X-Received: by 2002:a17:903:1b4c:b0:2bd:d6f1:3388 with SMTP id d9443c01a7336-2c7c41180e4mr116099185ad.28.1782453844472;
        Thu, 25 Jun 2026 23:04:04 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c8248a0794sm1252525ad.26.2026.06.25.23.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 23:04:04 -0700 (PDT)
Message-ID: <0538faed-ffc8-4ade-906b-5e3ee7bfae4a@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 11:34:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wireless Regression
To: Paul Guder <enyalios@gmail.com>, linux-pci@vger.kernel.org
Cc: mani@kernel.org
References: <CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VuMTxe2n c=1 sm=1 tr=0 ts=6a3e1655 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=9oq-OZBXupljmM9ZwkIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: E1Np3NCNQUZdZUGET9thONCb64qNG3N3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0NiBTYWx0ZWRfXzmE/wCv+31O1
 xL1meLtX96HrqsltgIEZS26sInIGKwBILpVjqjQxKFuHdM4dbIRI5Yp4m02a+OAWsXtjWfaFqTh
 kH4hVLwAacprRvDmGb8/hz11qP6WdltKjRfQk/D8H7BmyZWTzJ6eMqMnkvrDpSuLwRrVTnmZTzs
 u1nqUg+oXodUmtxPff1Mfflyu4yp4CtqGwYNVEKc1s6D3l+lb4ARfE2BCYd+/JR5T5HiGE2tr2Y
 J5q2Afr5XF6I18GVz6jQEySvoZ0+QeIztUiT0rmJgWQfcvBLnu9KDsZzCfUF+JAher/wZWh0XJd
 oKJIy0FslkALHx3FPAZ+pZEXWm6w4CR317mnAlOTUaRo1q6EAsGSjzJYsJg41AB8a2f87QeZSmR
 3dLoybjULCZ5Hj80MHNgE9U0EKOjuoLHzcOF96RxR9MFGVI+Iz94cIILVBanpwwYGmf3/mFH5uE
 Mqgk/lxKr4H0yAPzyDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0NiBTYWx0ZWRfX4+ybFCyi07Zd
 kmcAUOOmzz7lAw/kCdGq5g7y6qoq/0s6J5dKTrFpuREwZZoN7kQ1/9MDEPthwLs6Yo8NrVf5f51
 F3BASfVyuJgfs7yj5rwF4XwlTsb1cmA=
X-Proofpoint-ORIG-GUID: E1Np3NCNQUZdZUGET9thONCb64qNG3N3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260046



On 6/26/2026 6:19 AM, Paul Guder wrote:
> Hello,
>
> I seem to have found a regression with the wireless on the thinkpad
> x13s laptop which uses the qcom chipset. This commit seems to cause
> the issue:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=f176c47683bf
>
> Any kernel that has this fails to load the ath11k_pci module with the
> following errors in dmesg:
>
> [    7.298226] ath11k_pci 0006:01:00.0: BAR 0 [??? 0x00000000 flags
> 0x20000000]: can't assign; bogus alignment
> [    7.298232] ath11k_pci 0006:01:00.0: failed to assign pci resource: -22
> [    7.298234] ath11k_pci 0006:01:00.0: failed to claim device: -22
> [    7.298267] ath11k_pci 0006:01:00.0: probe with driver ath11k_pci
> failed with error -22
>
> When I revert this commit, the module loads cleanly and wireless works
> again. Please let me know if there's anything else I can do to help.
can you please share complete dmesg logs in failure case.

- Krishna Chaitanya.
>

