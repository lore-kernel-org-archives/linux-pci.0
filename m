Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68047359A96
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232856; cv=none; b=TX+ucIeEpWadUzfoATLYp3GF+Kwbj3NExAgBCSgwx3z67QgwF+JSLrzEujoWfMHJK+8PtVlQyM17eWTk+WqnbVW8EXI5y9TgvQpPUhHa5BCv9MnLpaVN1uxEheZI62/6Q/ioQY4XLASjBcXEQCSJZUPgcWkQAPgcrxMGYyvmjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232856; c=relaxed/simple;
	bh=P7eBKgOTVNbd2AU6d6k1MmcyBnI7wcKu6MKbMkU3hvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXoD7xdKGBXQ9NxUrIziELdn1MNSqsXVAumaqfQdY5OVhxyWbffxo19amPn65f7IftwgcxIWmQOXEuVY1cD5uDdiQLvkQw2aJd/YxW7stpZsco9bSTA34f8UbylW0Rqpyyd8lHFnqpXyRH4wS3u5zY28Rpmd3b0Pu6D2aA4sNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XZv3SF96; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=avgmS9sp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XZv3SF96";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="avgmS9sp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BBVsTi2676378
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Z15d13ybfQqYpQ5QfjD8B6GQqnkhmB5ANu1YfYyMoY=; b=XZv3SF96eK/jNY6Y
	SnaGOuiUVK6hri5FnzU2HIRhv3JMwyc0EDby1gpOiyvm1t3lMhU2uLi2oQ2r54YZ
	kdCjVHSx1B/64iXTXo7U9ITZjZix8Jj1NVzD1+g3GrXhS8awkLL5GR1c2zWz5FTs
	xA2w+MvaU0WnKl0gmn/rIXrWamIZHPxh72Lx/lvSrK/MfouCRSiW+EBhyB444O7h
	uneIDFEuWDqxwNBz5FpbvEMlntNGf2/cG+ba6WteyXtA6C8F8xq7Cy+yvfrbR5aS
	wasS2I8z5S1aAZNtkMRAIoI+NWREuKjPC+Zq0ZhBVz4Q8zvNAhQ8dhhK1OyOt2gs
	7Sspxw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu3cd1b5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae50463d18so9954395ad.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773232854; x=1773837654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Z15d13ybfQqYpQ5QfjD8B6GQqnkhmB5ANu1YfYyMoY=;
        b=avgmS9sptaORT6JKa42ynj4o91HJEgVz+BtrfeYvxKOm5Oxe1a93BG1rGR0dC64lig
         QUsVf3ntSLn8/EWGCCNczugbs+hHVdS2drWQ8m4LBdfwj8XjzFeTLnrrOt+z1pzl9vmU
         nEN7/ykjAylJbsQrpU9g+Lu/WPigBcCyqT1zsHxHqrC2riQ1iT32IXpteL3+AjjbE2L1
         9cvzM5YqxXhkU3eijN0BsWGRjjv5HCHrLqV2ngIYtpxo/OIEYrCdmBGZNBaCG0nf13ak
         oLY2imK7BY5TR9D/j298esBIra+TYF2rtgF7L9Q7VvF7KRY+3M+URrAQdxfnt9CIqR17
         WRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232854; x=1773837654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Z15d13ybfQqYpQ5QfjD8B6GQqnkhmB5ANu1YfYyMoY=;
        b=dOLKUa/mKKoehDBrE+7L0+8VhezW45TZFrD6GDgoQtuhQeMTkha1ibg8XQijYAwMaQ
         Ua21auG13uDNHmzUePA8oNlJZbZuCXh+9Om6ytUoitVzj04XriFEzaXFwGjFO8D0JgIP
         WDvNZw4GXp1VpP6LjOvOqlNZXGMWpPytxqrHgMZt+i1PcQrsn9W/EusekoFP27f9Veu3
         a8XdP0N0xZMB95yCNcP8T/rBtAzoij7XbSEJLLzjkk8K4AON4UqEoP1a3kzuTnpjbDEz
         AOazcYzBdKfgon9Su5SgLRcCQ5gdVdcUNLAQDbQZoXcoiCmIjfQJx7932JXnhvH56N2z
         bkEg==
X-Gm-Message-State: AOJu0YymXSvYpsY2HnNqV9efKsBuPepDDGuoU0wBhgCNv7eDw98Jn5U2
	cod/CxjqRUpsRSLInD3cEBctWdMPEha/bg/I0XWV2MxG0FqGBcsS+aiGRgO/7g4KRebLIVStF16
	SxaFLqY44anKsXE94DrFQ+tAaIxr7f9DiXVKDjMk81nhvOfB2YIRgRTgGiLAqXMg=
X-Gm-Gg: ATEYQzwgzsFLHmhXVzsjDGo93PT+tp5DlML54JtMTIfeZa4c23jQLBt/0gGMYabRTgX
	aWWkmCnaEi5LfTLrqAcUgt9PDD5ugpBX+Fjkq64hBHdfVBnx90/4NeyBQwbJW4hURovpAQCijwS
	BstzyKkoGtJQ1ScI+0nr9MJS0GJ1kC54sJe540lBJdLeIQwBRjty6cleUGiKNl2rzoEvx0qCM2u
	jLTsDznXnT2SRzqfL3f4jWdxBvjJl3O2hoX0BklSEq4VYo8+mh86tJuoLWsd1DkBrjCB26GBrRK
	yUrkMfb1/u1wLgwbK8UR8TM+8imi/ih3hheYRL0tZ6fozJkR3TroUT5OiLNzA45FpiDKL/c8WbS
	2HL8pfH5e3xVmx/7zGYdEIZ2rHbrl19C4DXJ7rtva+5Loxj3HW6M58nf3
X-Received: by 2002:a17:903:4b43:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2aea1ba9876mr80596015ad.11.1773232853892;
        Wed, 11 Mar 2026 05:40:53 -0700 (PDT)
X-Received: by 2002:a17:903:4b43:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2aea1ba9876mr80595765ad.11.1773232853351;
        Wed, 11 Mar 2026 05:40:53 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae2466a7sm23304385ad.20.2026.03.11.05.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:40:53 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 18:10:39 +0530
Subject: [PATCH v3 2/3] PCI: dwc: Add helper to Program T_POWER_ON
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-t_power_on_fux-v3-2-9b1f1d09c6f3@oss.qualcomm.com>
References: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
In-Reply-To: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773232841; l=2929;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=P7eBKgOTVNbd2AU6d6k1MmcyBnI7wcKu6MKbMkU3hvg=;
 b=xleuH3VgOgn7EvYNWW7rJTRN8DE5mC8MXKORI5WGxi1kXF0jqeOcM5ZZke1xLsKJx0QiVPNoS
 82R2YqaDOxzBhjMSwkW6qCY8XlghwT7d/CGXh/35fvYga4o9rKoOkx9
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwNyBTYWx0ZWRfX+5M7g5C6ZsdY
 yyjoVmcdX6ORSQ5BUvsUhgak4qCGd3cuwnmoX1XCeigF760PVof6t099WuQWZduYmWoVIUhKnl2
 geYACRR6KtFhkznBiIBNPgAYV6vuGofrW09dvPqvid34CZtot2o+rRjSxWzS1fwI5ZkAUan7tRG
 vFf/xX0ewu9FtYA9TYnXHqvqgYSlhAJV5TATd3RutNtwp2GCul16FSpaWeXwyuHtfM3zXec0AjU
 RrMniXjtwgaYDt9uto/cVwzmil7MGTp/311GBh6PwM9DB5IXrHxCRtH/fhEKdeYkR3xmBwtF8hx
 YlEnvipQSLE6g7ctKE/8+F05ugZhYi8zpXbsuKKczodzeTDs9Xp66Gl55KV7MzG/zUnEnWl/oyc
 sTIijiFoyQhMcuGhalfBNyjrJwkEgZi4SQl0kiYJ3RUNxst9APRfgshB9uPhMP33OU3a/cQUn6x
 KPQJdU9kDuw0Ays+W5g==
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69b162d6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Kzt0335Z7iMlu65KMVAOeO5EjRtCzamK
X-Proofpoint-ORIG-GUID: Kzt0335Z7iMlu65KMVAOeO5EjRtCzamK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110107

The T_POWER_ON indicates the time (in μs) that a Port requires the port
on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface. This value is used by
the ASPM driver to compute the LTR_L1.2_THRESHOLD.

Currently, some controllers exposes T_POWER_ON value of zero in the L1SS
capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
which can result in improper L1.2 exit behavior and if AER happens to be
supported and enabled, the error may be *reported* via AER.

Add a helper to override T_POWER_ON value by the DWC controller drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 28 ++++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f40487c6da6dfd66f7c8d96a74259..6289329ef2b2a4ac9264d1c6cb5ea4e88c261634 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1249,6 +1249,34 @@ void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
 }
 
+/* TODO: Need to handle multi root ports */
+void dw_pcie_program_t_power_on(struct dw_pcie *pci, u16 t_power_on)
+{
+	u8 scale, value;
+	u16 offset;
+	u32 val;
+
+	if (!t_power_on)
+		return;
+
+	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (!offset)
+		return;
+
+	pcie_encode_t_power_on(t_power_on, &scale, &value);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
+	val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
+	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_SCALE, &val, scale);
+	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val, value);
+
+	writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 void dw_pcie_setup(struct dw_pcie *pci)
 {
 	u32 val;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa5c27690f998d58729130ea863984..da67beece3f11e33d9a1937fa23d443feea3bbc7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -602,6 +602,7 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				u8 bar, size_t size);
 void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
 void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci);
+void dw_pcie_program_t_power_on(struct dw_pcie *pci, u16 t_power_on);
 void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);

-- 
2.34.1

