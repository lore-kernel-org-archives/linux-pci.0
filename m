Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com [45.254.49.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CAA37F00D;
	Thu, 16 Apr 2026 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776323566; cv=none; b=EPMZhZni/ugRNMf2uGwjKMKhz7ZDEbAXlaoXMrq9k4iUnOijq09QbZD6/0Xbvtt4Ly0djrhe1QgSDJ4kLKdNF6P79vmHAHYg+iHM0dF2WlLHuc1CFG0FTVgd7JII9oWNiTO2i8pHsPa/Qa/owsq1zxhH5vPc6rPa0EwCtrCa+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776323566; c=relaxed/simple;
	bh=DGoUtmfUyJA820hOjw4yi3q4y8EGWylhVe7SKv4s89k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=El4ZAh96iquWjFFuYgriOypVYl3inc0FtvrAy/zzZk7zZIxkOhbaOAWlN2rKL9ZGYOR6eDltoDi93rYw5W0iN5PzwRlobF/eIdu4xKscYKxkjQNSfbRbJjnMUrwNt2UnMeiW6ChO9SooX7CAtyagHpOYQzOcGFqxwLUhTpwxN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=SKBOGdYW; arc=none smtp.client-ip=45.254.49.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="SKBOGdYW"
Received: from yuangap.. (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 18fc72fa3;
	Thu, 16 Apr 2026 15:07:26 +0800 (GMT+08:00)
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "yuan.gao" <yuan.gao@ucloud.cn>
Subject: [PATCH] PCI: Avoid FLR for NVIDIA 5090 GPU
Date: Thu, 16 Apr 2026 15:07:06 +0800
Message-Id: <20260416070707.3242381-1-yuan.gao@ucloud.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d951dba860229kunm87b7e6a7dff59
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTElMVkIdH0lMSx5CQxlKHVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSEtKSE1VSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SKBOGdYWTW2GqidaVwTyFFLXpmLMm0Rlr2hYPFhLYJNEV0Kz7eOK5FPeC0xM9pwJabXJVBtzT4lO503LySi2Zix+R5wRA1YkMVcGNpRJVU2jWcg3rjYgv9N9ob81yXrAcaMahrQ/m7eiqe6XnaK1YxZeulQ4WawIOK0/DAsXVps=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=sNStje91iAC4EO4tWOP9oKrQHdpAKriZjxYmfZ0ZIKE=;
	h=date:mime-version:subject:message-id:from;

When passing through the NVIDIA 5090 GPU to a vm, there is a certain
probability of encountering an flr timeout during vm shutdown, which
subsequently leads to a soft lock of the host cpu.

As described in this post
(https://forum.level1techs.com/t/do-your-rtx-5090-or-general-rtx-50-series-has-reset-bug-in-vm-passthrough/228549).

And in dmesg:

 [401106.011979] vfio-pci 0000:d8:00.0: not ready 1023ms after FLR; waiting
 [401108.700074] vfio-pci 0000:d8:00.0: not ready 2047ms after FLR; waiting
 [401112.412204] vfio-pci 0000:d8:00.0: not ready 4095ms after FLR; waiting
 [401118.620399] vfio-pci 0000:d8:00.0: not ready 8191ms after FLR; waiting
 [401128.860788] vfio-pci 0000:d8:00.0: not ready 16383ms after FLR; waiting
 [401147.293518] vfio-pci 0000:d8:00.0: not ready 32767ms after FLR; waiting
 [401185.694859] vfio-pci 0000:d8:00.0: not ready 65535ms after FLR; giving up
 [401195.372583] vfio-pci 0000:38:00.2: Relaying device request to user (#0)

 [401208.274941] watchdog: BUG: soft lockup - CPU#11 stuck for 21s! [CPU 22/KVM:30337]

 [401209.887848] CPU: 11 PID: 30337 Comm: CPU 22/KVM Kdump: loaded Not tainted
 [401209.887854] RIP: 0010:pci_mmcfg_read+0xaa/0xd0

 [401209.887866] Call Trace:
 [401209.887872]  pci_bus_read_config_dword+0x43/0x70
 [401209.b887876]  pci_find_next_ext_capability.part.20+0x65/0xc0
 [401209.887879]  pci_restore_state.part.39+0x6d/0x3f0
 [401209.887883]  vfio_pci_disable+0x22b/0x4d0 [vfio_pci]
 [401209.887886]  ? __dentry_kill+0x118/0x160
 [401209.887888]  vfio_pci_release+0x5a/0xb0 [vfio_pci]
 [401209.887891]  vfio_device_fops_release+0x18/0x30 [vfio]
 [401209.887894]  __fput+0x98/0x240
 [401209.887897]  task_work_run+0x6a/0xa0
 [401209.887899]  do_exit+0x375/0xb10
 [401209.887900]  do_group_exit+0x3a/0xa0
 [401209.887902]  get_signal+0x140/0x7d0
 [401209.887906]  arch_do_signal+0x2c/0x260
 [401209.887909]  exit_to_user_mode_prepare+0xc0/0x120
 [401209.887912]  syscall_exit_to_user_mode+0x27/0x180
 [401209.887915]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The flr seems to have some issues on the NVIDIA 5090 GPU,
so I’ve added flr-related quirks for these devices.

And with this patch in place, the host kernel doesn't exhibit these
problems. The vm starts up and works as expected with the passed-through
NVIDIA 5090 GPU.

Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
---
 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be72..71f833f3e2d84 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5618,6 +5618,9 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x2b85, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x2b87, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x2b8c, quirk_no_flr);
 
 /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
 static void quirk_no_flr_snet(struct pci_dev *dev)
-- 
2.32.0

