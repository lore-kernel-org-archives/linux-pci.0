Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD482324B0C
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184488; cv=none; b=jLIAMj3v+YkBf9kN9fCwjmAxuaq2UEtjhzoRrOtNJcnKfoSYYEwdQudtJb16sE32xh/llkdNALsfZsq2hBun5Q+hbQHmW8323VFVFGNGI03QPluPyn90ds0sXahKyv+Jcrbzc2YkY25BR0K18MwPveAPaUlWL6xLYFmNYVRXHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184488; c=relaxed/simple;
	bh=KzQSc10mg49D7pNMOH7LAFPa3VsHh1YqsvoC/K2QRBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iKw7CnI0kE2h7LA2xyyIPBQFa0gm3lCwQ0f5ZEQamGGjVG5+kp6zg+XcoGefNt6JU6oRcSQfpSJSH9jUwKvRn3OOyPlrxNYYPpp6vR4nhDpryNVFNIsotZ57znRiU8VBt6J/IwtnY8CJUcMVNOvsMQfdeiwx2LeXyEV9TbUQauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1770184481-086e2306f656ed0001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id phGCJUvNjH60FnHe (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 04 Feb 2026 13:54:41 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 4 Feb
 2026 13:54:40 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Wed, 4 Feb 2026 13:54:40 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from HX007EA1.lan (10.32.64.12) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 4 Feb
 2026 11:55:42 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <leoliu-oc@zhaoxin.com>
CC: Oliver O'Halloran <oohall@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<CobeChen@zhaoxin.com>, <ErosZhang@zhaoxin.com>, <TonyWWang@zhaoxin.com>
Subject: [PATCH v2] PCI: dpc: Increase pciehp waiting time for DPC recovery
Date: Wed, 4 Feb 2026 11:55:42 +0800
X-ASG-Orig-Subj: [PATCH v2] PCI: dpc: Increase pciehp waiting time for DPC recovery
Message-ID: <20260204035542.53232-1-LeoLiu-oc@zhaoxin.com>
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
X-Moderation-Data: 2/4/2026 1:54:39 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1770184481
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3433
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.154017
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiu-oc <leoliu-oc@zhaoxin.com>

Commit a97396c6eb13 ("PCI: pciehp: Ignore Link Down/Up caused by DPC")
amended PCIe hotplug to not bring down the slot upon Data Link Layer State
Changed events caused by Downstream Port Containment.

Commit c3be50f7547c ("PCI: pciehp: Ignore Presence Detect Changed caused by
DPC") sought to ignore Presence Detect Changed events occurring as a side
effect of Downstream Port Containment. These commits await recovery from
DPC and then clears events which occurred in the meantime.

However, pciehp_ist() waits up to 4 seconds before assuming that DPC
recovery has failed and disabling the slot. This timeout period is
insufficient for some PCIe devices.

For example, The execution of the ice_pci_err_detected() in the ice network
card driver exceeded the maximum waiting time for DPC recovery, causing the
pciehp_disable_slot() to be executed which is not needed. From the user's
point of view, you will see that the ice network card may not be usable and
could even cause more serious errors, such as a kernel panic. kernel panic
is caused by a race between pciehp_disable_slot() and pcie_do_recovery().
In practice, we would observe that the ice network card is in an
unavailable state and a kernel panic.

Therefore, we need to increase the time that pciehp_ist() waits for the DPC
to recover. For some PCIe devices, the time taken for the error_detected()
to execute may exceed 16 seconds, but the dpc_reset_link() has not yet been
executed. In this situation, the Link Down/Up events and Presence Detect
Changed events that occur during the DPC recovery should also be ignored.

Signed-off-by: LeoLiu-oc <leoliu-oc@zhaoxin.com>

---
v2:
 - Modify and add code comments
 - Add handling for error_detected() execution exceeding 16s

v1: https://lore.kernel.org/all/20260123104034.429060-1-LeoLiu-oc@zhaoxin.c=
om/
---
 drivers/pci/pcie/dpc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..331d0299af6a 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -103,6 +103,7 @@ static bool dpc_completed(struct pci_dev *pdev)
 bool pci_dpc_recovered(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host;
+	u16 status;
=20
 	if (!pdev->dpc_cap)
 		return false;
@@ -118,10 +119,22 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 	/*
 	 * Need a timeout in case DPC never completes due to failure of
 	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
-	 * but reports indicate that DPC completes within 4 seconds.
+	 * but reports indicate that DPC completes within 16 seconds.
 	 */
 	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
-			   msecs_to_jiffies(4000));
+			   msecs_to_jiffies(16000));
+
+	/*
+	 * In some cases, the execution time of report_error_detected()
+	 * exceeded 16 seconds, and dpc_reset_link() was still waiting to
+	 * be executed. This situation should be treated as successful dpc
+	 * recovery.
+	 */
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
+	if ((!PCI_POSSIBLE_ERROR(status)) && (status & PCI_EXP_DPC_STATUS_TRIGGER=
)) {
+		pci_warn(pdev, "DPC: error_detected() callback timed out\n");
+		return true;
+	}
=20
 	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 }
--=20
2.43.0

