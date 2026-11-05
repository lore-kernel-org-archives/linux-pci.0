Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912550;
	b=p/LUuLskTDNQox3BH7XtUZaurJvFF/E6BRT0T22I9tFswRqrLA22yHjc1iRXt348WTaN
	 +s8nr+YBWfEOi+bRJ5dsOjVqU5ulBepAl2kUeia1VnKEsAnSZthtq/6Na0pgxTzJFEZKE
	 hi58Bq1xFh3yyZZPQYAgO2XED3eu86hQjSqMORW4OTaJgJFI1CFqW0OxmYbKL6yldZAmP
	 yNa5W+4s8Lus5ssplPrZb+6mfdBuMK9Rgj5pfxfRCP/bn3WUtD1rMkeg5coCuWyeGlLH2
	 eNk3X8+3hjsiDgro5rqCYTo4TTDYZyiEaOsWSAvrOecpQqhk6bQqVKBNExW7I9n4ApQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912550;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-FB-Internal:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=Nh/PNfZJ+4poa+/4MlOKZcsiZSQUMnjoP1xeoBQtGHs=;
	b=oA3G7j5MZXMrACPXYLMXFih7xz/WiUGTnvInfIfpKnE5sfd96LjBdQ7ThDbQMsdd3+4/
	 Apc1CkOBQSXPHbzKbbQQ0vSd7JW+Il7yRU2pXjrVggyoOx/1Fq8Mt7UH0Srei229RbV4F
	 K0C7tYN6Dsd8+DcFNleRt9cVp1vKYlM8blyvmWrwTg3CG68uL78Mj9pwPl519/k/lJr5P
	 TaW5sxORE6pURMlaioN6OfaU+UlEfCznRyqOh93KFmNCP8d0wTc8hHRUHlYPVnaI69FIe
	 S9rICnGW8VIC+/x6J9sd/3Q5Yy91MgE2WwbeSJgFSGFA3noCMcCasGAq3F2lF2lvb1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="NhbQ/54N";
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27E606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 21:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC27E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NhbQ/54N
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5L2Khx794341
	for <linux-pci@vger.kernel.org>; Thu, 5 Nov 2026 13:02:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=Nh/PNfZJ+
	4poa+/4MlOKZcsiZSQUMnjoP1xeoBQtGHs=; b=NhbQ/54NdkTTqYzT4zKGaqa7N
	dhTKqyKik6osO2OHCwsfUDXZFjj4MqYM5fXkmun8tkYV/ZC5LQDO+dyLtl1EbKg2
	N8JnOoJkUZLrke5Qhl5583kono1icC+lqrvfvXcmhY3JmN6ZFuESMgwKfbID/605
	IyJq1dMeTthVcA8T2oWljZgka4S5bTN0fCQXYL7wbVFfsXUfcpMcqgIJrWYmFt8E
	FAXUvpcC24oXo7698TpgfhL9JZCyedCik8Z4Em/INNUmJoD/3dZCpf9b+s5wtPnd
	QltcTIoHANEErB5/MN5sfOtSmjnuru6qmuF5o6Y/VfHq8aMFpZUBuEmC7imxg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrb4ehejf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 13:02:28 -0800 (PST)
Received: from twshared9449.02.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 21:02:27 +0000
Received: by devvm9890.eag0.facebook.com (Postfix, from userid 139328)
	id 247EB540BD2E; Thu,  5 Nov 2026 13:02:15 -0800 (PST)
From: Jennifer Chan <jenniferchan@meta.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jennifer Chan
	<jenniferchan@meta.com>, <stable@vger.kernel.org>
Subject: [PATCH] PCI: Add d3cold delay quirk for NVIDIA LR10 NVSwitch
Date: Thu, 5 Nov 2026 12:10:10 -0800
Message-ID: <20261105201010.2297078-1-jenniferchan@meta.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dk-j0afleBmw2WV0FOTsr9RgJlYMwrvg
X-Proofpoint-ORIG-GUID: dk-j0afleBmw2WV0FOTsr9RgJlYMwrvg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MyBTYWx0ZWRfX3/3bXDYToD/e
 PUzp0r0O2YFkgkc4512ENK/ew6gK3bq0RezaCWAZsqqO33H3NVieUcVtkj61uE+sgLt9dDxz9+e
 CiExFFqCf9mkx1DVe0HMtDw+HJO9kow=
X-Authority-Analysis: v=2.4 cv=DJ8acCNb c=1 sm=1 tr=0 ts=6aeceee5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=AQQVFG2uCnKRw25fG-IA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MyBTYWx0ZWRfX33tjhHSPTEUb
 QuH3pFBVnYeIJqgASwOrLMe0pqyMF9oO5FtV0q5dd63QJssJs2J5GhZ/kiwose4DTbidO/hAhjf
 UL9V2/JxB69NllNNLEZ85ItLG+ZH2Re7iSUzkG9fV/F+TUyxVA+ntMp7BmXIMe/MuBNaiBDQNgr
 SHPUbw9ih/Z1E456kUFxyWFtCAxTFLvdQ8a5SLAbw6vWumvZ6CnvWVNmtZcl34RCcs0qbF+KBJB
 pwTRFEP6oZ7/PhCO0MNYq5pmA26sRjo/MblrukwUuf2CEvL55mwRsEbmjlzOrlESsgs7DT4ewkg
 91PbFZjs4DtvqxJnRj4zx/P0M1G70IThD28mFhejsrvXGCFiVSw9jAiyKDn3MVZ5WJGJZjcObQk
 v8r8ha78ORlxpha9YWSd/wZ6Atm8kMUdmaeWLNEh91ZC2Tpd8ih+HJ0e/wYfYLU5Dpoq0tlwt48
 1yDrSpnjLNX4ZuEhBvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01

On a Supermicro HGX A100 system (X12DGO-6), each of the six LR10
NVSwitches (10de:1af1) sits alone behind a PLX PEX 8725 (10b5:8725)
downstream port.  "nvidia-smi -r" resets all GPUs: NVML unbinds the
switches from the nvidia-nvswitch driver, resets each one through sysfs
(reset_method "bus", a Secondary Bus Reset of its port) and binds them
again.  The PCI core waits 100 ms after the link comes back, the switch
answers config reads and the reset completes.  When nvidia-nvswitch then
probes the switches, one fails in pci_enable_device() with

  Unable to change power state from D3cold to D0, device inaccessible

four others fail to initialize with -EIO, and the NVSwitch fabric does
not come back.

The same systems recover every time on a kernel that sleeps 1 s after
each Secondary Bus Reset, as pci_reset_secondary_bus() did before commit
ac91e6980563 ("PCI: Unify delay handling for reset and resume").  Adding
a 1 s sleep before the link wait on the PEX 8725 ports of the failing
kernel fixes it too.  Config reads already succeed at that point, so
pci_dev_wait() does not cover it, and the switch's state there is not
known.

Give LR10 a 1 s d3cold_delay, so that pci_bridge_wait_for_secondary_bus()
waits 1 s after the downstream link comes up before the switch is used.
This adds 1 s to each LR10 reset (about 6 s to an "nvidia-smi -r" on
these systems) and to D3cold resume of its port.  Resets issued further
up the hierarchy keep the default delay.

Fixes: ac91e6980563 ("PCI: Unify delay handling for reset and resume")
Cc: stable@vger.kernel.org
Signed-off-by: Jennifer Chan <jenniferchan@meta.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..4a84095e736f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6569,12 +6569,14 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x=
0220, of_pci_make_dev_node);
  * after reset recovery or resume from D3cold:
  *
  * VideoPropulsion (aka Genroco) Torrent QN16e MPEG QAM Modulator
+ * NVIDIA LR10 NVSwitch (HGX A100)
  */
 static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
 {
 	pdev->d3cold_delay =3D 1000;
 }
 DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x1af1, pci_fixup_d3cold_d=
elay_1sec);
=20
 #ifdef CONFIG_PCIEAER
 static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
--=20
2.53.0-Meta

