Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3882C1788;
	Sun,  1 Mar 2026 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329419; cv=none; b=dT6E1ujXf5S+OwnEeSxiK8P6BN1fuY1ZP0WIei9LpVV61QVSu33F51iCThDZYGnXfuzGChBWs3DG+aW5dmzBmOMktrU32SwRxM65TANkmizcByQImln+FqJ8wMnydoeO8VaXRKfmJl3AQataxWcUVVeWbf7BKfSZK0yGW1ww4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329419; c=relaxed/simple;
	bh=lyBxLh9LnsM2texUtGYbGBBSF2aTYDOF6E2zcP8GGXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xeq99kcgdbFDjiY1Gp3wXQx43hJbeFF3Bwks+6IkuJSEb24IcAXvhNHYEjRpSllvNswW3tAp6c8Ke+8+tzjB95CcdXhzxrRZWlbZeCtSk+C8KyGFg1GdLU2/adohC7ffO9j8q5LzCoE4RLdSauLT+qiBDPFuCNTYwA00/oo2ry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+9mYhEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+9mYhEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DDCC19421;
	Sun,  1 Mar 2026 01:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329419;
	bh=lyBxLh9LnsM2texUtGYbGBBSF2aTYDOF6E2zcP8GGXk=;
	h=From:To:Cc:Subject:Date:From;
	b=n+9mYhEOku0QvXAwUg8AZrK2UbPcwoJUWsmNucrzKOcPJGtSkyKp6Df+sHGbwHuMz
	 yu46asT4EO5iPhmGNoT3wun4qJcIGgbV8CfxlWCdCsOX5+ionovsWHd9I9dDhNDLgZ
	 //64tRW5+fVZlJmwQA8WFF/s3BdPyrVRPhKk21caMnf5TJlT8/SZ2aj6lJV+e9z/AK
	 1EalZgdWj5StsJA5IVhkgKfDUmdYukN3QxGUgXsRYun3qo0v/BdfwZdJaBunOvjECV
	 2BHydvvR+ojaLplWXdTEwPqly+Lsu7NYplnYQK2EMpRNHlZzDQxaEwL0NDS8tFMmOm
	 MbLxXgKusn4tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mmaddireddy@nvidia.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: endpoint: Fix swapped parameters in pci_{primary/secondary}_epc_epf_unlink() functions" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:43:36 -0500
Message-ID: <20260301014337.1705741-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8754dd7639ab0fd68c3ab9d91c7bdecc3e5740a8 Mon Sep 17 00:00:00 2001
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Date: Thu, 8 Jan 2026 11:57:47 +0530
Subject: [PATCH] PCI: endpoint: Fix swapped parameters in
 pci_{primary/secondary}_epc_epf_unlink() functions

struct configfs_item_operations callbacks are defined like the following:

  int (*allow_link)(struct config_item *src, struct config_item *target);
  void (*drop_link)(struct config_item *src, struct config_item *target);

While pci_primary_epc_epf_link() and pci_secondary_epc_epf_link() specify
the parameters in the correct order, pci_primary_epc_epf_unlink() and
pci_secondary_epc_epf_unlink() specify the parameters in the wrong order,
leading to the below kernel crash when using the unlink command in
configfs:

  Unable to handle kernel paging request at virtual address 0000000300000857
  Mem abort info:
  ...
  pc : string+0x54/0x14c
  lr : vsnprintf+0x280/0x6e8
  ...
  string+0x54/0x14c
  vsnprintf+0x280/0x6e8
  vprintk_default+0x38/0x4c
  vprintk+0xc4/0xe0
  pci_epf_unbind+0xdc/0x108
  configfs_unlink+0xe0/0x208+0x44/0x74
  vfs_unlink+0x120/0x29c
  __arm64_sys_unlinkat+0x3c/0x90
  invoke_syscall+0x48/0x134
  do_el0_svc+0x1c/0x30prop.0+0xd0/0xf0

Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
[mani: cced stable, changed commit message as per https://lore.kernel.org/linux-pci/aV9joi3jF1R6ca02@ryzen]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260108062747.1870669-1-mmaddireddy@nvidia.com
---
 drivers/pci/endpoint/pci-ep-cfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 43feb6139fa36..8b392a8363bb1 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -68,8 +68,8 @@ static int pci_secondary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
-					 struct config_item *epf_item)
+static void pci_secondary_epc_epf_unlink(struct config_item *epf_item,
+					 struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
@@ -132,8 +132,8 @@ static int pci_primary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
-				       struct config_item *epf_item)
+static void pci_primary_epc_epf_unlink(struct config_item *epf_item,
+				       struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
-- 
2.51.0




