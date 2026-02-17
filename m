Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E32331A49
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327486; cv=none; b=l78SeoitMLzysZdU3P9FlKAzIqyEDodBAOMtD3rOB/bzpDPiSGp+Fy7ijpOhpCbvvw+Mn6iBmDy/lP1wJePQLY1WXYP7PnlNuYHteQpS73edqpE3W1eTWMN6b6/aU2OIg2Oo89t1w632WZBU5RMtLR8lcLYBbkfrGLiXYYiQfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327486; c=relaxed/simple;
	bh=iKt69Ev2cDAHIcEtVWTDlH0t7RzwTpLdooqI1VoqhTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGRIseJ9ltwKjNZKc04cvLwXXjlxf1n2wsbm7kIc/1sNyTLcWmAySgNMGQzkLgQHn997J3jjAQ462XLR/wuNSda8TPWfSC2+6hA3uUwoTkCJrzg99u+EHFGiTxBbIB76A6snfhdpTY9/nYZnM0S3r1/R73raU5ZFA1Gik98WIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JZY8bqlU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xbg5oL8L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZY8bqlU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xbg5oL8L"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9Q15f1544917
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tzdtf2gBTGfcSK53xronA+EV+UsP+WxBuPc
	s2eqZxOk=; b=JZY8bqlUp1p86oxP0p5UxN8ZtRQgljqibWGwcltan1zo9bgOjCB
	G+Am2sD5a0pdhx27NtPtRqASffRGGsaDvskmQ2YavTT/JQcatTGw0NHT23uPXr3v
	hwS5ZwF+5WENTzA8O7K8EyxtQ2SmUsjOpTXdrdnYaHiCqTG/mB7K05S05fEq2BHK
	FixEPvTsCLmkFzMUNEGh2oIj0I4uDo3HEbV0zMQnTlSxGgZYrO5Tb+aotjPHoC5f
	FeQgL28ldfHCn8E3ovbSIW65sG8C7OLmE5bFKl5ZwfGg0sikhD1xL9vY03cj5It3
	BjhmROMmryUw5AHOKI5GsLj9l4MM0lI2tCA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ajsyby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:24:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a8f8c81d02so39753135ad.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327484; x=1771932284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzdtf2gBTGfcSK53xronA+EV+UsP+WxBuPcs2eqZxOk=;
        b=Xbg5oL8LtZPm3PY1VAKeZ16ThtUu1q79MGuKriyte1NLJ0uB8042XIS3YfPjfjbdo9
         phb5n9FItIYp4Pu671d1BzcI/H+mat+dGf1eC2WoUpwrxfPkNRlD28KY7M54AWcBIiyS
         M7aHLL4lvpm9kevIl0f8SKLD2Q1kEyA0NYnNmP2vvUoG1/pWsgsJXGsopinp1I4Zlei+
         6NwbEBxSeJ66gAZPa/glqhwNMT/qX88ES2kaV5cz2AddVlY+qn+H9VPGsyPCv3gGYxXO
         1aikAYOb8tYKmnFK9EuNGKLNMI8FtmEjyMjNu3aS+4WiurC4p5FrJZxTIw+cqNm3Y1n4
         yCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327484; x=1771932284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzdtf2gBTGfcSK53xronA+EV+UsP+WxBuPcs2eqZxOk=;
        b=qhOtLlnNzN0Q00IycEhcAi8F67xVLNPrZ1CH4ys7q+Vsvl67en+TnAeNWDz0ndRl1X
         B89u78E9vcnYvOlzKi2l2YuCSXjEDtOS8DOvQofq14TRZZXfd6TY6eoBk17iR7Lm432T
         5g9HITGyruwC35n05ljLxrVKcRVsg/EItJ4nul1EAClzU5aEhl/Oevyuv2R5vRG12VlD
         0Jfo2z9BV5JX3Y4pbnx4SgZcWDHnWSZqA48T6evkF5lGxG1sCY2vHQ4aS3RiptCiWIiF
         BOrkSFalGmIVB3syQBBelnvHhqYFTT/GxxTT2g7j5Cib4PjKU1Z8IOg7bA90L6qxxI6Y
         8P5w==
X-Forwarded-Encrypted: i=1; AJvYcCUBMsEjf9Rk082Y29+9tjCAb9xl+nkJA1GVrC6z+pKnAODwIvCuacRv3sgHjwOEBfwXvo5HwndF2LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktHMsf1GXg0Z9pKfzhH8FZXG64kRb2iWt3NZDbDJlRpRrF9XT
	1wxx6ysewe+x7CrDy1fweIbS6ro3FtyLS229ZUGFsEMX8FIq5YpGsYgYQEM9Uci34H9U5OIrPoj
	fTlQw0H5fFX4E91mwydal92sAxW1XaKpaO6Z0Al+eQjGV9QKLXfr1apigrHw3xc5NTJkWk5s=
X-Gm-Gg: AZuq6aJbolWrcq0pCbLyIBIKMgztUyWshixma3kmpFzzS1Hnv+97yfTGBGhQ6kMyc7c
	12jjWIZPHyUI9YmUmlh1MDgVzmutgnAhbAP8tkuzqvO5iKcT+a/JgKzZuwIJaCUML2DJTvuARuU
	tPIP/g7WmvScSKT36VCEGGmVISCk/MM3svqNWe7evsGLSm2IP4sx1wYGQVpqfSSmJDDLhTWZCA4
	dVi0UhGf57e05aOB5CARbYnytKIFB9nRPb9psjWI4+s5Bvr3cBoFPTeWJ9aPzUZ+NHa6oof7mCj
	rJtjXT52pXLcMlQBR2ETSG13iCVUpKlFRAeYVCmPfBPrrdYjb23fDasmaqBMxZMt4E/HMCk+nAu
	5NK5UaudxvflcbGgPtj81abQTJb2QCsO+26TpX7I=
X-Received: by 2002:a17:902:f787:b0:2aa:d816:e1a4 with SMTP id d9443c01a7336-2ab505c045emr161246605ad.31.1771327483877;
        Tue, 17 Feb 2026 03:24:43 -0800 (PST)
X-Received: by 2002:a17:902:f787:b0:2aa:d816:e1a4 with SMTP id d9443c01a7336-2ab505c045emr161246315ad.31.1771327483284;
        Tue, 17 Feb 2026 03:24:43 -0800 (PST)
Received: from work ([117.193.209.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a6fa33esm102091905ad.13.2026.02.17.03.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:24:42 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] PCI: dwc: Proceed with system suspend even if the endpoint doesn't respond with PME_TO_Ack message
Date: Tue, 17 Feb 2026 16:54:30 +0530
Message-ID: <20260217112430.7955-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NSBTYWx0ZWRfX8oVxDhsEd4AX
 GHbF2cLeQj0JYXeqTPzlVlw1WtTJaGlG55nDnJXDHtY6abRnilRbP2F47oZ6zRL2CU7zJ7FJTkw
 zc9SNUN0ntYLLQkmadgOOFUCqA/23uIbZD+16zNI6J6R5g9a3nU32lFR/mwiP3Q+FOHta49OGY/
 xvR0Bph267ZfZpSuQnTH0xQs1mYbjylDAtrWJSuuCVLACYbe1ZCq9eU/GKwcmSeiezqXI/Oz5+u
 Nrzizam+QUQDtHtGfcOBhkX0PiMXHiyEfNx5D3Of7QHaLoJqNTi1IlGaDf/2ESAf+Aq2sBzE1QO
 +61mcR2pPJ6XmNbBHj6Aq7fhqBPtI7uCqeilXER1M4dh7u5QBJUICksp6iKUWaC6048eaw+TuDj
 WQEiZDuEa6gL22ark0X7UMg7WjETkq/4dNP/Ylj0aXQqTndufm9x2tPZZX7uC0X+QegrVHFK5Tw
 A0zfflsaa//bJa/6VwQ==
X-Proofpoint-ORIG-GUID: jOIGMk95Gjt5JwpyIMGeSpz99BzgMsN_
X-Authority-Analysis: v=2.4 cv=BryQAIX5 c=1 sm=1 tr=0 ts=69944ffc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=SjHr3uEWn81Gzxy87858+A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=8OcN5Qi1sVG3Ylv8c8YA:9 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jOIGMk95Gjt5JwpyIMGeSpz99BzgMsN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170095

PCIe spec r7.0, sec 5.3.3.2.1, recommends proceeding with L2/L3 sequence
even if one or devices do not respond with PME_TO_Ack message after 10ms
timeout.

So just print a warning if the timeout happens and proceed with the system
suspend.

Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6ae6189e9b8a..c01e6cafd255 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1255,11 +1255,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 				val <= DW_PCIE_LTSSM_DETECT_WAIT,
 				PCIE_PME_TO_L2_TIMEOUT_US/10,
 				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		/* Only log message when LTSSM isn't in DETECT or POLL */
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
-	}
+	if (ret)
+		/*
+		 * Failure is non-fatal since spec r7.0, sec 5.3.3.2.1,
+		 * recommends proceeding with L2/L3 sequence even if one or more
+		 * devices do not respond with PME_TO_Ack after 10ms timeout.
+		 */
+		dev_warn(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
 
 	/*
 	 * Per PCIe r6.0, sec 5.3.3.2.1, software should wait at least
-- 
2.51.0

