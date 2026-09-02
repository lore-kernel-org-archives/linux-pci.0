Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8C435A84
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343908; cv=none; b=RN0GhEIySr6l6pIYuY6RhlRW+b2CsW4YIc14bfkXm5j/gIABoa2ePR0+j7ZszfUOMG8mY9rRkWaZu/q+qztzhV9CP2g3kg0ogMJS6e9KDsNJ8RTEKeGBUkPEDjLBPkFizwjmDasny48kTKgDWrcx9kzU2bP6lO3NRLl+uQxlRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343908; c=relaxed/simple;
	bh=MqnEivMcGljRZrK7sqB9AWRPTMEpI3mNs3vN5Kxlhko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLxS41CXydqpoPp8nRhjXGOTJTSjjThnDckZUZzY3GTlf3Ntdk+GQTGdkD/gMK0a5U9+1jzCgq4k6xJLBQBdL15E7+iC33mmjybxxgzp76Mja67R8OIp9jJyqX08OO5kIk2DYWeLCWyvaggUyJ4q5Uyohjhg9vgII9aHFNgizX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UeK5KfgL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hGG7PBTl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UeK5KfgL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hGG7PBTl"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829N3uX1080198
	for <linux-pci@vger.kernel.org>; Wed, 2 Sep 2026 10:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hGLV8ocmkLX6cUaKfIwRziMPYkvvnBHHmbRn7IWjrAk=; b=UeK5KfgL7e9oD8Tz
	75rNoo3ECYfgWQ+mPypX+A7CArwBHs5szY51yvE9FgFobhIG/n+2GPczqYA4VsN0
	5A4tDVM4LXQeO9L0FOakPDUsk6rGpplqZZee+VKQnVYW0ai5C9Ijyi4mk7YH7oDn
	VpwRo4SZA3n+BkXwrmQFr7k3iSDF/fMtMy7LbpYfojxRuGiL+w440uDaGCGe7SZM
	8V9WH6NPROUqd/poOoEwHu48LnMS+ZxTn8AwbNzqC/5a4QExKZB02NKfnM/zLOBM
	IZFlo7S5WWnYmv6DOzdZogTaT9Yrt1s1d7bpkBben7SViIxusEwwwMog5yngzMPB
	D/9CYQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geb561mc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 10:11:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93821883e26so26394285a.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788343902; x=1788948702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGLV8ocmkLX6cUaKfIwRziMPYkvvnBHHmbRn7IWjrAk=;
        b=hGG7PBTldJuaUCDzK4pGnIOsIT1LGYLPaCO70GIdWUM3JVIf+z0j9Av4JZWZFJOgtm
         J83qH1YHmmFP4pNnEh5aT0ghpzxGhDBKmzfx6MUC5pyjXCS+3QgvC/bedtq5xz39U0dl
         f48pwyPU+GF4a7tIYhDjxKOrqYG+kVI7/g9bxdWIa0dOUpztk+NqzYO55lBR9QymVdGj
         OGUl9X4Pc6E8lzuRrvATXcMW3+txNKBCXsDnpoZFwaCicktAxpIAPgnK9K1czHEKK2/7
         kSTlXTSG72zyXQfkv3VltAnXB2ph38YcKA1PV9LV0b4fB+nJU7cS847Q5EkkwNI2SOzX
         yIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788343902; x=1788948702;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGLV8ocmkLX6cUaKfIwRziMPYkvvnBHHmbRn7IWjrAk=;
        b=fDEJBuQrHmQ3OiwJ032wbYGIjiDviCNCQmkmtbPy9a5W+Zl+T05rAL/XeSdcoXI4wa
         bfWBGk1qmRnGcZgmT77z1aNWdfWIvIrIjRLkduNriGE7JxLElF2wxLg84uqsHhqog4Ph
         s0O/T4fO6OA0TOpTShKuV6lnd+LF6JkC4i7eyhwIlyNCljT346YtdLe8eTA4zY5SNaOg
         2V2glRoFCEzPxpWv/E+wOTxTFk0wCybzjJJ052geSC+wX7axOkZmeNjkzuVCVr35r+Gx
         tFM0wCKi1DDfCtgKIiEPeiGaMDgwM4W75uQXWxfCllvX4FOLxwEsO7dpcJXkKKy69ZzZ
         9jdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpONZsMZQuGnPKwNCJly2u2gEN2lBKzFFQE5L/D8FMQAmnqUICP9NtUpf0KbjakHhmazpGczBdguh4=@vger.kernel.org
X-Gm-Message-State: AFuF++lOyWaRBN0PreT0ENqcsiLZD7am+efEZeG6U/87SJxJuzSgg+qI
	3imln7f/GBXC4BR2c6lB4VfvTeaSx5x5jmLtuLkwK2tkJFaAt87xZK0awStm2Z+Z2WNyJyD7+WQ
	kwqzJ9FZCJz/DJgwomm7f4/u3eYXwiMgKdOzKz1xOgVol04mbmtko1Ei4T79sifg=
X-Gm-Gg: AR+sD134oHFXJd9zZeHEQOcWESlCzs+bd3X8b56u7bkOqAw3O9i8Ndgx9oLklj1c7Rb
	Zi849E0a9y3sa7VHFSmfx8jy9Do4XTCHDdVVeFrPTU5R57Hv5VSJxD3DLa27R5kijpwAz7YhTJU
	ZSz/QMW/2rX9GrFsQ1Sa05QzaIZLZJTUvgh722ovSiStTR8WkGDNJ1RqlKXWKUR/PHVW1dLATOG
	K/N1EYMDVnFzrdwK2bR/xyZlv9dC6E0hXdU1+VSGRsV55kUDaWPnYF6XPULk72xR6nxM+kabCLz
	MD5A19R1I4AfXAH+WUx2jLPNQSKFx/IIfByGjEjHMxV7ZDr2NEa3wQmfRINeTHlCt/70fi0JZeJ
	3tV2JYpFUuqU2S5dIfn0dzQ==
X-Received: by 2002:a05:620a:1729:b0:939:48c8:656 with SMTP id af79cd13be357-93960cc57ecmr241732285a.1.1788343897379;
        Wed, 02 Sep 2026 03:11:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1729:b0:939:48c8:656 with SMTP id af79cd13be357-93960cc57ecmr241723585a.1.1788343896176;
        Wed, 02 Sep 2026 03:11:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d039c9fasm105678066b.31.2026.09.02.03.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 03:11:35 -0700 (PDT)
Message-ID: <18a73f51-a535-4cf2-a4da-d7cd4fd2a801@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 12:11:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-4-18bf59d19d6f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-nord-v2-4-18bf59d19d6f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5MCBTYWx0ZWRfXynxeKJtbm+vV
 J5n0cahPPuAk0iQFSo2hyR614o9yYRYn1XoppFCy4bAJ5dNn1dMKKTmRFSDC+FTwc0T8A7Z2Ds/
 g0p96RVj5YraMt7UVbFMQ2WaM2uaTQCoWF3TRGx8hRnqRLVh1y3GluDGKc/UZAkb08wd84qYWwf
 Z/AIrzdN8sl7jLilSlV/L1Y5Gij6DBwOqlYu1UjEb5XL3Zq8Jq9YkuHLNRBV9zxW9WmMOZzTuyR
 XxxDFEXpo1pQ68Vy99KR+FlSI2vPbjEDyftAV16XjxpQXfbSPD9OLnuro365Ig8NJUwhZo5hK7f
 sE3F05O5v7V/ADBHtbu/uZxOoI94fQ08JHnpHStRiXOBJoREdKSTsOSXNg6DBFcN7FOY+rbmH5P
 U5wB0cfWgNTq2YNwSUhE0O3oqvvWenmDHj8dIf3FCQtalIYk/6Ozx1XTJQwibs0WcZZinz9vikT
 lWKHo9xXNFDllA32tWQ==
X-Proofpoint-GUID: bqZqqSKtf2PUGi7xLwjljW9yTHOrF8vs
X-Authority-Analysis: v=2.4 cv=D8N37PRj c=1 sm=1 tr=0 ts=6a97f65e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=uUvTuc4oTmGzQ4V00ZcA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: bqZqqSKtf2PUGi7xLwjljW9yTHOrF8vs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5MCBTYWx0ZWRfX01NyE1NdhmsH
 yZloyheISz1H2/WUtsZOrxrxASGBp2XEJHH7gpoKVyZdMPxv63+HlJjCTBnrnvN+Lq9xgbZPFW4
 nwH5uGbRpeg3iDIjXgZ28dSMtQjJW7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020090

On 8/28/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> Add support for the Nord Gen5x16 bifurcated QMP PCIe PHY.
> 
> Nord has a single PCIe PHY block split into four ports which can be
> used in multiple lane configurations: x16, x8+x8, x8+x4+x4 and
> x8+x4+x2+x2. The active topology is selected through the link mode
> configuration register, and the driver exposes the corresponding PHY
> instances based on that mode.

[...]

> +static const char * const nord_pciephy_port_a_vreg_l[] = {
> +	"vdda-phy-a", "vdda-pll-a",
> +};
> +
> +static const char * const nord_pciephy_port_b_vreg_l[] = {
> +	"vdda-phy-b", "vdda-pll-b",
> +};
> +
> +static const char * const nord_pciephy_port_c_vreg_l[] = {
> +	"vdda-phy-c", "vdda-pll-c",
> +};
> +
> +static const char * const nord_pciephy_port_d_vreg_l[] = {
> +	"vdda-phy-d", "vdda-pll-d",
> +};
> +
> +static const char * const nord_pciephy_port_cd_vreg_l[] = {
> +	"vdda-phy-c", "vdda-phy-d", "vdda-pll-c", "vdda-pll-d",
> +};
> +
> +static const char * const nord_pciephy_port_bcd_vreg_l[] = {
> +	"vdda-phy-b", "vdda-phy-c", "vdda-phy-d",
> +	"vdda-pll-b", "vdda-pll-c", "vdda-pll-d",
> +};

Can we only list a/b/c/d resources and then take a union of them
as necessary for combined modes?


> +static struct qmp_phy_init_tbl nord_qmp_pcie_pll_a_tbl[] = {

The abcd tables are identical except for the last 2 writes. Factor
out the common config and create overlays.

[...]

> +static const char * const nord_pciephy_port_a_reg_l[] = { "port_a" };

We already have some of these symbols in this file that shouldn't
carry any SoC prefix

Konrad
