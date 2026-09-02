Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5D3A1A54
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338650; cv=none; b=bLmJgR05LGnzrvoxA1J4vzsBPUAiJsfP5RoljalMNdsP3y28vwgOxbbv0uW/9OmElVKyVpylPC1vCkaFobfNQ9M6KDIArwYmYsKqFIii6/AY2pj+ujLZRGP2C72aRAL4Aj52iugGmE5IxsA0lrNNWuxLapS9pqYsrGHdnpDU/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338650; c=relaxed/simple;
	bh=GstLgIHtvyFTm90ArYuPevwty0lzfMMUujZRrcj/Sfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+e8imJhU5ZhT3x8luA0aBofwqzPy7IejRf90zxw/h3UbV6KOLwu7Q2G2KELYOhjPZ0GIgnlW0emBjNxbO2nOar+WZKUWxwlZRi9rxUc5I0poGxIeO2zgpqndlWdZ5wwJX7STztXU3+lS/S75WU7g0h7YBPEkwcUCZDxRPgwgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h0JcRGmO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iT9LiAzu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h0JcRGmO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iT9LiAzu"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826WC6q588392
	for <linux-pci@vger.kernel.org>; Wed, 2 Sep 2026 08:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i4OzhxkrdUBOFLLFsotE5mVozTuaUx95en4vSNcnE/g=; b=h0JcRGmOW3yXBfJ3
	Jwg/N1/SmEx2X+CMj+1kJeGOLtnZ0m3Hzy7ubZpgM3LSK5QO8HNKhvVDxFOTFL+n
	cdKpYpumJFH8c12HE2yzjcbcsPSkXkpYoHbCx6wqEzWdGOad2n3eYt/By4kq8tsm
	qXgWaWidssOkHkYai8YrCFKBDW3Lnrmj8tiwsYd5vzPPMq+xZuMBQUsNZtiGvdpa
	mwVGB9FXu2w5aUUaxzAuIKl6Ssexe97sB8v3UzobuhuBSunsQ87miV0XuqtsCw7s
	uSXJ0Se2Xbu5nXqkmc31W5BnQ793GX4bG38y+9NTNTkNPD0zie7MiSPiUNCfr8XH
	TjG6ng==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge435tr66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 08:44:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51ca37ce4c3so1859361cf.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788338646; x=1788943446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4OzhxkrdUBOFLLFsotE5mVozTuaUx95en4vSNcnE/g=;
        b=iT9LiAzuyI8jwF2nWSLcnoIVYJ/Sp6Tgv73j1Ktqc32aoCW05qkWQq5J8zXunGpr/X
         +jkjIW++kvOektaYWpLP2wgNBqsINVDt01JWXmzkuU90e0Fx9II3E3aJNIv2oQSBC3Tg
         T/qVQ9uDzca/9jWx7DRWgHkiUIGi0A78FniPiJ+EbgesdeOch9xcH4NsKAZZ8FUsTZa+
         QTUUy00ahjeuLX3Rf4RNasHaIF2F8rRGk71oF1Fz6jS6aMqWKkSAiVU5h/D22KNVa6Ql
         TlbRCKbsk7OIu1S7lg4dcVu5E9MVnUR7FznXfuJ+VE8YjW+qNHaOYlrJ4Bme4IzQrEa3
         XbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788338646; x=1788943446;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4OzhxkrdUBOFLLFsotE5mVozTuaUx95en4vSNcnE/g=;
        b=k0r8rEXfM6Wu8JNL45ROYEhIz2Jdx207V63ajt9q1ZNUzcYWeC0Jl3SdJq5yAsCZs1
         w8CbD2xl/hApkfgvm3BGE6Wes5bWrIGNBYgNXIlGKNDW87HzSsILjD1EEyhMEo6E00Rx
         OB4QFABJ075HuvXQ39TWirG98oBeZC5pRuoOk003w0j6c7ny9zQ716b0hS+PGpGBoqbg
         YWYiYCUm+ObFb0gc7V01Ry+Qc1NfuCqRfJLRFZU2CUw2MGeFrpDvm6ADE+F3Dd9zxdLr
         Sc2MrpWC9fg0uLMUGN3GLmYeh3aQlEtG4kcuFJXE+LKZQyHzXNXs/ANBkGdPgEUsG/9y
         wXgQ==
X-Gm-Message-State: AFuF++lHUIKcttsO2QxMP9CGJ0jmEslYEGgMUFurRKxpUvio1yp71E7y
	dMywd8UFLNfJvxjWaFT2GRA1n/TFW+P687cMGQt3A2hzeqHT2UKcbGfuVgwxfoWaJFAUWjng+sp
	fD7drNWsR5joZhO+ey0ljhkDLvu/CWb8uoqezWNo0MWmKjlyK8r1FTQrrVOfdN7o=
X-Gm-Gg: AR+sD13rh2dsh6/C4cm2fmfOgHIT4SbuAqP1k+Sx57tAo7rbtF9UZLnJV28mU46RFQ1
	E5KC5tkS96HBIt0VSgx1Mk/EFiOmZYdv4oJCsnN6HSkn+KfatCU90MW48tB9XHuzzJmUQrvrxTN
	m9Zmkh5KAtw83sA5zi+j/nFHVb84UEJOPDdDUg+FFxhUiFZtdP9lzooZS46nO3uJgZ5uft/V7zs
	Glm0FPHue3AfCCULdRB9KvI3vpgDjGq2DT4jrYcZfM/iQPoN1Io32/b99wOHwZVl7AxgO9ePL2j
	oiBu6fRQ/XSAnYAf7kWzh6BItd4xjSbQyyCDNQEgpIuJprbc8XiqvcmfQ8uHDFAnmNxEzzqhIN5
	uJc3rWNkzhJhKfk8TDz5J7Q==
X-Received: by 2002:a05:622a:115:b0:52d:9a83:419d with SMTP id d75a77b69052e-53036992976mr22276361cf.0.1788338644082;
        Wed, 02 Sep 2026 01:44:04 -0700 (PDT)
X-Received: by 2002:a05:622a:115:b0:52d:9a83:419d with SMTP id d75a77b69052e-53036992976mr22276031cf.0.1788338643648;
        Wed, 02 Sep 2026 01:44:03 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f895e14sm673780a12.3.2026.09.02.01.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 01:44:02 -0700 (PDT)
Message-ID: <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 10:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3NiBTYWx0ZWRfX+n4reayyUnOu
 q9XDdkzkdLI8JAbNZqKBlQpU3n4y27/3GoQeS1gsWGhFg+MwS6+fFAbXKbWMcQu6Gmg9NIJNLpU
 MuoDJ8VyqdXkZN1oKMpYGiCaVLJXHPrmt6jU+3H8W2ykFy1CTVIEMpbFaHTB9GrfsmDm4Nmk8+N
 gVyL7q1tS1VybLTEvLLaOWzuiQqZca/NLQvCJebrl1qDD+mqy+4T0RZcmJw+xf1eObPKC7KvnC3
 PexTvl2BMkD/jDddm9mAXNVqHBFeSmcRbJte5m/plFx+qUDGizKD07jeAsfpRXHqxJrJ1RE/QCx
 NsgsvyDgl7yJjyeNOiEjoW79ilJEyamTQtyTcG+3cWQVl7rzKL+7ltjHUrgbaMdS9ZBJysM22x9
 SSBO2kfeiEJk9etede1wOA9tOZcyq6OIwLdstceEuey5xvfwRJN33nQdVhYPWc19b8YPjmAnthM
 huql/1MlN2gmkLi02vg==
X-Proofpoint-GUID: axgxXo1W_9gx53mfNUBUqkQpQmUHOCD7
X-Proofpoint-ORIG-GUID: axgxXo1W_9gx53mfNUBUqkQpQmUHOCD7
X-Authority-Analysis: v=2.4 cv=JpnBas4C c=1 sm=1 tr=0 ts=6a97e1d6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=i7MDaAbus5dcvw8aKywA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3NiBTYWx0ZWRfXzyA3ydulAJjU
 iSo0AHNmp4gw9NwJ54BmsneFDgWfl753Kuqu+f5q7iBjbBdgBDt5B195c/78/bF83pciIOo+hiI
 OztN2iV4qoU8LLtiAPxsXgC4zEmQ6l4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020076

On 9/1/26 10:47 AM, Xilin Wu wrote:
> The TC9563 PCI power-control driver powers off external downstream ports
> whose device tree nodes have status = "disabled".
> 
> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
> powered-off port functions during PCI enumeration raises an Arm SError
> instead of returning an all-ones PCI error response. This prevents the
> board from completing boot.

I agree with the premise of the patch, but I'd like to understand why
that happens - do you have any details?

Konrad
