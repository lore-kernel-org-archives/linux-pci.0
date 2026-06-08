Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD13C4557
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928388; cv=none; b=l3G64wXGXomx+/fX0HiV69M9J7aeJuhqYIxunHJzsVfIkLvsjfSfXdDnd4BD/qkiwgr80EfKEeYih7gYD0dr2wcUQMYmfTPw7Gtrn1eiXI6JFJA5so7ZALtJ4l8Lm1zOyuGX2uKTA0hjTl/0xtwC6couWWwN4zxbLSiZ3jAJ5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928388; c=relaxed/simple;
	bh=RCYy0IHiJIJ71s+W/69dtSzgpRWYhBpmknflCMoSQ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQ9YjBYrAkmFATaOissH9E5Jq8+GpirGLZfd/zwWYJUik4GakhRpefJLUrSuib7eQzazFq3yS4Zf1fs7zs55ObPA6JEzqoKm1EfVChrj1OifbR5hycUP4piH4uP9m6ZAZjtpAgbTGGYhpdc0FSWveabBMegt0MZHHibrLYJKl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3N1gQtS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gnEc0q/E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3N1gQtS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gnEc0q/E"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DR8NM3783079
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 14:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T48n2DUWsXNrk3FetI/dF/Eg9NT15exAWsHm/kM8tw8=; b=k3N1gQtSk6OnTdvm
	E3Xfi5uS1MXoIMj1wX3SgYwWlu2h1JuCd+0V7Om7+xRUpC1p5VZWoc70uaaLLQ1S
	dOSrfCWM/Ut+fDoDbd3fn6KLk7Covdz4ClO11shd6Dsq4rkzC31YIIs3qfo/zBWT
	scbGj8S+apvyyujS5UuhcIsvHZgDKE5iMS74v4LwZfujaAxw36lOhG+iOWd28buv
	utg13w5p2vIF4YRQ211eQuAo6639MX+DkrqiASUKtzQnXgUGdga2fJQi4q/exhCF
	MoRn0NNBTon5GdL16F+/99WYZLbxs8eE7GEoKiy3CW07kBIwr4G4K3CqKcjZpj7Q
	FIKssw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxee0ah1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 14:19:46 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5a1912d5c85so6782034e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780928386; x=1781533186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T48n2DUWsXNrk3FetI/dF/Eg9NT15exAWsHm/kM8tw8=;
        b=gnEc0q/EJ+1Vp/L2aJ2iXTHxsf0d97IYT5cqjLy2WUZScMkwpBSXj2YqBrBjSmYPPq
         4SB2PBp0u1RIryn7GRROYMNB+FKpra+WJtpXu/iZQfs+fZhX3mYegR6qj2gk8551aI9c
         a8AgYIryQZlmvxq98poTZktBmWhT/JJDWUCHlUpH85iwTxIwcTXmHAxVOp6FLZjQebad
         MCVfktJW9W1thWqT04cGo7X1eQuNSD2Fx4HSRSE6ja6+W2YGn5ZXHADQaL5ZU4yVL7yT
         xk0ignjxlGjWkxjpr7DWGBASksk3MQ5b2jgF8DLN05PPkndqhNYGIDyszmBMB2WK1YbS
         5iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928386; x=1781533186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T48n2DUWsXNrk3FetI/dF/Eg9NT15exAWsHm/kM8tw8=;
        b=h5azDscKCWr0yN1KZPbbMfMEiEOYVhbokkJMM+rpbUke4f1Qf0cmgpiVzcDnjW6l71
         OekduPus7ZXuuNaLF6aLis3TcwJ9n1csp7XmPmseYrqoIreDDkoHDdfZuhqHnDSBBPTd
         O5kWq3XIOUE+gZn7Neo6Hpgr0EEZvBYfcJ/myxNYyxBntdTYOnPl8t5psCKcAtXNfu2Z
         1Yif67+FJJ6ELkCzUDrNMMi0QasrxaNQ1wnQNzxAS7CkzY9Z6y48bD1nW0zaw4ey7veC
         hGqrURqtvZOOyg+KgbsWpBQ3beiG63IUXSyg1v39WRJsvqS8Dw8vMRN21kceJooI0G+x
         oaUA==
X-Forwarded-Encrypted: i=1; AFNElJ9kUiLDXbdmYrPF65/V2jITgniVzbROatPZ1lnUIVsQAN0RY1vPnUrulSxNITtGE3hbidcEr6AHuS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOmgPQL4dOfXOH9G4UdlUf4HNzDnsnLRUXT+PoN8cAUG6ruHu
	XtBTFcdSLtSi2bCa8K/EnFSJieZ8jNp2yl9Elgfn1TcjltOO7AyHr5LjtwxzT2/Eh+al2KYMTRn
	y20MkNICkcpjTtZYG6O6UZzK6raQx6b4MX/DLTx4ZgVMnt8RDEcf5duIuE6c7jOo=
X-Gm-Gg: Acq92OFfOeJcV8zC1Y4IMjfLlX6xrJpFY9PAJ4Vm+70KjFkKJJw14SSP8WvKZQW1Vgg
	Rkm8JJUcefyesjIVsWC0DuYS/CH9u8gLPOyl3zmPPMOLjBlfvCzd5jw/sseIyZL5vN4utGyyROb
	sHaaWwedYIjUbMPlw6OpoPHNlt1UNUWsp8xGkcimm9Mjq9zUjzhgaMHUnXK0IlCf2F7Rig94YO2
	UCJco2+QG1ttf3STI6hCUIO+N/qq1uqEJEsxhK7C4pCByW0177j8GLjHXcD1Eh7pshcilSXpgia
	E8LDLrSpz2Gxl7laNpUivs+1IhmoikpM4/cq0GAYo9jkQ1zFouWL2D0KPEhHf/eS/uUE7JTz799
	MbnFScyUvv07fDMmBBnT2ABpSAGykz4hPlX/DugiumESb0edRV0ZZD2VdkbA=
X-Received: by 2002:a05:6122:1796:b0:5a0:c38e:6199 with SMTP id 71dfb90a1353d-5ac4ca5ce4amr7610857e0c.1.1780928385973;
        Mon, 08 Jun 2026 07:19:45 -0700 (PDT)
X-Received: by 2002:a05:6122:1796:b0:5a0:c38e:6199 with SMTP id 71dfb90a1353d-5ac4ca5ce4amr7610799e0c.1.1780928385554;
        Mon, 08 Jun 2026 07:19:45 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:4904:8660:26f:8b6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c15cesm397599425e9.5.2026.06.08.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:19:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: (subset) [PATCH 0/2] Enable WCN6855 Bluetooth on lemans-evk via PCIe M.2 Key E connector
Date: Mon,  8 Jun 2026 16:19:42 +0200
Message-ID: <178092837981.163118.4463258851423326572.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzNiBTYWx0ZWRfX2RrMB1aH5Hjp
 6smlmGOOWP/n+FPvoym++h+KHXzC85cjib4r1eQE6iCvxctUOHrV/UtU5i2M4sFhhymCxmx8MzU
 ExuwTxyKaxKO8B6FUC0O7E0cuAoRLzyqfXvHrFcFZo6lqCw+HuNlXiz+alBowUI5MWwz5qoCX0S
 g/wdQ7JVhBiKKxx9dM0dMA1TNmSs/J+Wag21auQHPo3pvFpukd4jSA0F0KxHSQPRMgE2KJ+Wlcy
 zAB+9bHczpI4nM4e/Z9q6Hlx7Il18lHNJ1xClWAQOvJ5A2ywljLPMTCOr9BvGqJw/LE1OZHmgAq
 RY3a3uc6UnLc5Bgzj1Sx42b9OxuEP8cX9k++6DeGeXibqZGR7BuUk6lDo20f+yTlWNSl+/f7vC3
 o/Fr9J9qFSrrr1LxsIZ+d/h+Jb+Hbr+GtH+WkxzWUSsujKswc+a7X1xkvGHGyI5ZkiRTzC69ttg
 6iV1KHDOgd4MSaFLhqQ==
X-Authority-Analysis: v=2.4 cv=V6BNF+ni c=1 sm=1 tr=0 ts=6a26cf82 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KxFyB6w1bcBEixo3GQYA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: BhQPzr4MEnCnzBIX7q0jaiKXQZEOShog
X-Proofpoint-ORIG-GUID: BhQPzr4MEnCnzBIX7q0jaiKXQZEOShog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080136


On Mon, 08 Jun 2026 14:47:00 +0530, Wei Deng wrote:
> This series enables WCN6855 Bluetooth on the lemans EVK through the
> PCIe M.2 Key E connector + pwrseq-pcie-m2 path.
> 
> It depends on the "Fixes/improvements for the PCI M.2 power sequencing
> driver" series (V3):
> 
>   https://lore.kernel.org/r/20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com
> 
> [...]

Applied, thanks!

[1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth
      https://git.kernel.org/brgl/c/bde2202a2fffd3137df9a0b4b8ffd8a44ef316f6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
