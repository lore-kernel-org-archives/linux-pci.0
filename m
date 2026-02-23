Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780C35CB8B
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845653; cv=none; b=iXVinGVolmc3UVvncPT2ttA3GTjSqB9tQMS28+UTDJouXVqfvBJDWZY03BWkoc7j2FJ0dYLa0YmpiiapI6G5QUVJ0fdCWkKjmBfbhN7iIya6jDLn2S7fSkTeP9YzBlimPje6hrEeexeY3N/dZV8DgVEJqHTcwLrZIoEZInwLDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845653; c=relaxed/simple;
	bh=US5ky/eaGr7/zjLC3Ki0xuzmQaTtw9+WSJMCH40IvBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRn5vDt8nUQfR07cQcfaTKYqtygMwT6e4j9AGDOmJRIEODczurx30FvQV5rUVRs+GQ8/DhZ9oLTASyRGtokhrZKCm2fFbWGlvxTrgJbkq/hGZJ23sVTxNcLYLHUKuU/MtQ+HUupX9SLp2na9QrmlU8o4YJDehiItA93WZFKJ68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y2JAvrDd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DDezdD5v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y2JAvrDd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DDezdD5v"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N9c57A1291412
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7R6wERXgtgmbnWJq0JgIZgsNLnA/7M/DJRTsX0zPuJc=; b=Y2JAvrDd8VT4A+Pk
	BzxVDJRHsMoyWFTlI79cH5rTjjWInszzrs1X45Tbqo8qG42uvlOKJemCydxPAgbc
	/vbidiS76eB3/BoXZhSSzLw3jow3yvOnj4naQJ1O537FI3b2Fn7VDuyQR6dpkbW0
	XmtIZd+e1Df/HohMtqwNLmUcqMho5KJrEMI2zoUYBG5e3nsjVENWl1FWFlL/WHdP
	n8IXJLHl8OEfSoNKuSz28kM9ejOasLsJ19uulxtPg0/8sIguesiyyqKfu253ewhu
	QReNnnPHzTKT4bslUV5bnQ1Fv3R+hTCJxDIEfiq2V3CT0Xh0WTqOmHLqDS/hwTix
	h28DHQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5x7vh5h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e1919fb7bso2620566a12.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 03:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771845650; x=1772450450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R6wERXgtgmbnWJq0JgIZgsNLnA/7M/DJRTsX0zPuJc=;
        b=DDezdD5vhErIZgC8ufXf+HzOJFXjoDqIdUBYLlVls/mAiLzB0IlGvNdq6lWyfEWRmH
         jVPQfSlHs4oU2lvlPfqAFe7RtXhUJjv6ryZcMwOs1FkVdHWHVSOPsizSp2PrmFjaXMS8
         h0e+Oo+rO+O7QfqM1UUbP37AZGOhBcRljGc0KFZJoAjvvIjLjAoZbWxx0exybDfjDbAE
         kWB4ozzH/S0V/2TeL4CcFBfkmE87rJXkvf3Yx3JJmPwCTVaAZW9QNJsUfPehYYcxjVmQ
         0WURitszRWghbWUDeS83avs2BYBOIeHN3St2AMNbxdN4hKPncKS75N+N/DZ/BEdgy1LI
         8l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845650; x=1772450450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7R6wERXgtgmbnWJq0JgIZgsNLnA/7M/DJRTsX0zPuJc=;
        b=r9ok2FRFmgLAEmBX9q4TGEh3XrJf0ZLsg0M3E1H9kJTODiprsxYYgx33/cm4850WKN
         fgZnDb/Y5SfTf6iuNZodyZyISRSesZTdGeng9ficOdqvkXpssFEtLLqGpvffKdlPPLXc
         ubUkvCKkezB1PHaxImpCDHL8QEIcjzrIL6zMPr15IrUBWRsEmloaYRLWbQyWW6RvqZsE
         31ahWSSQNKoUVuZ/O2MRqSgpucxECt320i7THCrHSS8nFStIjWOdC4y8r7nVcZ3yvd9/
         UcEpwmqYNcj/Mm4l/8XxYNiBp1tC+8Fuinzy4L3tkk0FaQxST5fg9m4h3UinFVt2k9F8
         1amw==
X-Gm-Message-State: AOJu0YyD+yTphDdCYbPMv3bIIUzJrFWYjYBCDaVJxtESlm09W3sRQVMN
	aIfiC00IcifxlTRVClJdFk/Ur54Ae9D39ZhvhIB3v/GMYG0f8QY/MgsG11/FHU9NToX9GFfmN0s
	bQ2eGJxZiK4Etd/EwPNr/p8YfnHzVv7CZk/OExv4R7J8s6kGI1NgZxctevgFMyZPLifyJ6bM=
X-Gm-Gg: AZuq6aIlCqEAr/N/gsF56tgcImG797xEiQOn6VHoKXjSgvbPQDXB2EV+7F+a3Bx4+lN
	oWnSEPcNV2oqfzZNM9+e3ej06fAw3xGXMOF/a9royfYKt0xFmYpQ1Mr+HA+M8GXENFXO12X655o
	b+8tK86wtHNRqUpYkH6F4lnfJmgT9puSEbr4Ck1VJzqxqumYVfk7lFL3AL6km8pnvofJg2h3Tge
	GW3QwN6MK5I5JBM8BValruFukHTU5D7IxUaTAPsNYHAiEJBM7UJNNFeAOgc/0M5qRiLHY43bYD7
	cB/vCYjFKcMvuPni7eR91+Q/GwGs11yK9Jj4gguIZCNqKVvKFfulDGLUIkiBkJ4D/lp6N+tW6W+
	9oiKOyiheX+rH6kBIoGz9zzNbzFj+QBSPrl+0YBrs7ltfKLkTI7TCoVL9
X-Received: by 2002:a05:6a00:2d9b:b0:7fc:da5:f85c with SMTP id d2e1a72fcca58-826da9f05bamr6675814b3a.38.1771845650475;
        Mon, 23 Feb 2026 03:20:50 -0800 (PST)
X-Received: by 2002:a05:6a00:2d9b:b0:7fc:da5:f85c with SMTP id d2e1a72fcca58-826da9f05bamr6675795b3a.38.1771845649975;
        Mon, 23 Feb 2026 03:20:49 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd899386sm6744057b3a.43.2026.02.23.03.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:20:49 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 16:43:31 +0530
Subject: [PATCH v2 2/3] PCI: dwc: Add helper to Program T_POWER_ON
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-t_power_on_fux-v2-2-20c921262709@oss.qualcomm.com>
References: <20260223-t_power_on_fux-v2-0-20c921262709@oss.qualcomm.com>
In-Reply-To: <20260223-t_power_on_fux-v2-0-20c921262709@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845636; l=2863;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=US5ky/eaGr7/zjLC3Ki0xuzmQaTtw9+WSJMCH40IvBw=;
 b=LBjbnwz6E1dINdav/+PKkrP9Hl6PG7F0q2GXDRhnkg1LcRHU2rTVkTvMhD+REz0ROi7hnNBUR
 VcD3rRZudS9AhZeQYm4wwtDd/a7hk3zsRiuLoZ6NHqbWaG1SvfoADUs
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5NyBTYWx0ZWRfX7GGrn0yP1lmd
 CYEI6k4DCnNqVa/l3DqeNHRj7KSP25GSjOrCUmpZmpBHV3+uUojO4oFBRdFqNpY01OET+UwRyST
 tHiW8EC82gYhZRbfulGZ7Gxw/givqSbRLIdharqgXWO3OS2oB7I8Rlp7qLqcrO9aq9pZ0tBL0T8
 beAmAZGiIYOH43gYYXHR1yfHOVeXafVhAHpvg3QNfjbSRj0hRuMj9W+U0fxxJAzGBdoNCwjtgu1
 /4iqSEM6KZriKDoLEqLK8ep2jau/qGvKGRiQmgu6Pw6qApA2EZAvZ4Tu9v4oTB6NB0KUGUMm3fR
 4ubcbwlZk/oL1i/aA99TKjnTPN5m1sdzJf3BdlCwJrazSJlmzCCc6QfnW5moHyvJCElScwMcjSr
 Akcp1tI3K2hm2AKih9EkRv4hJJ5nFrqPx9L7g623snvZGX+388kHo11ODc/SML3XEDWdhb58oSg
 Wb6Alhw5l7nSRs50CTQ==
X-Proofpoint-GUID: 99qJCU8wRTGdd9zUfI35IfCScw_WfNh2
X-Authority-Analysis: v=2.4 cv=X71f6WTe c=1 sm=1 tr=0 ts=699c3813 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 99qJCU8wRTGdd9zUfI35IfCScw_WfNh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230097

The T_POWER_ON indicates the time (in μs) that a Port requires the port
on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface. This value is used by
the ASPM driver to compute the LTR_L1.2_THRESHOLD.

Currently, some controllers exposes T_POWER_ON value of zero in the L1SS
capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
which  can result in improper L1.2 exit behavior and can trigger AER's.

Add a helper to override T_POWER_ON value by the DWC controller drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 27 +++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f40487c6da6dfd66f7c8d96a74259..f56e2c07ddc57bd84882c14bebc7d4b4961f601a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1249,6 +1249,33 @@ void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci)
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
+	if (offset) {
+		pcie_encode_t_power_on(t_power_on, &scale, &value);
+
+		dw_pcie_dbi_ro_wr_en(pci);
+
+		val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
+		val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
+		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_SCALE, scale);
+		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_VALUE, value);
+
+		writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
+
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
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

