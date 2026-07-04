Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124421638D
	for <linux-pci@vger.kernel.org>; Sat,  4 Jul 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783133415; cv=none; b=rfc7I4fEVym7DVH7bNMmSEhe+vk/fUTF2xFK+cLDZ6LkthQ4iS4y8iyVwK7BUMYoAK4/RJI2Fn+oaVP1u7URHZbOlxq7QbPLjvRbASpVZN9eEqRYevK5CtMqglTkyEAVQthmMji843BGczj3Fz6/jYbySrbNBVqpZ2NiDBq7hcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783133415; c=relaxed/simple;
	bh=78x16NySLeL5DDuQjFMiZN7FNer1+wj9hHzQ+pB7LCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C/htWtko1kS4ZJjQ21BaQI5mVT3WGdtd+k5ATQ+WiQc63dvqGPlfi496sq/zwNurExhuUjD1scCwW+EJqHooW79sXVBGEHPqDAuaFe+000jEf25oSM8S36aEYDj+U6uiaaSwxg9TDjLrdb+Jxf6dCQdMELlvDcxfaqYQWmByZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jT6AIJyy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=frjlE4gZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jT6AIJyy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="frjlE4gZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPRix1005362
	for <linux-pci@vger.kernel.org>; Sat, 4 Jul 2026 02:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U0MxyDFzYldG/YIgz+nhPe
	DiWvmTyd/fjgk3grmZLVo=; b=jT6AIJyy4+MM1O6nUF2xOmtLT70Gj4W6fGM1T5
	iMG7OPB8SGLcpKGE0pm3sBu2q7mt2SJpyQgDdXuQMTBMTbtXr+OWc8ICpfwwsYBr
	FtsZ6hTVGburTMSH09vskqRIauCvnF1cSgbIKxEFbGjTGW+5/00CW1IcHPyIb4By
	zum0C8oiDhjJJ5n0WMtYYM1y2YnOOTGqB/Crub40eUqCatPkCWP1C5anKYFtT42a
	AdnkYbfN3Vt7Va8N8NVurHUCcYFW/Vfm1aXexR0LN0DUTgnnv5+cJWav2Sff5P4w
	08MZ147PzqHdaNQY3SCSUgwk7RaAuryL3SdN/7hXvxdCWL6g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eydb6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Jul 2026 02:50:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c9960cf96cso19564725ad.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783133412; x=1783738212; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0MxyDFzYldG/YIgz+nhPeDiWvmTyd/fjgk3grmZLVo=;
        b=frjlE4gZN1bDsCMza++dNNzMKoACbfAyKmqhk2miDUIBcjgxoiOljF/VAubGTXwV9U
         RtYHSjuqqrPqF54+LWZnU53powy5R9JfF3dplURvqEJWpSqPcESA2hvsN/Enng9ETJrB
         uYKKgV+xWAG+pQFcvMJwafb65b0c7mStN7ZteZ8WgESVzNtpoud1gDueFSumtSkVspS5
         4LDLXF+51+Qh/saxyNgUO0doXrMtZ7YNU5mrbhnkz5eZWGQ/hYVY4gDEGf816ekzytnO
         x4QeCFK/DZ8ERKJEb17j7WmXXvoCyRus/mJHkf628RCQlMqTZoQ/mrXFuHmQoL9UOlYY
         CCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783133412; x=1783738212;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0MxyDFzYldG/YIgz+nhPeDiWvmTyd/fjgk3grmZLVo=;
        b=dT6fYiRQfUdR2vf9crNorHHXajEfx2EXPAfvKFZMgyAde12xXqBRHDOn0DPDqH7F2/
         7bC5NShPD2ebUmtIRIM5//0prvyJn73E9yaRAFW7q/oqL26+5sunKIz8UA5Cm3yJgy+X
         N6IOd5I0NgmbtlRIwyaz4AdkLIjCONljinf/8sH4NVNswdX2/BrJsVzVundVwXPdI657
         QlUvQaXbKf+/HCskx8HaJQ5b3eDi2S4oSBc5WABpNpMuJ8j/1QKEEkxrRKwTPi8Cj/h/
         M90gParvP0s85ZBOZDA7dniTR6xX50ETYSgWDFX+0K4o/ksVeF9Ap8IZussvEu3EuNiL
         4uzA==
X-Gm-Message-State: AOJu0YyLuuV2oZcSm86v3WNrP4HUjporx1Ar6EW875iL8sfTOpXyOG1m
	LRjdr2lNjRVerTweMtcDwcTvF4qQIxrpzEWrNs0gZfwTpo5G2b1mRzNeRooiD+26VvHfSip8f5w
	tMzoWPl8y679A5Ws9mL+Sf2xbQKkwtKwRj8QS4uU4vr+0MEbvSVeoGl5NvVL6nbg=
X-Gm-Gg: AfdE7clXykbC6ZQbNBoX75DZPyf2xm1DtzLoUY0F82+GL4fod/fpJCis8J99+9reOrR
	aj7TnoK5M2fjZzXAZUp6QFINuC/VqH/EAD+Xx8/jB5YEiT7ot6mszF2Fc5KDqwokCRqVHXrWTz2
	/FwfWNzCN2F3yHtzdxSWpQ+sBpUrbSoAw2WU7O5lS/Zbrpg3JrB9fypzt0fWpOf9hETqnvJ31ou
	mu0XsVoewRszuFnvgwQzd9I0sWRlBT28T02mRf5LhPWe60K1zR+QrRC2BCvY20PPu3OroVG+tvw
	RjukjNzvT/oUUmi9nkLP6Qso0pB18sX+lMg+K208FU8l3Znys5gnvJn+qhzmfkO/NOW4Y8GQ6c9
	DJm4W5i0Ktrs0/WIOPFl+CfYqQFaBpHaoOPWH46ugsoUzvA==
X-Received: by 2002:a17:902:da83:b0:2ca:ed41:d337 with SMTP id d9443c01a7336-2cbb9f32819mr17523405ad.43.1783133411705;
        Fri, 03 Jul 2026 19:50:11 -0700 (PDT)
X-Received: by 2002:a17:902:da83:b0:2ca:ed41:d337 with SMTP id d9443c01a7336-2cbb9f32819mr17523095ad.43.1783133411123;
        Fri, 03 Jul 2026 19:50:11 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85bde6sm41142290c88.9.2026.07.03.19.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 19:50:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 08:20:04 +0530
Subject: [PATCH v3] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-aspm-v3-1-157217aff76f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANt0SGoC/22NQQ6CMBBFr2K6toSWFq0r72FcDGWQGqHYQqMh3
 N0WTNy4meQl/72ZiUdn0JPTbiYOg/HG9hGK/Y7oFvobUlNHJjznZS64ouCHjtYgJUjBDwoFidP
 BYWNea+Zy3dhP1R31mNy0aI0frXuvfwJLuy0pGduSgVFGKwGqQSWlbtTZep89J3ho23VZPCSVA
 /+5JRdfl0f3mOcgmGQVFPDHXZblA7CdyUXtAAAA
X-Change-ID: 20260429-aspm-da55a54279e4
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783133408; l=9894;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=78x16NySLeL5DDuQjFMiZN7FNer1+wj9hHzQ+pB7LCs=;
 b=ljPg18T+OqX2UFwY1i67MfeLoVPjwllxg2dg4KBRdOOePf7hDfZGGHClMUXIpsRPFaXOeNnjF
 5uzqjl31igADMFL+8r8JiQ8zbJQuHuC2/xOfigTNbrvg/U5XbJ3lVAN
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDAyNCBTYWx0ZWRfX505Rw7MZ/8po
 TD+g7K4SuoDwWXaF7IKKVxL4KYNWiRHd7w/oV6G/tvjgqxMCCiYwiXiGZHqEdPxA1aotF7EyFu4
 2p8PF3MjxI4BTaQRRtUohThsgAIjQ/ch0rp/XWv+zy+U+qLzhGdU7/t23/nG4u8F9g3YAZ7p1nP
 23lLVczZ9SWC6WbMA63ayQRMZP8gmHu78Q3Ow+oqLxK/eCd9rRSuekFTUOkLSVhODEJJVB+Ops8
 Z3E+cBh8WIj3YmB5MAREjTv1RYs6KTAVmSVwMX2rnyv/FqJGcFhsMlRRMpTdGG8BGY+F0N77kNS
 Zdzi4DwesK2PAyENyI7rXETc6EBtZxExXPjxm4CrTvwu5bBaXSETxE7d5u9t+oS/4cIlomrbIf+
 9gFCvpljIdn6ikaXf8rVwz/yN3W5r2ks1BTtPwYfXb43gObkzTfH+8y87b045TnCLDT8Vtfj4FM
 IwgZgzHnCD8PncbckZA==
X-Proofpoint-GUID: 18htbyzXD9dddbG5nv11YkmhHdTEdoek
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDAyNCBTYWx0ZWRfXzl4Q0bdySbIl
 A6Yo+Yemxnx+cSRjuk1sGZwCj83kYxVxzwjEzggVnQ/2XSpqydUd45fvW2Yq5ceDQ8zOT0IIxO9
 02IhZ1uvSM7O9p7agn0kKKGwny2nfJc=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a4874e4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=yjenD30AEij0EbU3Ek8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 18htbyzXD9dddbG5nv11YkmhHdTEdoek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040024

Some platforms require selectively disabling specific ASPM states on a
given PCIe link to avoid link instability or functional failures caused
by board-level connectivity constraints such as PCB routing, connectors,
slots, or external cabling.

Devicetree supports disabling ASPM L0s, L1, and L1 PM Substates via the
'aspm-no-l0s', 'aspm-no-l1' [1], and 'aspm-no-l1ss' [2] properties.
However, the ASPM driver does not currently honor these properties when
initializing the default link state.

When firmware enables L1 PM Substates before the kernel takes over,
masking aspm_support alone is insufficient to disable them in hardware.
pcie_config_aspm_link() guards L1SS configuration behind a check on
aspm_capable, which is derived from aspm_support. Once aspm_support is
masked, pcie_config_aspm_l1ss() is never called, leaving
firmware-enabled L1SS substates active in hardware.

Fix this by introducing pcie_link_has_aspm_override() to check for DT
override properties on either endpoint of the link. In
pcie_aspm_override_default_link_state(), use it to:

 - Mask aspm_support and aspm_default for any disabled state.
 - Explicitly call pcie_config_aspm_l1ss(link, 0) before masking
   aspm_support when firmware has L1SS active and DT requests disabling
   L1 or L1SS, since pcie_config_aspm_link() will no longer do so once
   aspm_capable is derived from the masked aspm_support.

Move the aspm_default initialization and
pcie_aspm_override_default_link_state() call in pcie_aspm_cap_init() to
before the "Restore L0s/L1" block. pcie_aspm_cap_init() disables L1 in
hardware prior to aspm_l1ss_init() and re-enables it only in the
restore block. Calling pcie_config_aspm_l1ss() while L1 is already
disabled satisfies its precondition ("Caller must disable L1 first"),
whereas the previous placement after the restore violated it.

Move pcie_config_aspm_l1ss() earlier in the file so it can be called
from pcie_aspm_override_default_link_state().

Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
Link [2]: https://github.com/devicetree-org/dt-schema/pull/190

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v3:
- Move pcie_aspm_override_default_link_state() call in pcie_aspm_cap_init() to
  before the "Restore L0s/L1" block. pcie_aspm_cap_init() disables L1 in
  hardware prior to aspm_l1ss_init() and re-enables it only in the
  restore block. Calling pcie_config_aspm_l1ss() while L1 is already
  disabled satisfies its precondition ("Caller must disable L1 first"),
  whereas the previous placement after the restore violated it (sashiko).
- Link to v2: https://patch.msgid.link/20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com

Changes in v2:
- Disable L1ss when L1 is disabled as pointed by sashiko.
- Disable L1ss if bootloader enables them but we are disabling via
  devicetree pointed by sashiko.
- Link to v1: https://patch.msgid.link/20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com
---
Changes in v3:
- Move pcie_aspm_override_default_link_state() to before the LNKCTL
  restore block so that L1 is already disabled in hardware when
  pcie_config_aspm_l1ss() is called, satisfying its precondition pointed
  by sashiko.
- Link to v2: https://patch.msgid.link/20260624-aspm-v2-1-800a4151ba3a@oss.qualcomm.com

Changes in v2:
- Disable L1ss when L1 is disabled as pointed by sashiko.
- Disable L1ss if bootloader enables them but we are disabling via
  devicetree pointed by sashiko.
- Link to v1: https://patch.msgid.link/20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com
---
 drivers/pci/pcie/aspm.c | 116 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 172783e7f519..f00285ee6be6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -839,6 +839,49 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 
 #define FLAG(x, y, d)	(((x) & (PCIE_LINK_STATE_##y)) ? d : "")
 
+/* Configure the ASPM L1 substates. Caller must disable L1 first. */
+static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
+{
+	u32 val = 0;
+	struct pci_dev *child = link->downstream, *parent = link->pdev;
+
+	if (state & PCIE_LINK_STATE_L1_1)
+		val |= PCI_L1SS_CTL1_ASPM_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2)
+		val |= PCI_L1SS_CTL1_ASPM_L1_2;
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+		val |= PCI_L1SS_CTL1_PCIPM_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
+
+	/*
+	 * PCIe r6.2, sec 5.5.4, rules for enabling L1 PM Substates:
+	 * - Clear L1.x enable bits at child first, then at parent
+	 * - Set L1.x enable bits at parent first, then at child
+	 * - ASPM/PCIPM L1.2 must be disabled while programming timing
+	 *   parameters
+	 */
+
+	/* Disable all L1 substates */
+	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1SS_MASK, 0);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1SS_MASK, 0);
+
+	/* Enable what we need to enable */
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1SS_MASK, val);
+	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1SS_MASK, val);
+}
+
+static bool pcie_link_has_aspm_override(const struct pcie_link_state *link,
+					const char *aspm)
+{
+	return (device_property_present(&link->pdev->dev, aspm) ||
+		device_property_present(&link->downstream->dev, aspm));
+}
+
 static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 {
 	struct pci_dev *pdev = link->downstream;
@@ -846,6 +889,33 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 
 	/* For devicetree platforms, enable L0s and L1 by default */
 	if (of_have_populated_dt()) {
+		bool no_l0s = pcie_link_has_aspm_override(link, "aspm-no-l0s");
+		bool no_l1 = pcie_link_has_aspm_override(link, "aspm-no-l1");
+		bool no_l1ss = pcie_link_has_aspm_override(link, "aspm-no-l1ss");
+
+		if (no_l0s) {
+			link->aspm_support &= ~PCIE_LINK_STATE_L0S;
+			link->aspm_default &= ~PCIE_LINK_STATE_L0S;
+		}
+
+		/*
+		 * Clear L1SS in hardware before updating aspm_support. Once
+		 * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
+		 * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
+		 * leaving firmware-enabled L1SS substates active in hardware.
+		 * This applies equally when disabling L1 (which implies L1SS).
+		 */
+		if ((no_l1 || no_l1ss) && (link->aspm_enabled & PCIE_LINK_STATE_L1SS))
+			pcie_config_aspm_l1ss(link, 0);
+
+		if (no_l1) {
+			link->aspm_support &= ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);
+			link->aspm_default &= ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);
+		} else if (no_l1ss) {
+			link->aspm_support &= ~PCIE_LINK_STATE_L1SS;
+			link->aspm_default &= ~PCIE_LINK_STATE_L1SS;
+		}
+
 		if (link->aspm_support & PCIE_LINK_STATE_L0S)
 			link->aspm_default |= PCIE_LINK_STATE_L0S;
 		if (link->aspm_support & PCIE_LINK_STATE_L1)
@@ -924,6 +994,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	aspm_l1ss_init(link);
 
+	/* Save default state */
+	link->aspm_default = link->aspm_enabled;
+
+	pcie_aspm_override_default_link_state(link);
+
 	/* Restore L0s/L1 if they were enabled */
 	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
 	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
@@ -931,11 +1006,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
 	}
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
-
-	pcie_aspm_override_default_link_state(link);
-
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 
@@ -949,42 +1019,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 }
 
-/* Configure the ASPM L1 substates. Caller must disable L1 first. */
-static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
-{
-	u32 val = 0;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
-
-	if (state & PCIE_LINK_STATE_L1_1)
-		val |= PCI_L1SS_CTL1_ASPM_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		val |= PCI_L1SS_CTL1_ASPM_L1_2;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		val |= PCI_L1SS_CTL1_PCIPM_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
-
-	/*
-	 * PCIe r6.2, sec 5.5.4, rules for enabling L1 PM Substates:
-	 * - Clear L1.x enable bits at child first, then at parent
-	 * - Set L1.x enable bits at parent first, then at child
-	 * - ASPM/PCIPM L1.2 must be disabled while programming timing
-	 *   parameters
-	 */
-
-	/* Disable all L1 substates */
-	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_L1SS_MASK, 0);
-	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_L1SS_MASK, 0);
-
-	/* Enable what we need to enable */
-	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_L1SS_MASK, val);
-	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
-				       PCI_L1SS_CTL1_L1SS_MASK, val);
-}
-
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 {
 	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,

---
base-commit: 71dfdfb0209b43dfd6f494f84f5548e4cfd18cb5
change-id: 20260429-aspm-da55a54279e4

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

