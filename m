Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E99371899
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534188; cv=none; b=qRF9hHhVr4mpchYOSRW89UfkBP/iAMDzpwENOXStJjXM0N1d1IFG2Qew38NOxqLAT82giz43Zt5kAjGZ0f+RNyP/dh/w/Aj9SDfAhWpeahX/kdSnTErDlolTCGr4WrTBzw/82f0drjZWwnrUmIuKwm6i7s70+99zef/V118G69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534188; c=relaxed/simple;
	bh=oKcONAB5sNh3frsP/GTImS4Z63f4ZuBvkhfNSfI+ziw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhnQFi/oRTrgIrM4B3Rzp45Sc6XiAAoADflHTuQJwN5FFHzq3GslaAzdIIKX+69e9S//D3DLNnxQ9gQlsz7FWNRGT2aNPHofbF6sEF/7YaIWlXA+4mNVRqqPVs4D2aZ9YtIUGff0gbFLA4KJSlrwrGFTmKCQ59z/8h18zOrO2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qz91mjRH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HorZuA+U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qz91mjRH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HorZuA+U"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KJbe1746859
	for <linux-pci@vger.kernel.org>; Fri, 9 Oct 2026 08:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iNcP9lIMFixukf9jSoJkK4cx
	lZP96poOCV/W1Al4rms=; b=Qz91mjRHyHCL8vofDqUgYO+5zTg3hjs5dCMg8J+f
	P6+a+7XbCDIIgLNkKRZgcg/VUykHcL6tlQqGSOTT0YqIy4FX8njnILTnBL5cPi1D
	E84JT1HgPDixSuu8MTRbyzHF0XxgvoyoLIUEFbdWz0MvHDDQr3obh0qjIu0VP52f
	oKc/FPHzliL7OWWg6m24r8io34ATeu8Hf/Ieexenph2oLROrTTdtNjdjqOx98rNE
	Hsl5yLT7Yjt7L/NL9WsiE4UpZwmJ/Ri4Jjjw9kzX143VyCGNhm2GeE+c11IPpu3a
	DsxdPIcCTqFRWD5/1cGPJJCCFCGghkZGlV6Ev5jlzNWBYA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvay43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 08:23:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93caf6c528aso1014209685a.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 01:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791534185; x=1792138985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iNcP9lIMFixukf9jSoJkK4cxlZP96poOCV/W1Al4rms=;
        b=HorZuA+Ud9ptDMAn1c4kgcfEuG/AzgxNsW2CG9IGvbw1pwlrBkmFZib3+BDLN5N20E
         odvs9J71YNRn/P7DIZcP5fXQ7YpLXZe9xR2/7eG5MS0oII1mSOEMzJD6dRHHGjhjQ0Q9
         jQZOMcqaaZItNAS/f+MpiffuTFQOyzPbTs/xa6CKmZsz3p3F9p5Uo2Szzp3r1UFRM5vC
         cd0I5j4eqjk/6WgG/U3q/bmwFtJeZsRqYYOVF3fK7B7XJoZCL2SKl4kB/GhRterz1K/e
         skTB7DJbZjUwX4wNOWQtPPgLonaMxeWu7reYT1Z/0C8nv0sqG26pukbhmquhgPhvnEXo
         CmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534185; x=1792138985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNcP9lIMFixukf9jSoJkK4cxlZP96poOCV/W1Al4rms=;
        b=0+YZUreOyudzlhs32XpQYn6UqnabSZ9FAnf7Y7rNYd04QgNuhITLT8qfhuOKwfkcOr
         ggyyiCLpZEJ47i8GTvkbZLVajhZTeK9iqD9HDIY5bPWpLEnSb3YQPT5cXPtzsly4wPNs
         pZglOUhRK6DctGTDPqCH0zG4r7zDjaqGkquUh4fy++F+t6b7cdkFpj8E8udPNJ224ts0
         L4Kwrn+Mum600ty5qVyZhMZXaxa8CrJKfcccg+/pZncS2rabi3JsXzVF4nEJrQTKjcDx
         xgVnQxgRpEJDppl8X7XckdMw+ZUbT8B9Ud3OvSCQ0mFvU9mwV3K5GrUhMP14ynKgIz4l
         Qj2Q==
X-Forwarded-Encrypted: i=1; AKwUvBx8tHZrDwOgj1OQn0z8PZ9HePsBQqzCIm4tHmN6FtN7bQOoCgXWyQLYeeyjYdF5TyVygyszzhCgxpQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k0IS7JPpZBwQsVlCBsi0kC9RFwJ/yNRSsbd0w9a70BIpO9JSaA
	46Ap23dlwgX/3xT0hdfDyKBcwql7Z+1gsrGppjO5kChvOYImYCLU2UbaCMBauCq80CQ0c4m3GYg
	nwRffdzZtepkjzJ1gCeSZ/kNn6PNMJCdEUzfVtWsaqJyT2C3BDtlX9vLFKJ9Pbrs=
X-Gm-Gg: AYBFou0fhEpYS8lzV3CKuLGAByWk49r0UDk2sI+0y8ijmQXVijQWO7f+/s72stlUqR/
	mi0LB0Lgn1VasHLCRurL5D2X45XmQkiKisDIDCtXM9REz6dyginohdMgerH4tJyHRjeF3giBHJO
	ecwSyhBIpf81W+/CSMMiLs3mLkEy1V14DUZks1LvjSpHy+bgMvQ/oYQoAuZ7DnCvmyB4sHvjh+C
	o4XoYUSGsVhyMP6i64hdJjGpFI9t8Uzb5WvvaSIuYDbGsjyVh6xnoUqpg10FXzCTSZD12ERZXxY
	w111AK04GaCH1I78FFTRnVkcloxYwWnLL6biALwYPrU7dqog/vdlwPfiP2mWTUHvSi2DTeBXO5d
	fcGx/AC73B9x/65XcX+Y=
X-Received: by 2002:a05:620a:3720:b0:93e:5dcb:eb9b with SMTP id af79cd13be357-93ebd24ecabmr153055485a.42.1791534185529;
        Fri, 09 Oct 2026 01:23:05 -0700 (PDT)
X-Received: by 2002:a05:620a:3720:b0:93e:5dcb:eb9b with SMTP id af79cd13be357-93ebd24ecabmr153053585a.42.1791534185087;
        Fri, 09 Oct 2026 01:23:05 -0700 (PDT)
Received: from umbar.lan ([2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9c3cd783csm4527711fa.32.2026.10.09.01.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:23:03 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:23:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
        Junhao Xie <bigfoot@radxa.com>, dragon@radxa.com,
        Daniele Briguglio <hello@superkali.me>
Subject: Re: [PATCH v2 2/4] drm/bridge: simple: add Chrontel CH7218A
Message-ID: <p34hqt4x5pthm5ailvwvde4le3ubhcsxsiixi4y4f3ma2qehrr@54mthvv3carp>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
X-Proofpoint-ORIG-GUID: fSzOfEMipW065CWW8lpK75BTZ8SlcXd-
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8a46a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=6mBZQueXRAtxK1RCuRwA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX7wEyb08VMPzZ
 +VoyOVXqxZsEhfXrJkbQCd8hHmkVp9gl8VtHC92/17p3JhzfwQOUCuuj8dpC+TopbO86J8oqltv
 QFx82ITM1gvKGt2Nuz6dHOObsvm+CCC5NT91d9v9i8XdNFKe8VM3nhhzNLnGA/mhRuxsQW4lCDv
 DAaLMX+G2PiNbgSJpbC6f8TRhDB2gejiN1Ro4AczX1CQNI2iLpeiR3Oyg/KOOJGvBIdVWSOUhtN
 Ttl4NGxuV+e/LoDzYo40Duo/BMCnuiG01US96mKlUuGtbDBvKNmN2eAoldEJpcSoyI7RcHT3IY+
 mYtgbPqjI4hZb8VOQNTDwRcDZV9TKQ/WF7bdWjCpbVCsnEXY8xYZTKf6SpdhFn8Tws+P5S7Xnlg
 E2o9oc2p2YHcGCzoHuN2UKX6idZluGDLadDVQ2AhN9SOOgJMWi1DURuU+bZ3hxehHxXPLtciOTF
 zMlHMm6yZ0zPhbyzJ9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXxUCJxNPFmEQX
 G37qW17iHk6OhqvHm3tTJlpht1IgG7ZrUH1vkWOzzHTijEgU1gpPEFlHn3KVtgVg42yK4MhjPVX
 e3Yj8wTm1hRDYAruRG+i5IQQ47jmqwU=
X-Proofpoint-GUID: fSzOfEMipW065CWW8lpK75BTZ8SlcXd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090032

On Fri, Oct 09, 2026 at 03:55:07PM +0800, Xilin Wu wrote:
> The Chrontel CH7218A automatically boots its embedded firmware and
> operates without host-side configuration.
> 
> Add the CH7218A to the simple bridge driver and expose its output as an
> HDMI Type-A connector.
> 
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
