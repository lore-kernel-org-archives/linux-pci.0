Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADAE1DF736
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776399391; cv=none; b=Q+3VjKeRT+QZTjUCvcymEEiKyT9AhTg/TeJmVdbTtgfJb3ZDOePg8EgazPnbXSG+1sMgTGZpVkLdhpoVRl7OamUAoXIOvF5ZjdZFZUMVS08DBAkw2oEVbtfrfHX8/FhUQwy190RoIuNfQe6oOwMDA4crXPEhfZEUT4tdZdckgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776399391; c=relaxed/simple;
	bh=wReg8hifVkzlEEdADzMhijrroaIK/MnJQ3ovMsYvmFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jr3MdWTQzN0g0K78Zh1OFovXT85eQ6qLyHXFe6rO0f8agyhvOuk1Wr2nx12rv1CBiHFZa+dwk3lOS+OBJ7yUfuedneh8vtfx99/Chib82bAj4jrL5yqAA4rOKbhHtO8ak5r1N9lgNVxegdV5wamIKBZ2/jT1jwamOhPyVB3e22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJzkkslN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mhp5ZKlP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJzkkslN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mhp5ZKlP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H0fhmC1872640
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 04:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pPI4cCpBd7lg33U6go0Gl6
	viFTKES19pJQYgUxAXx5Y=; b=NJzkkslN2l0bWwmQGu7D/aGdTzidTHFhGQA69U
	eBI1WqVLgBs5H7rGdCckHAAgyAYsngrlGw6f8q0H7Jw2kuFlLIEQuUBZfKU1pTkl
	YkyZqQVeumbs5ZceUTatK1OwtAxDqXB7MFuX7zBNwmC3wP8k3cFpI8h1k6BoFonF
	JYA7tMw2a0sjAuU3gEVYt8X0835LOwyscX4jE/SZj2+iVwbPzyOkpS0aMcOX9eM3
	t9Cp+bdguYNhxDCGjk5qofjWFEiQUGeIYH6JxHI9On3a6JI/o43ky4+M0oLVh4D7
	df7Shlyyho1EJGfcjXg89L39y8p/+JW8gToufeIAXnIedNfg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2kna8qc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 04:16:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so29385eec.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776399388; x=1777004188; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pPI4cCpBd7lg33U6go0Gl6viFTKES19pJQYgUxAXx5Y=;
        b=Mhp5ZKlPVlVqToHBr0fy6TUG3ZuKQv04INgY0LEottidgak31z2nobreF5wo9uapj+
         KoalxziOfW+IHKEPOqXGJGZml09WT0iwQ1JX4cSxJUCAz5Q5KAE2YaBQqsrxMqOBtl1c
         RL5q/NQXO5g+Xn6WmPU3VckfpbPcjUobkVqnrtU310YdNyuKM+9zEVk6rJIn0W48qasd
         iSW+hHV7bhpewlF0UUtdBPk9iVBqGHHAR6Wc0XSWMeTdECd7vZCcu2TMTp3vWpdogX6Y
         Quv34yDYveYHm8LARozdKA9ui8Zao5EKlgOkzBZzfCq0pNXlr7Dq/nTGx8zuTWoRLQk0
         iUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776399388; x=1777004188;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPI4cCpBd7lg33U6go0Gl6viFTKES19pJQYgUxAXx5Y=;
        b=Wk/uTshlQRoJ4G2leA7TxnWHIIzic9iC8K0G+rvm80pc5RY66INXJpLd7MLTuyrFBE
         7TNDGg7lCYJmp1IdD4+f5hVGoaqBe9eODzan5wIQfUUDq3abBe6j/y+zTvi3rIkTvXJO
         I7gO52IRsQrhcRRhxJEFiY/vMEvDyYu9046VFp/5LEHAr1DUNI16hkPuKf+2kxDJsMoM
         716L+6FO6q+5DwKVBTTy0b+uGkxW5sx9TB24/IqjNLaYQy8aPUSMuKRbQv4pyrYEeR+x
         ZzHFfw2xCOWGUtraBC/xPeqk3zSdvZU1IJEte2SltAsDpcwjPJbZfMvqkHX31z5+tIrU
         PFgA==
X-Forwarded-Encrypted: i=1; AFNElJ8NqmsNm1taup4BC6OQH4SgV7EA70YBotOSyHKauMdQ3d9J9sB9w8+RO7DPypmdyf6ki6mixlk+1+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFw9DAFXTO7obUz8dwqN96LSyjKNVamhsv8Hg/miY+mKyC0+OQ
	WHTNSJ4myFXY0hQJfKKB2mtilLPRupp15fHEgIXZ0S2aXmdN9R/fdhUcPM6OA1bccxy4eLNAoZF
	Q1C6kEvoDV2MX7uAbKyno9R4B3D2crTeEQtb+6gHZcjdurmB9UYUGWn71mGM3pTg=
X-Gm-Gg: AeBDietHt3l4h8CiwyAaEl/S/Fq1hj9v47n89ToSxUjDaB9jtUSK3k9U76VQwHxWkst
	uy31r865xNuz4BWCwKtUxtszp4ArL/GK/tWthssLlCGsAKp+aiIlkz4Zx+KMcV6TAOm5BlGmwAk
	Fqr3FyfpwWIafXyVzyiRhYGVeVuqVWmcWdmGAB/yu0zN0R3qqzhqk0rard6kUTtHFIMj9m1X0Z/
	qTgKo9kCJwMNmeNxcWCYIakOZYbIZjVEp2BjnMgJijHDcYXYf+m/w3PYK+mvdzIrKgSnreWy3bb
	fbUqGOzQZrEsZwgZ0BVd4ItWsDuY6flsTT7zUlUWlX8Ud86X08C47JAKC+qNKS1Xth67+J19cs+
	CVQJrjTY2NJR641spNqMHo8P09DFWZl12VpUMnt9ZUc8710YYQatveNhJ82wVsyT+8+ARK8uR+S
	G1dzY=
X-Received: by 2002:a05:7300:6c05:b0:2d4:2cc8:67e with SMTP id 5a478bee46e88-2e47a106ccfmr558556eec.23.1776399387845;
        Thu, 16 Apr 2026 21:16:27 -0700 (PDT)
X-Received: by 2002:a05:7300:6c05:b0:2d4:2cc8:67e with SMTP id 5a478bee46e88-2e47a106ccfmr558541eec.23.1776399387191;
        Thu, 16 Apr 2026 21:16:27 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c38sm638451eec.5.2026.04.16.21.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 21:16:26 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 21:16:25 -0700
Subject: [PATCH] PCI: qcom: Set max OPP before DBI access during resume
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-setmaxopp-v1-1-6a74e2d945a0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABi04WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3eLUktzEivyCAl3zRJM0E8u0JEuDJFMloPqCotS0zAqwWdGxtbU
 AQDZ/L1sAAAA=
X-Change-ID: 20260416-setmaxopp-7a4f49fb90b5
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776399386; l=3294;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=wReg8hifVkzlEEdADzMhijrroaIK/MnJQ3ovMsYvmFo=;
 b=/SvocC1tbAISboxZNBSseO3EC900RS6124mkUXh1rof+7sbSNZR3DgI4YolUmP8MVCo68k2vX
 QH/RORxPfmmA5nLQDcKQl/AG3247lgd/Sh6SuX2v/biC/eE1TLYeMs9
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: Rcv9RNs-a3q5D_RD--3pXmvJsTXZcqP2
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e1b41d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_e_GtX_bwWpn_Ay3u5MA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Rcv9RNs-a3q5D_RD--3pXmvJsTXZcqP2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDAzOSBTYWx0ZWRfX7p7I84NGcth3
 zRw1xKhUiH5rgd50X+D4rkcjM80VRZ45THljTo2vLjKxjmetlfpAZO3CtYp5JWE3S/CuCkZsAg0
 /eZErFipa1ySTVbISIAMTnUxj/ua0wh0dq9pMvyKnAei2QS9rDMxfBW5aKqy1qGNz+W2yIIQ6vG
 IEU0pjpRrkxsCG3USEHV9T+x/XotTnPTXDi9RhbwYd4B7vd7BtKtXS2aPzW950y2qJb6WigUtaa
 5W1xVgY4v5bNfSre2JzfbU8rtiP9bimaZIAQwkBFjcz1pxW7LKIlJCAUBdLdyiLEkN8k5NZv1OL
 3eba0dWzyQuiy1gijxdeXW9HLioVPIps4BsCqSTdnLe0fLZ0H958POmaNn908awHE6fPZalJAVg
 d1uZj/qnK64n808bOptYEbmfL/Vvb9eAJ5q/x/to6aE33SSswxoEB7iUL7lJZP6Ygr7Cv4scUyU
 EFo33Oo/eV+MXROR1ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170039

During resume, qcom_pcie_icc_opp_update() may access DBI registers before
the OPP votes are restored, which can trigger NoC errors.

Set the PCIe controller to the maximum OPP first in resume_noirq(), then
proceed with link/DBI accesses. The OPP is later updated again based on
the actual link bandwidth requirements.

Also introduce a small helper to reuse the max-OPP setup path shared with
probe.

Fixes: 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 42 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9fdfc88ac15120b2b01cad746772ae612a2c9690..c9b201a1c033a9849e97db9ee4d07d26655d5a6c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1613,6 +1613,22 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 	}
 }
 
+static int qcom_pcie_set_max_opp(struct device *dev)
+{
+	unsigned long max_freq = ULONG_MAX;
+	struct dev_pm_opp *opp;
+	int ret;
+
+	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	ret = dev_pm_opp_set_opp(dev, opp);
+	dev_pm_opp_put(opp);
+
+	return ret;
+}
+
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
 {
 	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
@@ -1845,9 +1861,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct qcom_pcie_perst *perst, *tmp_perst;
 	struct qcom_pcie_port *port, *tmp_port;
 	const struct qcom_pcie_cfg *pcie_cfg;
-	unsigned long max_freq = ULONG_MAX;
 	struct device *dev = &pdev->dev;
-	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
 	struct dw_pcie_rp *pp;
 	struct resource *res;
@@ -1951,21 +1965,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	 * probe(), OPP will be updated using qcom_pcie_icc_opp_update().
 	 */
 	if (!ret) {
-		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
-		if (IS_ERR(opp)) {
-			ret = PTR_ERR(opp);
-			dev_err_probe(pci->dev, ret,
-				      "Unable to find max freq OPP\n");
-			goto err_pm_runtime_put;
-		} else {
-			ret = dev_pm_opp_set_opp(dev, opp);
-		}
-
-		dev_pm_opp_put(opp);
+		ret = qcom_pcie_set_max_opp(dev);
 		if (ret) {
-			dev_err_probe(pci->dev, ret,
-				      "Failed to set OPP for freq %lu\n",
-				      max_freq);
+			dev_err_probe(dev, ret, "Failed to set max OPP in probe\n");
 			goto err_pm_runtime_put;
 		}
 
@@ -2100,6 +2102,14 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		return 0;
 
 	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
+		if (pcie->use_pm_opp) {
+			ret = qcom_pcie_set_max_opp(dev);
+			if (ret) {
+				dev_err(dev, "Failed to set max OPP in resume: %d\n", ret);
+				return ret;
+			}
+		}
+
 		ret = icc_enable(pcie->icc_cpu);
 		if (ret) {
 			dev_err(dev, "Failed to enable CPU-PCIe interconnect path: %d\n", ret);

---
base-commit: 33a76fc3c3e61386524479b99f35423bd3d9a895
change-id: 20260416-setmaxopp-7a4f49fb90b5

Best regards,
-- 
Qiang Yu <qiang.yu@oss.qualcomm.com>

