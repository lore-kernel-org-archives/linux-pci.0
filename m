Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958553DA5BA
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365455; cv=none; b=N/qk//lUWH2i4CCJMJeLsrnrt7Yy1TjJXBhrb7krTtFzUVhlXsZLWuRKsu38NSRYPfK9JtNnWJbln5ijqcM8I1P7QajhK1A4npcXK7Q4LrIZ9LKvvcPxYq2cNU7sqR5OL8CDJUkT2g1NRtOLE17VC0BYqIeDfmwWvc7xnUFstqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365455; c=relaxed/simple;
	bh=XiLKTsze8J8AZJi/BMBbOlFuV680Mddl8yNvZzrLHJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jsk48eh5iqTk/IdM9yyE/h+X8lsL0SZgdF18ws0LuIC+ssX9nxmuT3fwLRIDFIh8EnIKDfzS9YSQxw/79dhl0ktGFMWNCTAd6zJbNneL6lNYLhpfhQotuwfU7QbbjfTdlm1kNOQbcZvfm7o6J26LLb/zGYpC13uZd0X3+aiz3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKdGFCWn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L7s174C/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKdGFCWn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L7s174C/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7v2u33968212
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 08:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yaIwIxnOhznyRxBC0cU16UUPAXL3RW+G5mxfWpJe9Mw=; b=CKdGFCWnnvTXRNTQ
	ZNksRjHxmXI01J/Tb20091Ow5iKHuUClqaEIbzp/VRM4LxDkwo7bm4EKCw38NyZO
	Opb/HOjcU0pl19LP16eQ8Aiq761dHW/a9vDWFBIPhojlMi2jlnf9Cb1kwDRlN486
	g468zdeKHFKiz7lvEHxMgL3tFgU6bMWFvf0YzSlO1ZRcWsB5bpCd7XaE+gNjALYd
	IAgKDz88lTNSN8tI5nCR8x026p5BFkAlfatfTNIo85MHDd39POzl8GY0iOGnNBwM
	CaOQoMgOsEnDvfbyevzgCKMYni9Ed0+/Y9laMeGYX9GAS8zZalHtKI61b1R/3g81
	MkiAAw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0g53a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 08:37:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b7aba0af02so50568395ad.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777365451; x=1777970251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaIwIxnOhznyRxBC0cU16UUPAXL3RW+G5mxfWpJe9Mw=;
        b=L7s174C/SXP2VKKGL8Z/c4ZjtHdnKZpFOCFL07sgv8v6v64Ebban2Y/XWZFPPE4JsQ
         IVpJVUPYeQX57CK02lbzxDmdCWmCLg0RUfc5qYKgpOG3eXzy/N321Mq89KN7I7ctNsBH
         laJumJcY56WeHOeT7o11nKSgdp+o0lnPBdD9NFQ9yEvKwS4irT0LLex0oyTY293Cg8s4
         3xsqOV9j5tf05BZFzrf4IdjvMdB3j+lmD1fLxzQ2zMSqqSNLGpZZu1nZqBmVkkwFt0sB
         jlzvo+SP93A9+qqib/SVlXd7w4t8atVESODZwO+V1rSyCFil1G+rlM3EqpcVv7mAgvBr
         syuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365451; x=1777970251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yaIwIxnOhznyRxBC0cU16UUPAXL3RW+G5mxfWpJe9Mw=;
        b=df2CcvbZNCVh+AeHnqYYrFB34YePV5jMgQkNebQ9/nvVlvk1btXCULPFP4VOJn9Gac
         7CfPacBE5LDxnL2nCJWc3+wlJR+6VEwgw2svbKDc7e99CTlbeVoztEAhvKOAh/bbF6dn
         mPwRdO2ceZpLnm5AiNFrP8OU6MIp9QyajCW/HXc2vW7NL2sWpJyJ2KeJ41bcUgiMMPJ6
         cxx2BPzFXMdFmdtTzx/kI2hiZ1aFUJjHaiL99Dbm1Qj+Vx+0TDNg9wfmbjhTXDrJBhI5
         lQjEB0lT97skGvEUmIz/wvQpqOoAQIrCnJcPMk8Am3TV7LSrjK2LIWt898Q48vufnzhU
         0NbQ==
X-Gm-Message-State: AOJu0Yy3JKDIlHSH7MMYjys01AEgIjwjY7yhDUAfENPUMoOi38WalC/I
	rS8dZ5k2eSkrmZyNKG07qZjpdVmN9cr2gf+GHngqs+4GdS/EyT8LLAg99lQPfdIvWo1/TV3qvLI
	DGLwD3DyWlEhrsVkL3qZkEKt7iCnHgEbaIL4Wxz1IavF3m9uujBy6N1aNkLvC+PI=
X-Gm-Gg: AeBDietkEV7yJHasrgN1Co8EeHNFVKT+ixKF5Z2yCwubMqHYt4AYl+PDlQJfZEHBvuv
	u59WLbiptieLyqme9DPoyg372eaEB+rmkSYlQO7Vaou5R25vaUYnzrx0zLe0IeoqR1pSBg9dPUo
	wxB0FLvLGhHkgjAXa3LfuD/s/Ww48IRiIuTEgHEp7W65b17ityj7Cocf/QZgUIlpMAE1xcB8Izj
	cldCLaXr9TptOZxMC3Sqs7k7YfXIaLOUFYOA/yMSUQwMidDAR1fq2OWcHT3zGyrgUzTqqOFOdpU
	578p8JRckX5EBB1A9xnWaqu8FQiuxhp5kjU2wFXuWTX++4TcNvbnNG+kJRrJoJLBxF7N5p88b3I
	YnpR0mmSRHtDIlu6ka+Po5KqIaS5MAfRxmwhc2Hf1UsqArZJNzg+G05QRPtUwfDtvbhE=
X-Received: by 2002:a17:902:ea05:b0:2b2:4697:4370 with SMTP id d9443c01a7336-2b97c3a24admr24103015ad.3.1777365451312;
        Tue, 28 Apr 2026 01:37:31 -0700 (PDT)
X-Received: by 2002:a17:902:ea05:b0:2b2:4697:4370 with SMTP id d9443c01a7336-2b97c3a24admr24102625ad.3.1777365450808;
        Tue, 28 Apr 2026 01:37:30 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97acaaa2asm21645315ad.84.2026.04.28.01.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:37:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 14:07:15 +0530
Subject: [PATCH v5 1/3] PCI/ASPM: Add helper to encode L1SS T_POWER_ON
 fields
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-t_power_on_fux-v5-1-f1ef926a91ff@oss.qualcomm.com>
References: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
In-Reply-To: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777365442; l=3731;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=XiLKTsze8J8AZJi/BMBbOlFuV680Mddl8yNvZzrLHJE=;
 b=g47OKo/9QXn3oxthv11scYA0upYKny9R5Bl2k1j632CT3/up21E5N8hSJv3ggEu56+2lyzWt4
 n21McJlZhbxBJrQSTW4DbelAKFikr5Q/T5elz49WhQrRghTr/GJjNow
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f071cc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=j3416i00YO8nPnzCGbIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: 2vXPKKD208yTuxJSSM4LeV7ndqbgYgct
X-Proofpoint-ORIG-GUID: 2vXPKKD208yTuxJSSM4LeV7ndqbgYgct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3OSBTYWx0ZWRfX5Gig5PIoIIt7
 vy7IhA5xDO8c0Dglugm7d8TM8mbiHyg2BkoAuvDfqUk/dpCqfbGT7gMbhyxTsytV62/p30Y2rHx
 gkuuDCf72h2BJWoFcKU7IQtjjJPDipfSWp68ZUuHAzx8mmXP2WfZZ6+4FL/zRZkCBWHEb7lc8Nu
 4qcgqbByxDhWL8qX9aE9ev8Lht0DVEwET+6vYwwIzs778SDzze/oy3NG69rMQLdScBGNuxumpU4
 hEU5wFSyWVK72a3xqkxj22iF/quNWKJ/tP85/lYFfCsbrkMJUM+jFmuLWo7/D77qujR3zcOV3fh
 ruSYBMRhGQX2R3tNZSfgFdjZ/h4sDzNe/qM1twdzFZuWuW3bk8R+bbzaA1owbwtcy15tMjSZX1J
 QQYLQNkEJTNz1AcYUtYEXjL66nC9P08Nh0RIdwL5nI0JL88jPb3UFP9WFmTOssyGHSTLTHeMCnb
 867Y6bE+9zRUW8gGduA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280079

Add a shared helper to encode the PCIe L1 PM Substates T_POWER_ON
parameter into the T_POWER_ON Scale and T_POWER_ON Value fields.

This helper can be used by the controller drivers to change the
default/wrong value of T_POWER_ON in L1ss capability register to
avoid incorrect calculation of LTR_L1.2_THRESHOLD value.

The helper converts a T_POWER_ON time specified in microseconds into
the appropriate scale/value encoding defined by the PCIe spec r7.0,
sec 7.8.3.2. Values that exceed the maximum encodable range are clamped
to the largest representable encoding.

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..c379befe1ebe 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1110,6 +1110,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 void pci_configure_ltr(struct pci_dev *pdev);
 void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
+void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value);
 #else
 static inline void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap) { }
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
@@ -1118,6 +1119,11 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 static inline void pci_configure_ltr(struct pci_dev *pdev) { }
 static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
+static inline void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value)
+{
+	*scale = 0;
+	*value = 0;
+}
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 925373b98dff..457d469b8d49 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -525,6 +525,46 @@ static u32 calc_l12_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 	return 0;
 }
 
+/**
+ * pcie_encode_t_power_on - Encode T_POWER_ON into scale and value fields
+ * @t_power_on_us: T_POWER_ON time in microseconds
+ * @scale: Encoded T_POWER_ON Scale (0..2)
+ * @value: Encoded T_POWER_ON Value
+ *
+ * T_POWER_ON is encoded as:
+ *   T_POWER_ON(us) = scale_unit(us) * value
+ *
+ * where scale_unit is selected by @scale:
+ *   0: 2us
+ *   1: 10us
+ *   2: 100us
+ *
+ * If @t_power_on_us exceeds the maximum representable value, the result
+ * is clamped to the largest encodable T_POWER_ON.
+ *
+ * See PCIe r7.0, sec 7.8.3.2.
+ */
+void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value)
+{
+	u8 maxv = FIELD_MAX(PCI_L1SS_CAP_P_PWR_ON_VALUE);
+
+	/* T_POWER_ON_Value ("value") is a 5-bit field with max value of 31. */
+	if (t_power_on_us <= 2 * maxv) {
+		*scale = 0; /* Value times 2us */
+		*value = DIV_ROUND_UP(t_power_on_us, 2);
+	} else if (t_power_on_us <= 10 * maxv) {
+		*scale = 1; /* Value times 10us */
+		*value = DIV_ROUND_UP(t_power_on_us, 10);
+	} else if (t_power_on_us <= 100 * maxv) {
+		*scale = 2; /* value times 100us */
+		*value = DIV_ROUND_UP(t_power_on_us, 100);
+	} else {
+		*scale = 2;
+		*value = maxv;
+	}
+}
+EXPORT_SYMBOL(pcie_encode_t_power_on);
+
 /*
  * Encode an LTR_L1.2_THRESHOLD value for the L1 PM Substates Control 1
  * register.  Ports enter L1.2 when the most recent LTR value is greater

-- 
2.34.1

