Received: from mail-m19731110.qiye.163.com (mail-m19731110.qiye.163.com [220.197.31.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C63C3425
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447641; cv=none; b=hq/aNiX0es4GTdizKPiGH/UtqOmL+4NWucOSKGpaNprKjkPEEl4c4ZZYqws75y2DqSvFr+gMmEt3mKbLvy/AwHvNmeEMkCXvyaRD6TsJjUcADdV3F6OnQRr/cNvMGAMlLZpSMAUPkm2h10L+S9mPANwvbFuXQkxNOD/PBGbQSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447641; c=relaxed/simple;
	bh=4FCb24CvhhClq6VOBGDLqdutLB5eA1Z16ZdXpL0pvp8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cTF0zA2EPJVyeMefOgPhYCx5+LxLj+bmrEbTgVYYmMSriLX8E3RiNdBe+9vv1DDHfEMoHv+tFjbzSGH6qX5E0ToH8vzFVCr6Ofv3MA3S9ucQIYMCpm3Hysi6dnPtWMBAU/qn+0XWoTzTgz2SzhwYRkOIkFUmsybTwASMciPV0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DmXe5QQp; arc=none smtp.client-ip=220.197.31.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DmXe5QQp"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 504807775;
	Thu, 8 Oct 2026 16:05:18 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI/pwrctrl: Only destroy devices created by pwrctrl core
Date: Thu,  8 Oct 2026 16:05:00 +0800
Message-Id: <1791446700-100166-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa11a8b965903a4kunm6624b022d584d3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUtOTVYeSk1ITxhJGk
	5MSk1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DmXe5QQptOFRwCRBzCs3g31TZLWjxa5GJupHNCv1kler2r5+EBhNesE4T7OdusEv5pHE3bwSovl/5kdvrxSK+EhBaiySGI/Zb8whSzEJENlVzQULmB+jDAJITJ3OGb2wmq0wFtrAE+CKtteM4DQFAqGHd4vbbTHaivnCP7mZZGE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=WFNJbizeyYmGkrPzqUybTmyfWHBGmbmGnPT654zbEOA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pci_pwrctrl_create_device() only creates platform devices for OF nodes
that pci_pwrctrl_is_required() accepts, but pci_pwrctrl_destroy_device()
unregisters the platform device of every available child node without
that check.

Nodes under a PCI host controller that are not pwrctrl devices may have
been populated by another mechanism.  Destroying them here would tear
down devices owned by other code.

Mirror the check done at creation time so that only devices created by
the pwrctrl core are removed.

Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/pwrctrl/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 10d817a..c14df11 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -388,6 +388,9 @@ static void pci_pwrctrl_destroy_device(struct device_node *np)
 	for_each_available_child_of_node_scoped(np, child)
 		pci_pwrctrl_destroy_device(child);
 
+	if (!pci_pwrctrl_is_required(np))
+		return;
+
 	pdev = of_find_device_by_node(np);
 	if (!pdev)
 		return;
-- 
2.7.4

