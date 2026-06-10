Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D929DB86
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099314; cv=none; b=cHjSGUQAmH0FcEmOrUylT248PIiOTP3rK+/2+aFQ4rD1K84OHHzoIv6c38WKQHXLLeejpeG9fR9OJbJa6ACV0B2PBYmaang2ez15Jx3P3Yv3gdntR+cIIc907iTKDVJ2OPm1AggfKQ6iO3SEPoQQy+RHvh0bXt9pkP40fywN2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099314; c=relaxed/simple;
	bh=bUpiHSAIALXiB2BHU/s8NMZzGgYMNRJvgoquxwx96wQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ngAJ/f7kHSpxhhMsaZXbDDQEMvOBgJAUdFRhCgd1luwOl6Z9dpI4MyqelYfyiUpN/c/SwNC2p5zzgW4KagDOIpYtQIx7HoGVyaWUBAKAvlLnpfD0vvmuGCletPdKTstl8CkbR8zQeSgHrjqE9movhM+OWtVNmMcASPJoEcCQdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K27YSiHd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FKIHRky2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K27YSiHd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FKIHRky2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACBsZK3763976
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 13:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1t3DKnJLwN7pmQAaW15e3YyxivpxU3KsElLN9yzYDj4=; b=K27YSiHdh9fr/8jn
	4jofhsStGwSbgnREcY6FOyrDMEq8+oO+uXZVHfPtoQhHHedIvepbL4oBMj9Rexhx
	IieGa09kqmZ3iIGvaBHCa60aWgj79CgXT1zvz2NQpO59iQ7veGLxXvdHzW7EsILY
	OT2zHXZLBTtm4BoIq/ZKH3F2w4ev6musmd1KlIHqm5FZtXsyijos8ZZKJxBTfAXT
	fOci2S/+V/HD9aM78jmYDoDeoHfboLFWu1o3SjEu+zlSIT0zuI+Bd/UyV52UPbmN
	ipSyJ380I8pXtEGko2r2o14nr2Ji9smkjWJK9YmY+3qO9LLuKe7ca99LmxdO6LBm
	r8/MQg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnetqjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 13:48:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf1dece2ecso69647945ad.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781099311; x=1781704111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t3DKnJLwN7pmQAaW15e3YyxivpxU3KsElLN9yzYDj4=;
        b=FKIHRky2CtjpTs6Lo//6GEr33XTeU5Wx4+RyaYPbNVf0zckHp9KzOm1PEWZZKfwWT+
         oq6HAHpyGWezjxtI3hY1woZ5hwrzDOvDUcU561UxNSw3Phx8IzQsxafHyvfUyeYN5LmO
         L09UcTWGJy/8pBNFezsJVgkTjgZj4YGAdIkAIJfx6/jyx5b9Lyjd2rTeP0n6d+tGM+WD
         ZS6QJWb5GkAXOA08bg5Ip6o5kdt9ZKDTwufFpJI1QZXMWue6rvWXqpHUjYmhZfQNmcES
         uiDtVQtOXnSkRcePkijnUNWJ/lRaC3bc8fZ8aWW3BCkBNfFQ6q2jYzAlwIf2AMMzRzEE
         aF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099311; x=1781704111;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1t3DKnJLwN7pmQAaW15e3YyxivpxU3KsElLN9yzYDj4=;
        b=gk2+CakjmK2AusqVBAya/bkttB04mLIslSmacK+soDXBTpnT46usjMnT5Zk9SOUZ3L
         6x1PbA1gXpxzTtMMBOMg6r/gGh8fodnLUgTFTrb0lYXaY1lyQwMf8L8+q1tIFLUug2+1
         yHbYx/OFbBSDORQuUloKtBnoqhITr7tXdzVZAwr4jESKsdy/F4x4KQjyFfpCB3rBKPeH
         8Xjeq1/iWKBdTLki/ed8mjzE4+aqho+DqUmeJvzEQEL0/4uJuPkJDmEIW+PlMKYlTONs
         ljdTU8fryv8bNDTYtJkFsdHdHetoCsGzQ/hHENKKdAMtOCGdLAkwmVCD+JD3HATBRdSj
         YqYA==
X-Forwarded-Encrypted: i=1; AFNElJ+oUWUGd8wcM3K2EGdkTnjRXU0gntkY5o0aNexh/Bpg7Tc5PK0sjsCdplMsV8bt8pA3X32bfq1QaoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/8eHyo3XiOmX8Q7gnRKMx1quBzhKkX46K0FqZEWhrx5gVM5d
	QFsbaKwyNUtSP30qqcFGkm00iPafOehKTeFpwXZHRAYu6iZZeAJEAElsg23A1Kr+lvcDYd8O5sS
	AnhmL0OqSpMVshDb1rzv+DGipBAUDKuDifyjh4fTT/94siZRt1aKYTpwMR5bFVNg=
X-Gm-Gg: Acq92OFQRDEp+P013J81eFj8XEgtauLqNXB0Zdb/vfkRwmE9dU18h20NzHUMZDhQvW7
	kmC2S/3FPhqg/8IqDCTOwxcFEj6j2DeDCmlABKPDSwxwdCeVidBq8+7VCaneg4mluBSN6kG5XNf
	TEPVQrq+KOpmv58zMceSpovm9DqZSJjEarh88xUl9U/Joo4KOGYKDsDxXdQ+RKjZE9Rpoq1XFR+
	Zoheb/xWbztd7Hjqh1cebC2DRFRwhIVTTYEJuUPqkEQbQLea23xkyDGG1bUmYK1bh1SwmXUh+hx
	4N3cDZbYOrfxwmxopi58N11rUP1YcmKjxZWzxCKk+n8j+5oKYU3/c/QhLT8jFtvRMfpoyo7jxVs
	J/Mxf+qrVFTGV4IEUHEiX+pOTGZb4ptg=
X-Received: by 2002:a17:903:1205:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2c1e80f9b57mr295502495ad.7.1781099311376;
        Wed, 10 Jun 2026 06:48:31 -0700 (PDT)
X-Received: by 2002:a17:903:1205:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2c1e80f9b57mr295501975ad.7.1781099310778;
        Wed, 10 Jun 2026 06:48:30 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.203.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df6esm270319645ad.48.2026.06.10.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:48:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sherry.sun@nxp.com
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Subject: Re: (subset) [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and
 update device trees
Message-Id: <178109930423.8833.16452944960716589912.b4-ty@kernel.org>
Date: Wed, 10 Jun 2026 19:18:24 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: x2yYLej2IfkXYVI2RPajYgHxIPpw551p
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a296b30 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=eDurORsI8St+1bJHqsJewQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=GUrLWBD2z8Uwe9ZWfuYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: x2yYLej2IfkXYVI2RPajYgHxIPpw551p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzMiBTYWx0ZWRfX5LBa5+at7RLx
 v1yIEWbfO3u0yEJFXz4JAcUhv32clS1r89r0t5V4hEdXt6Xf7Xo63T180MEk/Llh5bywpaf5zNb
 RgFVrmezI1b9SQi65rZZIztZTVFV0h4jiJEgxfn4IRxR4hWbZt1hygrkz+FwnPg8Yb2K+6P/Eih
 +JKq3vR4MSXBxSq4r12ZWyz/mJ9/UvYrdF0eTRj5aKPmzZ6M0ABfKBfQ16WCIU6NcJG1Tl677yh
 sBO8O2XAjuaYCPNWFETcWPn7yBGf387vMsFjG306B2P5ZeppdzCUTkH6DSsKrVNwSZKyelhibZN
 xc9cgFPMDUJS0MCSMrKN+HMFK54bwcGET0zk0enB0AQuzW4ETBgChBK5CqpT+7O7H6C74217ERp
 bwtpCA1ppKsko+BXctUbq/LgY7EFXfEl7F+iMQmOwTR4+XbTK4RRnkLD6dX2Lymyt2SMp3yBQal
 gTbhzJQDU++QRBHK6Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100132


On Wed, 20 May 2026 16:48:56 +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> This series integrates the PCI pwrctrl framework into the pci-imx6
> driver and updates i.MX EVK board device trees to support it.
> 
> Patches 2-8 update device trees for i.MX EVK boards which maintained
> by NXP to move power supply properties from the PCIe controller node
> to the Root Port child node, which is required for pwrctrl framework.
> Affected boards:
> - i.MX6Q/DL SABRESD
> - i.MX6SX SDB
> - i.MX8MM EVK
> - i.MX8MP EVK
> - i.MX8MQ EVK
> - i.MX8DXL/QM/QXP EVK
> - i.MX95 15x15/19x19 EVK
> 
> [...]

Applied, thanks!

[1/8] PCI: imx6: Integrate new pwrctrl API for pci-imx6
      commit: 85c1fcfa740d4c737f5575fc7251883e54227a51

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

