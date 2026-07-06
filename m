Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585A38B7D5
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333665; cv=none; b=aghmucWcg5kNUYRFZAKGx6+75cnKoJolFxorpsiQ6pW9STZAMbciAkjlG8MdXWUQl59xIPZlXKm8lahgdhDxq2rwWi2ai/xrIhrjwDmRzRp18illRLwRdMThOyGl24wRo4VzMciFkLAg7iNJRFnSUBPspZIImhjWvxdfmbCoiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333665; c=relaxed/simple;
	bh=i5REZAAc43M+MJhQ/yiOT7QFRqqFEhWc11/DyUhpPPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4PdKG88I6sc3ZsjWFmeQtL3GoWhU4XAVggLpbDCw1grQDBgNL4CucI/k1E+eeN6WNBHeORI+P2Ih0A3zV8i4uNA4VDadvkjgFomuGFcmaeFsEg2MlZVDL0n9AQH1V4Nq0t9Dt7YDcuaHfqCqBwFdfoorL7ClAiUVF+Atihs7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mshRc88f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b3FGOu4U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mshRc88f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b3FGOu4U"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669H1Vl160180
	for <linux-pci@vger.kernel.org>; Mon, 6 Jul 2026 10:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kzxuDmDI9P3nADMyBmziym9x+XR/HKbUY2Tt7cCbW9Q=; b=mshRc88fxXApwUFG
	KJB9ZSbjMs9DIPqkQND1+cGwJZ3j524UUyIo8TK4PpVwTtOQf6273dAYkWY2IZOA
	WUnAyCqiHOol2MYi6W71//6dEABP3aIRuBW1CUvRR4o9/8BVRQQsZGGZs4zUJdQ2
	kezRJZJJ6qkyZGlhc0DhFotrJzrRmjK3uQMEC3DTLMGDexc02wdWUtnX+aCNZmdg
	jQ9W2Z2viZxfx779woYuuUzTt3PxlHDBPaJKq989lebkgcDBb4tq5sRE841E0KGZ
	BNMw1bDlTEicsL60NQ5SI3Y1KDtH0f2vfX8pQD3LPFvO0BUfg3z1p+IFWJLMO6wQ
	tThFPg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgr95t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 10:27:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92ac0a54110so319142385a.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 03:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783333662; x=1783938462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzxuDmDI9P3nADMyBmziym9x+XR/HKbUY2Tt7cCbW9Q=;
        b=b3FGOu4UHQy/rBsSb6VH2NhtHxGFhLB1V/8cVe1b4NU4o+cil9nn3zUfZVe1pkmgHC
         ReW20ZAqhe/qCTDM/US6M83ast7vmiehz607Fmnp4Wtj4YuU7zeve42d1r1cuv/DV49H
         DMlWGdzfY7k5eRLf2M9f1CBLjHNNUT0Wfsx3F09rveBdZyGyxNfOVGH23/h+s1+qn6Ho
         a8Edyvt3N/0ogcwpmhVB67DVSm+Ugtu9ie9dwfJAEdlQJGeu3n1MFa9wxc/qVBGBwnq0
         itBk4Qnek+7HSux7CW94SaGCdENbV6jdQBg5uEyTfpG9hdVowBRAmcCYWoiYwKnooGJW
         WY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333662; x=1783938462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzxuDmDI9P3nADMyBmziym9x+XR/HKbUY2Tt7cCbW9Q=;
        b=CbtTrU/CKMlZb9VIm11c6XL+KnRDjtfTfOIfRNoKklyStuLGIKNjxa5GZEpUvzsmpC
         rgYJCOBAIpef8FtzN6sp8nToaqdC8KI22dAa4BGi0BsQgZpRzZFI7D/KHyiRvm66/sCT
         iGdir0qXs227nVaiVSJ/xv/78PFNjqO1sywkEKcLSrXm/7C9DS1R+jQkQmYzDI/Sr77r
         Pd1Nd4cRWbs5VIvVIaHZAFgbKQiYSXZ6Ni4UG53b1x9FmNtMrdZUSpVhJgBeBtKm3m25
         n6ivxUF/ArJHZifQTgCqd9Kb35t3zfzZgfBzQLSU21AQF61var6n0ilGnVn40afvxXlB
         D3kA==
X-Forwarded-Encrypted: i=1; AHgh+RoE7fmSSx43SDHYuAeXlxJGLKRCyeWF//0m40JUCvjeH7JrPIalFftz1hgbYpjKkh3nR/5sOVxePyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzp/qHVXX3d5nBGS7j3R6mRJetiN5FHXJu0J7VO2YrRBaVzUyG
	6/TFsGFo+In+eRO6TZNOreH6FCxI0yoMjMuTwfmAk9EhwLl3VNmPOOLdq4lUEujFWm7waEZs692
	MBjP4Ly61IMrLdxG7zTxmC0EhhMi0XZLWlItLOgeQ/d0U9RNNSfIFJB0LNJX2eNE=
X-Gm-Gg: AfdE7cnRQli1rbbBgu8Sv2apTrBgpTL4W66ogfhLGRdHTMtZvSU5GpN5loS4Qa7Tcuk
	RV9df+1TSnc1+qPQzD9yrrFtlsRmgY7AFDH7j7MIABGnLXxd7wqVkDh8zE9V/bR2N8Yl6Yc7qij
	ic5HAL+d3nkjaUAKmfTAvNJtzy4pnNDo5f9Rf+ssovPa0rIw6B7S9l9kFzpS0Cnhkp4cjF9ahUk
	VzvHZenJimcY3dBVAdFgUvOANHHSzRl7LhdAUyQlpHwmo9Sa9Sc/2Gh1Mp1sMvqgSBOeFokw3an
	7doWQ8Tb4aOsG7PWFajX/HeGdRhb3EswsbP3xrejtoP61Pd9evIiUVAv04pxZkIm3XQd/VEuRmJ
	+qGmCRedv37Wnq4GRcHNqkQIhSL21Q+49Acb2674=
X-Received: by 2002:a05:620a:19a1:b0:92e:6430:3c68 with SMTP id af79cd13be357-92e9a3987d3mr1253226985a.18.1783333662264;
        Mon, 06 Jul 2026 03:27:42 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:92e:6430:3c68 with SMTP id af79cd13be357-92e9a3987d3mr1253224985a.18.1783333661876;
        Mon, 06 Jul 2026 03:27:41 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm24299273f8f.11.2026.07.06.03.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:27:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1 with M.2 and TC9563 switch
Date: Mon,  6 Jul 2026 12:27:39 +0200
Message-ID: <178333365073.24664.13638699281586651515.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kk6FVmq_hAkHERyHK63va_-F13jbpJsu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwNSBTYWx0ZWRfX7zcBp/AxAEX0
 P7AR+XK8DaDp8A5RqlGtAKJ6FsMLHfS5FEV8Hb8vx7VtT4nA3xt9yejlfmKC49pt1xTwB+9Zobd
 HXonN4pOXYFGbl7j1BK11oxI4CkcEgsufdBzGy1NTuoWS3B+vmFjHreI2CuffVggqPcMfqyqkQB
 SqtOGOZHPh3li9zgn8cEOJds78a6k74JwcYh9tJsAD5HCuP0y3X5kwb7UPskfZsJ+yBbMS7mtog
 bZzInX8c9jSn7uuCu15chkG0YsvAatYzto+CUtjN7dShwFkCf4v1He9yF53RPU1UKpCrGbiH+M4
 HzcxappoNu3MeLobmlCj4cS5twKGws75w3p5A0hKViZ/nBVVhVgmK3e4e5/DG6TNXsp99ZwRyqp
 GUAItWXzvA1Ludsox9uG2YlhKxk3890tg4V3ZWfg+CV5fRiMo9WTkg0y1urlzCncPEVtdBVk7vd
 88RSNJRUaGmpqp3nz3w==
X-Proofpoint-ORIG-GUID: kk6FVmq_hAkHERyHK63va_-F13jbpJsu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwNSBTYWx0ZWRfXw1gDYADwfYMI
 2oo2xiH+dnfXpZNHRT4gcyKSe16HyL73bXkWcbOhRHkG8KdOQRgtp6yRDQ3lJeJpgZ5dFERqDhO
 50ECua5hKZc3FXkC034YE2RHwEkNUWo=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4b831f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=uuhBvGbuaKCM7wGRyFsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060105


On Fri, 03 Jul 2026 18:08:29 +0530, Krishna Chaitanya Chundru wrote:
> This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).
> 
> The Eliza EVK exposes two PCIe ports:
> 
> - PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
>   via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
>   (connected over PCIe) and a Bluetooth device (connected over UART5),
>   modelled with the pcie-m2-e-connector binding.
> 
> [...]

Applied, thanks!

[3/3] power: sequencing: pwrseq-pcie-m2: Add QCC2072 BT PCI device ID
      https://git.kernel.org/brgl/c/162ea02941a936f8899f3dbe10607b1d5af1b07b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
