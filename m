Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62BA4BB5B9
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446464; cv=none; b=OPr2Al3I8Npdwps74pMHxCsI7Jgnw/zLrfG9iZJ2Rolkjtg+GhwFUulCWRGQM42NGM/pG4ao+w5JW1tTJ4Dr6ZdAhJ6Ap2vODzMwGVCGPF4oY36GgICQttqDqeDDnnoqReFrCrfYPSCVeVCTMX4HfdIxTM1gt7d7dSdin5dKV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446464; c=relaxed/simple;
	bh=gi9mZjH3jh34DK+gNA1UPkWEDaxFzIUHDuBU6k1qR0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peZqpfyKVpGq9xO+6o/+XZS5fOz0/p6+st4naJruSOHPBKuVcyHl7DIN/nHCC+CAq8J75KVkW7qQxM4wR5NcxUrpNVtMkTx2BvbJr791yDF5DKuUbIllBpgimVaO02+IuGl8FmYUcYHndlq+sX1kWckiP02OWsSkD4SZoVCKAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBK842fY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MabNpojT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBK842fY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MabNpojT"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DB7gu3580108
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 14:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PgPqH75E2Evg/LBzbjzhxHEEsoKS9CNve/6QYZ72/hU=; b=dBK842fY8gNu9XDN
	zoQ/UYkuTkfbiLqEi4fBQCgGl9oyBZdCDJmCFcVDFZFjvnJRgMY9MPDQhoNDCwbZ
	y0mHOy/k4LNRG+bpWh5Df1Wb1ArEMLzE5G4brP2JMUWle0O8Rtgjdhs19Jdfesqg
	cDG8Oer+Vn53UWUFfedl77YW5MjCY7LOzVoIvj7Xkos6DqbkOI0j/TOqTGcwsXs+
	chGCtnybaWc+PM7RscvWvIspRJZLCQ7v03uOvljsvfCrHxSLyBHccf188DZwK+DA
	gExti/F1jJGJsFNp6vObuyiy+HUdCU13YOHDqYuaMxhhi3kNU80Xv1yVmTw4g6PN
	XbUPMA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d11ecd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 14:40:50 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-789eb1bdd79so99984137.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788446450; x=1789051250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PgPqH75E2Evg/LBzbjzhxHEEsoKS9CNve/6QYZ72/hU=;
        b=MabNpojTSNW0eohxwYVrIvbNrQybiLADBH/pqvYcZCYZQp5up5/ToENgZfN6GUiDgM
         CLoIOX/Ira4e+SfJB/i8TR+eKAsGUOUqR7I3BcoXLuW1383i/7Wb5tiI0XLgGcc8GxYv
         DcwCtDDycXMlX0Rl/GJfSKrnZXm/Jc5dAL8Liz1jWh8FNlWtm5j2P0xht1H9hDpIWWAa
         SCoxf9SWoXtsVrElm/LMC7yuWAkSN2S/E/A1PRE+303dSVGDgCfTBWUv33ojRb8ouZxT
         TxblCwGNVpl3xP6hxv4VtESNZ7lg/Z74ECIzfs7nVOZWdFNbIiShMSUhXrnKEObYP0d0
         LnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446450; x=1789051250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PgPqH75E2Evg/LBzbjzhxHEEsoKS9CNve/6QYZ72/hU=;
        b=cYsUZGYFGhv+pVbS3I+B979z0fu8Q2m3x8iF4gRltVMyp+wiMFJQYLj9274wAycdVK
         XFIVDpPBK7QvuG5SZ28hJ5R2y7Aai3nqQ/IzMKOCOJ/mfSupEY1zRPXf2mAvaJ6NhOSx
         lJUKTlzt+oTa0rgebVxamkSFE7mpWvG5ceM2mqAebkpiNunx99l1ncYuSQavyQZ8UJBT
         ZMRUVukTyePTvpOoCrkc4ciLcM8br1zSK5HNxfFvP+Vo6dab7QMw28lZhuuCGnAJQ4p2
         WknjXo3r59DExVpyEo8sO0WKB7l/x5DjKemhZ3ZeNuUxJZnbJJ1cG4xq00GkEz8/sRzW
         3oNg==
X-Gm-Message-State: AFuF++kM3dP081s+vP9ZjLwWbkafIQA3e7uqiJgPDBnX13VSTKABtVHV
	no5DFZ6UJ9JKfhWrkv22mx6LgW5v9MfIDBh58OQHWInusQhOl5S1pfDPXgdEJko/1BXENE3uYhX
	1EQQujjpZaYhtLzFze2yo3k6cNl+9jurunAVJlC9N1uc1wMwxMOuWX2jc1PCMjxw=
X-Gm-Gg: AYBFou2Bm0BLkQs/50SGQcwc15m3CtD1WwPR4eMycKZCGnxWfDL+0VZ0WVDa0z1S+CH
	KN8XECuX//JwxQmUkXJBQuc5bFAFkpT+KS/guiBZ9CQKoLyIlhamVCBZtO4ZJ+iFqJRVxNwFQf8
	Z84CU453o/32OqQO+bxiFPuajJO3EIcPw21u+R+7mnl/YFLlO0RTa49abUhDCDVbmDWYhy1WBJl
	/fiJQ+FsNkF58mPcVHsJwy1b4J/Czzl0sQ/+4ijnp7i0g8+JSNoX7uvOYqYaTqVl060oVATMlu2
	DcMPCcyYq87hPMtrMbFC+yODR1Vc83wHTGHg+V65neB/mx1Tgeu2SlxMRLH2Qs2ftzSUjATSy2g
	cQWYX2TEr7Hkmbaqt2JJKnw==
X-Received: by 2002:ac5:c84a:0:b0:5c7:d15b:5f2a with SMTP id 71dfb90a1353d-5c7d2809352mr1626569e0c.2.1788446449940;
        Thu, 03 Sep 2026 07:40:49 -0700 (PDT)
X-Received: by 2002:ac5:c84a:0:b0:5c7:d15b:5f2a with SMTP id 71dfb90a1353d-5c7d2809352mr1626554e0c.2.1788446449511;
        Thu, 03 Sep 2026 07:40:49 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3705866acsm147251fa.18.2026.09.03.07.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 07:40:48 -0700 (PDT)
Message-ID: <a5d83aa4-7065-47c0-bbda-35063034b0d6@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 16:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: sophon@radxa.com, Bjorn Helgaas <bhelgaas@google.com>,
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
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
 <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
 <B4EB99E5B76C9F40+e6fdbdd4-5c05-4b98-867c-29c7178a0d72@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <B4EB99E5B76C9F40+e6fdbdd4-5c05-4b98-867c-29c7178a0d72@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNyBTYWx0ZWRfX7rUOFC/6HJrk
 Uggrjp+oJ8Wzk6zsSrnpPG2gyNo4/pNqDij8ON3cg/N94Uhi7kvR241dmRCWUtDzSzk67dH6DaC
 itlQUF6yzN1wBoQueB8ILDWt28TschPa7YWh5X61nF3PCHy298OiQRVRZnIEVyS0uN7GI2GgZFH
 69ZbFqlfDADQLaPCRJxi79ony9fjMX5o8g7qapIv/F06dlsPVr5l3YrLLGbfW6iP+Us/drETDpb
 tGwc8sgHDOooPcHwzB+qi6GROTaTDb31UrMb8CUNUtVzwOjM4LosjzW3pbW0EnjvkSEYqFNMaYm
 dD8oIXW64mR4viBfdytQrx2qgqKbldiOPPz0vuiZ3JRwzMzlBOBymcchY9JRQ681NybI4TYG9hb
 eMJbJVj8MDA9MJKqQarAhDhNQ5e0vbpRFRmGFFdqaM17rZCFf6OX7brz2l0mzZ5k0zapQcazgBj
 I3V/DdZwu3dTft/ae9g==
X-Proofpoint-ORIG-GUID: MflKMDKNUqhh2YX4596rk7RnC-bncwOL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNyBTYWx0ZWRfXzcpLBGfANMKK
 MwI5biMD0C0ozaZbgqSebhjbapzLbZ2EYqTBaB91ui6qVhebMpGnk+vlYmshuUXdsIjy8+rofVV
 rXMiqPdImP7akr21s7KeNo2W34b2des=
X-Proofpoint-GUID: MflKMDKNUqhh2YX4596rk7RnC-bncwOL
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a9986f2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=z2R-DqfiRA8ArFDFZ6YA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030127

On 9/2/26 11:31 AM, Xilin Wu wrote:
> On 9/2/2026 4:43 PM, Konrad Dybcio wrote:
>> On 9/1/26 10:47 AM, Xilin Wu wrote:
>>> The TC9563 PCI power-control driver powers off external downstream ports
>>> whose device tree nodes have status = "disabled".
>>>
>>> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
>>> powered-off port functions during PCI enumeration raises an Arm SError
>>> instead of returning an all-ones PCI error response. This prevents the
>>> board from completing boot.
>>
>> I agree with the premise of the patch, but I'd like to understand why
>> that happens - do you have any details?
> 
> Unfortunately, I don't have further details. The downstream kernel also includes a similar workaround, so I suspect it's related to how the TC9563 chip is designed.

I'm curious in why the port is still advertised on the bus if
the i2c interface writes some magic bits to "disable" it on the IC
side.. but perhaps that's just how that IC behaves and we can't
do anything about it?

Konrad
