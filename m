Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8542E40F
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976244; cv=none; b=rUKtOEhiP80d/18WJAGJ6xxvxIfu5/8gH43M9Ny2QRWPnPJfNsjI8WvDfY9zMRqQr0awKf/zI7asdB56g7oemCbEBh0n8QLnCkrB0qMlg/KjvSsbRCOP2qMm0Eu8j+b0stfrui7Si+Vub4vrVbUJe+hW5wfT0fWuLNx8hL6BE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976244; c=relaxed/simple;
	bh=zn/AZhlI9NSBovtLHa/ZrSMdu0QzWX4YxJ9bkOoAWso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0+wdwOvrqi4CZLGJXiOb6rxVlF+iznLY7e9M1GP660RBTrIBIRVJebiRHZHTHv2AIytMehDvIxh07QP10pfWXXi5UFjp1aBUK2lE7NUacNXnpJSY8b5xvxGl1T1FyVgQGwDwjFCXmZNq9I5a/AvEt2P5AEY1Ti0TrhXvJlahDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVZ/bqTm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gs/3lb5F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVZ/bqTm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gs/3lb5F"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79fmj3952276
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 07:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H4vkek0/ZbqGdMSZk4suthyJcTIAG7Z7PUDKSg5AbNk=; b=jVZ/bqTmgndhwE0J
	coxsNZ8+mrbKWW8CHCFPd0t+2fILFKxyHNCEub6ZxeOTHlwARyBQ4uOaFygaM2W7
	TicckL2T2tHhyKid3cooofHbUM18EvMktw12QbEOHx0famlhHi25FpgAxNFa7nN2
	malkcqr9k76IsdfGnvSgFbsVU4NwrfCObSs65oP6gxRVz2jvbJLGmfRTgBUXFlqE
	JJvAyLq2tyWluHF5FWp42RvvwVOs0UXml/rDih1aqYlbAQzsod04Uq+LD7ovmF9G
	eRIh8GSF6lyoIkX/Aaje21x+hQj6J+gqevKfospTyywVMcV5D+YbPXFN+mPZTykV
	uqr8AA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gskp9w64k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 07:37:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9349ba88188so55284985a.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789976236; x=1790581036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4vkek0/ZbqGdMSZk4suthyJcTIAG7Z7PUDKSg5AbNk=;
        b=Gs/3lb5FKOcmcroC/9FWcR2LaGHwfguSWEu0/w6dhXMwpTSk3uj6WDalDra748Zcs9
         G9jrdHBAL8pfgRpWhGnQ6kGuLTz5ZlwWLwj+PMTGWg2ystBkWi1MRfSdvPUNnIr5kpDz
         InLQTuh4dmtNgdQHgFzxCrTgeomXqyYbbZ97ymfZS26jwxCbedLEMldglfAW9HxSNZiY
         EW0NvwkmD4zUt9+YknAbnz1/lbHzRPf4+9s1KH0d+l4lMK1o+LfKDqRXEL5R/1rBoT0Y
         7tTR/SIHAjnepcYwyGCrGRKR0unwMaTaTisGvahb/dEFNc9N69pG8ODP5o3FrOgwNBkc
         6H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976236; x=1790581036;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4vkek0/ZbqGdMSZk4suthyJcTIAG7Z7PUDKSg5AbNk=;
        b=C/pbESOE3CtO1Tg4L5CVG396jq/4eFSFNZI1Vt6aE/4Ew5HF2OsB85kSyGsETzyN6W
         6KOBCWfyuanOBxjMny3Mzs2efXIgvRCFyv+nOVoHzzaN1JuRozZn230m0PRjcC8SGATV
         mmmxN8lua4irNzHu6gHDG6xQm8zxIUZk4sooEjXWo+pP21admLzi5Be8d9VaLbEC/9uO
         1p+45WRkS6R53DNkN/o6GKuwaMAmIJACahwe8cEq7j9DrcLyKT5mJZXDxCapiQ5W+UEd
         PburpqKT/WNX51nP9zgCi/kXMfhwBvju9TcbLvEQoLrhZJv9rYksL3GXAYyV+pf/oKr9
         wR9w==
X-Forwarded-Encrypted: i=1; AKwUvBzvBB/4ZNb4k7Q0IPpNm0n3mNxdQ4F/Elwb9RHmYd++zI25fwwIcnpmIXky2Dqw6EOPQJeRPhaMdGk=@vger.kernel.org
X-Gm-Message-State: AFuF++nX8olV/RQ8ttsjpvrPz39bkLYUUdFzNulY6XPHrC0+fUPD0Aty
	kxM3Zbmqc3BY/dSB+QpwZNQaSDT5yQJSWcRFFukvNL5xvoDGo5H5elxPDSlheRd7QmPARWGBS+/
	SUEvILl4Oja7NPgO7MsTSYiX5wj594k3nl5ChmZIW8O/LwZnS4w7g3SlWqcNOW58=
X-Gm-Gg: AYBFou0qV1pXsIKU+ynBBtgYNN0QHFROv86Kn4Pr84J5FQKvF4CRE1ilCg5MaQ14bsx
	KKXIFljKZwKF4qakNnXUFFe/EJQjxxapOImcqPvBigZojof5naxXUCp2fVEwGNpNqiDf8TorhQy
	NoiGWIjPt0+Oq6AdaEF3oK5dp5oIMqzPxt6Lh8BhK4ZMKy/3KaEr1kkXpJWVDBdR5+qAvO3vCYs
	UOqZj9XlMFd+C5VgNWtRiq6vQiXDlbRvVkCLL2RqRGgC7vEowN+rJPSC0Etc3B/jGo9ARohWloq
	bGx9PU+0oShbYnp92B4NT3nIpeVRxMlk4LdEZB9YSj54TdIuQbdQAML97uJW5lp4RP33kndKgmh
	lCePf4jn95DGEl8ptZ2qXVg==
X-Received: by 2002:a05:620a:6cc9:b0:92e:6485:f640 with SMTP id af79cd13be357-93bf577a07cmr801547585a.4.1789976236108;
        Mon, 21 Sep 2026 00:37:16 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc9:b0:92e:6485:f640 with SMTP id af79cd13be357-93bf577a07cmr801543985a.4.1789976235653;
        Mon, 21 Sep 2026 00:37:15 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3573ce12sm262631266b.35.2026.09.21.00.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 00:37:14 -0700 (PDT)
Message-ID: <dfad8320-5a92-4398-83bd-3e796faa24a1@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 09:37:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Add PCIe support for Qualcomm Nord platform
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, shengchao.guo@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <arDPABIQl9wKYVKa@hu-qianyu-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <arDPABIQl9wKYVKa@hu-qianyu-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MzPqexjToSm6FAFJbQKCngQlFX_4lW-i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX21+IzW9p399K
 LwSw5ukQsAmt33sEkZkfL9neeT0DGlZ98i6aNNKnnR1DXKUEmVXeHWeXVSy8X2g+gzfiZQaVvZ+
 giw1D31/Bje9TzFttKjuvmqztTcqVMMFjvL2VcldO4VcgHDwfdyt8Q3qveZR29YukA7X+9Fp6aq
 udNlEibuZOBd8vJ5Rv9OKzhE4d/ChYEdeItrrKRnCO54kRRxvp1zHX25ZA+9nwOSZRvtA4jMWhd
 A0aJu8zak+J2bvFFZaN/fRJN3I2TbCe7YysrxAiT9Iqhr2Lno7CZiAW18cra9L3m6MTW4xZ+Nn2
 p0BguvnQv/T+UV6W/p+nI9bcSLQvaz6KUCheuwoQ4bjkyFZC7VlTrZzfCci23Y3ibQ9RVb5tvuq
 Xo1QRMsQi9yNGw/7ie0cLUUhjsxnMGsycQA820wafNEwa3gooHDRxQgpAIp2sqjkAK/6w36plp0
 h5QJRJBbfyp33t9BWXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEwOCBTYWx0ZWRfX0n+oBzHI4J/Y
 c7ACzMwvqs1wqDRkF6Q1LIEHdoMq0L2Hmdl1Gm+ImI/RjAUAzmYVMV54JbIbnPiiwxYw+ARegNS
 Ii0REQ/CWioj7b+NpeJn/dt7M28g0wc=
X-Authority-Analysis: v=2.4 cv=BKAmP1QG c=1 sm=1 tr=0 ts=6ab0deb2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=eQCDFL0YdFa3ysEWRUMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: MzPqexjToSm6FAFJbQKCngQlFX_4lW-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210108

On 9/21/26 8:30 AM, Qiang Yu wrote:
> On Mon, Sep 21, 2026 at 11:07:08AM +0530, Krishna Chaitanya Chundru wrote:
>> This series adds PCIe support for the Qualcomm Nord (SA8797P) platform.
>>
>> Nord has a single Gen5-capable QMP PCIe PHY block split into four
>> independently-clocked and independently-resettable ports (A/B/C/D).
>> Firmware selects the active lane topology at boot via a TCSR
>> configuration register, and the same PHY block can appear as a single
>> x16 port, x8+x8, x8+x4+x4, or x8+x4+x2+x2 depending on that mode. This
>> is similar in spirit to the Glymur multi-PHY support already posted,
>> except Nord's PHY registers are programmed by Linux rather than by
>> firmware, so this series adds the PLL, TXRXZ, PCS and PCS-lane init
>> tables along with the power-up/power-down/soft-reset sequencing needed
>> to bring each port up.
>>
>> The series also documents and wires up the qcom,nord-pcie compatible
>> (reusing the existing SA8775P PCIe controller binding), and adds a
>> CORE_CLK_CGC_DIS/AUX_PWR_DET workaround required to avoid a timing
>> convergence issue in the PCIe power domain.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Tested on Glymur CRD and Glymur QCB, devices can be enumerated.

A test of "this didn't break my completely different board" is
welcome, but looks a little confusing without you saying that
was the intent specifically - unless maybe it wasn't?

Konrad
