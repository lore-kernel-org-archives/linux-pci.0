Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEBC378828
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644092; cv=none; b=d/qkRra1j+/NxNCzACo06aGZehlr2ywwvlyG+3Nzr4P9tXGnJyMhLfI46DRH81PREKEnGoR4VkF2QY7z+Bi6Rsil2acZxnemuVoITeZo93RxTQSChbTkPNIOwOcMpHy92qYyPxsVQc6VsxjGPqJCRkSioDl9/CHpKXfzYCF7Hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644092; c=relaxed/simple;
	bh=kbwyU9cBNmm9WhMYvQnmwfdACGEnIi/6+1yBtoNp+P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uu9lYe4wI6SYERNlUz8f8EKlOaXX8Vx4KaLiNFbDiCSLo2VopRIHJo/fClt2AzTRWrjMVyZ9CsfwQkyehNDNizgIgHZj/HQ2so1JpFOMFwpuJTIUYLtDyejvuqgBHNfHZKiS8uKAds1+8MH/sa2yzf7fxFC7WwN6QZJuR8Ejr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mk0E+OyE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e2HRa0P8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mk0E+OyE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e2HRa0P8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDfwDW1912524
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VfRHGzv5LZrjsMqHcjUMBQ
	TNxpKbC+Fo/KrOiwV/OcQ=; b=mk0E+OyE0bGCNHGUqqPOdSsBdIjafgpy25wVzV
	nWrD2fF7m6lhYBQCtbR3GOByizoHS1Vyo2+svtP2oBAnZ5qt77uSw+NbWoptn7Mr
	UjAyvlvV8guHyuNoucwCTxTnmCx7+0mB2FDsc686elH7izsogS6qrIiRti0JmJ1A
	T1BSp5ggVOddXpojSFxxnxs5FPMpYB6kqJGVtP43ryZ78M2M3LBtbdh/lEGC13GG
	Kn20L2OfJbpTerKZV3K+7ML5rQ/Xhnr9qvp+SUrCSzTo3IFij1VmTOthxQ3Fha8Q
	SLXGYYFxl0MCggBv8cSwRQXoxLU0ex62Mg0f9KniQRoPmshQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1dujut8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:28:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so153106615ad.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784644088; x=1785248888; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VfRHGzv5LZrjsMqHcjUMBQTNxpKbC+Fo/KrOiwV/OcQ=;
        b=e2HRa0P80s6EJ7DqGIkg8+9RVvAk0kjoXPLcI7vQfFLadhqik/q3te3qClFZ1P46Oo
         4WPC9ZJAgqbyVMFcP9Ph29P/WsGXW1hCo2tfBzPTzqbb+eHd+00gPBdXws8qMksIq/6l
         LimNF+hGdbJxhaE/wKErKk+3YjXwVJYCNA32pbNlvmUb2na7/MNyVpDxgymWiRk3r8h9
         Gj5uZYhZxi+i/1yFBTwNKJIevwdwKHhwedd7S57Y3ES+lQGgKO5Dfvz3ZpmFQ3syO/P4
         PEmuU3xKiOfyDwolkzoOVcizFeWHQdhwepIZK2UrTDYWSFhDtz8DdHy/hzLoYmZmy3AA
         heNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644088; x=1785248888;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VfRHGzv5LZrjsMqHcjUMBQTNxpKbC+Fo/KrOiwV/OcQ=;
        b=PV6KqYYptqKd4wKIy4EwRO6JsJ3GhCoV5bSVA5CDpqhCfwuVea3bB1J7ueFx9KPO/V
         wUXgJ+TL0bqk/01c4t6Cm7k9r7yv2hFags0eodKDcKN+gkFAH9aUR7rpSuWGG31EAyzO
         IM4ickSHsvIdB2GSsYG/BP5gV2D252HGxkxONFmzvZXFpJ1jIhJm/utPynYrRlXywF/W
         tSUU/PJ5gZeMZlvyXuM6YAcpTKghEhcMlY7UYcdnSgW/UG8t1x8dOgIMyjxY7ZXB7FkP
         jUh+bChEDIfhM0qy0HYut1ZYZbh+wGPi5cB/JAnUvHK8KvVdS9AlGHTPbF8nZdZVG5ph
         CUnQ==
X-Gm-Message-State: AOJu0YyYR+l+xewVGzcKZC879G1U+31GcFtCM6uu82PKG4ZAutKoQHc+
	SeVk/hbgwLtPM1yYQFXlLceNI3cetqzGwgch64sr15R/T6tuNLNOb8qhXNq8Y545Uh8cmPfONM5
	ACi+oxe+ADA7D8Bwit3HF9MYZPDLrrxn9l2P4yCfAz6Ud9fgZIT1g2jceA5u9vNiNEtLaz+8=
X-Gm-Gg: AR+sD12RzDe3U+GK35QnkL34RcHsXvQ4OwT74sZwjghnReDk+o3eD7RIcs3rVwmtHXj
	nJjNOJwjN5smcnm8U1AsoOJayfaO4+d5OHfpYDA9C5L90/G8MaojbqZwZkyf04Z4IJtIO9x7S6I
	dLsad30LVE966CMjoq+ZJxBTstNQpQwDtnWrYqc4k5fN5W1P1Rt/6258UCj1EXgjkJxMzJlnm4Q
	5eqJDbMn1ptgUZ7hQHBi9YVTBfwjc/l04Hbhoz9dG1Ancvzr6ZCnuUfVNNAMmuJdGTCeRT1g5YY
	oXa9boPnQyNuzihHpdijTAGprs07ttV3pvGANZwhXJ2eu87PG5Q2Q2QvcSAvo9lrQGX3/W9VhJ7
	e2vwy2pizUyzA/Mxj0IblvcEjvk6snydNBzA=
X-Received: by 2002:a17:902:d987:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2cf3489c64amr214777495ad.21.1784644087844;
        Tue, 21 Jul 2026 07:28:07 -0700 (PDT)
X-Received: by 2002:a17:902:d987:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2cf3489c64amr214777025ad.21.1784644087344;
        Tue, 21 Jul 2026 07:28:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbaf6sm43581095eec.17.2026.07.21.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:28:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 19:58:01 +0530
Subject: [PATCH v5] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-aspm-v5-1-58860c48d0c7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPCBX2oC/3XNQW7CMBAF0Ksgr2vkmXjsmFXvUXUxTuxi1BAaQ
 9QK5e44BEQXsBnpS//9OYschhSy2KzOYghjyqnfl0BvK9Fsef8VZGpLFqjQKI1Ocj50smUiJo3
 WBS1K9TCEmH6vMx+fS84nvwvNcbZzY5vysR/+rn9GmHvLJAEskyNIkF6zi8ERNdG99zmvf0783
 fRdty5HzMsjPqxBfbNYbK0UayDwXPELWz2sVXdbFQtkESzHaE18YfV/a29WF9saE2vyFmuvnth
 pmi6DKJcVZQEAAA==
X-Change-ID: 20260429-aspm-da55a54279e4
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784644084; l=11532;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kbwyU9cBNmm9WhMYvQnmwfdACGEnIi/6+1yBtoNp+P0=;
 b=DiHRySyAXQ7wo13X+hhU8D2sVkvZ+N5uXcTuCHOKbfvLy86M4vU7WoiozogH4uqasn17X5v7O
 abUMTOuajtzB/eiVDPvbhr1UvGDWXbhG62AvR8q/QZSAqU0FREFlyEv
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: wCjHZBwR52SAqIjuBkEmkvVYVaeptSYz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfX04hV1PX6Jjt+
 QPP5JFy/y1ERHsZdssnR/VoST3VamUgrgLWmOTd/gm/JzxuILi6Yr6ynpMmW7hw/ZDG3bl7SSwj
 IgHQZOpAJpsm9LxpOzplc0q3A7+SkB0nIs+exnYC9dfljoMPVmA+8t077XnIIyjsysVV2+PHj+4
 KQ0L2CoHLKQtiF6UqS7g35PVZ6DPJANyV7l+HpcSek4+Ksg83vZpCqeDFZQsU5NT6K9dHr6dtnv
 TWtchRwCNdfom/7elws1fdcIgQiopnyVesbMqT3Psk5ClYvd44Yfjk0+IoxmHXbp8YgAWsgMJYO
 30Mo0QTyYSk1AL5On4LLFXoBethRQ9HLfVNYXbT1K4W80DHb7Ukf3SaiD9pcTHwEi96r9xtsJQR
 6NqxzodvoCvN/y4CVcppOYDXvBeyNUVhEqEMakzY7qMIvXEF//gWNPjfJT0jEyn0oTFTcN+T5T1
 bT0XpuCgIs21p9EsImg==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f81f9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=3BgslpDsQ43E56dAdxgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: wCjHZBwR52SAqIjuBkEmkvVYVaeptSYz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfXzboZouAC+9Xc
 5vXDlxPeuydbv2sQs9CQ0xDmUbeDjRPBRZ0GtJ0infC9whcD23RqUz3LvBc4w7du6OrIsx3zAAB
 t0XD5+dNzMZNCWLsUMefNe1feSs9FVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210153

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

 - Mask aspm_support, aspm_default, and aspm_enabled for any disabled
   state, so software's view of the link stays in sync with what is
   actually programmed in hardware. Leaving aspm_enabled stale would
   make pcie_aspm_enabled() and the aspm sysfs attributes report a
   state as active even after it has been masked, and could cause
   pcie_config_aspm_link()'s "already in requested state" check to
   skip reprogramming hardware to match.
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

Since the restore block writes back the parent_lnkctl/child_lnkctl
snapshot taken from hardware before the DT override ran, mask the L0s
and L1 enable bits out of that snapshot for any state the override has
just disabled in aspm_support. Otherwise the restore step would
unconditionally reprogram the link back to firmware's original L0s/L1
configuration, defeating the Devicetree override it is meant to
enforce.

Move pcie_config_aspm_l1ss() earlier in the file so it can be called
from pcie_aspm_override_default_link_state().

Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
Link [2]: https://github.com/devicetree-org/dt-schema/pull/190

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- update all the child devices when enabling the ASPM back (sashiko).
- Link to v4: https://patch.msgid.link/20260707-aspm-v4-1-d66f85b728b0@oss.qualcomm.com

Changes in v4:
- Clear link->aspm_enabled alongside aspm_support/aspm_default when an
  ASPM state is masked, so it no longer goes stale relative to hardware (sashiko).
- Mask the LNKCTL restore snapshot against the post-override 
  aspm_support so the restore step can no longer re-enable a state the
  Devicetree override just disabled. (sashiko)
- Link to v3: https://patch.msgid.link/20260704-aspm-v3-1-157217aff76f@oss.qualcomm.com

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
 drivers/pci/pcie/aspm.c | 135 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 92 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 172783e7f519..82041052747f 100644
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
@@ -846,6 +889,36 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 
 	/* For devicetree platforms, enable L0s and L1 by default */
 	if (of_have_populated_dt()) {
+		bool no_l0s = pcie_link_has_aspm_override(link, "aspm-no-l0s");
+		bool no_l1 = pcie_link_has_aspm_override(link, "aspm-no-l1");
+		bool no_l1ss = pcie_link_has_aspm_override(link, "aspm-no-l1ss");
+
+		if (no_l0s) {
+			link->aspm_support &= ~PCIE_LINK_STATE_L0S;
+			link->aspm_default &= ~PCIE_LINK_STATE_L0S;
+			link->aspm_enabled &= ~PCIE_LINK_STATE_L0S;
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
+			link->aspm_enabled &= ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);
+		} else if (no_l1ss) {
+			link->aspm_support &= ~PCIE_LINK_STATE_L1SS;
+			link->aspm_default &= ~PCIE_LINK_STATE_L1SS;
+			link->aspm_enabled &= ~PCIE_LINK_STATE_L1SS;
+		}
+
 		if (link->aspm_support & PCIE_LINK_STATE_L0S)
 			link->aspm_default |= PCIE_LINK_STATE_L0S;
 		if (link->aspm_support & PCIE_LINK_STATE_L1)
@@ -924,18 +997,30 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	aspm_l1ss_init(link);
 
-	/* Restore L0s/L1 if they were enabled */
-	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
-	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
-	}
-
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
 	pcie_aspm_override_default_link_state(link);
 
+	/*
+	 * Restore L0s/L1 if they were enabled, but don't restore any
+	 * state a Devicetree override just disabled in aspm_support above.
+	 */
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		if (!(link->aspm_support & PCIE_LINK_STATE_L0S)) {
+			child_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L0S;
+			parent_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L0S;
+		}
+		if (!(link->aspm_support & PCIE_LINK_STATE_L1)) {
+			child_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L1;
+			parent_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L1;
+		}
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
+		list_for_each_entry(child, &linkbus->devices, bus_list)
+			pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
+	}
+
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 
@@ -949,42 +1034,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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
base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
change-id: 20260429-aspm-da55a54279e4

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

