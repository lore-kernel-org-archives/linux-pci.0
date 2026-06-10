Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A13314C2
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109284; cv=none; b=F1amWoVT1BFMLKJrOXd397B9ZiTeTvQcuQGc1r83iw2VfErAHmhFpGeNIVY6f5LHLGuzqT0oBMTRvBBoPjwXsMhg6mp0ipVQu5wbG6XV+nH0q64DjkGLdY6RVKu20SljdD+gPeoJfHXbHBIXrhOKMD0MwAHqGXd1E5kW0RSdI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109284; c=relaxed/simple;
	bh=BIE7gkW/4J2dxkYGHiDbLFQ5KlUnz/F1BFTyzaULS7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MooN+MUGMbPbHpdWKJd/oXNsKGqyucXQX4x6y5PvtyFZEqAzAWHBXjsv5KibAOtoipcRyhC+uOPqqFOhUFEcRwsg38siniBzHt9shkIk5vEROBqfh6rpnxh9jwfKc5U6tg4iQgwtRM807BtkyUWUP/AKtlyG8OttuD45G2wQfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YuZqHw2D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NBP+7/Nx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuZqHw2D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NBP+7/Nx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AFwqh72042139
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 16:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+XOIWlH40mHwtCgl/V4OVzh5le+vWzs9b3kpiqeGWEw=; b=YuZqHw2DxiLOZgXy
	FHEd1jLR9TZTr1SQAXCLCOkvey5LHWGgBrQyNIGxFxX6k6xORDM3TzmqVCO3Onks
	jzlV/fCkg9/PDKuGWxu5rWE00mroKCs1BDxhKmQP/UR1vadsJ4vxcFWojFmHggLM
	4zgxykU93hyYmvfR7zbOKNgH4zgco8H3b+3O9Kc2NxMmfgNVBFgyJlbSvFUzBSBW
	5W7HmNI4qGplaGOR89HtrM7TFsDOSTuqS2zixq2Un7L3qUN6l/B9NmIeEPMQT5xf
	AnyCOfO4YjCPerFjbovV4XNaPOCuIIIdzKEEhMTh7DUBXPW/x2sceyAkYTK1NR7g
	d+hIbg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epukev655-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 16:34:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso114984605ad.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781109281; x=1781714081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XOIWlH40mHwtCgl/V4OVzh5le+vWzs9b3kpiqeGWEw=;
        b=NBP+7/NxfWvVIaktGpAND5A4LnvagBDftdIjle4GiWFjx1ebcpB5K78zX17LQtki++
         Rd9taNuICbFN1ogRttyeD3sDuF9HTukAm0h+8gVUw5Tx9wVQ/pcwwENsM8Sr+3jYmHWA
         /7UCJxcf938c5BwaFeLoxh55Z+kuT5pLUO3BUBw4q4+Xkl8PVaJ2nKQ5Zcv8BxJWG7E1
         28CCc12qZFPpZG32e0wjH7iPs7WY8odZaPhyDFaTUcd+hxnEJzvfHARKZLS//H0dmMfb
         RtNtMRZFYLe6CgZvi+Dvtc3pUh4nDt9jTdh0KokzUIyYaRNRPcgPf5vdys1Mfqtp21iH
         fkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109281; x=1781714081;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XOIWlH40mHwtCgl/V4OVzh5le+vWzs9b3kpiqeGWEw=;
        b=R541MGCl4m7Muivk1nGFdMv16HbB/QdVl/SVALra0ekfNXLN/XC0If2eFNZijhRCMX
         d35ZsM0vt0f3EKxpk8gjWdRUCMWDw7YSy+A7qlswGmcKG6JEKS6yxTaQmIk9Vd9tGFHO
         fMpbcNqxeM/YGZI9Bct8DLgFRs4ewFHJKVH1M4txcrUClMh+XhvF12J611Z2vaDxWftS
         5gTXnKgq13VuLooELjODZNF3wJiDZRIgBUZBZNGRmN2oE8cn7Zc0Zlg88Hm32ioPM+Fj
         ECQQ4jAIeSsfU27h5giGyKtbP1HwYJPUWAqIZ9y7KWqO8eODF5oR1RwrXAx7LqBHES/J
         tZLg==
X-Forwarded-Encrypted: i=1; AFNElJ+sv9oPRCXhPXlbIa5iD7OjP4u9blrXLdIam7N+44a8mQV8XFl2uvOj+OJ546h9q888dp2SwsMo8V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb2qExFW/lVfVXufwvtHkAfFJUGsb32UvY4OENdKeW0cErjBgZ
	XQahNnepHzWTwA0KKmP5wdhU9rew7nRV2A4xpq1btSTuIgy9BJtJswWxzhulEIAdQHSdiz2yBUY
	ny40cahn2ppzXurej3rbrckxdWz8oRXkM5NISxue/MjkHpFbGIg6/Bi2H/rxEkOs=
X-Gm-Gg: Acq92OFzv0X1X0jsZMDE1G1+Q+8VCf7yhCeswNbGiJXNgzSoOI4432sALub0UwgMRn3
	piHlUkJ5btLweiGbm+xzWiFcDPQoKjwruoqg265IMEtCBA5RKNdpDkw+RRPPgRlU9RUlKHHEW5E
	MgAfaGg5jc/8rsIRPloucNn7MAtDUi6vRLy3Ov3PhqjYW7Vpjvzw0no1wm1Ve5Y26ZjsJOW1yK2
	sPXwdWSf+/vQxrJ34c1vE9VzJGnazP48rdnXLJtDN2iQOazQ7664NapqY3Az8bv9WIyA9SGp2B6
	yu11rDRB1eimJ9QB6cAh8OWpkgoIzyz5aatZ09UEAsGxycTkVbfr5sf6Xp40PFt4beLZV0LHMWC
	pdeqkylKRAAlpnYBjuQn5QlGJSnwm5u8=
X-Received: by 2002:a17:903:41d1:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c1e85c0cbamr301159795ad.30.1781109281094;
        Wed, 10 Jun 2026 09:34:41 -0700 (PDT)
X-Received: by 2002:a17:903:41d1:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c1e85c0cbamr301159285ad.30.1781109280647;
        Wed, 10 Jun 2026 09:34:40 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.195.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c302sm243953905ad.73.2026.06.10.09.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:34:40 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20260608-eliza-v3-0-9bdeb7434b28@oss.qualcomm.com>
References: <20260608-eliza-v3-0-9bdeb7434b28@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/3] PCI: qcom: Add support for Eliza
Message-Id: <178110927481.10093.6331910233610738004.b4-ty@kernel.org>
Date: Wed, 10 Jun 2026 22:04:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfX9H74Raviv6HP
 75yPKOnwPFrBcAoSGeSf/sDHc45gK4wrULVAuozBnIiTpQ7Bp+fn+EsvNZRxzwioTF6vEtN2leE
 X7ZZdqyNoom0nxd1ADYZi5f8M3NqlLhBHaggcBBZslP1PH87jV/DEcIcZTU0llZTBx3JJ9Q0p5G
 WZqiPk70Ipj4NdVxGWc0Wj5c45wRWvxnMVJb8PPGv1bMhGBRkLZPOy+dxpVLMOR57Q70wYicuAr
 Wxd8XaJd1u7cZAydMkCD+JFTqhpShNl/RX/KqnITkokpkRP0dQILsLvEZ+uI0j0q0dGpk/iqJm4
 lN82u47hREBidzVZjLJKbZnE0EUgd0lD/UOOPIWXDo1qvD2pSUQKVifUFWHwFJUvdztzDJGTeMo
 ODZ7I/WoTkNdBX3Vfyt69g/nJ/ij3GLaLUauV64RH1KkiRCnH7aaLql7zQZ8m52XPqwYhpEGi2R
 Nq+vYlG9z4vrO2nQRzg==
X-Proofpoint-ORIG-GUID: wXE5pi-C0GNgcEJSWgFXl3wI7eerXB0x
X-Proofpoint-GUID: wXE5pi-C0GNgcEJSWgFXl3wI7eerXB0x
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a299222 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=n8UK4BQKCdfH/t0JQ2luxA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=jf34NEdiGforZHx8bOwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100156


On Mon, 08 Jun 2026 14:18:12 +0530, Krishna Chaitanya Chundru wrote:
> This series adds PCIe support for the Qualcomm Eliza SoC. Eliza includes
> two PCIe root complex controllers capable of 8GT/s x1 and 8GT/s x2.
> 
> The QMP PCIe PHY support adds a new Gen3x1 PHY configuration with
> Eliza-specific initialization tables, and reuses the existing SM8550
> Gen3x2 configuration for the x2 PHY instance.
> 
> [...]

Applied, thanks!

[2/3] dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza compatible
      commit: d233626c009a515fb3ed823fcd78cee432701d1e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

