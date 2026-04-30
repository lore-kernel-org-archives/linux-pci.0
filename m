Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9D34F259
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524146; cv=none; b=a9cT1k/5EN3FuDbwGXIBsLGxNT77wqcV6kIU+3VLL3iCeVQT8hAd3gU+i9ie0qFSctblikR+2flfsU65QEcNkvzzMrAgP+j4VC2PhOfGPRdzNgHb780fDF6zxSXqC1UozwDwb3omOPiL5CG37WObg0ushGsggZsR4naNKssMT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524146; c=relaxed/simple;
	bh=vGgZxq8aamHl6zJ4qm8ME9XtEuUqf/lSF2MLRyxVmG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jMfII231GceN9IC6vzqxmBYu6d7KCZB7pvMtWk7jDvFAvHxQInCReFCy1CNNHQ56ZoayqKU6xOP71gfhz2GN5QrxfNL9GJA1k8N/8P3MSBh/kH/vKEM5xsQFYvH+DWFvotHk5KAXIeAgTwAXCtGoy4d8tPwJiXWQpt3uUrYLCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=leZfJTYc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LEiF1sJT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="leZfJTYc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LEiF1sJT"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNuJ3p3636534
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 04:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pKjr29GMYGo/qoTqucyBfo
	Cu5CZs1q7eEN5iUCOE6BA=; b=leZfJTYcHghaLcGHx3i20rO0+Fmc/fQhOnu5cu
	yh9z4hLTxnzGinGg1Er+ud3VQkpEcJSojbyVHE8xg3WKq+0KK52rqNvE50/jpnU9
	PrhLeAO08cZiHI0ILA8ROUAs2rHGmibYYwR6LehU+JHWkUjLhwRPTJBDijY8Ll6C
	RsJWr966Hi57pycJnWHQ2G+dKfsKFFZKJ+uNLhQdEVZsNXRfcU20FEQYFQhU12GG
	lFmEiIRCRfYVgGWMjiRu/Dipn4E5bDF0encq1WVL6eEPAWPZCyJul0b1aM7T19xC
	JqcPHqyoi+vERgK9TbrhZZFpquhRu3PDWLUXDN4kHMm1jUqA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q0tfu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 04:42:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2497cc190so9534165ad.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 21:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777524143; x=1778128943; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pKjr29GMYGo/qoTqucyBfoCu5CZs1q7eEN5iUCOE6BA=;
        b=LEiF1sJTGjzPNZg+OrVtDAtoL6tXtsXB8lO92yzgm8jNP0IqR+qsftjG+uwRhjX/mP
         e9DQUQaowmCvocW9OvZLpPbGB/SuQNaO0kaEp06fXeEmTb1yBK+ie4PMqMSTemMorr2g
         FKDF5jJPDqqNyvsucYai7KodZgDPhhMNGYBeVbZueXXikKY0yISWFRkgnwxgenJ8rq3N
         tAtC6BeiYCVUzVtcjpheXDMLNSEY67TplrHo0UulR44u3szBqTUCFAAXywbxF4d5Zvdh
         QwiUwQF4hyu9Whk4Ziz1/ky6CtpS7zt6KIF1KZIbzJ0EFToP+5A/lr3vtoa28TkCGmcR
         hIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777524143; x=1778128943;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKjr29GMYGo/qoTqucyBfoCu5CZs1q7eEN5iUCOE6BA=;
        b=UWUMfUb2LaqtMf+7wkKqwpdXOoGo+PYTGiwN7X5h9cmw3rQBjRk2svocUpfIcyKSFn
         SWb3CuUwj41xgNhmVJncad2horJ4jp93lLAVrgwjIpOKNdIt2rQKz69Hco8NHVuaPEAa
         qIFlhXbPDgyVSS7DrkGN0ua4h9/NGXQ2tOECWwHAG+XJ6jj0YOanXNRNNcw+iK7QrgJX
         TKtOKb26Ln8nLTRcPWCCAXhG6QzLZBjtCJOClqQXTiSCJcU8+EpfgjdKfvBY0fWlTMYA
         0299YTzhpevd5B4ghFrY6CkgXiwcCItBknbXiLVHyF47VidK38671fsXxMX6eY2rY1JH
         UhFQ==
X-Gm-Message-State: AOJu0YxoY4I+dmv4sLP55WGom3PDKzm+is5lDmaYMhBcBiNXCeV06z27
	dBdSBB0Li+0zOR/ooJC07Kvb/p3RLp6XpDuEPCLeKQOwpAgKb04h40TjlqEjQRnZ5A0gZToqOtn
	YKrXvn8kxhHisloXf82kFd2xEkTH0kGqBp+x51/WIghMW1FaCcdMoHil6tQZOvvDlbKRxnzU=
X-Gm-Gg: AeBDietfIKucQg9d8VrYyoXwFpC0C88nMFux3+KntMo1/7n5K3mqmtmbDc4PrmH8VmU
	hCiGGVLgQFp7YbFtqI+wqQWCl/3S5xyx9meWdMqQ+C0Oxj+pqQc6HmIddBd8RghZ6M/oozz8M0+
	+fxUfruIdTC8RLeorsfNayyRy/RhkWzicYkYzALulONmHPqOpYUGcmXzpHVsKcynUzsf5Z25CUM
	87v4e8B5n7z4MCGoFuC2+XezAQkgnC0sHUGCrc8DMkvbBGfCph4CSbN7O/gHWAqpIj1bUx8Mve8
	u2P37RqfmiyOv/Tt9Mm2OOEKr3HCDW1oplnODAYxmV5M2pblVg9yYu7ICdnScIsXzoL0YBY376H
	0EtFArjY5qOyd8wcLrodvfh1lW7eUIZ+CloFSOLa8J/ZI52nuMdTQ9IASjLrV+9+wtWGU
X-Received: by 2002:a17:903:94d:b0:2b9:6a4a:137 with SMTP id d9443c01a7336-2b9a434a22cmr8503115ad.15.1777524143139;
        Wed, 29 Apr 2026 21:42:23 -0700 (PDT)
X-Received: by 2002:a17:903:94d:b0:2b9:6a4a:137 with SMTP id d9443c01a7336-2b9a434a22cmr8502855ad.15.1777524142676;
        Wed, 29 Apr 2026 21:42:22 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98878a9b0sm40264855ad.23.2026.04.29.21.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:42:22 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 10:12:18 +0530
Subject: [PATCH] pci: quirks: Advertise D3cold capability for UPD720201
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-d3cold_support-v1-1-6734f280c481@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKnd8mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE2MD3RTj5PyclPji0oKC/KISXWOzlOQ0MwNDQ1NzQyWgpoKi1LTMCrC
 B0bG1tQCfPm64YAAAAA==
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777524140; l=1483;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=vGgZxq8aamHl6zJ4qm8ME9XtEuUqf/lSF2MLRyxVmG4=;
 b=R2dzp705P8lrLk5a3j7OELUvHDWHr2WDtCyLYF03iNyb1j47vmchOeiActNR8gfBhpKfejMKR
 AQiEbTCe5v9A3xutTuDIauVojOFlg7tBGMDa3otT2zmTmkuknHl1Nax
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-GUID: qs2YTCUo99PqEvxNnwyvPcpFkyBbXGNT
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f2ddb0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=s2POf3137QwqGv_6KJUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA0NCBTYWx0ZWRfX4GiP9gMg8r1R
 SWoXwyB61UuPY5VaZBL7lqaNGhMSNaqNx/mwCPL1QlImyqFfVLYysQ9QZ648U2fUFLYUTxrFz01
 9/TPyA0ADBFKqygKe/xichMNCpOjbID+EtGAxeX0Z3fE5u5xq7Xm5IaAOPct4lGljmEzoZOpvYc
 2L/IvbKz/iTPON69xA3VreEPlKdZwvoeqkewyoMBFFfBr8lmluPV/Kv6etbfBJBRCEVBb4E+XF9
 jWLtsx5Mo5bvnLXsVwrq1iCxhtw2jOOS0r5yppMzwMvKdb2I8bj1V6tJyKYfLpR7jTj24zAWA0O
 8R4QDlSSPCPeTYQ1AjZwteSrK/ExkCTBco5qzS6JumJBdzid8Liy82uuUt7hUOFCxNk1amvuCe3
 yZkI877gAuGgiMPafg35necT1k/wImnlcxkgC0Cy3rNcvY104tG0ONmWfpp2RXbFVYAFJHWE6+f
 I8TstZgmVWD2qeqm0UA==
X-Proofpoint-ORIG-GUID: qs2YTCUo99PqEvxNnwyvPcpFkyBbXGNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300044

PCIe-to-USB bridge UPD720201 does not advertise D3cold
support until firmware is loaded post pci enumeration.
This results in upd blocking D3cold entry during system
suspend and causing overall failure to enter XO
shutdown.

Hence, add a quirk to advertise D3cold PME capability
since the HW actually supports and advertises it post
firmware loading.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 drivers/pci/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..c32617ed33aa 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6381,3 +6381,13 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * Renesas PCIe-to-USB bridge UPD720201 does not advertise D3cold
+ * capability by default until firmware is loaded post-enumeration.
+ */
+static void quirk_enable_d3cold(struct pci_dev *dev)
+{
+	dev->pme_support = dev->pme_support | (1 << PCI_D3cold);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RENESAS, 0x0014, quirk_enable_d3cold);

---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260430-d3cold_support-36dcf6011571

Best regards,
-- 
Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

