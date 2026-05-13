Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351F310645
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684100; cv=none; b=KVYHfjOHSABRvxDtoFf0gHZGUlNJHu7YuDP5fuaZgYopPCIoc91A4qz/+vfzPrFaJs8z31eluKwAyTjW3ndiQLKwlEwb8fm9JNZV9Mtpu9b/gupGYlVWqLUSYkgsbbRNJXRgsc4FfkWTzaD6HsPAK7Dgv+BlKMExpIwmdtZX9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684100; c=relaxed/simple;
	bh=/SZ4lgqUsAgCzmclIYPcnNzgg+iJvjG1BSdLoDV3NwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r0Jg9PSu3G9/xf6frB1ABDctIDa+NiyOwO47YyPfeWIC5pAGyIVT+dvD3amHYWA9l2CU0PdKmoZTB/DzhVxLw1lFAqlWsaFFN1moBqqI6DmUcDCQAZVIeDBoLxvlMcZxjwxo9tSHglEMKVz7ycLh9JtolN5rObAf65EtNkZ6duU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XTlxDDph; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YDwa0Vp1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XTlxDDph";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YDwa0Vp1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D8nIV62888316
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 14:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pt/ApixqlclrG51koS1xQvuTNFgR3QVJPDXsgl/ix5M=; b=XTlxDDphz9dNihO2
	/kDmXCMp1Vw92z7+otxHLWBzNfyuKRiw4zFiwt7aF1/5CWrNOOhcAO+xWwAWJ8gR
	CtILnL1U1JRVfP+Vn8ZiHzwQKMxLs6uMl1r1/rlErLa11zORtyodAPGdxapluCqE
	ec7hTSv7GYeGtgVIA8Lsfzruz1jAVFnWhX8dl3ZsgglJqODTuq3EF+3pUIrOrJ/2
	A39MxBDxMCQQScSmfiP2ztc1r7ytkhMZoD5nVYRQUrS4GF6B2G4gy+itf1ALpnhn
	0o6pCHyVDmRChCMaDiZcfvV0AzMtosdOYFU9ylVzTfJeFZkG8whEP9X19ZrLoikE
	kSky6w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4ghe7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 14:54:58 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso3533645b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778684097; x=1779288897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt/ApixqlclrG51koS1xQvuTNFgR3QVJPDXsgl/ix5M=;
        b=YDwa0Vp14AdrCRnQ6t9gLD4EQwAI5U1dmHykdEWNHDvYfeiL3/ZRitXo5CsoSkXXqH
         9nMG/24qI47xqvfE4CgVd3OyM4ocfg7heNTtVmAfo2s6hbnaOAajxHRQmBxgGTLOPJcq
         XweXzebq7tTYBSTHVBD4JzXGfAvfAnEtz5YwqM9mMi/e25aDeRUv0gpDhb9u0SbpYlgb
         a90ed1V0V7BVEzWdRzUjQElY6D2MELkyi/IXJxlmKcfIkT0GVI2IrLG1hV5o6+nEkjI4
         7a29fc0E4defWXPMOeSc2J3u4/EK4xGQR42TqXBeE4R+SBOL058Msx4CctHSUieCPXx/
         crFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684097; x=1779288897;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pt/ApixqlclrG51koS1xQvuTNFgR3QVJPDXsgl/ix5M=;
        b=cDbpBTmMthfsQA3Sogx0JRtBtpRoqC2sK1ii6k9ejfUMARO8cNUkcixFWv4tgCSU3e
         etZOdYuS5W+X8COC6Lp2mpNrub1h3unMMjzQh5p8qXB8wm47/RW6hS8uAniRo/jnhEKW
         0zjw8BQfSv0sVLWKTjDuCCFSH7r8dnguZAaqv63dU0TfRXLrYmWAvrWhKto5IZbxEbp2
         9BikQHa6F569I5IAJcYum4vL5iYX8UIwF4eD+90zEpdAr+LaYcn+HmQCnVwSFeH7rVJ7
         /0Tpjw2opofnRqWqh+cRuA9sXJf3lyug9fVypt6+PzNPMaqqUKqdA8voK2wKvAbqitLU
         Ejvg==
X-Gm-Message-State: AOJu0YyEOsaWbNCIyJjlBMq+c/foFjZ+N2j23ECwuqXhYlNbzucwesLy
	iTCAB1Hl4ZVsPcx7+p3y7hlL6QEhMtVPJEN0gUOl6j/0Q4ZSQ0hqdNyKIRnlK64ye+qAorBBAP+
	E76bokJuQEI8bPpbSCJXaLt2avHpg3cAf1OWhcaF28IaNQgqcbcxfakaLhGz/zUjVpxUpI4U=
X-Gm-Gg: Acq92OF8yNUXDUlo4Url5z4ya3x40feFgXUkF6WK+T27hdhwZcqHFlbE18QofqNlPvu
	fpehJIgpFxU1P+LD+kAHGeSYtnRM2GpI5NONRTwX2OL+OJwd/8idS+hWnBsAPQl1RBM9eQopUtP
	HYsWTe1KWJHgfu9liUzPiO45PqnPyNeETOrAtIAoK2XFbvACawRmADAM/oDPooMjBFlEHKEyVGU
	/e++YQeTRfMFtCJ/TQ8/3symPJoBkc1z849Qe/PJnzUQBXJDZxj00SKQnSJHZx1IM1sK/x+6zHL
	ZmtKzhlH/+ARRIBv5aXhRcUkSmYIDtsl05PoezzFTYSJDoTHysXdwK6eUjZMBmPTS5O51IQzKiD
	Zal8z9PnzvGeDHtpUlusA
X-Received: by 2002:a05:6a00:2c86:b0:82f:b0:28f0 with SMTP id d2e1a72fcca58-83f042b390amr4151475b3a.34.1778684097324;
        Wed, 13 May 2026 07:54:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:2c86:b0:82f:b0:28f0 with SMTP id d2e1a72fcca58-83f042b390amr4151440b3a.34.1778684096733;
        Wed, 13 May 2026 07:54:56 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.195.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f38fsm26172053b3a.8.2026.05.13.07.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:54:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com
In-Reply-To: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
References: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/5] PCI: qcom: Add D3cold support
Message-Id: <177868409227.23780.11104184283675036276.b4-ty@b4>
Date: Wed, 13 May 2026 20:24:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: 6c2vBBY3zB3AKx53J25tMAGBp8hbSgf9
X-Authority-Analysis: v=2.4 cv=DOS/JSNb c=1 sm=1 tr=0 ts=6a0490c2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=QkUiPtlOeBxfVnO1KVo74A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=0YlPbCStZsfHY8mGD2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 6c2vBBY3zB3AKx53J25tMAGBp8hbSgf9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1MiBTYWx0ZWRfX9GboLlWmSVKT
 AAGlqWuqvO+nJrbyDOLsfBfVUbMj6n87hktjCfg4TQnP7YVKM/11KPr6s6nE4lz77OhKhCO/821
 KM4qd/dLdijT9icrn3OjeIoaj2JVlBfNzP8p5de2GWz38+ttarToTdEshUE2ozwmMEBj7cI2VmN
 V161pGJtz9ROoBQ+gosr72JdorAtqBi3OjsV5dpIQhbqVj8Xged7LvExrAdXQzQem7ptiE50XtA
 tNKzlon7sSuNhIHhLF4j+okJMMQ+5gZ3IrOaRUwhvgYk3CCMhl9h7ie8UhUyL5EVjsWt6kKRMiP
 LSoo5iBfkhnwcrf33D1rMx2CUeik7/VQiIWGOGTY8a56U3WMwwwOw+gra6yeXbG9efhqQBIqO1z
 3hMrch4ou9Ge6lSX+bvj5P+f2LWlmByVK6iTQp5AXixQHANBrqnCkvIf4pooCawvDaMqQtNwpPS
 sRyo/o8u4WPQrZw/taQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130152


On Wed, 29 Apr 2026 12:12:22 +0530, Krishna Chaitanya Chundru wrote:
> This series adds support for putting Qualcomm PCIe host bridges into D3cold
> when downstream conditions allow it, and introduces a small common helper
> to determine D3cold eligibility based on endpoint state.
> 
> On Qualcomm platforms, PCIe host controllers are currently kept powered
> even when there are no active endpoints (i.e. all endpoints are already in
> PCI_D3hot). This prevents the SoC from entering deeper low‑power states
> such as CXPC.
> 
> [...]

Applied, thanks!

[1/5] PCI: host-common: Add helper to determine host bridge D3cold eligibility
      commit: fdf2dc2b677c8a26573624ffcd8f4e2265a99b6f
[2/5] PCI: qcom: Add .get_ltssm() helper
      commit: 60aa688121667577f2f2e7d01c805277dbb75a89
[3/5] PCI: qcom: Power down PHY via PARF_PHY_CTRL before disabling rails/clocks
      commit: c3554c5ec37a490fc66480e10f00ac5bada8eb0e
[4/5] PCI: dwc: Use common D3cold eligibility helper in suspend path
      commit: f4f39b1fdb9445b1e4682fed6f86a2e327755acd
[5/5] PCI: qcom: Add D3cold support
      commit: 2ce984daf09332c09bdc26550d7b6cd4f12d3a6c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

