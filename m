Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFDB3DA5AA
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183433; cv=none; b=KALjpQmjZ5QUOJd4EVyeO80Kjd4MtyrqUU46IZ9Ln6FW68ZCj0EqUQmOKIdwOTgLdc3up8kTqfHh5BSStj65QXwMRWQmWWfKcLvdOFGTsjz0yWl3QTEd7RX21g8SZF5mI5EDEZWu9NcTY8QxXW+i4n69dCOHrnPXs3NxVMsw1IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183433; c=relaxed/simple;
	bh=nbI13m/StU8b8bZ11kywO1OROX66Dspe4XXmpDY1Pig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BktKjtX1Bm7AunD2U7Jm0FSa3CKr7vzezTFG/52Do2Bj+oWk8C2RM6icqBJrwOU9P5Q1Lxwf6B+wQeoG5uFFZL/k5lQMQ6p2Fceb8SSngi7485PowdYnG1GTDdKGoEDDch1aKIsEc5BJZ24rg9JCpoCx9CyiDo+dNzW7mTTOdxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=emPtKRK2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KGZM8ZrV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="emPtKRK2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KGZM8ZrV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBASNP3255800
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GGvmEtrf3r8j9vw/t1qgIE
	OjG+THa4qhYcz64m3UBgo=; b=emPtKRK2c+enF90aBn/VFm9G0SeHYRbjnkgh6Z
	KIpcsMclVk49nlW5UCD+eEPXpoBpNi0XBzdBa2r61VYkZo+4g8z7LIDIXw/rMr54
	oJzwW6fLPV70tETB9UoXwe0a/7BNTPud3JtyDGy4HXxVYRwwUmK6O6COlbfGbU1W
	+58SBqbuWJecbzkZZ66zNekzi64taE/WMUPhwAdkz/cEQ8eSb8RPateI0XeXT8fv
	0OvHpJa5SpHrRrEYHtEzm+fgEj9impoiU5jEGcN2EZMh+79KhdwyHYfsjE9arZfG
	8GRoiHQ2VIa5BoXaAKgeEqmCWkdIgF8AU9+MWgF0QQQAxwiA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yas0w1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:37:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398d292eac1so2863139a91.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788183429; x=1788788229; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GGvmEtrf3r8j9vw/t1qgIEOjG+THa4qhYcz64m3UBgo=;
        b=KGZM8ZrVRwVYmnQsderCCRg+2sOBnqWAUyAn78geXZ+FyUk+oxG0mmgE3Cgr5qYGll
         DmWHqd/k4kO+c6xxcmY4I3uDN/rE0mO1z7h1XX2RqEB1mnxcnXl/NA1QWY93I9dz1mPr
         rtGjzwTDTXumA94xB/AI7fqMD3QlqNXPZLyuASLarGlAvAFUXLrGpKPqcaBmKqPKdMn7
         lJRD3qDoUwRDKdwuKwMeEoFHSyLXvZWt9/7iAo7ECGz8X/QtkeUMn2ead71ySGkkx1HY
         +8W2Vs0XFC3cCThxkqxmP/rNE3BAPCoSpoTAK1scRZquIv3XPhNflvMhCSfR010EpyvT
         2CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183429; x=1788788229;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GGvmEtrf3r8j9vw/t1qgIEOjG+THa4qhYcz64m3UBgo=;
        b=F8bYb8ncHslZINI94+d8ZCdL7SAzGtMS03Y6tcJtfAMrGRN2Sm8wc5xcx8UZK84sGZ
         iQ4753BzLSYshXoGLroe183vh/bWuS6TZlD3s8apN3Q57lywWfaCPJA4b41jKdmtu0qx
         QTwKFbjxguNC7VTF9PyKULPG0ZQ1KfYoyvoQlS+fET4uJvZQ3+r/4nKQ5cTMDP/peiTO
         NiNpzjqXmqzN+j0fJSoz+/fPhtjuOnMPSZV+77Dt8iV0de3nwcNM982GuPdQ+O6Xg9Qb
         oj+OGxuQCGCaRWbz7Uv+ToHHSU2THUtEQHAAmrwbynnBAuKTDF3vnQiYeTa8fKj8pxCT
         IZ4A==
X-Forwarded-Encrypted: i=1; AKwUvByWrWr83tnbVMg3NsREShZL44xm9TygYHZjzbOlW0xbkFIIpMEiZm1tUrB+TvDRI6IPaM1mqojOjf8=@vger.kernel.org
X-Gm-Message-State: AFuF++nljGnzJno8BwgoJSxhjuLS4FqyAV/S+E74kXopYbfqWhaJZL5B
	iN9I8OLFTpgRNNBzsP1L6WL8mShGkDHYPiHbh0nAyXLxNlySDJSgO1+Savc47ujcP83RhZlVErd
	weTwivp2DRotUMQPTOXJE0O94zJ5yA4P7SgyXAT2TQ2RC/k6YrQtBiZA9E/Mw6oY=
X-Gm-Gg: AYBFou1YHgv2wyDSw/A5e+HoJX9xT0ncPjmpGlWzE622eU0tE96JL0gkhQspjGogJx+
	+9RjTxHyoeUEB2t+jhrLsYaT/IMTpKbzCFIHLMwwaSqcr/aUpSR3qSxYeSDXgm/CET0cMWWkJ+Y
	E6rXF4kRsVEc4NBxwcFl0xF1qc+yWmm0ZB5n5APXfzdILbs22+oncgCTMNP+Sb1cd5rlkHtO83s
	gKMp9jAPdqh1Qhj11L0cUddfhxTb7BU9j0mQfIIRlffvHAXczSTgU+gPcom0DrJm8eIyBFiAT5v
	0o4fdXcqHrLHZqRD1v9ZJCAStHlqut+es15AMeQfClQbQ71gruRYwa3OM8V9TELyGxOe05KrCYo
	k/t95c+UiBzWwBN9hwuFSsQVx7jZXEeDchw==
X-Received: by 2002:a17:90b:528f:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-39907e113f5mr1208478a91.16.1788183429291;
        Mon, 31 Aug 2026 06:37:09 -0700 (PDT)
X-Received: by 2002:a17:90b:528f:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-39907e113f5mr1208384a91.16.1788183428726;
        Mon, 31 Aug 2026 06:37:08 -0700 (PDT)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d2e465sm43323985c88.4.2026.08.31.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:37:08 -0700 (PDT)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 19:07:02 +0530
Subject: [PATCH] PCI: qcom: Skip system suspend/resume for firmware-managed
 PCIe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-skip_suspend-v1-1-ba2d877e22b1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH2DlWoC/yXMTQ5AMBBA4avIrDWhfoKriIjWYEiq6SAScXfF8
 lu8dwGjI2SoggscHsS0Go84DEBPnRlRUO8NMpJ5VCSx4IVsyztbNL3oMqUzJctBJSn4xDoc6Px
 2dfObdzWj3t4H3PcD+QGWL3AAAAA=
X-Change-ID: 20260831-skip_suspend-a5bc5b29fb34
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mrinmay sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Rama Krishna <rama.krishna@oss.qualcomm.com>,
        Rashmi A N <ayiluri.rashmi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788183424; l=2084;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=nbI13m/StU8b8bZ11kywO1OROX66Dspe4XXmpDY1Pig=;
 b=DwHFxvONOcl3BS5GrIZb2aKOzzbydp94yk4fACGz1RdNlgoKugek0XmhGYeumAPtACD9bRf8U
 lPhg9G2CicHCpSGYdz3nrn2nkEtsgC/hAm/JFS8AlFous9WA1dPXiHG
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNyBTYWx0ZWRfXxLmZn8GT9MqE
 Jv0ZxinUsofMb3j4swhuq4+GnBXVE3qjqcRRh9QL/ySNSNCbyEMNgqUdM5Dp3rYIvcbZ0zSKtyx
 qPlqMsbv3CRDb0h3d+YkxxNbAqq0im8=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a958386 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=vTU8PHaab79fjezaUvUA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNyBTYWx0ZWRfX5vJRbGdsIqqd
 8TdIyTbkkcU7ktCW7EuxCjXN5/04yglcKxb6fmHuXo68tizP7+DJA5WKn/Dg75MeHvl7QThAQaU
 4+E/hR9EKOUNKdwcTjCa2FP11R/HX+8BrqvlLFD7DuK2YEjAkLMUlXTN2N/Z/6ScGGDC/WKYMVz
 0mIoEAZB5Uz9lgvnybQUYVFzYc1um4H8dqnMEqcY4p4YMk4MPD6I886GQxt+FvUjXF1nBJcUSAY
 Zyvv+z+S5QiOZPKaQxpI48GBrK2v/d4UV7oP9fdAiEYN1r3owzRLvI0A3RkqeVERa5M1htAZgUF
 sIfAMVEh+xIUUHzpGsD7YYy24E/q6RAuIH4bFrTaw4+wK6KNb27nsEEoHTRASRqphQ7PxgrGBth
 VN0WBg/ASwggl/qhJW7xPytkNnY+Yy3/xumps/ESVZ5YwLOFcKFdyO12TVuFc/lhmwflniSeqHX
 4oBF9IeoaOk+Uh+6jvw==
X-Proofpoint-ORIG-GUID: yErd9pZfMGQvfEeY8scCIFAKihqiZgCj
X-Proofpoint-GUID: yErd9pZfMGQvfEeY8scCIFAKihqiZgCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310117

For firmware-managed PCIe controllers, all resources, including clocks,
regulators, resets, PHYs and link state, are owned and managed by
firmware. The host driver must not attempt to manage these resources
during system suspend or resume.

Skip the suspend and resume operations for firmware-managed controllers.
The associated power domain transitions are handled independently by the
genpd framework through its own system suspend/resume callbacks, so no
explicit action is required by the PCIe driver.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
Hi,

Firmware-managed PCIe controllers rely on firmware for managing PCIe
resources such as clocks, regulators, resets, PHYs and link state.
     
Skip the host-managed suspend/resume operations for such controllers.
The associated power-domain transitions are already handled by the
generic power-domain framework during system suspend/resume.

Thanks,
Mrinmay
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..56f0d039e36d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2341,6 +2341,10 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
 	int ret = 0;
+	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(dev);
+
+	if (pcie_cfg && pcie_cfg->firmware_managed)
+		return 0;
 
 	pcie = dev_get_drvdata(dev);
 	if (!pcie)
@@ -2399,6 +2403,10 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
 	int ret;
+	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(dev);
+
+	if (pcie_cfg && pcie_cfg->firmware_managed)
+		return 0;
 
 	pcie = dev_get_drvdata(dev);
 	if (!pcie)

---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260831-skip_suspend-a5bc5b29fb34

Best regards,
--  
Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

