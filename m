Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804904963B3
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867141; cv=none; b=N5nzHc84GqbmtyGj26QhubYZJLb4Nvl9h3AIPRpovnarUFDmTQjx7FWro7DyUZbdDrgc8CxPD73DVWTFcP65gze7gP9ci0quV/qmmKLVejqsGJvkc1YSGQES1k1AASVYJYS0vxPr90e90JwQLvOXA2b8iddOijellA5RXQBb/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867141; c=relaxed/simple;
	bh=AhED4tqTrGP4lTLdsnRoUZrZzBvGyQOjHem5uxoluE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vnq7i7xniGemkdGEyrezL/ICNKIm+SvlGSGXnGTeLXYqISmDyUPfJZfY8MWWEb9gOmFj2fqRwx54rNDrlK3HmmSpn5NBTfBhVRR+A2BHjpBT+wsHecasuNbzgUAntm2Mkpy9Vc/CYSSE9AnePsrdOR+KB3K3GdFdc5udPKhm1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPKdfl2K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dc28tqxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPKdfl2K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dc28tqxI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FfTZI070729
	for <linux-pci@vger.kernel.org>; Tue, 4 Aug 2026 18:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ASyHTNEVNi5r18fBCeervNjdQdHm+MvkAMt4iPH0kVo=; b=hPKdfl2Kzb0PMnWL
	wyJfm/ZTqLS6zb6najKVX6yGOjgKyPcdo45pD3b1SeTjF5K5u3BG1jC8DifV/4Da
	vXJCDtyAcaIsrw8hx7JLXQrn/Oz2cS+5thCdWTkAaDOoGKfJPvduQJa7MucvDJGU
	vVhODXcHwRSASU5Dhac4mkYQkO7udgkE2f26FEsmYRLxvS3jZhrr/V/RP2E3knnG
	2ECZpJm54y3AL3a2v1L3+Xl5Tt6wZeqpQrpDppned1mHKk+l4h+UsIFDk6ft3v5w
	kO6FS4900XVSwB977dTh5UWS1XnzeM39wVB4C6uuIul9GMlJSlKF/O+FktxZvKq7
	nho9FA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fujwsgryj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 18:12:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so140681a91.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785867130; x=1786471930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASyHTNEVNi5r18fBCeervNjdQdHm+MvkAMt4iPH0kVo=;
        b=dc28tqxIDqzCkVIhhqkH+2ebwNTNrT3rjAqFOoeUpRO5+xRM1UJpKEkt5bKOQSLmbh
         byeSeSHxRBt6ktg4xXm0LzTSte5ccYUdrTBATz9mYxlM+HKl5Bmw85/rrXh8hvUK/KJZ
         nTp0Vp5pvAOh6OdgoaEh6uhUa0mvGIePFkas0gCzTuegTBURlgle5+Tqh1pAOCc4BTni
         qWj/NF5/pYDojRKPWn7Q2WR0j1ubjKWntPO3C//+UeNAxQaS0RJm1snV1AbdYca526TA
         UIi/WcpIH9AUpVhydYPuEbs2ZizwtRIs8liICsO24aG40QS5tHRMDw/Szg+yP+/Lzpe2
         93NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867130; x=1786471930;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ASyHTNEVNi5r18fBCeervNjdQdHm+MvkAMt4iPH0kVo=;
        b=mA0YTYSHUh//FuyRep6ENmJdB8BED2NzOOP3IOs6Y5mZNp0FayC5fz+4GraMzCyrUz
         NGMRnafKYr4GyajqxNhhNVoR6t61rq8gmrWngjqtgaBPW6G7EqIIOnKX8icu5t8KCaTj
         fGmIgEuI0d6Dc8Tq0iJLE7IGtRproKEvzLeNFq+O/Y24C1qpGa9hEBoe/xaEi6rtcl0p
         hU7w4Fun6/RHumG1EiZrLXRoktSwARmOqTDsp4JhOIsU6SRGiMB5SBPR1bXgRsaCynfQ
         fF3Fg9bj+piBHkDljhS1HPrj7wGCwZIHYuu3b9Fc9V29g/Vi6JaW+crVKxK5GjvVC8Su
         qUVg==
X-Forwarded-Encrypted: i=1; AHgh+RpzHTC4WUS7FBfFwWUbU6cyGIfvN7/nsv1aZSw/qWYEdFgSB9AQhukDWbFe1I0rqwpcRHwPA15C2mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKnCvlWh32iGc5W8+YMWlMS33ByFdYR50VbkXkC2VhdEIHFrQ
	c7/XGKDOOwhS+2t4p495UOUtypPNB1tLel5bbvVjgqk2lSfhBLXXQOze6mPD5r/58kazRgSl1aM
	CEU5Ju10QLWk/+o9+N+D8wbNaKTJomH1UjMo4LAAn9p6kc6BuCzhxMmU4IWJ5IIE=
X-Gm-Gg: AR+sD125LijDPXF2d7NiLuCqzyY9PWgm4LX8G0tQfkgIgoC/MJCSUg74FYnrvLqy99J
	ep7uc4lZ0CR+HEbktLhZhTeRB4klPPh5g2QXtq3JhmszP4EXo1EOgrrv5Ks4fNVVt2kgX0uJqJP
	gXUhgMfE86uS+oWh3gibBNX38sWZ18pZFvrgLDdrplnpHh5a03zTRKfCMl98WmeILSFqZ8xtC1g
	ztAc2aCLCQXO7VKWpzZwEP9RptzpZWgi/J0xh1AJOJQOpqTNBmGhYc85rgKa9bLPgvN2oFZ2sXh
	xJUHMazRSQW2EkldP8k4iQCcT/g6Tb4ML5Wa08vjherL3yOvQ7URkwJdFZu/ymrDpR8hiktw+A6
	+JXJDd3MeQpJwelA+WnI+wuLATrNWS6qYZA==
X-Received: by 2002:a17:90b:4983:b0:37f:9ce3:ca95 with SMTP id 98e67ed59e1d1-3903c6e051amr654634a91.30.1785867130259;
        Tue, 04 Aug 2026 11:12:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4983:b0:37f:9ce3:ca95 with SMTP id 98e67ed59e1d1-3903c6e051amr654595a91.30.1785867129813;
        Tue, 04 Aug 2026 11:12:09 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca2e8ae2sm5560935c88.0.2026.08.04.11.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:12:09 -0700 (PDT)
Message-ID: <0d5dd29e-ced0-4c3f-a507-ebcd52f919da@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 23:42:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/14] i3c: master: Fix potential UAF in
 i3c_device_uevent()
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-7-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _b3oBnPM5am9aHKwywHKm5O1zSJP7nRR
X-Proofpoint-ORIG-GUID: _b3oBnPM5am9aHKwywHKm5O1zSJP7nRR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NyBTYWx0ZWRfX2SNa19CHfuK8
 umkBSgBFK/7kWWji/ERq+7wMBHgJiYyAyJJ6xGMut5NLfdDrVxdl2TJ64W6cXgE2490iaOfRHIZ
 LE19iQYttRSURvhpMEXYXeUxHiLUjok=
X-Authority-Analysis: v=2.4 cv=Lu6iDHdc c=1 sm=1 tr=0 ts=6a722b80 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=ohCnSGWktmBL-HYrFGoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NyBTYWx0ZWRfX4dyD1QL0qTRy
 VQWkiHTuGJh36oAaZceiYQmunRxtQgwMvrFnxmwq4NPBjCrCpwbZUIG06xQ5mXwBb753W+gi9Bo
 o+yvg+xWIGCUPj/dKVTnfuJHWjr5V3MyQH2dwwUBN4TrUVIhjV5jAHUNnHuqf3GCwv69j5XJFAv
 NxM992Aku4FSeBQREBOuBbs87N5eBonOH0tfI9ZMnWgEPeXYnwMrSKXUKdrmA8hTj461jl6lfix
 ghQAznv39gr2SClq4/mDGlDSFGngLjAFffppafL9010CfskhZCvdv6oFM3XDpEc+rTWCGSg0sn5
 fxeC94rdLbWnUebeaDqeGdTBu803VZzFcDqc5TNI877QYl/vPvK0Shy4z2qfQBY6NPtAh9LvltF
 3pe2mwM/EiZoGTl/oBvdxiq7uqh7t0xtxKDJ80BNmzqjTl0LKR3piOSHZLI1Sk5HSqv01OrJZnq
 XkITa+08kX9nWgmTEDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040147



On 8/4/2026 7:08 PM, Adrian Hunter wrote:
> i3c_device_uevent() dereferences i3cdev->desc without holding the bus
> normal-use lock.  Since the descriptor pointer can be replaced
> concurrently, including when a uevent is generated from sysfs, this can
> result in dereferencing a stale descriptor and lead to a use-after-free.
> 
> Use i3c_device_get_info() instead, which protects access to the
> descriptor with the normal-use lock.
> 
> Commit 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling
> i3c_device_get_info() to avoid deadlock") replaced the accessor with a
> direct descriptor dereference because i3c_device_get_info() would
> recursively acquire bus->lock during device registration.
> 
> This change depends on "i3c: master: Fix recursive locking during device
> registration", which moves device registration out from under bus->lock
> and removes the possibility of that deadlock.  Without that change,
> restoring the i3c_device_get_info() call would reintroduce the deadlock.
> 
> Fixes: 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock")
> Cc: stable@vger.kernel.org # requires "i3c: master: Fix recursive locking during device registration"
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V3:
> 
> 	New patch
> 
> 
>   drivers/i3c/master.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
