Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A68391507
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866893; cv=none; b=YsIWo+gL4CKml5b0zwgdqPI0O8ods90HOkrYWhF6lsBV3h72tcKqRM/bofkRXY/kJVokjr4P0FB/orlzBNZRY9HcT1eFVnoXFyST07s6bIQB8NcxYtxlAVjsSoiy5jwNs562uc9ECDuraC18EyGUF1zUz4+SkmSa4Es5uYmpPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866893; c=relaxed/simple;
	bh=p402t6s4dsATom6C//ZA3V0XuQ2KGU4ByQP7LL1aEl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft+cAFXZxTA8iFK15bX96VR5LRVK/hdiM4tts3UaLYH3A7fsUWdrsXOYggxaN9lwvDsdIOLkgoHcaCap7o33Qr/dFA+v5ep+PffpP772li3hNFIrwK8+HMZHUf/q902xjEfPEgou+WpMHqx9addh5R0rHiVFVcxdcK/k3IrujI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o/rLauv3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hpagcymk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/rLauv3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hpagcymk"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FfiNs1255317
	for <linux-pci@vger.kernel.org>; Tue, 4 Aug 2026 18:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GU1YtUDGbsfxTlijAya+pOjBIhU0+IZyXpQLGX6+QZc=; b=o/rLauv3GaIsBjcx
	/uTgzvuU3kdMD3n6mT6NJbQU/cw8fHHY/QbTVehsDSdEAcF9ORRT+aQ3CqMzksn8
	kowqJPHoVobbZczkeSYcT9aBaREraZQI4u2T1zdFB3vYYOPw95yy1F2u5AZAistC
	A0HQXm1mO0/W/sHunI/80kPWpgRDRdOr5qqSTxoimsxeK4WEV61D3tQPM9ZdY/BA
	IBaxuYxLJUO8JXes8oqHIigPyd40NcSDsn1qNNG6QnQrhl++mlI8jwdTi3KNi847
	fkcIWGi/npiVs3HWC9jEO6SOEPhDPakfq3CG1xZzGcZbObJbQTjR+a8wpJtippip
	WuBxuw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud1djg3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 18:08:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9c26587e67so153425a12.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785866890; x=1786471690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GU1YtUDGbsfxTlijAya+pOjBIhU0+IZyXpQLGX6+QZc=;
        b=HpagcymkPPaoRLtH/uE/cKTzCRu8uJyzDjE+JGhDDQiP+qrT0NLm9183hAxnVkJwbM
         LnbjrI3yGjviQdqowBlcQ5zgKx4MpAnOcFGJ23NAMkxeDJmlzclNnDM3ITpdkUhwJPKg
         dXmottWSy4jRNpVrZKxdAJUn7K+0sejXzOqgRwj6i2jWiSA/hApB/R6L1A0foe/1on4J
         2BgYMVLqmeh2cStv9HcVZHCkILbOvPIjlRhKFROgxmWlhYRdcQ7mLOfGUPjUteZgh/f4
         kyQ6QLi+5Bq0vnoUuLnes9CHJxTTpa4j4eC5rw/RJceAtAzTAZWgvZAppJoiln0lY0ha
         DjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785866890; x=1786471690;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GU1YtUDGbsfxTlijAya+pOjBIhU0+IZyXpQLGX6+QZc=;
        b=AyBgJrTW2W7TTdmEOLZkZra+3tPtuKofeeCtTPCGIl0NAZXqmMMV3HFRAHWuzrquAf
         oU8B4N+beOVh2cJQvr41oly6F+jNClFyNzapWHNKo9GQ81J4FcxLLl8x7Y2qabPGWZcp
         qVnSA4Zs0a4KOyhHJeh6eKejOQORTylC90dvAecg6TzHrq99iErR+Ms8aLYfTwa4yxn6
         EGUxe6MyJzb1Vm7dWthCgQKO3MF9gxElwTtw44jIlQ0k/4pwdPcVMV7eGtUdoHHmmjrx
         Z1+toY2khkZVLdZtSbt+K6eI8iOd9BRPLHhVqj2z5/vh97hNi6FksIVuve/YImOukVD3
         yPkw==
X-Forwarded-Encrypted: i=1; AHgh+Rp422/6e/ZiHKzrsWkWgOPtKYbLTnQi9tOLdWVo3yyQ6rZV+Ap/LNRN2PqNbNzEAM5yOMcQdg6+Kzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfKALvNrV4Z+Isjy1CWV8mRgax9rzdfNbAuEw2wy0YnUOcrMn
	3coQBPW+RoZgMTRDpmuxQPbFtIDow4pDpt7Prhe6UH1sIUNxldaEqZCqHirZyiKjY1l9pBySvAV
	jYnjKRFgylchPYyfP19sOj6H89Hf3dyL3Fn1fZgLwlJP8e1ggYSmSgPnSsN2tonA=
X-Gm-Gg: AR+sD11/QtTi0Nl2uoYI64BObSuP6i+Q4R2LrF/rFDu/4VYiZUBa2NU6DXW3X3gZbqC
	DwKWYUogPqLLErIhtImrEdrv8hrtcEAp28i3l2H3pMF+fsv0N7YvS0hqG2w1/U896cfIreWrJk7
	BSE3uFkKTRFSZFwa7Y7WxaPGvzVjhhD5dbcTz2doWBv3saisdhV/a+xE5nB8HqCQmgxj2CG3Rrk
	tB2ZNK43b39jUNd/GZUAtxspfw3nA0r12aydSIaa4lxyHzKQRWgrGTSIghKNNSQeFLVZ8+Rhn5m
	/mIrz4EkYsuELnD6vm3+oE/HweaJGutzB/76BrSAi1pSEojVBNImqLWjMF7/hgfNmrljjCSJuzp
	HavqLRL0Cz6uDLv/pz6dy3RogoKpuSo2DJw==
X-Received: by 2002:a05:6a21:6906:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3cb6c752d6dmr5609280637.2.1785866890344;
        Tue, 04 Aug 2026 11:08:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:6906:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3cb6c752d6dmr5609227637.2.1785866889874;
        Tue, 04 Aug 2026 11:08:09 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b0a9csm9922859eec.2.2026.08.04.11.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:08:09 -0700 (PDT)
Message-ID: <b062ed85-052c-4c7c-ba84-282a4be2bcbc@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 23:38:04 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/14] i3c: Make dev->desc locking assumptions explicit
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-6-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Z3xiq-u2cDp60zJQBHe5TN_kS7rxP8_U
X-Authority-Analysis: v=2.4 cv=SJRykuvH c=1 sm=1 tr=0 ts=6a722a8b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=RYwuQet4LqFKJ_N4TO4A:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: Z3xiq-u2cDp60zJQBHe5TN_kS7rxP8_U
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NiBTYWx0ZWRfXzTD2jSB/XK9G
 VtMg/18zpaFZPLutwVgQvZ7RD56faZHNOgR8i4mHHc6jApxllPEH/0bDiIoyWjQqek1mPLvFpIR
 rUUIU7hTomjc0ussskWMH0sFk4zw0VQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NiBTYWx0ZWRfX2lnBS9uiCQXk
 Gs9MvRSoJXceGTcjE8udur/5J4MHEJ8pvNmTYG8SwZSlZ+WpuHVvfNfKCxujCnPj9pZwv3K6Bv1
 Qvk8hTZcdsOLv0rHCpQLpqM53mK8ft8ji4zhwWZyKXdmBB+GEBlsQpi1sBLiJFvWZfU9CmxsSSq
 KSu8JQZ0CXmVY8RVfsXo7EOr7hqbXUWRhEfiAhQq/rEgu3+GBQY82mSFLXbFzQeaZHyDINqpDG6
 FX6Oc3zr7ITkUs7Ol4j51AHVLPWAW40lk4ZMsa2XmsDca7K5g/2NL/dnW8JItPhx6i2ax1FYkPB
 uSM5KxwDxIdBGlaadqTcteDmSmpjMk4dpSG6fw7qdYhrWdSPuZzGFEOgN5C9+qaPt+PrvGkvLet
 HVbpAg5sJuPxYCZMF3HSjgO8+Htn2ozZ6ZdRGpb56SpxykWjVDbBcC3NXWu8IMgY0py94giPoyC
 2ig/HtUAMZwfMSIUUKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040146



On 8/4/2026 7:08 PM, Adrian Hunter wrote:
> i3c_device_get_info() takes the bus normal-use lock before accessing
> dev->desc. Under that lock, the descriptor pointer is guaranteed to be
> valid for the duration of the access.
> 
> Remove the unnecessary NULL check on dev->desc so the code more clearly
> reflects the locking rules and expected descriptor lifetime.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V3:
> 
> 	New patch
> 
> 
>   drivers/i3c/device.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index a3778282e84c..5e6df6de0283 100644

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>

