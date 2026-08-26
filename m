Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94892344D83
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787728615; cv=none; b=gE5YrqPLSXnsr0cHt4AOERKREauI2tC6Mhhwug+YrxQ3NWbpIIdvU8XX4jXauZFDCjYoWa1b69rPb6zUwZGZ1WVcK6eKq9utG7gYI+y3RG1QgoBtMTjLM9QVXeVJgYQhsV/YTKMBZkLQsdR+zki6LnNnFUJ0gqpWggGvfcxdQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787728615; c=relaxed/simple;
	bh=QaDNHFhsRuNshSwZDCtwX2GUA1cVlFCDBWc1R+rzGV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IvefnzSZ/1dx+i0dnTArL0BG+6MjsLOe8MzJpMZlKyMgRiAf88ml5BvJZYG9l8hcPUSrYnLR2Bckq97hsnADEIostxwZrZ6sopTgYZ/ckik6vFs3NUFWVzTu+PYCxmWPjITELjOg8tGd8NrstDjG8sdQhvlaa7X8SfShL6s9Gb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NdSKn84h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JY7IJFnd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NdSKn84h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JY7IJFnd"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6S9YR4190148
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p6A1ycTpZigj2dUH9VB0U/4YPCbwh3lqf4lFC3kKxXU=; b=NdSKn84hzZeNSiLO
	+IeGsrq53tNNfs2VpnY/4Az0JsspGjmEMx8ohu8V93kCRTBgK+szzjBazX6bOJMe
	MI1mb6YyCB6sRk4qpu+1yXCZO2IujJ9LFztwnmmfpBGWF4138g3GBCAe9iJuGSkI
	DYIvSGPCoqe86XuWI30CaSgLUh/kMnZXve9EhoN9ZzxUUmoXnOYXKIzkJznrQzTj
	OgF+rya83TGl9Yv/+9LU9sdBYNb0mnv42c/VOYBf0imbv1ItAVmj1FC1UEtQ5vtn
	H7JLZm1qSTQVCR7bKfVB2FsjxO7CkRMcMgmGOwVN+dZ/GOmMs1rPnb6KJlxPqwBu
	tY5mag==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9cgpugma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbee6bb8408so815269a12.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787728612; x=1788333412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6A1ycTpZigj2dUH9VB0U/4YPCbwh3lqf4lFC3kKxXU=;
        b=JY7IJFndaK7ESwitKRgRzn+rjr/u8Uz5nwizadXpUUuA9EAjtqh75Oa/dqv2qfGdJA
         ZwAillFa+1EiCAYXmL1BDp1hM/MYvceT7RpeDy7gNNBs3eqhR/jwarZvSTZLi95GnB2z
         i5XnMs73m6tK4I7FS7FpPaajGhUAALG29FmFcDEejLfwTqHys2nPx9MQbM938v0RgVKF
         YPX0yOxG026HasxLEy6MYbAljN6kfuD1bxiy6yyu8VFk8SNGe/ZnTPEZsiKXjnqyouSf
         hBqnMbNSKNZgGl6piRVWNaUjIeHnHbpiy8Y/k7urvQEAHH5GYVQx2ZkavVr9z0U4Q1/E
         eX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787728612; x=1788333412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p6A1ycTpZigj2dUH9VB0U/4YPCbwh3lqf4lFC3kKxXU=;
        b=UleH6pxKaaxIGHoDuRL6mNRdmrxcDutYFV+SeDXRnvp+PNTwfE2NOqyZwS+8J14nZi
         FPgOs2YNXvxhRFin1dixc/8XXUFMwX92HTwJ7qUJnLvvxn1mRNzA8mHhDFVjdIzSqink
         DDcNfk3h7mLH4KuNtKo8wPUxIpyA6zwqvjK/x7mYOPY7af082nq4OWJ8vbg3eCGg8Pww
         XtdXNPlG87V10q+Ny8HEO/C0xza/Z6GN6DfYUuHmJU9vl5tO0sG2ZZ883RRjzFjPZc+F
         GxN6+VnxAFULkF2q91VmL3z2k7b6PWygkdsyBrqysK8tFoWj/LkTAWbuUIihypHwTSHK
         dsAA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3abtKZ8viAX9PVf6UPDqFB/cjFEm5md7GxxSUCrkjI3QYIsDUJ6WYDpKdYKxsCczaemk5sAELxsQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ncsBPpiOA2AxOyvcw3tlTk7TkC8v33hWR6NSELHeUWqhhDpdTc
	mjZIaIVjkwi6cJU2tV/4ngK049+Qn1NgksRpMbGJ5dgEjrMtEY3c8C4dMteAjli3VITpdFe7HyB
	f3gfFoHgNngA49A45aznbHj43LRgXD2r9JdpGYKIbzHQvu2FoSVFRHzWVaVgNAPOA0PSrDZU=
X-Gm-Gg: AR+sD12ACRXnTQCng5pgjnxbsMVkjB+PD6xTtXXDETqYbY0Xi0DAeDqUCVWfgkGli8H
	9DVHCg0rQyQe5cOjmYuWmDA+U5RZ+RMetbn98Dzy4BIVv1nvkjDO8X537TvNpMDPqpcZ1hht2RN
	bvwh+tn/gGHqr2AJvWeLli8bX5qsuG2iL90Uzj9ZutbFVeOQLNuj4jITR58kWP5OqlR4ZZ15vBs
	0hzRq+/v01A3NofF8txNfJeoCTlJAY8q8SvM+OR6myZPYREdZ5FI4ytNEZrocOkeJ+VwOd1wxuu
	MB7LE6wPVwdIrND9UJ+QqwiyoBDndV3jvzHoTfhpbeJgNo7CZZRr/RuPIL+YRJuWQsOF2fxRHQe
	WkET0H7mM7hJzfzhqSn3WY0PhT+xSeZf1rtE=
X-Received: by 2002:a05:6a21:6191:b0:3cc:ad3e:bd7e with SMTP id adf61e73a8af0-3cf8465a5cemr9891360637.14.1787728611554;
        Wed, 26 Aug 2026 00:16:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:6191:b0:3cc:ad3e:bd7e with SMTP id adf61e73a8af0-3cf8465a5cemr9891217637.14.1787728611028;
        Wed, 26 Aug 2026 00:16:51 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8dc465sm5553772eec.24.2026.08.26.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:16:50 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 12:46:30 +0530
Subject: [PATCH v4 1/2] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-shutdown-v4-1-eb5fe9d454ae@oss.qualcomm.com>
References: <20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com>
In-Reply-To: <20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787728602; l=2803;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=QaDNHFhsRuNshSwZDCtwX2GUA1cVlFCDBWc1R+rzGV8=;
 b=9JusIyhY3VXQ7BPp2DnSEQR2LUQSqA++Bhx8M543ZR2IzPxVhpM/M3jQSEJWvLyKiQ9tdmT4V
 2EPixcLaxhVBm44t7F7fQ7mvwlQCbbcpYdYYnTdYao0jt/9/t17ch6v
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 6W76TxxR1JZhbJ3az7ASxRO9gYysqlXz
X-Proofpoint-ORIG-GUID: 6W76TxxR1JZhbJ3az7ASxRO9gYysqlXz
X-Authority-Analysis: v=2.4 cv=I+NVgtgg c=1 sm=1 tr=0 ts=6a8e92e4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=yeOUdISH2rptVKx3L3YA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA1OSBTYWx0ZWRfX0/3sfeAynvAW
 Fa4RNy7Kgx4NnjODW1oKKAWElOSe5qC0T9c9s1xyZJxqTXKzIF23h6cAJfrhV+55Uvyw6i9Ajv3
 yGbJOG98nC6Q8I7o0YUHaPNldBzpxk2+mgMu4Y7EDxDninETxaY1wtsiMt3uhO8DNxGj/YuortZ
 n99wMMD+GOuYPCh0UeDWLRVLaK8+XGqpqV3201rICCnABdJ6q6OyatknXj/RjKmslt9iZO86FyX
 Siv3a/wNMHiClFLBALxJwABAu0AasmJc8Uwo5HSfWXlr8V/IQs0OJjpXRtik89e+XyPFeoXGUTG
 RU7PklNq0KH8XipX8ALl2KYkZPnFGofqUUTVtVWfVV4oftWyMudK93xgELcVyeUx2R6CWzNHIxr
 weLkEKZnrX1oKfAMYNeFBRNZE9swl7xbaGwmHM4YPV4UnqGY/Rg8cwMOb4pH5lBdXD51QAxWEBP
 QzhT3vhyWB3WFvuC3bg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA1OSBTYWx0ZWRfX1zBWxjQSD1cG
 YD1Y0gkvqaV5YXlBB/HM6mu/HJs7Touc7Ly5wEjwPDgk1uXAtE4f2tCR1OtZo1r7/d9VvhVSXnK
 UHqlJeUdjzPjDR7tMxHUpah473tXkGs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260059

dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
to check whether every downstream endpoint can be put into D3cold before
bothering to move the link to L2. If no endpoint supports it, the
function returns early and leaves the link up.

Querying D3cold support during shutdown is actively harmful, not just
slow: pci_host_common_d3cold_possible() requires every active endpoint
to already be in PCI_D3hot, and returns false otherwise. If any endpoint
is still in D0 -- which is common, since endpoint drivers aren't
guaranteed to have suspended by the time the host's shutdown path runs
the check fails and dw_pcie_suspend_noirq() returns early without ever
moving the link to L2, leaving it up right up to the point where the
system cuts power/clocks to the controller.

Detect the shutdown/reboot case via system_state. Still call
pci_host_common_d3cold_possible() unconditionally, since it's also how
"pme_capable" gets set, but ignore its return value when shutting down
and force L2 entry regardless.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f5a38e6fd8d7..5d07a742faa1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -13,6 +13,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
+#include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -1224,14 +1225,25 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	bool pme_capable = false;
+	bool shutdown = system_state == SYSTEM_HALT ||
+			system_state == SYSTEM_POWER_OFF ||
+			system_state == SYSTEM_RESTART;
+	bool d3cold, pme_capable = false;
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
+	/*
+	 * During reboot/halt/poweroff the link is going away regardless, so
+	 * force L2 entry without checking whether endpoints have transitioned
+	 * to D3hot -- there's no point walking the bus to find out. Call
+	 * pci_host_common_d3cold_possible() anyway (ignoring its return value
+	 * in the shutdown case) since it's also how "pme_capable" gets set.
+	 */
+	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
+	if (!d3cold && !shutdown)
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {

-- 
2.34.1

