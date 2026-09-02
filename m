Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287694A843C
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362210; cv=none; b=oc4SBxwzNc6TjbHsGLKU/VxevcH22nxiylE9oPrw+9snDgtLBcmbKB2z8HguhRgzQx1UsdMgzJPq3Wkj+DSnI7/LMCVX78Z4P41ak7ptQgAt9Bff5enVTEMXN6igJ14gzQuo+MRfkeb2itEyc+UArXboqe277CEHNfUh9Lg7PUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362210; c=relaxed/simple;
	bh=EY0WJ+63XZMHcJg9sqnTRl/NTwGGgC8KvPzy8eZihAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwxb661OCpDnl7XB421RzfAYCnSvG8KytQUJFkg/Jv7YU8VT++toucHrhaAX/69LHfqtbQvthAmPQmViUObOM3pnlkv7hgBUdftItgKAi/eGlhIrGmpZh6cRti5ctFGT9UdLGNWq3KBAQnRzP/jvXkhwkHFYufbZNLAwuq6jOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MqZmbgUR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LTkHvk7K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MqZmbgUR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTkHvk7K"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CR7aT1549918
	for <linux-pci@vger.kernel.org>; Wed, 2 Sep 2026 15:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x6YJYhz6qJkR9ol1EGjcREszafaafwzYWX/LvB8sgIY=; b=MqZmbgURP5B9iTcU
	+127h2np+UJ8c0hYXMDLQM4bKzN3SnO6lfUy8MhW26zEhwQQL9o2BlVuIkzjESXl
	7YVEB9TTe4pWjR0v0s0tupgKP60kAxpW34IlcrX23tAwAEJ7ZGNNHXW8st3WqqP2
	zS7LlsNmt4+VKEiMnG12pnqMIFMzMas2MIAr8wNyVlTyZFS9Ij0AO7dQhsobz15Z
	6DVzNOrl0kps+EAIbgCtvNvM7GzKsrLhDQZZABujXG9aTUBEIRcq7CdRD6iKKVyQ
	XiNIUSxfgj0rvaCwgvX6IBimTJ6lUimS/vNIliqyFp60GQaWBhBiENR7Thf+jm3Z
	1mqAWw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c9454-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 15:16:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ea38b1e7eso2708251cf.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788362207; x=1788967007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6YJYhz6qJkR9ol1EGjcREszafaafwzYWX/LvB8sgIY=;
        b=LTkHvk7KSeimAVdyuSyvL2T8QS5vrnnwGgCLxhtrzYl1VFEdTTG0iZPCVI3Oz0bVH1
         R8/D4VwKP70KBt2C9O/xyGxQzl+UfNYG6oJpa9EDNDJp85qun5HkXpVGJj7THi/SPSyG
         UdfZ9SBBh7Y7t8Kb4NhNGwq1aExKDpj/42bXiVDPf4SpRj190Kfz6EdlBxFpoxX9CrA3
         +3Wj6gCmpHAPyv17mwIlwsDvXxn/IkpOoDYKPh+H6PIzmRR5TJ6aedCGYwb3d4NYRAbv
         TKoP6mSX9PEN5TUqSETbr3ZsRchAXB4D8RH9TXye8MeJofbu8G4b4jzbaqOEmqVJGv+G
         FJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362207; x=1788967007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x6YJYhz6qJkR9ol1EGjcREszafaafwzYWX/LvB8sgIY=;
        b=E8t6Hz5mHWNb8OFZnJ8AyMGcEN7onk22nU4DbhNyAeTxXL6kVzIVf1TpBLcFXkLKHc
         V2qXAc3YlstOrBbre9cplgU4MWJACmSBaNXqM2HmHx5U0qB+EP3X9gFxk5egbPQH9BD2
         HHFpTN5fsGhy5J/9Lniv5SnPh423ElzYH7Lr7qsDAv4G3vqKMXaBfIYbnigLsoQ55mcH
         qQKf8f/HzANX12HS+GKUcDGl7eBGf8QVmhyEKteMcin0Nc+eCZIyinskUuXdZCCXe2oh
         Rv+A4HIRyLRkRvl8o/KrtRDzloqw5GGAPctESy7iFFLLJ73MtTvgQxHt6n/Vlka/JOhf
         f4Bw==
X-Forwarded-Encrypted: i=1; AHgh+RpwgMmGvLsp28j9elsOY26XIqb77u61eCIMmCsEcednOHiTTt6dXxg1PuZXGDgplfhva5RylV1CnG4=@vger.kernel.org
X-Gm-Message-State: AFuF++lZ9q9HfBoPo6zdQZf1M52HVVpOqnpn9QagcFB8uD8Xd2OaZ4Z5
	Dmn/0ATot9XhWbNOYJIQ4oJ0VOhK/waQ9cSOIrJO+41l5JKg7dErXmpe0Ve2dicG+2ddbpNsZ72
	TdR0QETEzXpNtI7DFznqZWDE/mWyLqDBexz73CYb4fHRHS+FiZihNwF57QvjmIDs=
X-Gm-Gg: AR+sD12a8dZrQ6iLjkmIjC6+jxix1JHIKa1AiNmDgDtKEvl2t6vuDFb+riUsbsAPDJ0
	XWzI8dVKfcGA+TYaZfubyrUIhng7UXrXNLAV0vyacOit9adsz3Yw8f8ATqdAW9T1wl14d2/iXD8
	WYcY8ZupdnjfK0j8H0bCtm00rGh/3Fyk+mJ+EeRWduFoltk7Q3CzFFqQ20/5K6/eU1mYtZhr/9D
	SNLI44WmkA1S7NpO6mN6T+NB/xn8yGq0qxWbb3rDj3uMKDInaN0oZug9O1Ne5XNIZyq9s5RuUVk
	wl8GlPD2HYUiZAe4LMLRRkjeob5ZNn/nEEz1EEIz1k95O/w/3dMdpUrdwPJD0F3vLI4LuOYqEVl
	2CngHlvsCzWN/YZk4Hr3OEA==
X-Received: by 2002:ac8:7d44:0:b0:52e:3b7d:df99 with SMTP id d75a77b69052e-53036b4e8cdmr38544491cf.1.1788362207279;
        Wed, 02 Sep 2026 08:16:47 -0700 (PDT)
X-Received: by 2002:ac8:7d44:0:b0:52e:3b7d:df99 with SMTP id d75a77b69052e-53036b4e8cdmr38543531cf.1.1788362206529;
        Wed, 02 Sep 2026 08:16:46 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f941dd4sm1212684a12.20.2026.09.02.08.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:16:45 -0700 (PDT)
Message-ID: <8237cae7-0a3c-48ae-a85c-8521cda87015@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 17:16:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PCI: qcom: Add CGC disable workaround for Nord
 PCIe
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
 <20260828-nord-v2-3-18bf59d19d6f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-nord-v2-3-18bf59d19d6f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNCBTYWx0ZWRfX63hFvt06cSeq
 hOS6taSqnebhhuQHr48gjt9S9zwpbx16zIAuWb+0ADbP/5yZUQGGcyLhrUFpbK8rhELQeow8Hbu
 K8YBGoyzuSbTvP5uAkP++fvDuPX5rTM=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a983de0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: pQYN_mPLbzXFlY_yhcx5-VtlCxreyhHZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNCBTYWx0ZWRfX90dP35fPGbrF
 HBD2L0oXwnCw1rrgVbTKHD647IDxILynPCoblV1WAzWYlQnR3Fdpwn4szbiyyo+qkQxlnKFpnH3
 11q0gdQYkJVXf3o+Nv/WiaY+9UklfFfS1eS8t9WosZAgNLIKWreVKE+qfV/IDth4K5WnnTXQddX
 EP3I3ONlUWH+WlhjbNsUIn6YukdQmCNyDmE8lclTq9/PZdz84U6DLeQd72UN4ohYtNyVYaS8sxe
 dnb6U5qKaThF01zLtaRFVKuPSsF+QU1q4silLacRzJhm27caa+0Mil3YxXvPUKAFKIU5bTP246h
 +LNi4nY6aVQ77ShEk5oahB0OrRkyPCejd1zaCRonRoG6wj3sPDuNhYbKE9INyDNOqrlrBUfD/Ku
 Xi+fROn7jVlZ6/1nVij/935/4vx5kp7pKDql30LglEMyVjyetc4dfUza9EZwkHRWopPcHg8rVPf
 tst44tDa9qKj2DirNng==
X-Proofpoint-ORIG-GUID: pQYN_mPLbzXFlY_yhcx5-VtlCxreyhHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020134

On 8/28/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> Nord requires a workaround to address a timing convergence issue in the
> PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.
> 
> The SLV_ACLK_CGC_DIS bit is already configured by hardware reset. This
> change adds the remaining required settings as documented in
> QCTDD11972446.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
