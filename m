Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9843D502
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020008; cv=none; b=Z5QTVWgpnYagDjDkEV4u/gSVnwY3tuVYqNnnCm1+CqvNs4GjDeZ9tYA/KKFdYMIVNBfaD97sXqocUjgTvjaRk2tx7tuetAu9cohVg0g5WflY8Tr/u0BN5egfA+5FENX86HlIgScigIZ4zZguy+R/X5bOtRs2aQEMwoAAgkrYXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020008; c=relaxed/simple;
	bh=zpF9w6itFSOJgKbyIAIC0rALq3fevBbd5Xb7VaWIxU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=II74A/VpXKaTU9kajiP5ec6otFmYOWYGXI+rB2BPM/VjS5GXh5NXqihm3QzBomXmST7hhOF5Cxo8dHQnJ1OT8RhUZnsPJpZvbM2WHAXc/P22ZoVEwJ0quJQisWplWOkEYIzsxalLeD7b0gYrsa/uzMUcgZgugawTNlX2rQtI3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WB/qeZzd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IDUmbCrw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WB/qeZzd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IDUmbCrw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClaGi2706270
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 15:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bw+HTzEU5Iy7MtnFBkzSQ787/7xbF41rkOAgUgVqkcE=; b=WB/qeZzddWSLZJTu
	/kqDbSiNiL8Z2yHm7uiR+9yGFtaSJt4XO1Oq2kxdOH77TwFt4I8fj/in4uXT+LQ9
	VisEKgHgJ7omEEmwGHD64v/f3zq6eDcznHVcE8DEfsZcr15SBF9J/4UrSSn8X93B
	KcSCLBZdKlCArg8oA1IXykcFFzX8vIVoz1v16dxA713hQrCBzUcUra5AGWqmgp0Q
	EhzvjWlYFWyZGgwLin/ZxCrpU0lFSk+7lkj2euau6U7TCiNmTrjQ6aBFgMcp4YaO
	TptR0OrX4j4zsKG+33g3lJnohWXnpUAGErm4XVxJu8y2xb9L05PgjH8/fexZqS5k
	EV0aAA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt228g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 15:46:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso88170185ad.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781020006; x=1781624806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw+HTzEU5Iy7MtnFBkzSQ787/7xbF41rkOAgUgVqkcE=;
        b=IDUmbCrw9bsQwQh4jiTkqo8xNuWkafqphJPWqxnQEA56YhExnONnL1yhjN8gjSBuP4
         aOdfYPfehcXfpXqZj/9KuXYrS0X045DNayJizwioOyV2tjlso9pvINfuVfmDPrLbi5Cg
         ZOPG0tcEwX57Sr2NfWYL2dpWSYkrKzNYXpNZeL3pjNGRljXfb2lLrRe0FjstPSTonPPf
         +iBQFz6uUPBRq1lpgRZoe6HEfzkWUGNpKtGN8yaYHX8AZUPmTxopoyT7MSArFTeDbUyX
         M1cq3SdYJ0gffsyTIeIV5i08ABg5rVSmWU15oNQfV0vRwgarIKSXE8El1WS27RwC3BNi
         6SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020006; x=1781624806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bw+HTzEU5Iy7MtnFBkzSQ787/7xbF41rkOAgUgVqkcE=;
        b=JgmHDgls32S5qHVIRzglrMFxtgM8Wu2Z26tIPr5CP3cXfnybA9SSHmY9YMKC/3MwEE
         eTRc7E2ajEJMBNOw47zxlFnKq94O16M+lOsCyVFSNEtYqCG27BrwwRUVcKsAxB6hlsAt
         dHhwAVZk08Cirg/ZlLmsa1ldaOFaKX0hNeEBu8pHqrCgdsltecO40cblS6QCfd0RnfQP
         DFAWxHWrTRjOCPsRZOqcIW7rgAENkMvxhozkJcFcNk6xzt+2cggOiyjoQiBGs5eWxh6+
         RNm2LhZadOduzaUM/fIIayNu7QRVXenBOWzTTIA9Qr6oVs3gCJvpjo2x9Y4uYd8oEatc
         D8YA==
X-Gm-Message-State: AOJu0YxUQlMHAa0Cyzx1fNDoMZLwur8j5YPBfWY5Xw1DqOyS4NFL2HT1
	39RFm49p2bhBEdNY/yZ8TKnyHQ6RGcroc6DOtfZqL2qXmn+eAHDm/5jGU8XCZqXF+hkfNI16deH
	mTQs8frtQ1/fgORRbWNZn/49U0H2u/uesBRz6AtdDLn7bWAZsbDjew74LU5pejq4=
X-Gm-Gg: Acq92OHcFADTdwa2Ab42jcIVNS+tDuuBksufmzPindNdIunc1+X37ok+d5Byy1ibaLZ
	9hi1dXOoXfsSZD7h2kL5cPsIe4ltxgTNyToVYByB0XFySClfSC39VCYClClpk2FVvgDgrds/MLZ
	RZTNYBqpZ2erGVqealZkf1RS4/c0Tacca/FmlK/3rv43HfhSgJ1mAOhRaKZr2FmODnOfintOm+n
	aE9QXQJCpidT8JxtL1xVxZBP3J6vUylTii+ujzEz1MAADsUxJyk/eekgROkd8SDq1IgwvNNZsXg
	NiaAWUyeJBcVfk8e+xY3NajBKerLZanuLyuLxgHG8JAfWvwTt/CIZeGpBboIsdaUF/zlKnNb/jy
	y8cifrZ5y4TGVKbKmWBB3T2C72E+pGLk=
X-Received: by 2002:a17:902:c409:b0:2c2:15c7:ad77 with SMTP id d9443c01a7336-2c215c7ae15mr207432735ad.37.1781020005570;
        Tue, 09 Jun 2026 08:46:45 -0700 (PDT)
X-Received: by 2002:a17:902:c409:b0:2c2:15c7:ad77 with SMTP id d9443c01a7336-2c215c7ae15mr207432405ad.37.1781020005013;
        Tue, 09 Jun 2026 08:46:45 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.203.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8792bsm223401015ad.23.2026.06.09.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:46:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260518072715.3166514-1-hongxing.zhu@nxp.com>
References: <20260518072715.3166514-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2 0/2] PCI: imx6: Fix i.MX95 PCIe PHY initialization
 sequence
Message-Id: <178101999933.10755.15039783004341281715.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 21:16:39 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: jeSYdiewP0ZXbs3gUiMJuIn9ePKR0mnJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0OSBTYWx0ZWRfXxivpV/80af3r
 6+YZKcRXnOBHw2Xo9Z8URosB73yfSPYuXoW/DvsKpg2oOcbbe1AXJKKKH9z77il7uMxs8bMd7/3
 1lGKAaEJAeo/ZiUDUqiHtG2T81Fij5+FEw3+ElElnZmOV3/xp+amDisjG/U76saWrXupMiJ620T
 UIDiA8/VBFgllAaviSbh/2btLKMNF+turFtaPqf6PPUq8qCfeynGdcxlvRP50HgVgqQPjzZHoWZ
 q0/vctO3MtKIEJDGwPR3d4ecTpCV/SZOBWXOlFXxUBnUH0tnhnsEYSvOJqLS3YsZCmw0OlTj6tg
 vl1P/90/kc4ns7E1GukUmJ2no3b0jLwpc/lHiJio+Vs5AchnBfwM5brxGPTvNn4o5hWfohtlEyd
 squckJNBVMQVvjItwff/KTvygFyPkAW+D+xyKLx/i0WfLR9zXFDXKqy9hVBCbxJKUaYb1TG2s/r
 K7Xsu4IGGsbxDsMnjRA==
X-Proofpoint-GUID: jeSYdiewP0ZXbs3gUiMJuIn9ePKR0mnJ
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a283566 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=eDurORsI8St+1bJHqsJewQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=6xSj6z8mzX6N8v9Jz00A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090149


On Mon, 18 May 2026 15:27:13 +0800, Richard Zhu wrote:
> This series addresses PHY initialization sequence issues for i.MX95 PCIe
> that were identified through careful review of the i.MX95 PCIe PHY Databook.
> 
> The current implementation does not strictly follow the timing requirements
> specified in the PHY documentation for reference clock configuration and
> PHY reset sequencing. These violations can potentially lead to unreliable
> PHY initialization.
> 
> [...]

Applied, thanks!

[1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95
      commit: 0c26b1c34d12d4debfb5363cc0be6cdf68e87ba2
[2/2] PCI: imx6: Assert ref_clk_en after reference clock stabilizes on i.MX95
      commit: 9dda3f83ba677b9cc2613cecd9120123000ae50f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

