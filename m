Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672493BAD9A
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768075; cv=none; b=oiGXPejzKFfih3h6JnT0kc+mnmIONh0URACgX1/Q1B7E5Zdltsk7T1g604Wsov4yJ2AMJbx/uwQSvaf+8r8FyxZqEBcnbHSX2T+kRQNNHT+UMOEhAeJ4cuyftDNzi+BPLnsCm4zHe+YGRXqsqeOJv2Y6wewChGzHFm/5kAap8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768075; c=relaxed/simple;
	bh=3T6+QI78/DD1AJxoS8WlDilNMixKlSD+OZgss0C6ukc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWdnVyxDUVRAzITQRpwnl4HFIplErFjI9XYNiQL8iEeqN3wZTW04EB7mbie2qfHRhC/Tv/0bkfp75nTQcXGKu0p+mxc8MyPNUvNAxUxKszP401Aj/aX/ZByrGBge5o36FGDpf8wO421bCkzluRU8wASEurpWeltUN/fujv+SRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHMQysYi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RFjjlVLp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHMQysYi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RFjjlVLp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L9Xa113164809
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 10:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=epLO+YivtnmARNN/OXhc4OMjCefXGyiYVQ3
	B/j6RVzg=; b=jHMQysYifGiWQm2BMelg3xYXANfkEa6oY9PC0AgmclPGZinCMvx
	+ruZr0YGUuKpkej9AllSFlTUeg2iBG5Hyak+VA9RqZZYuGYlOs8UiXSFOdseVL+B
	sycBJqSFiwEc3cpCp8JCGA2grRLTow5pd0BegmaKIvJAUdIrWgtfzVmry/ag3Idb
	DtgwrRYYlWK0yj8XC4mRYeNMDByTBqVnaYUj4a5QMYpQfwJ8BBK5W2CTYaoz5FS5
	Zc0FmZ6px08xvYeKfm7lJLEldb7mUz9IVimP5GwWJ+pRVt3GSu4oTiAbURUkXpuT
	NDhXAwnwbb7gOaGyR6fFB+BRq3MgJWj0u4g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp6q807sc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 10:41:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24e9b4d82so45584625ad.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776768071; x=1777372871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epLO+YivtnmARNN/OXhc4OMjCefXGyiYVQ3B/j6RVzg=;
        b=RFjjlVLp6t2ocRLitOpkO0PL1/+cd6506reI1sf/43klF+6yUsNuAGD9KXC3yBnXPb
         uA1gTmfR31eXtN9Guc9KvCV5nzqrugZzVxfSVzLwsxVhnLviyjiZ7HysRr+yPeoJ+cl2
         4LwRud4jCOeM2zexyGzPC08yyT5w0ywuc5cR5m4TTTGtTbDdH8kQcJXFhPY94evFmb6H
         8/3EjvW6oqHUsE3m6bX8enMDE+Q7REfEH3y2ldHwlXYG/ZbKQ+xwk1gJrNGA+nv4PPQj
         PNiuicSUkjm31uIzM7BMzkDTCxLwycOAhlQmE+y6aHdVLWSGv1KXyifnsAP72LI4JP7C
         6goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768071; x=1777372871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epLO+YivtnmARNN/OXhc4OMjCefXGyiYVQ3B/j6RVzg=;
        b=N3qVM1hBrVtTTS7NAQy6DAcuGVK14pjX2mfnQCinWfcav7/PWS1KBImHWmC1zrllKm
         p6xRcKREAMacHcxBJKxdT42s1n/QoAnDxC2xIQvagW+wSKDuDqLYkg0Bpnha6NfyYA5Z
         hyHiVH59l0sF3EEvyOxZTAXFxvJF5tVBvzwpdIbi3TdbAa7P8jRG60SaUfjkNa5YMYkK
         9fwLsDLRnC3FTOiQhxLQuVqp9ZUau+DjFpEPS9c96CeXf7i7HewMAJiHqnfEp9QVb0BW
         k5ZXC38QZfqdCgTyBWbP8/RA4iyysiKeiu/jMa1qMVJyHiYf8MMVjGJIHWdsXqEywVJJ
         twlA==
X-Gm-Message-State: AOJu0Yw5FdjLHpo3TMRTRI3QprmYRvI2RCHbfzts5xJnrnyG/ebo4hWm
	aZuykNCHA9ldjgZRwq2LZXViJOrspLhPqpyc0OGyLgm7YEM5NIzadN2ySsvdN+dXfrhyTqGTX1T
	5JAiTQvzryXbdQ4/0SdTuV0RzGvkLmle18JzbhwQGuWEFXj1zqUEsBuc5vwm90f4=
X-Gm-Gg: AeBDievx79abNCkN83bOXpdMOs/eY9DqVOdlRpjvbBHWa9AmcyadhzTXLwbBMSB1XoR
	pWuhZZFRhHT/bB0g6R02b5IVb8iB1qgCdOoef0qPFtTl3C+d+6qyqakW9IEY5/mI+T9dTJlrcyh
	TxtPPCddC73YuJTyKqyfA9oKNM2ReA8GkY5n/BXfAFtIw6jrPoXoUdELz5kAp2TjoOoRpt73Bw2
	bnb7Uw2GilumTBmNqrHRLtBzkBZmNfnCAS0XtuNmhT3ij/aKjhinx4NmAj+becSJ7oZw7L+ZENf
	iiFpsHWjW7AG/a6s6u8l0lQ/91Qkxs0PWEDo5Mc40W1Q0/IZFno+I5CR6ixfKYXFmpvPVfQ28iQ
	OSH/+9wcUoWIvoj1Pnvw/qsvYUnfHX1vPDjgbRes4ar9wTNiHBw==
X-Received: by 2002:a17:903:a4f:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2b5f9cb21dbmr106336065ad.0.1776768070546;
        Tue, 21 Apr 2026 03:41:10 -0700 (PDT)
X-Received: by 2002:a17:903:a4f:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2b5f9cb21dbmr106335835ad.0.1776768069969;
        Tue, 21 Apr 2026 03:41:09 -0700 (PDT)
Received: from work ([2401:4900:88dd:5c65:716c:532d:3c:8f17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa16e72sm130773195ad.19.2026.04.21.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:41:09 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH] PCI/pwrctrl: Do not try to power on/off devices that don't need pwrctrl
Date: Tue, 21 Apr 2026 16:11:01 +0530
Message-ID: <20260421104102.12322-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEwNSBTYWx0ZWRfX4sj8h1jWxino
 npXVEnl9JQWIjW3RbqIuXxMPQnb9d2AN2ov+7r0u21f/dSl8e8+GgXYpoCEt5gcYjGWnjqmeBfY
 h4D8f/XaJuUA6eqVm03VE8GEM7RM1XuoPsaxl0bIYZSZILayHpr1fFk/vj0XiehqY4kEsya6Hyt
 475FEbLeGz1JRQNbBMbo5Bws6V2QTYEM55yitgP/YFgmmIM0Lp1XBPEli0oRQHLp8XVIY9sdGsD
 wwG9laKmOq0OvSc4SMqjGWIcZLap11UnxoC5kzh6Zj+LAlmYDTb0SbXdf85tyDiQz+nC0DxI9ii
 DXEgSsV9PH1UH5+0ZCpSY4VJdOSYoOuKqTuUHgt36QRtuodf5PRNS5ESDoU9ERjMAztC3ulT2yt
 hQ+VTDiKAedXpvZRYCiD/Dhy48J2ew2cBFnN8Mz69QUD4yxqiD4BS9ZmPxxsQ5hjlCWjkwAACA/
 e6C44bSVlSc3FJX1prQ==
X-Proofpoint-ORIG-GUID: cph2Ulaxybd99y2jHIzyvafCIDsl9Add
X-Authority-Analysis: v=2.4 cv=eOYjSnp1 c=1 sm=1 tr=0 ts=69e75447 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=AWw1AI1ujJ3qdC1c:21 a=xqWC_Br6kY4A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=CVC7yXooD7wFAggVErgA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: cph2Ulaxybd99y2jHIzyvafCIDsl9Add
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210105

pci_pwrctrl_is_required() is used to detect whether a device really
needs the PCI pwrctrl support or not. It is currently used in
pci_pwrctrl_create_device(), but not in pci_pwrctrl_power_{on/off}_device()
APIs. This leads to pwrctrl core trying to power on/off the incompatible
devices like USB hub downstream ports defined in DT.

Hence, add this check to prevent pwrctrl core from poking at wrong
devices. For this purpose, move the pci_pwrctrl_is_required() helper
definition to the top.

Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
Reported-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 90 ++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 97cff5b8ca88..b5a0a14d316e 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -139,6 +139,48 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
 
+/*
+ * Check whether the pwrctrl device really needs to be created or not. The
+ * pwrctrl device will only be created if the node satisfies below requirements:
+ *
+ * 1. Presence of compatible property with "pci" prefix to match against the
+ *    pwrctrl driver (AND)
+ * 2. At least one of the power supplies defined in the devicetree node of the
+ *    device (OR) in the remote endpoint parent node to indicate pwrctrl
+ *    requirement.
+ */
+static bool pci_pwrctrl_is_required(struct device_node *np)
+{
+	struct device_node *endpoint;
+	const char *compat;
+	int ret;
+
+	ret = of_property_read_string(np, "compatible", &compat);
+	if (ret < 0)
+		return false;
+
+	if (!strstarts(compat, "pci"))
+		return false;
+
+	if (of_pci_supply_present(np))
+		return true;
+
+	if (of_graph_is_present(np)) {
+		for_each_endpoint_of_node(np, endpoint) {
+			struct device_node *remote __free(device_node) =
+				of_graph_get_remote_port_parent(endpoint);
+			if (remote) {
+				if (of_pci_supply_present(remote)) {
+					of_node_put(endpoint);
+					return true;
+				}
+			}
+		}
+	}
+
+	return false;
+}
+
 static int __pci_pwrctrl_power_off_device(struct device *dev)
 {
 	struct pci_pwrctrl *pwrctrl = dev_get_drvdata(dev);
@@ -157,6 +199,9 @@ static void pci_pwrctrl_power_off_device(struct device_node *np)
 	for_each_available_child_of_node_scoped(np, child)
 		pci_pwrctrl_power_off_device(child);
 
+	if (!pci_pwrctrl_is_required(np))
+		return;
+
 	pdev = of_find_device_by_node(np);
 	if (!pdev)
 		return;
@@ -213,6 +258,9 @@ static int pci_pwrctrl_power_on_device(struct device_node *np)
 			return ret;
 	}
 
+	if (!pci_pwrctrl_is_required(np))
+		return 0;
+
 	pdev = of_find_device_by_node(np);
 	if (!pdev)
 		return 0;
@@ -268,48 +316,6 @@ int pci_pwrctrl_power_on_devices(struct device *parent)
 }
 EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
 
-/*
- * Check whether the pwrctrl device really needs to be created or not. The
- * pwrctrl device will only be created if the node satisfies below requirements:
- *
- * 1. Presence of compatible property with "pci" prefix to match against the
- *    pwrctrl driver (AND)
- * 2. At least one of the power supplies defined in the devicetree node of the
- *    device (OR) in the remote endpoint parent node to indicate pwrctrl
- *    requirement.
- */
-static bool pci_pwrctrl_is_required(struct device_node *np)
-{
-	struct device_node *endpoint;
-	const char *compat;
-	int ret;
-
-	ret = of_property_read_string(np, "compatible", &compat);
-	if (ret < 0)
-		return false;
-
-	if (!strstarts(compat, "pci"))
-		return false;
-
-	if (of_pci_supply_present(np))
-		return true;
-
-	if (of_graph_is_present(np)) {
-		for_each_endpoint_of_node(np, endpoint) {
-			struct device_node *remote __free(device_node) =
-				of_graph_get_remote_port_parent(endpoint);
-			if (remote) {
-				if (of_pci_supply_present(remote)) {
-					of_node_put(endpoint);
-					return true;
-				}
-			}
-		}
-	}
-
-	return false;
-}
-
 static int pci_pwrctrl_create_device(struct device_node *np,
 				     struct device *parent)
 {
-- 
2.51.0

