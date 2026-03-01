Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABF13D53C;
	Sun,  1 Mar 2026 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330589; cv=none; b=smOY/kc3OpXHuD9MGYX8SibZN3fLXHvMMBdzZmQ94x6Q86F3ToPKcc4bYp4WIPJNypYi6C6GhFmnb+JTeFYHJky/Z8iikumGVf+UZtRpL5StugiYNyohCLrMlZUK+cP5BDoRAytQNzS5hISz7D0fzPfvnyBaMGpCQaX96KfArqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330589; c=relaxed/simple;
	bh=XB05lwxTfxDXIuf0adnu+N8fNeJE0Ligb1eERfvUHfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QA60ynT4bQUbxE/EPcQo+/qIPEf1KFgGbGIdQyHQPPOSgv+0O5gVoIhbRBXE+gokKFemA0/sGaFdjtrFro10tN3mRy5qj9AM2IcZM9Lv3N/v623c+8SeEFfX9s7Sc3L0T1DOGlZLeDqzHVjQ9TxCIJ0wdQ5EiHExZjO8m1J8OMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2wT10dC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2wT10dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5621BC19425;
	Sun,  1 Mar 2026 02:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330589;
	bh=XB05lwxTfxDXIuf0adnu+N8fNeJE0Ligb1eERfvUHfg=;
	h=From:To:Cc:Subject:Date:From;
	b=J2wT10dCeUb1NXOjzOVFzw4YTkTVcQZOvQo2IytASHwV6MZnqbZ0WuHJWD1Kx8OL6
	 n1GxJsWy2PpdgGdWPfxpVyc2g47EVbrGwnLdQcKbJ4YuhrESORv6kRsFuTesGywwET
	 Uez1IaGQbO2JdlzJWSvUnjweKSK3RV2r10lSIRXm7fLtnI9iPLEia5gu284xKNTgmV
	 m2IrFVNZv6hI3zJtsSjSRG18b5LTqAaFSguWh8Ui2I7boXNbpFymgMPF4e1If4NUcy
	 VvM6CnJQrOGbWrN74AqyXmw+QMhyiuQn4EwfDK7DEQyfNM3bZNT+aQ7yYOIDtPX11Z
	 WAPeYihLPj1KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Benjamin Block <bblock@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI/IOV: Fix race between SR-IOV enable/disable and hotplug" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:03:06 -0500
Message-ID: <20260301020307.1731096-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a5338e365c4559d7b4d7356116b0eb95b12e08d5 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 16 Dec 2025 23:14:03 +0100
Subject: [PATCH] PCI/IOV: Fix race between SR-IOV enable/disable and hotplug

Commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
enabling/disabling SR-IOV") tried to fix a race between the VF removal
inside sriov_del_vfs() and concurrent hot unplug by taking the PCI
rescan/remove lock in sriov_del_vfs(). Similarly the PCI rescan/remove lock
was also taken in sriov_add_vfs() to protect addition of VFs.

This approach however causes deadlock on trying to remove PFs with SR-IOV
enabled because PFs disable SR-IOV during removal and this removal happens
under the PCI rescan/remove lock. So the original fix had to be reverted.

Instead of taking the PCI rescan/remove lock in sriov_add_vfs() and
sriov_del_vfs(), fix the race that occurs with SR-IOV enable and disable vs
hotplug higher up in the callchain by taking the lock in
sriov_numvfs_store() before calling into the driver's sriov_configure()
callback.

Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com
---
 drivers/pci/iov.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 7de5b18647beb..4a659c34935e1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,7 +495,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
+		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
+		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -507,7 +509,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
+	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
+	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 
-- 
2.51.0




