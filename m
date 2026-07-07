Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B32C027B
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411971; cv=none; b=l39uYPClVE8fgFC76kQIL9EDHu04ivbHRhop8bSbcgyiJSoVflH66jOTcTB4vrYMNylb6G6mgBNLXRZNwyMWN10/zch6jY0lKvWb19HcsNoXqReJrqtdw5/+a3VVyDlCykqmh7m9LWe0/WMXrTmqhmPsnX8oi6UjnOlsGdj9gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411971; c=relaxed/simple;
	bh=OC9EJ69ZeGidyc3/7hbN/CPbFa/z+W5BZBQJs5G2NoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YgILVRFNad81QjA+kzIEUOya5VDrJMPvCyZuzrquUe4dYmOdlPfzBG4HxyqNhsFhu9t9I1AHdpC1Ctb04RoNrr/luBTH2gmdUOYbYbqG94s0Ks+ucnCQD3/pTAYajcutY2CeacM3tmvPLwnZi5PiluOzc4K8YRhRdjMsgPwRq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZTsoAS1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D8t3JepJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZTsoAS1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D8t3JepJ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748qJO2450511
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 08:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vlcGkUXAw/wvX9R8a682RA
	1Yur+vHJjRPILrt8MIszg=; b=NZTsoAS1HvMt9H7v5cfKcQmwq6wg00A2RhZnCF
	p6AGCbcdX+RNuLqvOAmiV3+xV0lvXZgPkNeb+0bxpdWkD8dLw5hdLEUWzxD5VTqz
	kAhojWk7EkMVfgvHlyTL91THv2dzizKoFf38jsjD8nTpZXhvyhQXm0UOvASdO6VA
	sDSheiqW6kYeBx6XEkyio8hd+fTWg8kqfR2ElDO8y+GvjvqVrzOeYXb4DPmHS+Gy
	9QmznYDjGWoc/kya2fxkxSXnWQ8V/4k5D7WSGWbQrtAZSInKCdXUCKv9CmtkdS4L
	ccidydsGfHgGpJGVH39YT8XjO2cA1Q0FsGbmBG5DLhwoYCaQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su70wb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 08:12:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c98136ceff4so6929642a12.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783411969; x=1784016769; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vlcGkUXAw/wvX9R8a682RA1Yur+vHJjRPILrt8MIszg=;
        b=D8t3JepJCjCVtMVZqQ//Ac9hHhXlNuT96Uft64jKnIYUCMmRxZjdeGdf9wiAyPtcXV
         2lWnS4F+vmnlGHpu3a+6QX+keSvWVQ6fmYDJNjdPQ5sLKcKYNRHlBd84L+LmYcVc0wjT
         qc0aG2Q17kQWiMyL/ftlGVqEGwbjZlGQhuj+dgQvJwvr+roZeLe9SjLXXA9Eh4Ev6Bhz
         nL4qCZNxcSponv69bNgyjUnBDvXeo33zHgRChCbxFdD33JJLOobpW89+z+w3bjMmp5q4
         dcnetR0Htq9lY64iPDpnf9/RgrTIdCC/zZMYRfD/ZUixbv09g1zJRJ99zNWnrcRCOjqg
         2Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783411969; x=1784016769;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vlcGkUXAw/wvX9R8a682RA1Yur+vHJjRPILrt8MIszg=;
        b=JU0rSVALKlyA2mtTWUypq6otNoaneOT7J9IC94czeFTM7iBVC2DcAuwg51ztc03tp2
         AeK3cEO20qGhJ+DwJOcrb5NO8ajT+7f1o7nUBZkTLHm28gFLYAzRRUxUKVzzpJbYcdrr
         L7EtW93nHGesihsu4eDz7cZUrX9+JYJvA9H7+dHUygGWd4yAgh+hha1m0mB1VrN5Jl8x
         y4tsApR6QmLH3ZBLc3R0U+NYSCx6onLM9JODBXblDlJelmC8lo4DlCTToRPGza/1Xzdi
         +yKUPpeAfq/hmQaWAOdFXDxmEAD/XW5mjAPK1NEAPZC8BA5AJIooeXl0quiP3u9+LvPo
         ZkpA==
X-Gm-Message-State: AOJu0YzkJI0WYVXOM2aOhUeomjZ048XV894cMQlCPdWwH/AhvmWK7fT6
	B0cGUXdy54VT3tQLmN0ZUBd+EM2AV5TqhiMJQpF6zXPF1n+RJataHFyBj8ujoY0TpyQRINPwEtg
	ZWNnTZL7QaUj4Hy3oglmU1lZr+vDY6eQeQSNKuv53fQSttdD6VQsqtr3j8Bvcv7wlRg6ihz4=
X-Gm-Gg: AfdE7clz8eUIWw5Nf8EmlScGVyx38rBppAy6Or33A+m8fXkocu8omhQI7PY2XSA6m+q
	bdRuts2qR20gpI/gVh3oO54Y9Zt3SsAqpK6qJacm9iQDJmuMoe3sD7H0l0AQGpNN5EVxdXFT7+H
	2+lJOlTV1P3is87dZkLqh18jO6InnxoBMp4UjcwPpfQoMCTlxto7wuTaRq4YMU4HVcX+r3RUz/2
	0Ec9SUW847WNblCd+C/Z6Qmi1YYFj7GSESF2CrV3OHr2ZHDmHQJEhQlOvMAslnVyhsWcHLaOkMH
	WhxfBLrGolHMVhkGS5gDcvmESxx/3yhY9ju+LV+YP5Uabr4Oec9lqRPcgsvUjODkHOKKVyukuK4
	U/yAFGsrpKJF7JbYWpg7SEnyLg5pT6Yxk/LyfdBUMgE4RbQ==
X-Received: by 2002:a05:6a20:ef0e:b0:3c0:9c1b:d0bb with SMTP id adf61e73a8af0-3c09c1bd47emr2017266637.70.1783411968755;
        Tue, 07 Jul 2026 01:12:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:ef0e:b0:3c0:9c1b:d0bb with SMTP id adf61e73a8af0-3c09c1bd47emr2017215637.70.1783411968157;
        Tue, 07 Jul 2026 01:12:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm6843632eec.0.2026.07.07.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 01:12:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 13:42:39 +0530
Subject: [PATCH v4] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-aspm-v4-1-d66f85b728b0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPa0TGoC/3XNTQ6CMBAF4KuYri3plJZaV97DuBiglRr5kQLRE
 O5uAQ0b3Uzykve9GYk3rTOeHHcjac3gvKurEMR+R7ICq6uhLg+ZcMYTJrim6JuS5iglSsGVNoK
 EatMa657LzPmyZt+nN5N1s50bhfNd3b6WPwPMvXVSAqyTA1CgqUBtjZYys/pUex89erxndVlG4
 ZB5eeCbTbj4WB7sgTEUICHFGP/YeLOKfW0cLEjFQaG1KrE/7DRNb1uw4EopAQAA
X-Change-ID: 20260429-aspm-da55a54279e4
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783411965; l=11266;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=OC9EJ69ZeGidyc3/7hbN/CPbFa/z+W5BZBQJs5G2NoQ=;
 b=0mRY1PltrqaqqU+7kUAacBopyeDKxyaYHna7XX/aa4wdav1UFLU/97cEzuhBxOj+/fgr+6LYi
 pzpWSUlufVKBUZhhwP5r0XV4SjMOWAz3YgezslcnZdZqNKkBoNcsABU
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3NyBTYWx0ZWRfX92okGib4+khJ
 /ZWd3X7FwMHzYCn5EpziDMz07aBB7kKWBGZnW3hWAQeqhWCAKyfqqxjlMFOQig5fdaRp2if4sJa
 j+V/3OlwiIzNstRsOTyQTT/IoD7YFoIXTCbOC8qfKXUWKTmngdkNS+Yh6/iIHfmlNpw2Vzq8u+i
 ZkKfL/4NXKwunWf27NcPyktcRSsM6XLdZU0YGtpGxbCluRq4EYu+magY5cqL8DJOadetjKLczs+
 /LWE/xMgQPyOoFUwMOjUuo5YpaKiktdo/8N9yDbsxT1bmNw4hmeFHikWehFPcqPCg+Wc+HRuPRY
 ivA0nxaVAD8NzmXoxBKJLPaLZsUEzjmqyDE7/hhSqsd7CqaI6gAnKAmtEF6hTB5xZJHPTdQGzER
 8ejX2EUiMRAMERNFam0ROeDoJwRVM9tpKwhEfc3Gpo1vOCMfJGbv/uJu+5fpC3KzRNEbQMXSrxp
 6y4nOqD5cZmb39Xb0Dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3NyBTYWx0ZWRfX/005qpw+7tVx
 9e8cQ6RZwO8zjBq03+f6fBsENqmUNwIyKE887mg+l77F7fp+tAD10yOHelB2UXgtPO+G0WrfpAf
 l4b8HC199OBhUFOOqsAAyfyvkz9XLgI=
X-Proofpoint-GUID: 5g8WfqWJFZEThYWSLQLSrf9MbTkJpKcZ
X-Proofpoint-ORIG-GUID: 5g8WfqWJFZEThYWSLQLSrf9MbTkJpKcZ
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cb501 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=3BgslpDsQ43E56dAdxgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070077

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

To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/pcie/aspm.c | 132 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 90 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 172783e7f519..19f5582a910d 100644
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
@@ -924,18 +997,29 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
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
 		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
 		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
 	}
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
-
-	pcie_aspm_override_default_link_state(link);
-
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 
@@ -949,42 +1033,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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

