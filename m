Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A573596EC
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164901; cv=none; b=j+CA0VsaoaaFosv1tExwhJ/upj/Ph1SPfQo4fOvRAtUqegXMbBrdmaNhKrLGEOrXhPCNyNxLisk0bBOMaYb7kQea69TVM2S2aEqhWyNFUI70bA7ldLh0hPqzpNTe6bheA4a/D0BapLwbyL82gV70i/mM0DpZleE6DGF7kMRbeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164901; c=relaxed/simple;
	bh=BlxJFuEvXJdNRfE6mEwRufDvigHI8H/m6FK4e/ESLHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KGCbnPiJForDeL+Wh7XjlT/R6Ya32IGELTkYhaYTbkVIIPge7RMF9Y97HUifJgp2NB1x0IPVE7ERZH0fBFYmpHMEwu0nRvt2LfBkb2kmgtNeWTLOLKLxcXVco+fVisNvXzCk7ufjU86VOVH+X7FHwfqm8APnawOzyGjkJ8gaQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1769164884-086e2306f936500002-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id zi7TNQI7lFCBKrup (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 23 Jan 2026 18:41:27 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 23 Jan
 2026 18:41:26 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Fri, 23 Jan 2026 18:41:26 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from HX007EA1.lan (10.32.64.5) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 23 Jan
 2026 18:40:34 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <mahesh@linux.ibm.com>, <oohall@gmail.com>, <bhelgaas@google.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>
Subject: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
Date: Fri, 23 Jan 2026 18:40:34 +0800
X-ASG-Orig-Subj: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
Message-ID: <20260123104034.429060-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/23/2026 6:41:25 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1769164884
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1355
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153451
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
amended PCIe hotplug to not bring down the slot upon Data Link Layer State
Changed events caused by Downstream Port Containment.

However, PCIe hotplug (pciehp) waits up to 4 seconds before assuming that
DPC recovery has failed and disabling the slot. This timeout period is
insufficient for some PCIe devices.
For example, the E810 dual-port network card driver needs to take over
10 seconds to execute its err_detected() callback.
Since this exceeds the maximum wait time allowed for DPC recovery by the
hotplug IRQ threads, a race condition occurs between the hotplug thread and
the dpc_handler() thread.

Signed-off-by: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..08b5f275699a 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -121,7 +121,7 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 	 * but reports indicate that DPC completes within 4 seconds.
 	 */
 	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
-			   msecs_to_jiffies(4000));
+			   msecs_to_jiffies(16000));
=20
 	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 }
--=20
2.43.0

