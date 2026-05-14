Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F432D836D
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782752; cv=none; b=cdfKa/hVFvhWn7Me7wgZG7/0/yRCe7vmkPhQn62CAKOK6MV5A4va3QA5XSsc+Oirolz5PdLh3BHHuDBGY2kNuvSwAUr8YCqzQJc3NqMMHDJxu9RjFDUyES9rDzbBefJ9JLK1/6XfCK84BijINbsmKpW0l47jpvCDVK08YxvTzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782752; c=relaxed/simple;
	bh=jRLJlDscFGlmVeGiHZHxkedxmQ5eRcIqyRMqxJE8fQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFBIQJDJvYmDy+p8OLiTo1zfH/gGF4ary/Jy6blzFaTuathWYDRMDA7XMILi1Wu2nan8OGAekCbkSYFPD8p1fu1MtBSgdKDepPTpobJsMAglEXIFW+oz6Wnd1oT3eLyYdPlpgMmHUSZ1CLXhGv5MZ+EV14RE7lGT5Y4iTmB9yQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ja2Yoyu9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XdC2lUxk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ja2Yoyu9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XdC2lUxk"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeWwu2841093
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ua2mw29cbC0ENuBTMoANjxbBI7lNjtC/MKm
	egco5xxc=; b=Ja2Yoyu9f4JQJKBqq6+mxRlSCIXOQIgmNMD8gS52XzYNqL75sTZ
	CnXIyvtxBcuuYBQxu53NrCOnQhSkviasSmf8Vt5vmxNQQwUgekmrtZoRUOf13kar
	tTqSX2ymGVQgGeZ88MTtI58roTDys1KW0qHqRcRPOOS9jSp54nfSPO4oNknVQKgz
	z/PXDyoXY5nlNz4BB/UHePJvNdKK+/TALaDoo7RTiJ3utRRRhb/7RPIUGGKybQ1g
	dZJvwAYRHXPtYjWz9JTM0OHJFV/o/h34/+Jz7Kobzr0F27zWwfHPkIndv2L9liWm
	ZCoSCuw+rlOGPXqzywtPA0fxKSYJAZZmS+A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5899tqbs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:19:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c828cee4fcdso3101143a12.3
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778782747; x=1779387547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua2mw29cbC0ENuBTMoANjxbBI7lNjtC/MKmegco5xxc=;
        b=XdC2lUxk3lw9YroPoHmwI3NQ+rnOkoiINdk2AZqMlFFl/AQiE/6001l9Tt11JmOBRX
         hWpsKNLS1L+3/hgtstQLTcO3/fVTTeKDVZhtHh38Hf7qpW0+oYf2avH31np9AlqYPn/1
         8fhHCoh92Z2UALGA4iCpatZ4Orp7RslhwA7u84L/KOQkakP2ZH4MmLcfBbFU4ldfxwde
         MviCxMK4+8A4H4y7y4Dit8PUXOmTGSoMrHJ2TvtYCFL8VXLVaLn8cYcCUq2KwozrQl4y
         YmI8K+FyuoJRAf4s6p0OyIxO741K70o488gNWlxfCDjLWDXjk5Ow08oqjc8wsMHF4WKl
         NwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778782747; x=1779387547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua2mw29cbC0ENuBTMoANjxbBI7lNjtC/MKmegco5xxc=;
        b=iehygjgyBndWiow918a3eLH+xGPpzX9jHg1gHeYuGbmoZhMqrn8apvaXxhVpvA3y+y
         9He7Hi9FYv2YHp3LE1K76TAEfbd9H2XrJKw5SFFTmSlKNTlO8JJnfyKHHJFjNcvZGzm9
         PQ0Svwouc6yG97zEBfFHfYdZCotV55OqJO0sPqfdBdg2UyUA/IcSVTA34PvahP/Cngl4
         DdR+giOOL3DEkhOyVJ4lZp0E1pKRtsOyeQ8nIIcLEMbzLQQ47GXpRqgrA6XShjv6tQeJ
         5EtXyQKpxnkHTXNOEAG8rOMr60fepuDmIbiedplVjYvSJ0in18Rp2T0qxiY/NgqoTQ/I
         kxzg==
X-Forwarded-Encrypted: i=1; AFNElJ8C01qX/9O3aEnTL+NA1+xAxiqZs2GjpkSHREtF4WbPFdr0ZbL1fy7FGVd0Spp4nIF7RyiHVm1YmmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUcy8hb1TTH4LgWgkMRsZljsRvla+o338ZtAphjeaEmE/5lq6
	6uJzm0AnTpuyupxGkkGhPGE32H/gl8DVwi6LGMaN+0J3ffesuFbrvbaoqVLB/8GeJkEecOEVb9P
	+xkeKrqBW2xrkjIvDC6AbbphUQTcKimGoJrxixGlxm3L9NP9lBWMv4ut6Gw+JqoM=
X-Gm-Gg: Acq92OEpMkTHP3YGeqtrGkbVK1Kl5op4qImOWnmJ+G6y6lHP++Nh8/WcpQsIfj/HTKy
	bgr2KCbBb7H75fFMIlJOKjNovhfTltgK66RKEh4F+FYF5L4JlpHPydjXBmDCAIJ+jq6rTrJTBzl
	0k21gTQ4M/B4mK4Y9RxfpewKQc5CSw86yCukEwWAp+rhGwrsBLCCT+j3044aTXo6918eFLlKHHN
	2QAYN8dcxACUHkO67RSFI3oGqRRLdy1nwUGpnYDUHzmL64LHCWdvtj4e6k0hUQfUAZHNwJALlYK
	QTPp9+5UIsCwYVPcIafIuXy1cg1HtjKxDeQ51zHME03CfWBMWTEuxJqMo9SRqOibaMEqIUM42iI
	97zdNRbUXCVi3+YRKRxbXuQFvM2opty/qxy/hSHKZLnuSpn4sIFghZ5DydCMXotRgqATUa6qgeC
	QqoSAF2UCAgkagMdn9ZDvka6uT+OJt
X-Received: by 2002:a05:6a00:94c4:b0:836:5c3c:2054 with SMTP id d2e1a72fcca58-83f33d5401amr656277b3a.37.1778782747218;
        Thu, 14 May 2026 11:19:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:94c4:b0:836:5c3c:2054 with SMTP id d2e1a72fcca58-83f33d5401amr656234b3a.37.1778782746619;
        Thu, 14 May 2026 11:19:06 -0700 (PDT)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7ed3fsm3355974b3a.45.2026.05.14.11.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:19:06 -0700 (PDT)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: shawn.lin@rock-chips.com
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: dwc: Initialize pp->lock before MSI domain registration
Date: Thu, 14 May 2026 23:49:01 +0530
Message-ID: <20260514181901.315647-1-yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE4MyBTYWx0ZWRfX8wspimzQZwjA
 QgpDn50vRQ0qxFdbA2Yu2ti9XOTTZdzxksbLhNh87MU123hiw3W4JtkaHPOljG23SxyOPcdE6wN
 uegXERmUXCNkRwcGNdF3B4XuDBwtTlYUI7F8NxIQ2fvAonbrkXrygJvnLEvvguoaVsns/SJG8FI
 jd9abxSp4oU2HLQ3EtfGdVOgrABH1IdL4KF+A8M8F3jp6+meusYWhVTK1ZBIrdM2yxjKcRYXsUs
 XJHifc3pZ/Vr9L3tIaHb2V1A6xt/klmQxhJ80lmm7vZwcnH6pb8IdMu89Y3cEXC3K/iP4FXzZu2
 2e+3su7urHReRl/gK35fI994IwuTh9PjUDmIRqJxnZmpGZ7h34IrK3e+WqEcWGB50zgqVJRrRS2
 m/X2K9SXPav4ZqgQxuZ8Dax+BhYs59Z3MxmcfbUCuamnsO9hwO9ofrlySRBETNbg0tP7HlkDcD1
 4c8peb883YAAM422H8A==
X-Proofpoint-ORIG-GUID: R7ZTcREC0KhUXYsFFIByGlZ87b9Gq0gP
X-Authority-Analysis: v=2.4 cv=N6AZ0W9B c=1 sm=1 tr=0 ts=6a06121c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=zSJiG3aQ0SmOekOxMd4A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: R7ZTcREC0KhUXYsFFIByGlZ87b9Gq0gP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140183

A lockdep warning is observed during boot on a Qcom firmware managed
platform:

  INFO: trying to register non-static key.
  The code is fine but needs lockdep annotation, or maybe
  you didn't initialize this object before use?
  turning off the locking correctness validator.
  ...
  Call trace:
   register_lock_class+0x128/0x4d8
   __lock_acquire+0x110/0x1db0
   lock_acquire+0x278/0x3d8
   _raw_spin_lock_irq+0x6c/0xc0
   dw_pcie_irq_domain_alloc+0x48/0x190
   irq_domain_alloc_irqs_parent+0x2c/0x48
   msi_domain_alloc+0x90/0x160
  ...

dw_pcie_irq_domain_alloc() takes pp->lock while allocating MSI
interrupts. pp->lock is initialized in dw_pcie_host_init(). However, on
Qcom firmware managed platforms the MSI domain is allocated from a
custom .msi_init callback by calling dw_pcie_allocate_domains()
directly, bypassing dw_pcie_host_init(). This leaves pp->lock without a
lockdep key and triggers the warning when MSI vectors are later
allocated.

Initialize pp->lock in dw_pcie_allocate_domains() before registering the
MSI IRQ domain so direct callers from custom .msi_init() paths always
have a properly initialized lock. Keep the existing initialization in
dw_pcie_host_init(), since pp->lock is also used by legacy INTx handling
and may be taken from glue .init() callbacks even when MSI is disabled.

Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c9517a348836..de316f103c73 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -215,6 +215,13 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 		.host_data	= pp,
 	};
 
+	/*
+	 * Initialize pp->lock here to cover direct callers from custom
+	 * .msi_init() paths (e.g. firmware-managed platforms) that
+	 * bypass dw_pcie_host_init().
+	 */
+	raw_spin_lock_init(&pp->lock);
+
 	pp->irq_domain = msi_create_parent_irq_domain(&info, &dw_pcie_msi_parent_ops);
 	if (!pp->irq_domain) {
 		dev_err(pci->dev, "Failed to create IRQ domain\n");
-- 
2.43.0

