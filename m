Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C03B19AC
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549714; cv=none; b=KPThi7yvxDPa/+rCMuhXLf7Q8K+fYHtPhc3qwtrMtB1QU8nZdF+V6y/CrI5hxn4NA5KAHUyPH+y7N7aBI9OfrkJMsvbuIKfbcnkb2UWlpwqpTg6/ZtLwghL901C31qmIdk8T7IzoADFePcWUglO1wWZaM5zgavlqSpLL6AgL8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549714; c=relaxed/simple;
	bh=FEpgr4DpokD/ru+VDPieVlGjiUmp15iFP2mJXKz/ICU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rENgGpY/jiFd/5HSWUEfZCgsLGAR8e+fW1zbOQOU+zyolHye+lgsoJFol1++v6R0xRr55O4bNzM+xyTvWQqXbI1r4v0N/Uck/GMHwBMHj5JDwo2ZBqBz9ni1bkPhLJpGHJP442pd5fCffg23B9aIxCh4ez/uRliz60bQbcz4rBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNVoGAxG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cblu5BL2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNVoGAxG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cblu5BL2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RD9P1574407
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jG3Hgyk7P1A7+B4l6oy9D1
	dles3YcASNJ+tr/p4S27E=; b=KNVoGAxG3sYf7VYLV5zTgIl5N3EOx+cLfAJhu1
	jsns+W+Mn9aBJ4Vw+ujkkvfMHmDIPGvs8/QjpWMNpqtInw1PatNasw8ubNDGSnRz
	VMMhe+KJ8ZxUtQGkwm1vqCqwYOp44I1Ct7WKg8cAwS4uJEp6BKvoEgL5L8Ke+Z1C
	4B9DFqagZPVqXzf/H7SE4oLaC7fh1zXmri4fIpwGj58H4Ppvetl+KhDikSms4ND2
	WtgtoQZ1qHbQ6IDtZoht+TBI4qDMgBVJKHbSTVCqVCg/MpHmtx86RUwN5yszr+Ii
	RUFYh7jKEAu92gmFb69VhlkFnW35OQoj2NkVSulyzb7vCjTQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g7456wjtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso5470130a91.0
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787549708; x=1788154508; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jG3Hgyk7P1A7+B4l6oy9D1dles3YcASNJ+tr/p4S27E=;
        b=Cblu5BL2grLMnARLr527WAvjN5yPT1LpTiaomHBRSsG3sCC/pCUbLtXBIyMnR3kirD
         GBZ50ruOU3AmvV72psUPaV4YyOEcJ0TcBLYenG8kAi/OkcfyqIX4uPpvMxWX+5xioQng
         LBYsvi5LclFu6yVZMPThPLZlG2iioVuWph6eNoZ176BNDcNt3xuxfA2v40I9fq7AUDo3
         vCgui2lsyr0gF5xYkx7deVDuQNhKcqx7+ugCBjLFEMOsTokLU5Ngm6foUOsgFHP7yhGs
         dhdc32saHf3MlalRh5gAb2uIE+TM/TRrklxLY8N6l94f6VvcNESpP+tadYgx1EnKvsis
         cDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787549708; x=1788154508;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jG3Hgyk7P1A7+B4l6oy9D1dles3YcASNJ+tr/p4S27E=;
        b=Su0MKSq6mWlIt3XlbAUDwoF/A0mnpYNGBvacLuj9MvGQY08KhwqneyikAuOwSzZUOn
         BBhh1+ibiPLl1wdWKsNz3ZBkR0KMXZC00E5sDHWwxWEUU2JEjnILJ6Cvq9wCu79tvq9q
         mPdZZS+vHk1fy9NtmGCzxdEDgpvHKoSKcCErESoTEec38ID061P7405xCFy1riAmeuqq
         VCAu8MPclukRK2JqIwHgimrKYvuaJIo5sg4UrId0Zuag6TAEzRHpZn7UDHI/W6WjXiyk
         zfd/agV6DQLaTaWe5zhbNMzsJfDD65grLoX0nGAUYRi2/OU7bWTyh5WKAkA1sE+eSqGz
         lbog==
X-Gm-Message-State: AFuF++nPW2MAw6SvRGUG/0Ky9D0weXY7Wl0yx4cTyr9L+MfPPS+iSJiz
	bloYaXcapHSve8WLn9oMEBCqpHLUWbkNpeion9dzivCTxgvlipYBarEGXYYnuw/DQ4U8QY4H4cB
	mnT4jhYVTeNIzQ5AlYcCPOIELDpmLui5goXYgsO7sufu2CQJRS363IYdicPHS46U=
X-Gm-Gg: AR+sD10A0crvRV7SEEpqMLYZSswvnop/EyBNcNbLFPbK7RyQ4v/SpGWSB0Ta6e6EnrC
	uBsoEdo3gr0spPOdXYPpOSL/4EXlTK02GalYiGzI0e1TS/hR0xeuT0jNWcDFPaEJLenwIlbsOy9
	eJ9iMM71h11kblBJKl0KsRBlz+llNPiJ8DTYQ1pB3qU6tERuJtSQuv4TwZVPZkibGciq1vba3kc
	ueZTiBeWtwm887i9aDE1tR0DD3DJzgcQ4MvkKCyqf1def41LoLU7HTQbcILyqVCQca/D9gGgG8d
	D0KOqaXRI5LNuadTBRnikf0RUFRv6miZ/nZv+JdB3lRODeQKrRBjYCH7O15rPYdiMB29tvn1TD6
	1OY5/WRifaM3JpeaW43nej+/OZa3I2sqWLnU=
X-Received: by 2002:a17:90b:4c84:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-395df2595d4mr25232249a91.9.1787549708031;
        Sun, 23 Aug 2026 22:35:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4c84:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-395df2595d4mr25232189a91.9.1787549707625;
        Sun, 23 Aug 2026 22:35:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327ff728ca7sm20166492eec.3.2026.08.23.22.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:35:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/2] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
Date: Mon, 24 Aug 2026 11:04:58 +0530
Message-Id: <20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPYi2oC/22NwQ6CMBBEf4Xs2ZKyCKIn/8NwKLCVGqHapVVD+
 HcLXr1M8pI3MzMwOUMMp2QGR8GwsWOEfJdA26vxSsJ0kQEllrJCFNz7qbOvUWiqsvzYaY3NAaL
 +cKTNe5u61D9m39yondb+avSGJ+s+21fA1fszG1BIUaBUZaWzZq+Ks2VOn17dWzsMaQyol2X5A
 mxL3Um5AAAA
X-Change-ID: 20260822-shutdown-fe8139dff2b7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787549703; l=1640;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=FEpgr4DpokD/ru+VDPieVlGjiUmp15iFP2mJXKz/ICU=;
 b=qVCBDniZGpDpORb3ZKCo5I8+lRiMtuxWig4sylyQcDqZ7mw5vgQiUzoxwm5GaHbnpAAv4HJSX
 NydSRGgr+6tCk6SNPQ0vn4YMy3nr7bQm/9bT2NonDjn3BAL/agZhlEo
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA0NiBTYWx0ZWRfX7SzVYYTUves1
 USwOzbZHwNSV06NkGlSkg/WdtJy31eltzRGwR2obnqtgIoqly9uOeoewP9m2i+NfK31WMEhqqNe
 USezNpyc2myTH1IBenH60IRrnx6eu4c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA0NiBTYWx0ZWRfXyC+Rl4gmFB+y
 QIOaj/nTdcIEuqb9TVwLhF3BAQHcwtpJ/02OPbkRQhmbkYw2rtJfs1XFWQi/nHjjggK3w0YhEod
 zth+fIBmiS7nxo00sKOGxEB3F0r4NIqOWJKZACqMKatesmfnkuQkG1QjjXIENTs6upk7Ff/5/Yr
 4R31om9LLcbKjbF9uq3W9xtt1GtuRns0Edt7ZE3hgeaXlCUpiZWw8H5mZb2q89qsL19vfSeki2v
 LfYQqAGOXmhrSOHFwGLuQ/pl2Ei8sjLd5zGQpR8ZLxCdqsb/isrzywa9Vi2h8Dalz28NG+6gzEv
 9bFGY2ylG8SHqxxCjrCDVfvvaamQ0dqbOhxFm+tFtrhWivo3egB9cHKNB1NLhlRF8jKZMt+5P/u
 fGtvSFduvARija+99vTLgnWiHdvGRUI0RcFBT+YYTlPxEP6wqK3Axiw6m0SO7xduwRsUJmlEN/x
 EF0AZPUAqkZCHnEs5Gw==
X-Authority-Analysis: v=2.4 cv=RtL16imK c=1 sm=1 tr=0 ts=6a8bd80d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=RZHP3SvTWnTKgiXxB68A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: eUkEQLIAouj11wmOg3E1FfB0F7yi4amN
X-Proofpoint-GUID: eUkEQLIAouj11wmOg3E1FfB0F7yi4amN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240046

During system shutdown/reboot, power/clocks to the PCIe controller get
removed regardless of link state. If the link is still up when that
happens, it can trigger SMMU or NoC errors.

This series adds a shutdown() callback to the Qualcomm PCIe host driver
that forces the link into L2/D3cold before shutdown proceeds, reusing
the existing suspend_noirq() path.

Patch 1 makes dw_pcie_suspend_noirq() skip the D3cold capability check
during shutdown/reboot, since that check can fail and leave the link up
if any endpoint hasn't suspended yet.

Patch 2 adds qcom_pcie_shutdown() and wires it up as .shutdown.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v3:
- Added null point check and use pm_runtime_put_sync (Sashiko).
- Link to v2: https://patch.msgid.link/20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com

Changes in v2:
1) don't remove the endpoint pci dev's only keep link in D3cold.
Link to v1: https://lore.kernel.org/all/20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com/

---
Krishna Chaitanya Chundru (1):
      PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

Manivannan Sadhasivam (1):
      PCI: qcom: Implement shutdown() callback

 drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++--
 drivers/pci/controller/dwc/pcie-qcom.c            | 12 ++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)
---
base-commit: c1366b72ad4e87be60b57b74635a3a0bc58d2b0b
change-id: 20260822-shutdown-fe8139dff2b7

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

