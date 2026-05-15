Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCB3D6467
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865334; cv=none; b=b9x9NvDG+ZuaY32yEE7q1PgfCWjZCOMkxQqAfYOxplr1Z+UFbeq/MJXOc/HGSlXLJu71D23DQwloBPT1yBnhVkCgilWW4vPLWjXCGtp0DxWPI/5hX7SIu/d0TYqKbbqij876EabyTxchg5lGvYDZz8OnkzpGfSQxjgqsK/2Jxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865334; c=relaxed/simple;
	bh=9K2h/TOwneDo2V+8IMRKN8704tebpv222lXgzRfs6us=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BPrrRymmWejcbPXHnHIxBYtX4IJngch+HyiqVkYAdilcrA6nbX9k/ZU0pJgAtXcCAujWoy7iH7aFSMYYeW6dF3X6VVU6iAQuVGIGtQwah8DEfCVGfGgpMLLX+6pZif0oxXoTOBt4H2s/CHDkDBB96/4YellRtVDn84rAiOw7PM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ReeeR2Kc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A0lNEwjO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ReeeR2Kc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0lNEwjO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAX6pv3219657
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	maIQim2k/5k9GdsUOAUiZ7MicWGQxeUUIRH3OStLOXc=; b=ReeeR2KckqUsYRYr
	S/1Ug2T807YHoA6Yp99lPslIBIv9naTFJYhvbW8EASM6k+YR9m7LJuszIDQUzB23
	IC/Lyr8mi+3t6w/+M233I/o1JPhPSseJ5Si2OgL9ck53j0+9E9fyAg2puI6NpD1t
	0tyELgNbNXjzY1ixYMlapJNsFT6AgU6WuPuMClFvD5ea8ncG93ZZDiLpix1LJN+V
	fT5qrVvm+vAHIMUFrL3d5IIjvpBIa0FALgEFfqRgzJsWDoyu7rIJRFfjjmxwBo5w
	kj1MEo/rkqz2/4MsAoZIyLicdJaiu85ZMyyO7On4buiEvKPtFIC/CJUYaLedcOuh
	sLGHSA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s45v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:15:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso2075185ad.3
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778865330; x=1779470130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maIQim2k/5k9GdsUOAUiZ7MicWGQxeUUIRH3OStLOXc=;
        b=A0lNEwjO7+cfnL0EKZ1xu8QNn/EonpGh+2J4dbqO8TOCo7W64BJ02B1i+bTLpeTcYU
         Fi+XQ4CNCxcc+WBQjPXxHaVfkENqAJ9yvMfMW8Sin893TI3ScC/uTRLU/dKj+BpSWHLt
         ChBA6RarpJtDJDuB9scJf1wePqyQ0oz0faKwye2MWjDmRhp+fhkLpAXyZhwMd/rvcxtx
         Ef/8wfiTbG5IfY7pcRPW5nkaizPmI2bkrGLzh1NZB4TWEYHhd2hGBsxN7oRSkxaTR/d6
         rUVKicx/OjC5+AFDy/WYY+fGQLDOgwwLisouDHCwPdFh1ffebwdgdFToFZ9bVLWC59FV
         4law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865330; x=1779470130;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maIQim2k/5k9GdsUOAUiZ7MicWGQxeUUIRH3OStLOXc=;
        b=jfJI9aT07z9p6Ia0I95FJa+0h3oaJXNlvsWMF8n9f4ujQDFCB1/hxhxkkbSf57pcsY
         u9ctyghZgQQztUceuV6512q7yY6V/++UVliGF05ee6l3BaVOS0p7HoTtrSqMDTyvQTiT
         QUkph+WB1Zz9+M6mqIDpfUa+tCHHvDgKQS+ZJfJ4bJwoqBbeQiHCpS8oLKPGWFHN4LG2
         vTx2HKyEGi/MvBSW7y+t5X7JHcUSFCaNFvRXqkI+gp2W0ydv0R0rlZ+ZbiisrF1zfjDc
         u2ggvMJzQfwb097hz2ImxFiz7f49TL6A5taR+n3zmfHdKc2y4LlfxbtwK5rxAm0Cdktx
         iQlw==
X-Forwarded-Encrypted: i=1; AFNElJ9qLVUYFhoETexRNboDF9y0XYPtljJku4Datl7GXo3xtMo0zhTpOC1z24qNZLg9E3ccJln2Irs7iYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGHDEJVKWddtIiftEvy4pzYbo5XAGmWuYk5S0+JTXUuX5/msC
	jVZVKFzX4s7fwyZ6mkpBhPXkXKgthWFgHkLO3E0QOim6911RJuh1cPARJkZyOQKIWqeGBYKwCMr
	fAgRJIRQooU5om+oGaLrV7dTMZ7lHGbc6aXZswoogX38R8JcMg3oXhOTK71Sbp9qceIHEGv4=
X-Gm-Gg: Acq92OHBiHAxs1zmMPnA5ippxaQ/cc0OOmdhrsvV72cE2xQvR2ZhmcpJQi2V6ySXNws
	hzUhWrzDF87XKT/o6gWli0mN1Ek93N6PCGBaP9BZW6jrIuBaomsomEWteRyw3hAz/BRs8+B/oXv
	f76mgDsCPUSx1ASywQ0g//sFBjSfeVwi3cjnVd3iB5bCVr5kyIB38VJwUZgieTZ+mK29hXf5DKR
	zldoskBiv+tzJwu9syEb24LkJfPpULoKYO8+eKSfKcf4kVCbpq9imifsAOQnoy9LRYpBg3w1Q9t
	95J3P7xSDBnYaeXJQwzUS2eGqhuG8iT8o4/ds4tgmMfK5RMnhiLsI6b79t2NAXBkdJAtHtSRvfa
	ZCuOIxMGzcE3daBUFwnCa
X-Received: by 2002:a17:90b:260b:b0:365:f8fc:3846 with SMTP id 98e67ed59e1d1-36951b87209mr5703917a91.22.1778865329655;
        Fri, 15 May 2026 10:15:29 -0700 (PDT)
X-Received: by 2002:a17:90b:260b:b0:365:f8fc:3846 with SMTP id 98e67ed59e1d1-36951b87209mr5703864a91.22.1778865329094;
        Fri, 15 May 2026 10:15:29 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.141.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695148c3d7sm4057064a91.14.2026.05.15.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:15:28 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260501102407.29462-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260501102407.29462-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: renesas,r9a08g045-pcie: Add
 RZ/V2N support
Message-Id: <177886532379.11424.6841122855911505844.b4-ty@kernel.org>
Date: Fri, 15 May 2026 22:45:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfXyx9yYuQBBQP+
 D502xUCYyKJTNRYEgf86L3cny6fuceZms/50kWu/KeNbm7L8I6z4NmmwyRdluw0t5jeK5I8samd
 APUFe2keGBtaziyiYQYU/WXlSNJ9PRoWUVp9TIM81M8LPEtuBaCELk/C85DaqaWtiXTnESMogXc
 P6ItRteLwnK7Rajsxf5xQZHvKwka+AfkuurVPukz+uH27ZlBqOLGh7doNgrwC5royxjHxWpDB+4
 6cowEi/Izws0cpcmvhswA8C995RCLFDSvXq8xp0g74qp0X70crl7w1rrnu4d7AAY/wtxxo0E4MA
 V/4aJnoUpNSFsE0YU88Fh0aqTePnSPnUnSnxKh6adUk5hkSYN0j//toQtnxZA0FDjUs2cwEjGJo
 KzyFDYpBbb0BXf8FWIiFTfBNZPNujBCosJqwNlbvzvAcGz/MlRmww0f4TcVn6IzPCCFLdniXtEm
 l5F4zJHdF0kf0MRYHJw==
X-Proofpoint-GUID: pHRbhUSgy10knGbJb-z89sMUzF4iD52j
X-Proofpoint-ORIG-GUID: pHRbhUSgy10knGbJb-z89sMUzF4iD52j
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a0754b2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=8TBCxnFsifAbGBbxUCxq8g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=nEI45t7MqVOh0zsBhjcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175


On Fri, 01 May 2026 11:24:07 +0100, Prabhakar wrote:
> Document the Renesas RZ/V2N PCIe host controller, which is compatible with
> the RZ/G3E PCIe IP and therefore uses it as a fallback compatible. The
> only difference is that it uses device ID 0x003B.
> 
> Make the binding title generic to avoid extending the title for each new
> SoC, and update the description to list the supported SoCs and their
> capabilities.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2N support
      commit: d2fc550dfe13eef91b065af7a12348ba4162ac04

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

