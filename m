Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1151411FB6;
	Tue,  4 Aug 2026 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813908; cv=none; b=Boljya0o1rACVj2jB0hMKAHESHjo6+t9R2gj/mnUKsJUCQf7ZQCr/z4IxMJhdIhnOHPzXJd4F3urUaOe22YXhd1ZKmmQRc5PEyZQTmTHmiEpGSI7mbi3GLK0fGyMYw3C4ZWk3+CybF0ciXrrlDqzidoLXq6EAY1MMbjAAkAqSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813908; c=relaxed/simple;
	bh=/6CYNuKh0bv/i5h06cVrNPdF1hRVSMacJDUcrHOlH8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MmxTxV4JniBuSnBEG0oARQKVCsZJBevLbR23ScIK+1lybCdqcgg39VNDgmr8quYKPavu+U8Sl+Ua3dIoHmVn9EGTEW/ALc+4CSRcCGvopPWh0irssBoUsiZaFY3C3s8UBX2K/JAyGOf6axDLhCQL9+X7ncW0B2qKdVoyFgYMtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 11ddbda88fb411f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:149415bf-4db8-4142-bc5f-a9c9e19de0be,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:6210addfce5dc955a25ce6429bf991c8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 11ddbda88fb411f1aa26b74ffac11d73-20260804
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1985487747; Tue, 04 Aug 2026 11:24:58 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] PCI: switchtec: Fix use-after-free in switchtec_pci_remove due to race condition
Date: Tue,  4 Aug 2026 11:24:54 +0800
Message-Id: <6fdcbfa869f707cad783c7f92d1681f0a2bd9a7c.1785813784.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In stdev_create, &stdev->mrpc_work is bound with mrpc_event_work, and
&stdev->link_event_work is bound with link_event_work. The IRQ handlers
switchtec_event_isr and switchtec_dma_mrpc_isr can schedule these works
on system_wq (via schedule_work() in the ISRs and via
check_link_state_events()).

If we remove the device, switchtec_pci_remove makes cleanup and the
memory allocated for stdev is released by put_device() ->
stdev_release() -> kfree(stdev), while the works mentioned above may
still be pending or running. The sequence of operations that may lead
to a UAF bug is as follows:

CPU0                                      CPU1

                                          | switchtec_event_isr
                                          | schedule_work(&stdev->mrpc_work)
switchtec_pci_remove                      |
cdev_device_del(&stdev->cdev,             |
                &stdev->dev)              |
stdev_kill(stdev)                         |
switchtec_exit_pci(stdev)                 |
pci_dev_put(stdev->pdev)                  |
put_device(&stdev->dev)                   |
// stdev_release -> kfree(stdev)          |
                                          | mrpc_event_work
                                          | // use stdev (use-after-free)

Fix it by canceling the works after the sources that can schedule them
have been stopped: stdev_kill() first clears PCI bus mastering, which
prevents the MSI/MSI-X based IRQ handlers from firing and scheduling
new works, and the works are then canceled before the remaining
cleanup and the release of stdev. This also covers the probe error
path, which calls stdev_kill().

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Fixes: 48c302dc8f3a ("NTB: switchtec: Add link event notifier callback")
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/pci/switch/switchtec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5711aaa5df11..f339ea54aa38 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1319,6 +1319,8 @@ static void stdev_kill(struct switchtec_dev *stdev)
 	pci_clear_master(stdev->pdev);
 
 	cancel_delayed_work_sync(&stdev->mrpc_timeout);
+	cancel_work_sync(&stdev->mrpc_work);
+	cancel_work_sync(&stdev->link_event_work);
 
 	/* Mark the hardware as unavailable and complete all completions */
 	scoped_guard (mutex, &stdev->mrpc_mutex) {
-- 
2.25.1

