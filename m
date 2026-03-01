Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B99284662;
	Sun,  1 Mar 2026 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328377; cv=none; b=ClIGLu9t8fUdf+YE3v7CBAWKD5arhLdcaNzjDfE0hasgM/OPs5VjMYG79t8p6LOaWxGPuOvfnpDmJgUdoenqzG/gQa6ixqzSFEUKu6Xst4ajNpP4JBY7UriqtKTL9/wf9xetkjGFF2HmVJJcUqMdc4mBq5eeqrT+TAxOl1y/284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328377; c=relaxed/simple;
	bh=KVnB3KDWT3XfCReNQqFvHfNyFlMclP+Hyk7wV/COcjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ef0im85FTdulyZOGPzJZ8PSoblseCkZMWyDGc5Pv0uDRDuAW4q4f7OA36/Za1FndC1u4FLah23pkpktbE27F9Z+FnTJ4knVtmoUz/MLRNofrszLhjk8J1R58wcP3XOz1nmSpu48w2vXQj7W5NjF/KZgHw9O6tb9pOYzNWm0Zklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScY87Ejp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScY87Ejp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E28CC19421;
	Sun,  1 Mar 2026 01:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328377;
	bh=KVnB3KDWT3XfCReNQqFvHfNyFlMclP+Hyk7wV/COcjE=;
	h=From:To:Cc:Subject:Date:From;
	b=ScY87EjpdUSptvjygvFhdy2dp7q8aPqIBOp4aeGEB8DsJ4Gc/Fjxrs+6RojCrGSF/
	 2frEE9Qn2ctr+iy1Hgz2Fx2/CxUr4aNTCh/8lEOSt2Bqkxz2ZACLTCTnG3iLgnaQFi
	 NA+n0D/Zwtx3GXn740RygNOQ6b/Zs2puSKlNYAASVNcBd3iotQlC1ybX6wc11t0T0I
	 6weZZE0y4Aerqc4llJHAl/LpiFBN3iYYB2QvMzN0ydbSt3J3U/kJIuGTw5BNGOi7u0
	 Z4A1hGdmGRwPB7tR98bhdc4fq3SopubEEhmCVhfZP4wKwL0Xr+xUd2XXHajUGA0MBh
	 OXJdGAfw2IRag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	guojinhui.liam@bytedance.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: Fix pci_slot_trylock() error handling" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:26:15 -0500
Message-ID: <20260301012615.1683635-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9368d1ee62829b08aa31836b3ca003803caf0b72 Mon Sep 17 00:00:00 2001
From: Jinhui Guo <guojinhui.liam@bytedance.com>
Date: Fri, 12 Dec 2025 22:55:28 +0800
Subject: [PATCH] PCI: Fix pci_slot_trylock() error handling

Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
delegates the bridge device's pci_dev_trylock() to pci_bus_trylock() in
pci_slot_trylock(), but it forgets to remove the corresponding
pci_dev_unlock() when pci_bus_trylock() fails.

Before a4e772898f8b, the code did:

  if (!pci_dev_trylock(dev)) /* <- lock bridge device */
    goto unlock;
  if (dev->subordinate) {
    if (!pci_bus_trylock(dev->subordinate)) {
      pci_dev_unlock(dev);   /* <- unlock bridge device */
      goto unlock;
    }
  }

After a4e772898f8b the bridge-device lock is no longer taken, but the
pci_dev_unlock(dev) on the failure path was left in place, leading to the
bug.

This yields one of two errors:

  1. A warning that the lock is being unlocked when no one holds it.
  2. An incorrect unlock of a lock that belongs to another thread.

Fix it by removing the now-redundant pci_dev_unlock(dev) on the failure
path.

[Same patch later posted by Keith at
https://patch.msgid.link/20260116184150.3013258-1-kbusch@meta.com]

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251212145528.2555-1-guojinhui.liam@bytedance.com
---
 drivers/pci/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31f..59319e08fca61 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5346,10 +5346,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		if (!dev->slot || dev->slot != slot)
 			continue;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
 		} else if (!pci_dev_trylock(dev))
 			goto unlock;
 	}
-- 
2.51.0




