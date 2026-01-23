Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5529DB88
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153618; cv=none; b=aFU/PyIUE+pYulNsh/Wd3CIJv6bGjYO2V7ztmX1FLCt5mq41Rg+qDlPF4sKGryifcBZBmw5zj2AOklIXY4+zfcYhhiNoR4C1WFPQg6fMUuaD4dlDHEplwxIyQ8GNZ74Teii32FG+ZSV1uYrld2bFDgGiOVGZX+4LSYx0UYjJh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153618; c=relaxed/simple;
	bh=87tyDkY4uu801kWSXc2jqH21ZAwb1nV0cmoJamyPBmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nkBlILbtcLwZf3N+N1LtREcyBA3ur5YwE6c1G88wzokIRm4v4nU2+g9CYwtRfLLl8ZC6b1redPJUWAhdTIyjTPRQHXEK1nEa1GfkOF90egISVcWbbdJDprGO/F2DHdC8mzSOPx3A+xiHYe8T5Q0E2He3Zdy0bt9oW4mzbyJr++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQEC1inq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/mHRVCD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQEC1inq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/mHRVCD"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N56NQE3656617
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 07:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WsdGVScU7J46gfp9UKfHBThHJRFlROuZJLKeSB1KZTg=; b=EQEC1inqzwJMawNB
	ZfL4Aice8AxQ8CHFYXM89nDKF0L/r5aGexkjIHDAARuoClohj7RGL3w+uSf9UQ/x
	0RfY08dPRYwqUI6dkIwMZ/eomoDlhuRiMYG5r+ev4S5fWhV2VPEWWi7W00+zozHM
	vKrA+t4BEVQBUR7/vwsTlZsfHK5mw2ygFt54fxy9sKsV4ydn/5n5l4/09MkKrdSR
	zc4o4mL+hZNY3jMUdmpF4Ct5vVgkWdAEyLmzX3xPmJNUtWVWTpSFYskjgcgW/Sg0
	zxbqjX8luKY9jIvXifC2Gf5beyZ2saSYxs2dcAuAg7/Y1ko8WqyVQ6mNWU2+gX7q
	h7A8Hg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv2hw8f3u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 07:33:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81efa628efbso1704995b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769153615; x=1769758415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsdGVScU7J46gfp9UKfHBThHJRFlROuZJLKeSB1KZTg=;
        b=J/mHRVCDU+0lovfpUxjevumPBV2ew0smSQE4pxp+uTKgN+VxwPi5V+ep2c29/xwZXE
         /NOX9qltpCiLGeOBk/U4FbVYe9zsI3K4jHq6Kar55AU5TdBE2H8p+W9yb4su24SShxpB
         7ub7jlMWryeVaYKEnDkDGHTA8N6LpOBXR/sCvtFOMUHBOPrVEJ4Dm/N6O8Y6WIu5oxw4
         ff15FX0J52fbok8TPZNKmO0AoPeROxibIDLpdovl/07zl/RWEgioEp94oAY7kLlkuM1H
         QpmRKXuaHtPsMyCiCGvxQwVocsva3X+ipFhHdOXjzioydcrVxNGGiXxA8GGwOvGRjd//
         RpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153615; x=1769758415;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WsdGVScU7J46gfp9UKfHBThHJRFlROuZJLKeSB1KZTg=;
        b=ILZdnqrk4ZVfvF2eYAiULMt/QVlYGe5bLMT5BxuqUsMGPCo2GdNU8uZnTOJz9KFkwR
         JfZlGH4++ZwNl0mL9UTTEq8vLQ3GSiZUc8Ib70gLHCiZqQ4XMEJZiutDUhq2hiCSQOHX
         Phfzx6XoppcrYtANL7MfRtHsZauUxJ+Hxhc1oA3AKg+s2SPcQkvnR05rbWWQ8W06nUD8
         bHdbgfgPIgLkBlQDox7N/bw1eDEN7E+WqhdItPjeAkEvg6qTkdoJHxHONaz+nuSCjceW
         VSvqc0OVRAOJSRAlR366sWPSmtzj+Gxg0mWw00TUkd14Z9IH90nR5df1iHnUGEaOtEGN
         aDog==
X-Gm-Message-State: AOJu0YyDY2dK029403hxMZNmla2iMshjif30Cfl5FMx+Jz8RA3muPA+h
	E5JJ01a7v2ycIg8N5FBqIVmH3qzyPSwW/W4lqVnEZgOpr62015oiKFX5+sPMp4a8L2tm9CvQQA5
	AYqmpImmssCfWA/uNXAFBDfoHM6FZtDjkfwzP9OFuG9cGuTjvxb1Sf2UGZQ0Ir+c=
X-Gm-Gg: AZuq6aKQphwH70x6IRXiBfaZG+b5SVN9DfDmTejPzcXzIDPwyhodeR7+xAmrrdrLx5g
	of35xObR33RxYSNrB27z0sHFIin4Mks0SjtirANw7bNgDiUqM9XEbbMazajoZAzzlB/EkbuQB/+
	Ik6aFtfJPGC9F4a2oxdD1A3uRoaaWDAffZefjVv4YAHT7YFla02ipGYY2kjZStBqFRL0cUDbaff
	ZBNwMGzfIHJoMYzGITGjoGr+/WJieCOHJjOphv92K3HqsCWoOB6TBgWEsz2WsOsoOLr5XbFWBux
	f68MuXZXQivR02gGuV+nJQnxtiUqhT13sW1n8WXFVcRXuVNZWCDlYdW/BvUTnSH2/gKvqR6mk/4
	Nin3zxOMZ
X-Received: by 2002:a05:6a00:428c:b0:823:1406:8797 with SMTP id d2e1a72fcca58-82317de3471mr1674051b3a.31.1769153615102;
        Thu, 22 Jan 2026 23:33:35 -0800 (PST)
X-Received: by 2002:a05:6a00:428c:b0:823:1406:8797 with SMTP id d2e1a72fcca58-82317de3471mr1674030b3a.31.1769153614595;
        Thu, 22 Jan 2026 23:33:34 -0800 (PST)
Received: from [192.168.1.102] ([120.60.134.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e903sm1332784b3a.51.2026.01.22.23.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:33:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20260121-remove_cap_clean_up-v1-0-e78115e5d467@oss.qualcomm.com>
References: <20260121-remove_cap_clean_up-v1-0-e78115e5d467@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] PCI: dwc: Code clean up and formatting
 improvements
Message-Id: <176915361119.92620.17499887137559458290.b4-ty@kernel.org>
Date: Fri, 23 Jan 2026 13:03:31 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: JhHOHB0dwrd1i0MN3Ckb0aHbWgu4O5V3
X-Proofpoint-ORIG-GUID: JhHOHB0dwrd1i0MN3Ckb0aHbWgu4O5V3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NiBTYWx0ZWRfX0FajDIFgos5F
 ITE2GWNKia5QTZdSaVoCbCa+dJBBl//yGIOgr5aNp+YZkIp69408a8wYAex/S3vsGxrr0LY53Z4
 PDLZ/9LxDWg6oCbGiwXLafuNuUPFohorB81GmaC5SpW6VPUZ7yW2i1O8aQ/GfdIe1WZJPt15SHr
 1WS7P4lGuu2t1vQaR3p0PaA32fc6acZ7Ucwu3LR2+mu7qBfn4wClK7QWrBJkoA2RgJYiPXI8W3n
 RJkp+uHf1xSWPbJsyWuf7M6JvQiOSoAFfKatFig8T2cCwEoaX3lbtE2Jc/qJ3Qo3osCOCNDEGc2
 JpyFvuqpVTQc+jyvDnOCcywOtOuGbyiG8VQTwoQG9beUDNT6rccKjPe9gEbQvJupQJVM1TugjOl
 hVMfn2zdpIeui9Z4iJVomi4u5IM438Vzhhxkg1az+awNRHVYd8OPmAMUmTbwBieM5c5mSFUdCSt
 wBVRCe4XDUBn4ZoXIAA==
X-Authority-Analysis: v=2.4 cv=A4Rh/qWG c=1 sm=1 tr=0 ts=69732450 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=CQ9XqwbXd+loVrtDZPPJfA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=IXkOZakT1NlM43P_8ZYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230056


On Wed, 21 Jan 2026 23:45:17 -0800, Qiang Yu wrote:
> This series contains two cleanup patches for the PCI DWC subsystem that
> improve code readability and maintainability without any functional
> changes.
> 
> The first patch addresses a naming issue where the "has_msi_ctrl" flag
> name was misleading. The flag specifically indicates when a platform uses
> the iMSI-RX module for MSI handling, rather than having any generic MSI
> controller. Renaming it to "uses_imsi_rx" makes the code's intent much
> clearer.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Fix grammar and formatting in dw_pcie_remove_ext_capability()
      commit: 8a214f64554ce4da91f35e7d3b8eaa9674f5154d
[2/2] PCI: dwc: Rename has_msi_ctrl to uses_imsi_rx for clarity
      commit: 0ecd890e3cf54a0586247b9a384702703277e4fd

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

