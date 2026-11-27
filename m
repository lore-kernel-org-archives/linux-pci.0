Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795811443;
	b=apZDqIUVGJe+StonVMR9IiqzsoiVrFBS4qK8bFeXlgDC5Q12KHcWlcZvqGce4KiS/5tK
	 j13pwqm7eWjSxotlT0mt0lDFa8wuT47XK/coTiuhGHUU5jJsssSUSn08IZdbdNUWJ95rF
	 NBsDYQex9YH8dab5jg3SaMe59+wwLeuCcQ7mVsRMt2uC7zQlnUcb9o78rD3+uoMVVJ8IA
	 Px9bBGM1x3E+jxGAUTnWav1dv69ecp4NiuwNvwQM12mcGbrRexCN7vAtIchhmxKEL6RlJ
	 xe7w6IvIIgPdNBGhVJUa6dhJyEGRZl7q/Ds2pTzX0qJAF+K6RU8xMYFZQJlQoqxJg1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811443;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Hphn3ZfKORUo3yr9W6IsBbo3W049JwCJrXs91ZHeeMA=;
	b=j5QRXKreckPSnp5k7tviKBwVRAU0HnCmKLjHyMq7ZB3ffZBC2iBWaQ/0Qh1rJGBQJd5O
	 m7x/+Lbrxu90VkKdGyb/W6sjMm3OxYLChBYWShwOM7NlVR8D+Xihf5Q0z2rHeMoRu+A88
	 UtWQLMkWeMBh6BXN5EmPFb9YCh1yqFu+4Hdmnzyl6AZnBcDKM4YU7wPSHe6FQ5xz5DWaE
	 i/K1oybOWu8CSAOpm/U+GV6fKisp667n2t9UPp/anmRhEWg7jJtoz8Iq6JMPTL4W3voTR
	 kkGE/ZICikzvBkIeqMvJLufnhfFt9KsMJiITlAfbgiW7JAXfq8UzP3f/JwUbX76L5JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="kNdXS4/7";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JER9oDJK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7E606A323
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38C7E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kNdXS4/7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JER9oDJK
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJRH722668919
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Hphn3ZfKORUo3yr9W6IsBbo3
	W049JwCJrXs91ZHeeMA=; b=kNdXS4/7/27Bmjheg0WPfQA0MdTG89+3TYQIrMtP
	KPX1JUzQQodVcJqU8ZuOVICrLCwbfVGxY0KtiAcPltWSjhCKumY4cq0hP/d73q0k
	cAaDuMqGtkCDpD9q+2XFu3dArsBdBFA7IQPBbS8Q5N4es80BriYOYy+nF0xvpSRU
	qJct5pbmkoRU61yfmFWKyHBkw9IKirVLWipywZK7r8utenuJBSa2EG4p6jBJHIK3
	myQwJmE1hSIGngZxKB7kPMV7ZOXPSC5tRhJPSCRfWLM1oQOVwMV2iG7apDEB6TXo
	sRdUM6onL8HQN5XYj9uOEWhDjIhpFS+Nxd2P6Mqr7EzCPA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1jg4hs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:30:40 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67e05bd44faso8620672d50.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 12:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795811440; cv=none;
        d=google.com; s=arc-20260327;
        b=se/voDG4hDoGsgZDaICZe1CWnA4qZRPIVeDDS55R7cTrJMnrajegZGRIhukJ4y0Wxq
         aJO9km2IEAPltMFQFWZTn6ISi++gaCrkZ58ljADPBMRwT9J4Ej28sqH29Ts7HP5SZY3y
         5yr1MO7roeBJv8AK4rQkH8qlfEJZPCMMU+OkK+EEK/AKEEPjBv31EELZMt9IEtg/vQjh
         SkfnSh/E4scbPb8fywtAeM7hFD1/ofWIAAV2bLT8HO9/NJCkaO31mG1npRQCDjDgztJq
         i08ytIVBSzcchoRQERM7Aqog0AUh6Ay+BO8Uuu3Ek4QifvYpiQMBw78n2GSnA0+gvLfO
         dcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Hphn3ZfKORUo3yr9W6IsBbo3W049JwCJrXs91ZHeeMA=;
        fh=8cCvL3BMHpF4KCF5oAi7Qto1povHCKVQmNXZaNIokV8=;
        b=VXsXziwoN6oyMb530dj+pWVHrEcyEF9Pm1PdjhMW+2PFp3iht/FqMgLOeZ0CklcuIa
         MyPGFlcwVXE04x3upEnmztx94OeGxzVp26gwkh6Xo/aBmdPQfKRFIJH5Am9HyGYZP4GX
         4SH1XqHUAR3z3uECdTNJQgtQHNHSykec1ybsFnP21fK2s2aEASt6eQeH5mtM5vDH4VHF
         S4TBL1VRF4CBKBTzNdPR+4KL6FJPzMb7Plittxa9vBmtMF+/sRaeC2TkoqwKvFh+H3Yg
         k4Ssx6yk40/q+l5Ms4i0lN+6zYiYRx6ntWQd1nAUOf5cTgPIL8/6d+SS4Yi9YYxifiGy
         zkpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795811440; x=1796416240; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hphn3ZfKORUo3yr9W6IsBbo3W049JwCJrXs91ZHeeMA=;
        b=JER9oDJKrd+p/VOFiEVXJktXs+fCy8ZWlsGHbGQkW3otoDmAHelb2RAQd4Gj3jSxZu
         5gry8Zp2+0y9O3Y9eMz0a989TJ0UjcSZtWF9/5PJlajEhJU4GR5dLdwek3C0ioyFbOGE
         z2Yy3kbvqRKhrw4QUMt3MJcds5lq34NJP3u7LdS0v6OQzf6AdVCRQC/c2uYgIvMjGLxQ
         dBahEFwtT/IYlWRNwTHGPXhoyP52nu3xSSthJQAME/2PjiBuYT5YVUFpkKNrCMp3DTIg
         5v38iOQeYv8H20nLxQRquKDIK3JEgPlDk6iieQp0dZp5WQFa5aFkTul0UBmR3j6o3aOG
         EZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795811440; x=1796416240;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hphn3ZfKORUo3yr9W6IsBbo3W049JwCJrXs91ZHeeMA=;
        b=FtJEPgMxQ2KSsd7U3J4fGUIJjwdhaWrJXWF/uXwahhzqSBWv2/jkSuKX+ZYi3lxLQS
         t26kZmkMqI6jFMjNpMByfOeR323bdQ4hH+CLUPoOgMCwqZ7PEv1Lmafvh6ju0ysY+zi9
         5GiWGS7FwMElvfl2jjMxvWc4HIELNx1UFdm/RlS8TDFt/9ALkeAxT57PHNxV5DAFkyqG
         G0tV7JYwqaubzP+f4+6CLt5oY6t1JtvL7FHZ5nP+xWQwYapXJpkSi7bZtXyI4i5Afa9y
         OdZvZ6IJEFr8ua/xWV3jMvEV5kdNHckeOln/Hc4nlz7SZKzSNzoQNfMTFBL+I0guwM4S
         8skQ==
X-Forwarded-Encrypted: i=1; AL+hErHwAHD15x3ol5uY2UUAu39zn1nQ6onrNdnlbo66S3xXgIlOQ1yyCRmYbUcpcwgT4kQjy46rE700Yk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jIFNkzaDreh3cCI+APi08zUM8AHI6N+u3tbCHGP20TKFoqyOB
	N/ryu6EVOOyvattDb5ltNhwMhqesYA4jCSLPsbngNKxhQQc1/H7YjYuF/qdb+BAE2tSVwuX92g9
	0Pjnhk3qKDOKzbQny6QCR5TIWobyAczbUXpgB+hWnwOFJl2zOderqD5enfYB9xFZWhwrOwH1G66
	xwjvizRQu96VNb7UTOyWzS9NroOXcaG/2MGiHpzg==
X-Gm-Gg: AZFdTZf0QTjMvRmLWrOFFYfqV6IgBavC+403iTlNHVO3uNZI1o0pci5zM2OIHbGikU0
	eazvfJX2gD150XeU7ej5ZFG+X1+oZW8TiJ/6kxGLvUeb/m2FI70TpKb+iry2eQ0z/EWMMjIjvaK
	61lvIV0jaRGhmKyx5ArY5dKwV8P+fV3zfil+uclOIkRMdwlRG/z0EDeAqBbVrPrNBsvic2ZBvyP
	6MksSOXOk0zjHSEHg==
X-Received: by 2002:a05:690e:440d:b0:67b:ec5a:2075 with SMTP id 956f58d0204a3-67df4446b92mr7114690d50.78.1795811439946;
        Fri, 27 Nov 2026 12:30:39 -0800 (PST)
X-Received: by 2002:a05:690e:440d:b0:67b:ec5a:2075 with SMTP id
 956f58d0204a3-67df4446b92mr7114661d50.78.1795811439276; Fri, 27 Nov 2026
 12:30:39 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com> <CAPnEM6aAK8hwJ3EfhzS=gdMPTf+bhVgS-=JAoM+axcHzBQ1CGg@mail.gmail.com>
 <FE7B564926118C33+50565d89-ad83-441b-b85c-cafba0df5546@radxa.com>
In-Reply-To: <FE7B564926118C33+50565d89-ad83-441b-b85c-cafba0df5546@radxa.com>
From: Chris Obbard <chris.obbard@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 20:30:28 +0000
X-Gm-Features: Aa3M54rOA0nGZYSsdhumtFBM_XfbHqu3BlAs81Bv2P-Z0wUA71uwNq6De_uad1M
Message-ID: <CAPnEM6YXXVJ==OXinyZyGBfKS4iX=N+eMJRGZframsnfAeTtjA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
To: sophon@radxa.com
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
        Linus Walleij <linusw@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
        dragon@radxa.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniele Briguglio <hello@superkali.me>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfXzzgutGTW+DJo
 u4KQmCiW9XY9tq+PlutIbm8HWS1u2Vs/bEOkHxRLZamz3ooRgwV7R6VO5p/Fr97AH9IPTrjRvOA
 3wLe1Ic0ypPpq+Iy9A3lsldHi9Z+lv+xSyoGAd8uIrWL+XesPKJVXPXxqD0ir6aUjoCb00MOPdt
 50pinFPIsZLSj2fdupceKoqnG8SY3Pc5YQOXMzm19ZoDrr721foSZq39MJkwPaQ5VCr0W6FyXCx
 FgqvNEsEbOc4oMcdUZgwErxg1SN/WnxeISLB+gUQhumJty9LEZtTGMSTjUjgEvZ4rqXC3bq//ic
 0JdRfpjJGrvmsoaEpZa3WrBEyqoYCn4SWzIH6NIH4k7sIWbxAjItVm6vAiyfIXsb7+cU+TLHQE0
 bbQQELCRG/HpuslRgBQ/IKtpm55uHzn/mBTekl/uPgKnIbBl+xtooijaGYsyrs9eSf3q4SsH2xD
 Xlu2hRcndgOlTcIthvA==
X-Proofpoint-ORIG-GUID: T6YHptd0TUll7eWdaKONtEduNt4jfVmG
X-Authority-Analysis: v=2.4 cv=QpzLTlyd c=1 sm=1 tr=0 ts=6b09e870 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=ksxQWNrZAAAA:8 a=NEAV23lmAAAA:8
 a=05-C0eYiNmMOl18pgPwA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: T6YHptd0TUll7eWdaKONtEduNt4jfVmG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX0k/t/zqcmFTe
 FTZthsW5AEoaukQYce3XDafyNNHMmbckHc3G7QeYOX3YNAZ9JqPh1l9Z906Pq3cQQx5E4F7dUsi
 50mrqvu+KKOJCpq/H9afRWPIT1hqDJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081

Hey,

On Fri, 27 Nov 2026 at 02:43, Xilin Wu <sophon@radxa.com> wrote:
... snip ...

> Hi Chris,
>
> Thanks for testing the series.
>
> For issue 1, the Iris init failure and SMMU fault might be related to
> one or both of these patches missing from the tree you tested: HFI Gen2
> support for VPU2 4-pipe platforms [1] and the missing Iris IOMMU stream
> ID on SC8280XP [2].

The two linked patches solve the first issue!


> For issue 2, I'm not sure what's causing the hang during the password
> change.

The second issue was quickly uncovered after adding UART - it was the
SError you mentioned
in the cover locking up the device - which of course
https://lore.kernel.org/linux-arm-msm/20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com/
fixes.


> For reference, this is the Linux 7.3.x branch we're planning to use in
> production [3]. It still carries quite a few patches that aren't in
> mainline yet, both for stability and to fill in missing functionality.
> It may be useful to compare it with your for-next build.


Thanks for the quick advice - you'll see some T-b tags shortly !



Cheers!


Chris

>
> [1]
> https://lore.kernel.org/r/20260915-sc8280xp-hfi-gen2-v2-1-c52075bc284a@radxa.com
> [2]
> https://lore.kernel.org/r/20261030-sc8280xp-iris-iommu-v1-1-1e3fb8562b3d@radxa.com
> [3] https://github.com/strongtz/linux-radxa-qcom/tree/linux-7.3.6
>
> --
> Best regards,
> Xilin Wu <sophon@radxa.com>
