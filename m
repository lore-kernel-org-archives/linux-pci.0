Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5B3CCFD2
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817809; cv=none; b=rxLiV48qK3fxrCW6+H0MqW7QvQ8X/EWRnQo7x1p73F4AfLl2KHTsSz9Z3IXGrZBSwXxnE1h8Wz6VPijtn9lY5HUCTQ5q0hcysGJtBl7nKDKYkvCnvCzBPOKnqyU5wa0cEgd8ryD/cQUC8YHHenU/IRLBz820ne8j4eTh6PKSLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817809; c=relaxed/simple;
	bh=4gAfGqeCeRVqsOicRrvppeNGdqMmWwPXp4y9ei6B290=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JT+u2ckP4FMzhv1J75KQvUu+KqasaHFry81EyJhYmLVwjW5vGDPmSF01/PKCtiWep1EyjzajxauwB+gkoGFhkdIZ6chcu1qnGy3kGyT8u9vC+JH+Wd1AtGEC5ZcPHjWy9oU8wIkyUunzBx/b9P5c+kt5MNsccbK1odsSg7pgldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=geaTFVZu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O+fxBZo4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="geaTFVZu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O+fxBZo4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mobb1542055
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 11:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u3nQCw5UjxNS30KSjgpkT46o4N+36B9c6Skaa5RF0tk=; b=geaTFVZuTh55EGFr
	ROVWS75OnECDmw8IH69yS8hFhbXF38RSeP3hve1YTAmJP0pt4dNN806qAwup9FZi
	U0qPgNYg1tyJMBqNIMhUTlU3wcPL8QUw6zsXk89VRkmyoUBLEjrOVHfme67/3wKM
	ZEQo97P8n6oVHBADH/GFbNN78BCB7gGgkxxBDwm/g0r2kG5SSEpoV7/bZll6gCBP
	oM+HvE2Ol9am/ljdqj4mX44loVbFnGLXekRRX1z6SrBsz74ffESSP0R51sUY7cdx
	f9/ZXbgjvSSRSTZhCnbWd1d7l1d4S4xB8qYBLm6qppqeeE2iXyLjN60+yMWoQ4Ra
	PjJRFQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4j3d7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 11:10:04 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139c6673856so6711056c88.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782817802; x=1783422602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3nQCw5UjxNS30KSjgpkT46o4N+36B9c6Skaa5RF0tk=;
        b=O+fxBZo4fKXHOLroyD0OyRCll7HvoqkFxuO8Xltu8755F7hSqmC/xobnWb2VYybpFX
         77XINSoAl0oEI7cZqqcFtpnAFuasRekECiSzQERXFe3FwVKjgBqUiHEBd4u5DSmjTfGX
         AlcP0CfrAVsaVDpmvwHPKrzPU8ykMNF0KQTGpCdockKt2+lJz4UcCa+eXFyuHCZeePBL
         w3eS9zNaVy9LAT0W8hfdk1SKfEFbY0vxsMdmbDMtFikk8ga708KWhagWmv8xtzKmrgJ0
         tdL2U2c2oGtKbu7HY5ZLEp78YH0YqHtp92W0v+uk4asNrVzmKR1GZ68x+qPhICpHp0zm
         9Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817802; x=1783422602;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3nQCw5UjxNS30KSjgpkT46o4N+36B9c6Skaa5RF0tk=;
        b=ZHfOud8BMnD/1G2NJG+PWBO6lQADAY9VsUANKEopYUs9DCBQqnGlDHQENmN07A4EfN
         lSV5Rzxt5Bz6wW0m1kCNQIu03uKe2oe79diLWBVng1ZqQF3MBUg7al/SHlvo2Ruh4Afq
         +S96sxjkZcON4skaAtY0bcg5AvsAlkLRdoe+2D5cFcR81ArYjThzwGiiK65CXlmUqVLz
         L5ivgmboj8b7GwRpzV+dKOf4glAe8O0zUdQXtguU0rc4h0CmUWWnpxNm0c+1ab1KmgTZ
         NJd/95PAhNS1/DedKVx/yOotGbZWpcLSyEI9B2iXftNfn9zLg6un5R8yrsPO/ZgN2hZu
         +gdw==
X-Forwarded-Encrypted: i=1; AFNElJ+dj2Dnq3KAu5xhKy3uPBWQxmgT/iTeioW6UGT+tEoxl/wWUMjaB/X8KlnN2lgbxamalQeiXJwzpAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwszKh777XvOX9wAr0JqWZv9PrEdng0yTlpemYl45WA8whgCdl5
	uCCPhW0atZf+9vcyJY8LCD+HY6VOvcsqO4A9KrdgyRN9ozXeWgIUipZnl7j4bsuKnXOSP8QC2yK
	+PVTcgGUIqbos4Q9ZMwcQbMJC70vS7lC8RkhkzVGrgQWFE1mdTmpCIim1odXezU39GiSumtg=
X-Gm-Gg: AfdE7cntFanggLMMHDvqtMukx00l0WfgBzf9d8m5KBAnrWIDk48o/Jha5Dd3mirfVeZ
	V6NGis6enGAmKxIjwDD9mLAPRvaIhyNTQPq0io3g/erYGSuBL1JTOZ2f2qXDnkbuc5JuLWYwcBh
	nXDV2Z4QhH7YHDh2ZSfmVI4VPCn4wdKanbx0rsQ3QEwPMrOPs5UdqcTOQgaAffvUOYM/84xJ5pe
	mXBsodGzmB25sVqrkW1bsw5zBNWU4djCp/pUOOczmc/hFdLKoqvt6CIaCcjwRKry87cf3lLE+Ew
	kTsz79hO41jA2GS+GSkFSVct8/GdbnO7HXGpkB1O0wgExxrIa3DWtuzyrI4RpHoqidlr87KDeWe
	IlN7UZzeySpw9Xp/fdOjT5Nj46kq6
X-Received: by 2002:a05:7022:384:b0:139:9ba1:dc06 with SMTP id a92af1059eb24-13b315931e5mr64781c88.38.1782817801900;
        Tue, 30 Jun 2026 04:10:01 -0700 (PDT)
X-Received: by 2002:a05:7022:384:b0:139:9ba1:dc06 with SMTP id a92af1059eb24-13b315931e5mr64759c88.38.1782817801342;
        Tue, 30 Jun 2026 04:10:01 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.56.202.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab20921sm5310930c88.4.2026.06.30.04.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:10:00 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260610-ipq9650_pcie_binding-v2-0-69e27a1fbf1c@oss.qualcomm.com>
References: <20260610-ipq9650_pcie_binding-v2-0-69e27a1fbf1c@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] Add PCIe binding for IPQ9650 and IPQ5210
Message-Id: <178281779620.290473.1071815117567946655.b4-ty@b4>
Date: Tue, 30 Jun 2026 13:09:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: Jd1h8wO0wVeHnPfKMqi47YPIJNHBNuU8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEwMiBTYWx0ZWRfX+4LdaoByeSyt
 /8aDIBXHiQpUZF0if2qAfu9scVau5czqmalmaH6aOSgkXc14KF7AWfUvyLtMCVoMgzxfrnUMwlm
 /GWdQpDD5Su1R/syqis3ehwVN7ZAeF8=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43a40f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=d0NiXODO0fVjScRmrPHHeg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cte5UXN6-ljhghk535EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: Jd1h8wO0wVeHnPfKMqi47YPIJNHBNuU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEwMiBTYWx0ZWRfXxkaGqPzfzILf
 4nr7lbrI+dRnd5UWmQKiH72b1pp3aMH0btZQWmhSsaoPZWHoO5hVzPswLnoI9RtO5I6Ee3fD6vP
 1OQpRtMfbT/CKJpsOxGPX8KsLsqD2J1fjsVjp7vyVsM+U3d7WK/JFlXFc08VY3AUR/WEKrvfzcy
 PiBRDo/jfrrzxCoaPQpwKRSZ/uqHLZwTIf5Di60yKxMu8GWtHaJJjQP2paWOEggpWiX+ChSZ01y
 L4hH7NYzGk3NjQ2x+DB+T8ElCjmxGZqf3XKDlBurjUVeExQH0dWoGUZt0ruG9eyA68ru8mg7Nam
 9GlcchZwRwpnd4mhJH/qlxR1brvWh6nKTyMiQ2T9Jpb4GihHyarZrYfB9mcK55qsM1X5qL7thBx
 j0XWcKwGku0HC1k1oOOusNmKaEjREe7kE6+IxvgTCd0qBxIwvFRt+eEjztC82kr5O37z6i83Pij
 J3id0aGmIqveVghl4OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300102


On Wed, 10 Jun 2026 16:30:52 +0530, Kathiravan Thirumoorthy wrote:
> Add the IPQ9650 and IPQ5210 PCIe compatible to the IPQ9574 binding, as the
> IPQ9650 and IPQ5210 controller is compatible with IPQ9574 and uses it as
> the fallback.
> 
> Make the global interrupt is required for these SoCs.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ9650 compatible
      commit: 5547ba1c0af0eeb0a37c0a51fe1bd0dcc4d0451c
[2/2] dt-bindings: PCI: qcom,pcie-ipq9574: Document the ipq5210 pcie controller
      commit: df045ed256f9b3a933466a1ff6903c75d4e5b629

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


