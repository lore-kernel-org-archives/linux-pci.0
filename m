Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9C296BCF
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160976; cv=none; b=miq60exy/L6ZdmoXOebL2e1Nh8bDNg7uX52bZkG1MLcU4DXHEadCIdltzMDXkZlot+wHz8ajEx8KK45DR06JzHE+zi20nL5z2YniOXPt5PfwlEctdXQTHJZjF7BfVbd054Xw6icfmOROqGuhSQCK0Y4XJLkHkJJY/NaKsFcNv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160976; c=relaxed/simple;
	bh=pmgBYe7iAmRlY8SfY9eVYYwGRt5Bedpxrsv54GlOtJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6GanAn6BdsU+1d+5zsGJ7ZgUQ2kKkRtfrOUhnmVb1cFREkjW0mrMCiRTygrg5rCIzl3L2TUBcdiKYF8gh4XVJqOL/MCJPp1Y8HtRj1OsWPjKLZxaQIYRrrNNdr4A19f8QLhTpJZ7WZ1mFVNhr2GsgUnQLVaRykWUYRde/Xvtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z+PnfzkO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=khBEBd3A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z+PnfzkO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khBEBd3A"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDllfk4065981
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PJcPUXVAP0E34FWnaNgRvf9bFB9m/k58e5dArp3RdUk=; b=Z+PnfzkOVsiMS/xU
	0zlzRNyRasFp6++MKEFkHuBbWl/XIVdKG86jzvFmfv1PgRTSHTWqF5Xi7kkGJd2a
	SywbjyWQH475tijX2y2VXAVw4AACH5DsL7E9eVy8hknOWzY5QzKBDGjWOlht/QVz
	fF3IPcTm4OfeehHdsUr9IpgfVC+nRGsPbxGyWgVEWH8755YtX8DTT8LCpbjZQ+GA
	afFIOI41syAFDht9UBTF2GYoGsBEiloIo+DkkzJjthPjiuQb/w05l06BOhP2P9r6
	l1qikCiIIQIwBmhp6tuNvz4ioJcHg7Gxq25u+nS44qGzeHxOeIBSyC79Sk4f4UF+
	dUgoKw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fngysus2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so3287645a12.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785160973; x=1785765773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJcPUXVAP0E34FWnaNgRvf9bFB9m/k58e5dArp3RdUk=;
        b=khBEBd3A6eJOTriAzpvwIkpsM9lOROahaZ+bnZg5TyC1aKCHrGfEUUiym9jM4fPkQs
         pmxB1ccX596ifR52jmiBYWkXkC6pmgBISwXX/UnQu3J0TaVlBWwefzxi2shYbl/p2A8+
         2HwZNZmGXQCGSIHruXry2nc3ufz8i++xVUHyOOCbzMRzetKOWMc7Fj7slY0Wr21K9Np0
         +kuhck7VCXzFZEfxOmvCAXDX1Y3r0eBPJI9FeXgVLRoRnYUkn6V2oaXQutba3tQl7Rpk
         fWDfC5GUjlwzJSkCL535QrQ7bYxfZYngvtxD223I9P7I+I+7qFqruOeyimDa+MBBIp/l
         LcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160973; x=1785765773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJcPUXVAP0E34FWnaNgRvf9bFB9m/k58e5dArp3RdUk=;
        b=K3mYyl77WE0phfi4I2/Ov44kcFtKpfxtRj81Hqdk8grOjDe+IyBsHuAhpxt9hr3nx2
         fHifZOk5ZCDyPPkmwPDVyT50Nwh34CCeNrgH3R3AxhSYR9u1vvlOhdwZecnHNQrDe/xC
         IStf3dI0oMMmCULi/PejNbY16uMvijYazHlwdFy76c4D11fC9EQlUQrP4mCGAoihECfK
         xw6vxTa3V0mvWvQXCDmJZFsfYgrGRnPov76ELoadlFM4NtpDP8DuHUEPP8noCui9t0u4
         440w+61r7w3Hv2/ZaWtB1srztd3kxAXiA8akBxLnTMCo79+X07uEldrIbJra1+mjcilD
         s4Ew==
X-Gm-Message-State: AOJu0Yxb2ZheFrrbwp+WEdaKgyqZnseTqvwUaUNc5fZmwGDQE+lQ2dQz
	YGbdVyWF9QMcVPbxDi0yoR2jGYj5NaMGR/mjj82JeHXC93vLB3A+8ZlAo8v879ZAIxOcM/Hublx
	Dg4f0WO/RsiPSOxUX67SP9DvWpAdt5NNQiBh4LKGqfzjIYjoMBzfOCtJ+pptOld0=
X-Gm-Gg: AR+sD13G1SuEBKBkHEDTwwlawx4xZng+1brTWxsxQiBlf41Om0GcoUrM81imROHxHEl
	CK3kppjz4Hyx5pZbDWO+dXoGCkRiQKycNUYjxoNYpE9xr+6CFyC8dMlivNrNRaa5QUFP4GX5eYD
	4VARDCcUBvdO3ehbUwqkv2bnGLYR2V8zABZXPqq95INOjZ63ttf4xZgcIwYSWdBgn5GJ3X6pBRw
	hXbRiZzT2rSjKdmT+LY6Dct4+vgPE1LGdpJPuKxqXOiyKWeEBar9G0TaW4gh/ADBVPaNKBP6w91
	esnQashwggP1Yp3vOZORCYW5kpdJ3vFMO+GNpi9Gb9FqP7kWYqNN3EWvfIldCmwa84G1EgD7MML
	PUNC24rwNDlsywDjS2Vr1Q/bF0QTL6lMAM3A=
X-Received: by 2002:a05:6a20:4323:b0:3bf:6011:53b with SMTP id adf61e73a8af0-3c67df1ffe9mr8232062637.38.1785160972836;
        Mon, 27 Jul 2026 07:02:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:4323:b0:3bf:6011:53b with SMTP id adf61e73a8af0-3c67df1ffe9mr8232008637.38.1785160972212;
        Mon, 27 Jul 2026 07:02:52 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e6054598asm13789423c88.1.2026.07.27.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:02:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:32:38 +0530
Subject: [PATCH v6 3/3] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-aspm-v6-3-2ebb3ee7ef71@oss.qualcomm.com>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
In-Reply-To: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785160961; l=9875;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pmgBYe7iAmRlY8SfY9eVYYwGRt5Bedpxrsv54GlOtJw=;
 b=JlWvgrEDWjcZbODBa7jrcxnSWF0OcqGgGIdPz+zUZe+FPFnjtLHsRErBc9B+9RGVjf09fvoiZ
 jul2KLcaF5PD1INZaTJoVhRuM9B9Aq68Wb0615oa4KjLejchy1hotlD
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfX0eyUCbM7JBHx
 a/GE+NdEs+rqFdYMO454YgP4Hmusq4k3aHbSLrcJkQXZhwMzU4qiAXFw9j4aWvZjatoKCc+8bAO
 NzCWqLhm3cooF33g6lE1atdrW226OtoIRkK0bbv646HjU0qy+k5rNBWO9X8eo4PYzBIH+lVY2c+
 YB3IpTsQ6yxo9zSfGVzj86ArcDpfRGz4SY6CF8/vBC9kJK0sNPOrP/CuX4aR8FxJQG1MfBdD28Z
 WzG1m6LqfKzeiVOSG255FewlCPNOHLUPTMRxm0nfqeVP0WKcBe/o7h2E1PRLnCa/M3ZpFZmrIuS
 hCz1fqcBasMADShVCJYwfbRVgwKgnQ3ZYbidVc0+1eUKNzD6mgWcJjDTStNMHyD5XCFPB+tOrcj
 fbafaviB9i3rpBpQl/M1Q4leKwN2MoO1uDvkBloWGjd/UaMJBkK/WpLG+aFHL70oVUJ38Te3pwa
 DvNHqdsC143uwMRvd4g==
X-Proofpoint-GUID: X57G-Kz_9Spfi8aVadYsYSZgyuWZXRCL
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a67650d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=yjenD30AEij0EbU3Ek8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfX6qlaV8zZ82BC
 s+p7q2Eo7tV5T645b+9/acD+t7yM/cXK2AUhx10DsNMdm0xoqeo4ffZ0I4oazQlilvjMSK5aUKU
 lvIOmutEa4ipWUFydkP43dkGSWOz2VQ=
X-Proofpoint-ORIG-GUID: X57G-Kz_9Spfi8aVadYsYSZgyuWZXRCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270134

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
 drivers/pci/pcie/aspm.c | 132 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 90 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 544f35bb2555..0a671825fac8 100644
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
@@ -926,9 +999,25 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	aspm_l1ss_init(link);
 
-	/* Restore L0s/L1 if they were enabled */
+	/* Save default state */
+	link->aspm_default = link->aspm_enabled;
+
+	pcie_aspm_override_default_link_state(link);
+
+	/*
+	 * Restore L0s/L1 if they were enabled, but don't restore any
+	 * state a Devicetree override just disabled in aspm_support above.
+	 */
 	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
 	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		if (!(link->aspm_support & PCIE_LINK_STATE_L0S)) {
+			child_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L0S;
+			parent_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L0S;
+		}
+		if (!(link->aspm_support & PCIE_LINK_STATE_L1)) {
+			child_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L1;
+			parent_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L1;
+		}
 		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_ASPMC,
 						   parent_lnkctl & PCI_EXP_LNKCTL_ASPMC);
@@ -938,11 +1027,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 							   child_lnkctl & PCI_EXP_LNKCTL_ASPMC);
 	}
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
-
-	pcie_aspm_override_default_link_state(link);
-
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 
@@ -956,42 +1040,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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

-- 
2.34.1

