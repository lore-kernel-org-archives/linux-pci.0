Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765073612D5
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845650; cv=none; b=lRxX1Qobbl7H0+xZPZbcu4SHW2SgtkiQI8SAW25GQrFOvdvtSulRG/OuKRUM3Gk9OQE46ZZ8xR7zekCTeksEQiQ+ruOmuxwhe0tXyH+uVJTezi4ZHpjKq8K49VJ3G3mAabmY4l/WkjrEUklFd/xFynUBMaCnNiPE8lTiVFdHtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845650; c=relaxed/simple;
	bh=aUnWFihU3Y3aaf4I60mFWgmBMoso3itjJCRkw9uXtOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGC7AjeKZyrLpBk9JVjaPUG48Pb2mnnC6VxSUNk+C76rjXKTJt64Zsm2RFF8TWN/lzWpRKSDRHZ6GAEkPqqBtzGpXdDo/saLAvC4nQIJ60/FMF59foe/ktXgiIX2NgTGGyDiJc6OTPyH4h2r56ceVzbUwRZ0H6rCZTw7bAqWhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m+i+N5+7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J5UUzfD7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m+i+N5+7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J5UUzfD7"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAWeto3698104
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xyb6+L4tlMbV6pYUJLmd6awL6PVi9mww3PT0E/Ez/ec=; b=m+i+N5+7h3vYLA+G
	B7lx60TwPCoaWPCyZkfDR0P9ERdHSGEI4PMw2bIdfbh87FPhEYjAqPEwa+H+jfp4
	y3KIciYSvaKximHf0uoeCYn5QsTxQ3tk8kKQjrh0LgWEDMf5v5Bw87QJc9QkJW0M
	jjyYOr2mIGquYjWK6VWftr6p8d0fPGVtDmNZEorfeQDRlbDGOZ+em9526oPI7eav
	XoDmmiHx56rHp9+xHvUCJ1US+MuAzhMg3O8MU4AvtR+lXfHlGn4ADuv9uTLUPB8L
	8JAzxqxPqeqAEH/kdy2qid95UG4F1Yixkhy35NeL1myu2bYFYkNu6w/mSYngROiq
	+R7Dvw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8184kb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82436a49592so1751209b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 03:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771845646; x=1772450446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyb6+L4tlMbV6pYUJLmd6awL6PVi9mww3PT0E/Ez/ec=;
        b=J5UUzfD7Uhz9QGiTPK1RpcEpn9rQ++iMT5ZyUsgcm3w3XHAMr5gl26DiO3C8kMqSIv
         4G14oTcfeSTboyJ284v/iKheXHEXFdLK+7LM8HPRkFiNhE/PwL9Y0wIEXQoV93fwa8Xp
         wZZE14ifEYB8vwKxHLfU6yDgAzGDtlGznfDC0t+8ZkHIng+C7feklO6iIE8j9TUXwGuF
         HVpuZylHOvmqXgY10nBcsC1+BqfFgcizWm/s2aKh6XV3/t0idHr99sFxIKubhPIJaPIY
         VB7IEGZYq7nWfD13LZKsggv6+FPoHF66xeibJtRwxXJZk6CMxCQ5EBwhNgURvwQzcucJ
         lrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845646; x=1772450446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xyb6+L4tlMbV6pYUJLmd6awL6PVi9mww3PT0E/Ez/ec=;
        b=XqE8FIpJmo733FHi5mZo4pJjNYqy4UHdS+tVAO0QyUm65ZUgHdhfQ+3DTrDn9x8/8n
         VqrrZ+Jobog3I6EIOLVzVSg0yl/hUw06cm68mS5P4c8HRHZHPgkM+tRStWUnB0A3ZNgy
         QFLZA6LfGH6kqUiU4S4u/ekWrE0N+utH3e5QlqER1vHAW5Ze1TzJFOCOntAsg/Q4XrsO
         TSRTYImQN3ShpFckymcieJGG8d/HnwPIpX1EnVTHmBDc1sPWOFfW+I/2VckymAwW/0+x
         aoqxbMQB9/GxhGNuFblfUFPxhPObhc/0k7Ef9mLjZ/j+YAUyPVcKRb0ZakwrhvsS72fE
         rGAQ==
X-Gm-Message-State: AOJu0YyZ42ax6Sa6N/M3yjpsHsrkY0FfLXWcfKFQUexuCQzBk6ZwNfu7
	rYZ85cldumKSIWL2hkdxulF1OiIn/ciCqu6QUhfz6ilNfNP2UjYl3TK1y0Na+tqlu/53Doa6AN2
	VLA4FO7/hMW73WdRLNz4ennuKYCZdIhpIpqlr8sAJB5mM2bJjxCZQgksoIfbH1S0ppG67OG4=
X-Gm-Gg: ATEYQzyBp1GaUf6GdtOPrxvjc2TARrey96AiLvQHxwWGAfikZ72aPVvhZkufygqPJY2
	Mep8dKDuuZJBXHQ2xH1sfgwgiAhGQE0UnLjnrw1YUssfFXv5rFjwurrafHOjWJC9KKAQEcuRPIl
	FUUxcEjiaxt5BEZDmnd5LVsuritJxz4uDCAGobblqDSCuS8PukJa8LGN343sTAhoaAWFab5+qk4
	8G/KDG8pPD64j/H4wTZ1TRUIH/CXCZRJONshg/0O4XBpgt+URaG3U8S6O0We4ImvTqTLChpUfAw
	NugkyR+7WGqgHc1IfMyNXhqi1+WrIE/ZPM1PW5NCHWYkFCsGCDvhuVCC0O+5LmGf/UNNVnaXr9/
	22X9N2b7lnnQTLntDtGYisM7r5glAXlT3Xz/a1gPmqCv+TKZdfeA75MPv
X-Received: by 2002:a05:6a00:22c8:b0:81f:4346:6870 with SMTP id d2e1a72fcca58-826da912406mr7327129b3a.28.1771845646109;
        Mon, 23 Feb 2026 03:20:46 -0800 (PST)
X-Received: by 2002:a05:6a00:22c8:b0:81f:4346:6870 with SMTP id d2e1a72fcca58-826da912406mr7327112b3a.28.1771845645586;
        Mon, 23 Feb 2026 03:20:45 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd899386sm6744057b3a.43.2026.02.23.03.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:20:44 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 16:43:30 +0530
Subject: [PATCH v2 1/3] PCI/ASPM: Add helper to encode L1SS T_POWER_ON
 fields
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-t_power_on_fux-v2-1-20c921262709@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845636; l=3597;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=aUnWFihU3Y3aaf4I60mFWgmBMoso3itjJCRkw9uXtOI=;
 b=2EOfI/bdhsjDYI3Gbxqc7xIt1wgjIgDQVQ/h4vS+GkKXHCa6G+Xe2zQPRnzHm2BSI64/OW7Xm
 WXzRJxCC54pAlvK3KtJQ/Q4uKJmk7yMLgtffJodpuWa9LBaFyf/5qfL
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: YgoeArL1jWkxNJAtN0J0Ea8r1Mj1RDkw
X-Proofpoint-ORIG-GUID: YgoeArL1jWkxNJAtN0J0Ea8r1Mj1RDkw
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=699c380f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=j3416i00YO8nPnzCGbIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5NyBTYWx0ZWRfX5uCgJIlvFE83
 MydNq/m18ksWhgWwksYzM3nTnMqJYhNigmPo3aBvSYCGsXxd6WNrlMFy0lNaXxdtGgfHpKg96Mp
 IBIqcQq23v8pam0j9MH1OBPHcE1ZcaoPYS7h7F0kXNy9nPHxArPe1pJ1HC3u5qGm6u719LrqU7K
 zxTHk4ZLgD76C2iD3VcTtVVPCFSpDmjDbE9a4Gf4bIn2Ixm7ZQOwBt/pV1ioMFIFgJCG2/Fsk00
 g6y2miJG85iIYCSr9moe9cDQcb+5LXaO16dENYB5iSWnfmFvktj/ZnrMXjiD/LYpvxlFOF3UHCf
 QA+0N807KJCtEVeDn95VCDMIWOBCaRi2hXgX8b75gEZMO6ZbgtRtJPTlzeMscRpz6HTY9exZYYz
 zwv/ETAgJTv6B3uR1ahr5pejHD5alMZgFf6jprcPv3hSS5guz/yfb80qWKbOyw/9Fjtfyo9yaUS
 gtXKvICMS8RYftIyfbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230097

Add a shared helper to encode the PCIe L1 PM Substates T_POWER_ON
parameter into the T_POWER_ON_Scale and T_POWER_ON_Value fields.

This helper can be used by the controller drivers to change the
default/wrong value of T_POWER_ON in L1ss capability register to
avoid incorrect calculation of LTR_L1.2_THRESHOLD value.

The helper converts a T_POWER_ON time specified in microseconds into
the appropriate scale/value encoding defined by the PCIe spec r7.0,
sec 7.8.3.2. Values that exceed the maximum encodable range are clamped
to the largest representable encoding.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 21f5d23e0b61bd7e1163cc869fe9356d1ab87b34..d7f9ae9e48c25dbc2d9b4887e2f74623688098e0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -525,6 +525,49 @@ static u32 calc_l12_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 	return 0;
 }
 
+/**
+ * pcie_encode_t_power_on - Encode T_POWER_ON into scale and value fields
+ * @t_power_on_us: T_POWER_ON time in microseconds
+ * @scale: Encoded T_POWER_ON_Scale (0..2)
+ * @value: Encoded T_POWER_ON_Value
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
+	u8 maxv = FIELD_MAX(PCI_L1SS_CTL2_T_PWR_ON_VALUE);
+
+	/*
+	 * T_POWER_ON_Value ("value") is a 5-bit field with max
+	 * value of 31.
+	 */
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..eec16fdcb9996ab0f663f4587a2367a676a49ce6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1911,6 +1911,7 @@ int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
+void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value);
 #else
 static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
@@ -1923,6 +1924,7 @@ static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
+static inline void pcie_encode_t_power_on(u16 t_power_on_us, u8 *scale, u8 *value) { }
 #endif
 
 #ifdef CONFIG_HOTPLUG_PCI

-- 
2.34.1

