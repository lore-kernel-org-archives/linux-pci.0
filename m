Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811580;
	b=03nD+1TqmXATOEs6qMs3UBe2K3Dt58zh/IL13xQzZbr4m7+MxQfsP0qF/YSXhBFBCIAb
	 kZGf1tEoKnMvGqNKMcbuzn/JTH1vA/9AL1tWNj8/OusVpMa2ecBBfu0P87raFnP5oMWSY
	 cOc0CuAKe9mVap5sjVf2348vrI5iPQn39msYw9nKNDiyIXh3RD6xqTFFVXBReukvb6I7P
	 4WzePiBXw7GIvRXwCWS886kVKvhNlha48/o9V1K0Zv68iklDMFRAhsByUwxscJG/7aGde
	 DqF5ZFOFn39X5RWwMlEJj04j6GT7A4TzooPPM810L0AetWPB5Xp9BrOlsTznNS+elng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811580;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RdbGxG6smopZOWzLypq/6hlFg6tVOfBxaUqDNkzkyXk=;
	b=Hn9zbg/Bi/tGAjnMVe5VFAtNUObC56Fm4aUuKMSaDbx1j6U7SuT8OZRArw0Fbg+4lw5f
	 DkGeIoS/eLo1G9nWb2tyB+dobBLLp5UKdmj2kBnGgsv8Ehhuee/KPBdoVqUjXhAUBiKJD
	 OLREADKMaKraXUVtU9+PWjwB9s9V1boYuZL1TJrCvJywiz3uK6YbEJrCgPILD3FzWEEZi
	 Ct2oLkmY56p8hPjEth/dDx59aw53MZ6u3g88bBs4hi7njJu48vgMbICDitHqAkweMwVpN
	 AuJvu+D89es0M8O7YKYEXekY4yRJr3yF9qJdAYt3aST4mFFC5SS+KXACF8C9PsZVqNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=opzmeyBk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g48J9c+Y;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EBE606A323
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8EBE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=opzmeyBk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g48J9c+Y
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJAtQT3038734
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RdbGxG6smopZOWzLypq/6hlFg6tVOfBxaUqDNkzkyXk=; b=opzmeyBkNRaTl6Ip
	vhb8AXh7xDbxZjFujumTPew5ZdjDSgWczgXMZ6P/fkbwsBRocrkAhbRbLFw93LWc
	ZQc6dtb2704fOdLQM1IlRnNk6FQhg2OY6y1UP3hA1iKTvAQ6UCd3kbhBAbBcqoHJ
	Oke2YxFTSXrc2zlgBFk1kB8FDPnY1V3aWxF0soS6meoxuEO8sVVqDq2nhoW/Xwkw
	q30c6AuR7CHjzt7YG28ioP3EKAL8zbNsjN7iYVj1BRU8Rm5RXQFkCfWSA758f3Uu
	Zrn18arN+XsUwkTjKn5bFU2BoZIknSL4PFql3w3IecpHTa7NCG5nv4mbjzuw4JFf
	pQzFQQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7e4ngf62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:32:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-92134f1eb00so115172426d6.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795811578; x=1796416378; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RdbGxG6smopZOWzLypq/6hlFg6tVOfBxaUqDNkzkyXk=;
        b=g48J9c+YPaNCituTlhvAkTROtSCEsbUmU3xgh5hsBHy0DncpUX+l3cfbBmIvIVCps6
         iZZHceaBKmAwuCWS5UPyPtBF9sE4ZpiC9HDM1JXl8frU/x3yKLub1d+NF8nV8cXm/XkD
         eskW/Fx4FmCzBBts7EvK1aaB34vxGeaJphnnTsKTRGWi5fvHjixt7WVL6cNEwD7m3BMP
         vPQLlOkfYaNiF6SdLR8MdDMlzGTR2fKajx2+t1qRpS0g6vAxPL8n6PhaXbbheqHqxO47
         kWzuo5RTasexOzju1hoz8rIWZRe1j0PCfNHtMgkkRwwnvihljHNNvb7k5yS71FRi12FZ
         w7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795811578; x=1796416378;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RdbGxG6smopZOWzLypq/6hlFg6tVOfBxaUqDNkzkyXk=;
        b=c0E0p8AZsABXt2OwTw32HsWeUYti75RY7W7W9uwZVA9gH2hLR5VFtm79ZGCZAjZ6ps
         JfByiIA40FaLfArTGymibUp18Kr3GUVyJNN0rVumXYBRLmIZ0X+1F33LTPUEvIM9C06j
         8cML3o8Z4GE0n8obDUh4e8jO5DsUfiL2SXA1C5nuJND8lSMG6Rk/Vo1na/KCOh6UGSlb
         dFnvFx0Sgpc/itenvEFWjRhYSq4+u2fI99b08F7/g8Hio7VsGx19vn5vMstzNXSjoAMx
         FEBNl3ZtuMoUxNy5XrGGJQlmVBTDqFJ2QU+4ztNj5KHAf1n6sUJFqpyanTWxLrVfUlso
         1d6g==
X-Forwarded-Encrypted: i=1; AL+hErFQ2joTn6ZiJ1gkRyhRx49dzzE7+UKFhBmPAK0SkS6S3qEFAtSxRd/FQsPy5nIbV66ueY3lq2KP4BA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JPYEE2E5oJJTgtEno2NPBjhDeQrQ6SimzfCh5lHqp8H/K4ykX
	yy1lUKYj4hUa7jRb48ERjDrnd0VUdMVmxyUa6aiPYF4pvoQ0iFYkTCcUiL9hq/NR8/zyEVBSqTZ
	2GsyMAE2w4iaNnO1clegj+qUunXqZ3OkFyEB/ySKfSJ0bwGxMv6WfAn86vmcDgaI=
X-Gm-Gg: AZFdTZdd5Kb2xZh7Zc5DuT01vybGmMgR398jCnwox8+Vqr5AfUqgkajxMw2H4HJpXEP
	/Y1UGSVVr9kvvgx6u+fjhH5pu+dPbLVUqwS2xNg6+FRb6BIJEEiaCcHJfUbD4EQZ20keWYeVKXi
	/Cuf7UMJ6RvMjoN17/HNLJK/eb3y3k8zz5qiliZCZWGzaLgjPyWm/20RcuiREVD+awx2DqMs/du
	1puNr7Y4Qge0AXaJMNTJbF/a7/7/8+wi37S1wXjuSZHSIraB8/Bjs/4/5I5Y5a0xqqRI9JhLhkK
	3weqbwzR0sHgWIahHLH11gCe98lTm2IdTXr6KaVnibuoh22zXnGHwWZpaq9SJWgcdb5+YynH9oc
	RPjCr7TfsGqMzjcKEFpLVZYuh85Wrejq+R0qfwSD+1X5k2Vb3LzZb32lC4igOdg==
X-Received: by 2002:a05:620a:28d5:b0:949:6d4d:2396 with SMTP id af79cd13be357-949ba9c6ac4mr4407929085a.27.1795811577986;
        Fri, 27 Nov 2026 12:32:57 -0800 (PST)
X-Received: by 2002:a05:620a:28d5:b0:949:6d4d:2396 with SMTP id af79cd13be357-949ba9c6ac4mr4407922285a.27.1795811577441;
        Fri, 27 Nov 2026 12:32:57 -0800 (PST)
Received: from localhost ([2a00:23c4:e5c9:901:c496:8838:86d0:bc8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm709585635e9.8.2026.11.27.12.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:32:56 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 0/4] arm64: dts: qcom: Add support for Radxa Dragon
 Q8B
From: Christopher Obbard <chris.obbard@oss.qualcomm.com>
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
        Linus Walleij <linusw@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
        dragon@radxa.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniele Briguglio <hello@superkali.me>
In-Reply-To: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
Date: Fri, 27 Nov 2026 20:32:48 +0000
Message-Id: <179581156894.3905807.8399699622838832226.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=364;
 i=chris.obbard@oss.qualcomm.com; h=from:subject:message-id;
 bh=uTOlrKK3r5wHlu4GNa7hytHvMz4ce38/J/1xbEGeX68=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBrCejzTK0vY8gwlDXzGRSZrdDk2sadJ0Wm183Rv
 cxZQ1XiJSuJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCawno8wAKCRBjTcTwaHBG
 +AxYD/9UsZNT7/FLc955HpspGxAIsT9gvOm/npB6eyd1uICYgQQa5CMdp03G7hw6lorCfcHe5BM
 A3gtWHV+8rfD+AVTMvNdEimJwVR+bQ6Jv5+SoXxZRbw6Dhjvuk5JeDjQCYPSJx8OkQlwe4j3g9O
 4JgPJeSThp0kFksAAjHOVrbxWmekg0WR45tsFX5+fzemIlOxNguBPxtLDzoRFV5jV9+uhlGjUs7
 PU4G/f9h2+t5PZIBoJ89CvaCzh1mRl0eXDXz0q77PYyPYoIlHMXeDADxgvFMCgN0+GXR2g+IBLf
 supvMhGyrT4ItRqqRU9nl3Pu/xMLNMdegq4kKRNCPRRYvDC+jci4KSBTAHx93tA1pJKT8byI3aq
 0KBC/IHH+xt03QLOOxCMsaRI/ZX/NcTYo+1AgVnaD3m/3DY1hYC1QLMlQgja3Va7F5Egnwky5Uy
 4LLp80n4YpNrpMiKMoiJK1ubZwRlhso0hN7j6gUXjJFCmF4FWpj7oydhXyMrsSS55NdiPwjurj/
 zXHmsq8moGAE98cGq7IxHI/Q0Tw632ztNsQVEH93jo1EVNIkZw4ZvHMmGxf5lzo9Viu9xf7Kf7z
 J9Nbuj9ILpohAHYi1FVAI8gQDGZ1eFDGJEviLW6Oe/jCbGtp1KvfD/VR9gcRP7PKO3YtKkMyMcC
 pLsFwktxzCIc4VQ==
X-Developer-Key: i=chris.obbard@oss.qualcomm.com; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX3ccnYKhf+VaG
 WVrnvLUsujNR3eolDndUSrOjtk9V62OmZ0e1FmaeIyyZRjwjy0pRF59HmFadkI3mMCo4KLABG7Q
 4pO8kfyYbngi35+d2iX2KCYv4+a1RAY=
X-Proofpoint-GUID: ofu1424-MOzyM_ghFtT0hB_JM-Tt12qf
X-Authority-Analysis: v=2.4 cv=LPLz05W9 c=1 sm=1 tr=0 ts=6b09e8fa cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=bUWDG7REKp_wvTPU5MMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: ofu1424-MOzyM_ghFtT0hB_JM-Tt12qf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX7ky5LSg9yjkY
 oxrKQZeNG4e5zU95kirT+qSykCj2l1bRazWKDCPUrGwUeWWv8iTh4piiv9slhrz+b/HyO53LHiQ
 p/Ip73c7iUHWg17z4QQPqEaxV4JGSD/Dz8jBwRMDguEd3g0hLbJsW2Xarh1tPkOIDN71/gJ7qbg
 jA5NrWy4MGRVF0lgg6Ai8tgTbrd5AER3tO6JqXcTJZNxAtI1MbDHtmN75SSkDuhSwk8jgoLJsXJ
 38hJAo6wSdp7Q2q+/TMcwlRoE4/GcqX8P23Y/g2s9YoA+KWsfN2iguMnaQExpsX35nfD81ykS8f
 5nrmaWkErPtyGMwdYQgQ8OIoWDbakPOnmALUdgm0idPMusl5F39k44+ldC7KgVWH8KD7wrlS/9X
 rJSXKAh6LWH4esyonDZDNF94FRZTiOnfUGFNUIZKTksoiGFMOHBxlvaK1UPxMtj3WBIyDhOdTSW
 dH02PD6B62Xv4kTt6cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270081

On Thu, 29 Oct 2026 18:13:34 +0800, Xilin Wu <sophon@radxa.com> wrote:
> arm64: dts: qcom: Add support for Radxa Dragon Q8B
> 
> Hi,
> 
> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> Snapdragon 8cx Gen 3 (SC8280XP) platform.
> 
> [...]

Tested-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>

-- 
Christopher Obbard

