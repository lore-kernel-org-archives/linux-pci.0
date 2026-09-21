Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B11463B8B
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982115; cv=none; b=XgMiN4ZFqM7E9ieQ807o+eC8Bt+WfIJTjKT/izDcDjnB+cho8bnLzXnrPu69HeaknsNn5Q6pq6yNBbsaLqR7Uskj+JCHFkirYj2XgvfHvz9nyyv3rOR/LTFqJUS0oQLw11yVJbOKgmCt89Sh1BgcVnytrhP2Kphxz2ZxxoYutNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982115; c=relaxed/simple;
	bh=NgDlzEiS0NbsIJziEpI4M8ZIVcA7puykB/WP9m+iYJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEOltKruGonjc4e0bcGHg/yjXhPrIAV4nMqEHO36wYeTs8G7tSIpzDWguUWQrWQA4hA+GR3QYt3SC1zEMfbnbt/7bzcTwV2DYzAb8M/ijmillfSw0LYdkeawfJchA02W22d15NBb5sd1IpLeIpAZC49QMxub7dVyO4Wy6JUtrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6lpFupq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X90EbTPt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6lpFupq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X90EbTPt"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79xXw607136
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GLhLHWDFh1O3xJfyugwviPWr18h9lNQNghkpTPHNp/Q=; b=C6lpFupq6eIsTgEz
	AxaRqx2vny38HtwLqcSsrou+mjtaqfEjUp0xWzC9aaW/IpSQca9A9qILrN58now4
	1zLyh7b1uHQYhE9Jz7SoKuVerVoFSAV1sDZzDXfQKXWXaxRqbRY82344EoWVf+Mh
	MSjWb2Q0saRNuaqYm2c+lrjcJb1JGvJyjVsBp4utM+TAsPpmIwoh7KPkQGvXaKM5
	lB0oNFFp1Y1onyo1TObIjHY215VwRD/x6s0dxKuTSi36lVNAwzFgFOZW6UfYcYfm
	U1W2uN4wuFU585zhiPoV5qWLwDgumc76OUUkSqyG2nDlOU7dr/amn8Z0cgdq6yJu
	eWLscg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1ehhah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:15:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6fb956002so38675095ad.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789982112; x=1790586912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GLhLHWDFh1O3xJfyugwviPWr18h9lNQNghkpTPHNp/Q=;
        b=X90EbTPt1c1R0JnbUzYjAvBJDcxJq4CoE2yGBrfFX8crrDW3kNrg/FOoc9L3MJi5GW
         o62GnJB61SnGo9x+nejfionNY49Mux1CVwCZ8J/Apa2Clq7Dx3itaIGEcvo8YG7kUk7S
         p2IzPwjkncVKkhDRbQQ0QSzB0kpcl3ORLU0jSlF61OtaKIDclOpvibobp1vRFGUwCGiq
         WMMBOre/tYLA3o4vnkI24UqlGilWB0h5QLUHgQlFYwfxKThFciVz5ZYe3lVTSFjQSO7E
         mQKDcD7KZdRsAAyLP8YCAlcjoDUPhaHPSarutsQI/Oh7mw2ujorpfAVNjeqvqQcRQMKV
         D0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789982112; x=1790586912;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLhLHWDFh1O3xJfyugwviPWr18h9lNQNghkpTPHNp/Q=;
        b=oe5tluNHPJ2iQBkMZcBm9ZUekkppMkQgpsIgYgi3gyo6RLX/FNAXWD0A9fuAVDhVJ6
         zeXsr3Ms0W2cayEMH5XW3CoFgOK/A99Ay0o4xkFbTqguTVyjNFGFRU0MDjFsCMv47RS/
         FuRbyvzp+f9AzCwlS255GrRsGloBS3mNVTM5TxtoZlG7ufWNtgN+6cLhULeWH7tA1M+E
         gvKp8dxO5cfh/bc5KkNRUZC4ZSh1b6HwIfxdHJ299iV63xxThFLFQhxDyh2gPv35Zlbg
         Hhj9gK3swI5SoTfqCmWdoZxX3JZIj1vNPoXXHPUrjaVaCUPifU/tCFGxl0OH8x6217Ci
         G16A==
X-Forwarded-Encrypted: i=1; AKwUvBzoyhLStgkzilpQxGcAm6kAaon9GGpMAj2ir58c9Etow52dFMucx0JyE+oPVfCn9rK2eqg/9d+e1/k=@vger.kernel.org
X-Gm-Message-State: AFuF++kd49ZsqUq2xGLq5ptCu/yZrkRBleWDo1CzWHtk0RYhZobDNG3i
	GLnJSl3VRaKdMdvRWNWtFNNMp5wtN7FylSwejMMaUbBwS7RT4LSfh6NFeyccJ6wZDZ1tCp0fvoh
	n4c2at4yDsib2ygVqND9Ipi/f8m5RpMZyvdBt5atj3spf6hs6ly9ImOdk3xxiwgo=
X-Gm-Gg: AYBFou2q7R7Yq0/MdnoZkbEgGTqJKB9rk188n4zE2PctlNr0BywFGaYmw/Km07cb4cl
	dX5oxk//pu1TVF71U8ZuoM/3cv2KcIvVGRygqgVbrP51sjhICLvfiPqdZcOMSf1AB8bM9AFFHAi
	B+n/FEfOgJ+8vCEzTqPwFFABaJrm577il58hrUPwI0A2478PyrBsLSfcOCe3sD3NkO5eYh6pi30
	58W4ZVzeEEc8GgoIcxzy7awkgjQAY4j0y/svrAWmqecXje4gVgBYXYSdvs4mLMoN1w+DpWTDcEd
	hVdI78p6cIKzoZnNu1QS0nLTe2sEgYZ1Q5Fj9laqwwlF5LjK/fQQYjzHD0mF6d3ECtkMiy5PPY/
	JkCKcd2zrW+2GHwiUX+4bbXS9ToRpqKtD3Hwpc6E4Lxep
X-Received: by 2002:a17:903:468e:b0:2dd:c100:4b81 with SMTP id d9443c01a7336-2ddc1005f8cmr91844105ad.56.1789982112398;
        Mon, 21 Sep 2026 02:15:12 -0700 (PDT)
X-Received: by 2002:a17:903:468e:b0:2dd:c100:4b81 with SMTP id d9443c01a7336-2ddc1005f8cmr91843865ad.56.1789982111982;
        Mon, 21 Sep 2026 02:15:11 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3311ad4esm17917215eec.5.2026.09.21.02.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:15:11 -0700 (PDT)
Message-ID: <65d9422c-d691-4b5f-b1f3-c2ae5ba5cfc8@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:45:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] phy: qcom-qmp-pcie: Split phy_ops into
 init/exit/reset/power_on
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260915-align_pcie_init_sequence_0916-v1-4-0b2195836f30@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-4-0b2195836f30@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMSBTYWx0ZWRfX39lQgf7CJ1q2
 i5NgF9t/K76I1V8K0ykwSv8jeQfDtI5pGXDb3hK1BIhTr7kvm8vFmFzT51fDKH562rAoGhMcTya
 JAwM16hcXMwjby5F6TQfB1C8FdFjJCU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMSBTYWx0ZWRfXxhBGY1AiUCmD
 9er0iAo7NNDVXHuFXmneqz+o5S1ZnjGuDf97SPG5OYjEhrX6tfGbsl3W8RYzhsAJzxcOL1n4eLq
 7r4NVN7dLExS2WNyUc5BnLNBhYWLPgEOpKzd6OJ6gZAgs31ElDS9MXAj2mnXbpkeAEeAj51GEMt
 nNWn02/lQW8u1DmD/zCW+iGTrPEWfg04jpMYv43JrFxkqDt+nnqB2q+FL822fw4wo5P1ZChhuGS
 fzQpjGTjBg4PeKN4FDkULJQM2b7JKxAfwJbbtTz0j53OZg9cxLQh9EDvk7eMlcTysZAe9vBk9XB
 x1BDzEKokc+72GP3GDhiikpPP+dxCLX5d8GzLIa8oRRr4vjwUtwZOWmnhHsntoSjR8/B1goyaDU
 2RZ8wqKLXWTy2uRod2/NQigiVQ1zQakDyUuGSg+vTnx+ZMTyodnJantp255J/3y1BdTiPoJ2Fey
 b8JzruQQBtnpiDyp1Jw==
X-Proofpoint-ORIG-GUID: hSHyU4QiIDaugat5GsmgakY7jqrTZvTg
X-Proofpoint-GUID: hSHyU4QiIDaugat5GsmgakY7jqrTZvTg
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0f5a1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=DFGctsAPzAe98lL7n_0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210131


On 9/16/2026 11:34 AM, Qiang Yu wrote:
> The controller now calls phy_init() from
> qcom_pcie_host_init()/qcom_pcie_enable_resources() and phy_reset()
> from inside its own core reset assert/deassert, so the PHY's reset
> toggles alongside the controller's core reset as HPG requires.
> Making that actually happen here needs phy_ops::init and
> phy_ops::reset implemented, and phy_ops::power_on adjusted to match.
> Split the combined phy_ops::power_on/power_off into
> phy_ops::init/exit/reset/power_on to do that.
>
> phy_ops::init enables regulators and all clocks (pipe clock first)
> and determines skip_init/skip_reset. phy_ops::reset toggles the
> reset that skip_init picked. Register-table programming used to run
> while the no-CSR reset was still asserted; now it runs afterwards,
> in phy_ops::power_on.
>
> Adds skip_reset to struct qmp_pcie so phy_ops::reset and
> phy_ops::power_on share the value phy_ops::init determined instead
> of re-reading PCS registers.
>
> Signed-off-by: Qiang Yu<qiang.yu@oss.qualcomm.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 184 ++++++++++++++-----------------
>   1 file changed, 80 insertions(+), 104 deletions(-)

Verified the PCIe enumeration in IPQ9574 and IPQ5424 and it works fine. So,

Tested-by: Kathiravan Thirumoorthy 
<kathiravan.thirumoorthy@oss.qualcomm.com> #IPQ9574-RDP433, IPQ5424-RDP466


