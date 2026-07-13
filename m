Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4783911A8
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928584; cv=none; b=g35p9N4i6lPCpvhr9Cd5CMgnEu+i6Wq779m3B2UkknDxvyO/WOVqEoHVxsLIKeToKf246PBnirnbNx+ckphWdfZSmWQUtDuBXt8WQiSZeQPUQ99j47PEKf4dUSis+UlnTI5jtAPvns9lALMpUobWj6CuQEyUlcc7DottkCz3Uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928584; c=relaxed/simple;
	bh=MYmlLT8ThQGLNwyV/BC1KUqTtU7yI19YSWTO28NshSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBTLRbi59E0luP2NrVNbDJC9DExInGWgHsTrQk4IGK5HP9nhCCMKb+5r7BIERR3YUNCzoJwPGSL+huREYFjfoLa7h6ACkL3/3uz2Y/Tximi4+IvbwlkPEx7gxTFru+ndtLFWwe5DzHhWacdZnml9jVWQkQ3yJF52QHuvvpJZcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GKNpjax2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rs0cxEb0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKNpjax2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rs0cxEb0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nn33732256
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aWJFgQziladGBTw3u8LccKLmksdh3iW/fQSBcWMufXg=; b=GKNpjax2+eMcCj6U
	zTU6e0ImgTSsAl4ulwMAGQQDKuf9m6bT/M+07Y9HPwtOOB+738DBrehrzI7N3XWI
	r1+fUGF9+e/aS8ROz6Gr1+kshQ3K3qPyTNnM3y+Mg1at7z3MlsV+bsp5P7wT+3PY
	xp4zmCPZdKvhfIGpSG6WehyqhZyHc7ntqlFRAXKoNyI3DrGOkTnH8cBncQrSGQ/2
	u/Ub+DDAAVdh86x7/QZEiq59FVlviZDhttbNm8TMN1tNLrY93eyjuIlXfXifoBSG
	utp3oYW4RYWqq+JYgLj2apmWKTbcXdjX5vaVmlbwnX3Nud9esE/trjI4khmb3bNL
	OSTkQg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn39f50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 07:43:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1242122b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928581; x=1784533381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWJFgQziladGBTw3u8LccKLmksdh3iW/fQSBcWMufXg=;
        b=Rs0cxEb0sOPa64DtBo5r0lPjcEYsruma+aVbwuJd8Jx6VUEX1igMFWdiCQDEqcixMI
         gFJSV3dXqoDHbWKal79WfsUSw5QxlJK9mvid22VMqFFweim3i2i2z5fQ2/PwqYt1tCun
         95Es3h/K3hCSklOiAES3wq4SqXa+RtKvCY9WVg0PT9ynTW81xCUo/eVid3l874KCD7E8
         ZSaK2TkTxe4pZ+OpJURyqzo7HeZid7coHACZKxnSInsVC6IukaNDLMQz1Rjlvuop6g+V
         y5k6hPw2YJKLv8SdSu6QuoNslzNWJrnjQhR8PZhGTbCy1Menx3+XWZHKdnkpAL8pARo3
         U3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928581; x=1784533381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWJFgQziladGBTw3u8LccKLmksdh3iW/fQSBcWMufXg=;
        b=sjiiNXdZCPKZab7JhhT3kiWogva8EXLrUKY6JZwX97f/JMONdbf3GWGQ2Pr/OKAbyI
         AWe0pIqWcrFO6Hznrh90Cbz5pPpBXLINASpX/j6Ir4WW5OpwbzlZSvi8DtLyUqKAs1Cg
         lvvuBlePZx2cvY/c+yHPzHPSUCjDypdBTTxfYNIUtepOffg8K3xIyY5kAEMj3GSqOk3r
         pVVk3nwsn4z+9DG2s7v/eJtzqwcbeFxYso7UakqCyWO/Q1akZw5jgmF8Ma2jnS+yDlt7
         LYN7Jxb3+C408aBSUc2Y6kq+sz013k0UnDsBXfIYAR3PudcMLfnQtfjzIIkFwiwfHu5Y
         73Qw==
X-Forwarded-Encrypted: i=1; AHgh+RpXIxWr4P8k6VlzzOfn5RqKTCkCMGECx2/5YoSSPgj9vG8b1ippXbCEUJokmj6eIQysIQVd3VpXIuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyurFZwQR1WmexUbo92ArujiPHS/VXOpVK2J53Xy5ZgcjmqQ1p8
	lJ3H9+AgnSXT0MdTY4eSQP9i1haZ2F5K4Uh7DXNGj7CNyZgiVDHIOkuZ/NY+s8He+FeZUXuHQEt
	rloly7FQW0n8QD3ommack9vu7RbStKaEC4WNP1+/HlkxSxQN9xFBlX5D6RZgmwdM=
X-Gm-Gg: AfdE7cnyVuo9+e3nmhh+OKw53egeVL+gvivSuxZaJPc6C5pi7gImRQohjGwNGG6KWzX
	OZyyFtwGJ2/ljX+nt+cuUXxhjKEI7AAE9yDRPVaFC2EMWwncs2g6kKN1YFIR0IoCYL+cWhy4w6o
	iII6wcKZrk0yaYuBTcVtmMhw6BefwsSYKpSK25FlQBF9BgN/CVdJSiJLE3hc/jq5o5zLxj9ddjA
	xWjAGWWkOWg2KSSxQ6eX0OHDVGz4L9NXOj3qBlqmBO8iRtGRIiPj3Q6ITPHmJGaXJvXsBVQRX+p
	snlMB3MbZJtcSmTVbCvb9wWPz/8lx/tq637D1zqPUzq1gFs4r4XKAIqbzUIfvQlRIDWFqY28Hzp
	wqFrtngKeazOhsITGouhACEvUAUCz9pn1q5WqN5yuFJbB1+kYWcyq0rGl2Q==
X-Received: by 2002:a05:6a21:50c:b0:3c0:9acb:3fc with SMTP id adf61e73a8af0-3c112e077b1mr6962668637.33.1783928581575;
        Mon, 13 Jul 2026 00:43:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:50c:b0:3c0:9acb:3fc with SMTP id adf61e73a8af0-3c112e077b1mr6962653637.33.1783928581158;
        Mon, 13 Jul 2026 00:43:01 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm61329797c88.13.2026.07.13.00.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:43:00 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 00:42:51 -0700
Subject: [PATCH v2 2/2] PCI: qcom: Clear Attention Button Present in Slot
 Capabilities
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-clear_abp_0713-v2-2-4f0333a98d4e@oss.qualcomm.com>
References: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
In-Reply-To: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783928578; l=1446;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=MYmlLT8ThQGLNwyV/BC1KUqTtU7yI19YSWTO28NshSc=;
 b=z3ZkILMCnLB7e6E16R7obZNqsIMcdw37AAYKgycR9RUPbAY4yKc9xY9dlF37aojRYiO6oErzQ
 E41YQhmcLrZCDT/SsTyc8qXzZZWVYYJPdJpQzQEalN5Wl2GkSyUubyO
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3OSBTYWx0ZWRfX6/i8rjWcBLcb
 jyCoLNBskVBg1XYl3hYduu67dDhHhx6Ea+0UQh1+Bg2NEWSOOihW63pluwg1HVvrLvQGTuc8xiz
 bSyMWjMjJ6sg6FCT7MhlFfTFb1axYTISnSttQ5VfHjoZFQaJldtOBSge1tyhIfUHF03x5HbUBPg
 DNsqeyWvFM2/gmn2+akYN89pd+51YnuGZ8MCWxkhziqYuHyjs7kBQh4ReZho63oDk+9AROyALIc
 uVeaX34yxeHrSAsVmpb2yYnvItZ3pNEy4wzz4sfVj1idsyS9yfPxGSjJLtZClYHd4mJKF+R2I4j
 4yd8wUVtynXodUpltm88olFTQly3cMVqnm9VVXN81AM4IqPACbevvZfFd5nM1wdEU+Rj9in/Ii0
 bAgf/zPcLiQ/u7OtPc8uDOiL0IIo4iEyE+8Ew5CADRQYD3vQuiUs8xCJJr1mvXP/G0h0S3cERqY
 4BM2/PmbWox03Q0KiaA==
X-Proofpoint-ORIG-GUID: Zjekgs3q-jOaCZDM2f1PDb7w58iHFjBK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3OSBTYWx0ZWRfX4zAtIqAk/X8i
 s6EjcHGpCcXqHFC5TjQq4FWEdXUNgFzRKQiQ1ONB2NNvRpMUfPzOSVIejcCUGg7fauvOEjIR75c
 ngpZI7IZRAc5nHt9O124jyelS/D5Tuw=
X-Proofpoint-GUID: Zjekgs3q-jOaCZDM2f1PDb7w58iHFjBK
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a549706 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OhjUHQ0J9wk2a2_2EIIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130079

Qcom PCIe Root Ports advertise the Attention Button Present (ABP) bit in
the Slot Capabilities register, but the slots have no attention button.

When ABP is set, pcie_enable_notification() in the pciehp driver enables
the Attention Button Pressed interrupt (ABPE) and leaves the Presence
Detect Changed interrupt (PDCE) disabled. As a result, presence detect
changes are never reported and surprise hot-plug detection that relies on
Presence Detect Changed events does not work.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # X1E80100 CRD
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 465c940109a7..0a826ba63277 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -372,6 +372,12 @@ static void qcom_pcie_set_slot_cap(struct dw_pcie *pci)
 	 */
 	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
 	val |= PCI_EXP_SLTCAP_NCCS;
+
+	/*
+	 * Qcom PCIe Root Ports do not support Attention Button, so clear
+	 * Attention Button Present in Slot Capabilities.
+	 */
+	val &= ~PCI_EXP_SLTCAP_ABP;
 	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	dw_pcie_dbi_ro_wr_dis(pci);

-- 
2.34.1

