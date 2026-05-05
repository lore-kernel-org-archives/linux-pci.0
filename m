Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A63DE441;
	Tue,  5 May 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000442; cv=none; b=q5ML1bYmxNvPVPMk2Z4bSRC/9PWtdFhgtpNuybuMmqJoH0tcUG+3VJLQ7Nc/72tZYU3lB8nT8hAumVLx4W46W7MtHGwoUVeLcGwr+xSNirwPVvdZv4+xb8gmqB01vN96q39FcKdpn3iDO46ejzuLxfMw48Ktuqn99SvER83jYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000442; c=relaxed/simple;
	bh=yEy2Ni19fXAThxGH9F+EJAuKJTAgVsdxGGryKTOpxZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6PnJHhRtOThg/tQUTHfTKeU3JpdU7/6mtMBc1HMWdbHS2i/CmvxdSN6sXPeNwtdxGmLw/BK0zJcAd7MRD6B6S84SPVRRYPsZN/BPxvVYMeSxyrW6QdtttRz/RyoNhEYFfWXaP7Uvh39HoeWvOgx2+N5AA0a8Ku1W5HMzMNKmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/VseuhH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/VseuhH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778000441; x=1809536441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yEy2Ni19fXAThxGH9F+EJAuKJTAgVsdxGGryKTOpxZc=;
  b=Y/VseuhHhEkLZBjbixcLRqTQat1JdkSO6YhEKml8X9BFNhkc9EYZPyqj
   DOTJu4LjQ3l6ABNbAW0bez0jaiuTmg3lii3NJpsb1JmQsHdrh1iRfjL7D
   IYTl1DYRD8Xeqb4YMPpTBJKiib5bvJnRTbcqbfKD/f903C1DXq/iFBlHF
   cCIjMu8E9FwS2xcRPcpNnl9r4OF5HqijX966lRHReXlzeCH9TmE+ys7Pe
   DTo/SqXUnUM/55cgLj8BkDIPfRKCRID6Km8z08SSN6bu1KYW+VGqQZv3I
   ZthXE6OfxzaMC3DT4ZPpFMO7D3mnqzYaZlsUF2mI4ck45uGvvkmIRm/kf
   g==;
X-CSE-ConnectionGUID: DMsnFlNgTyWAOabqQc5eIg==
X-CSE-MsgGUID: Ilu6K8tMTvO+83uhdVHltg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77900541"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77900541"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:00:40 -0700
X-CSE-ConnectionGUID: UKPVYKjcTr61A44PIk3MYg==
X-CSE-MsgGUID: 41p1iy0vSHO5/xEQShGXTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259211464"
Received: from soc-5cg43972f8.clients.intel.com (HELO localhost) ([172.28.182.189])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:00:37 -0700
From: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-xe@lists.freedesktop.org,
	Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
Subject: [PATCH 2/3] PCI/IOV: Restore initial VF ReBAR sizes on SR-IOV disable/failure
Date: Tue,  5 May 2026 19:00:09 +0200
Message-ID: <20260505170010.3414074-3-marcin.bernatowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
References: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PF drivers can resize a VF BAR via pci_iov_vf_bar_set_size(). The new
size persists in config space. A subsequent reprobe/unplug-rescan may
then cause the PCI core to reserve MMIO based on the inflated VF BAR
registers in the SR-IOV capability, often multiplied by TotalVFs.
On platforms with tight apertures, later SR-IOV enable can fail due to
lack of space.

Restore the initial VF BAR sizes saved at SR-IOV init time when SR-IOV
is disabled and when SR-IOV enable fails. Restore is only performed
when VF Memory Space is disabled, which is the precondition of
pci_iov_vf_bar_set_size() and is true at all the new call sites.

Note: this changes user-visible behavior for drivers that rely on the
resized VF BAR persisting across an enable/disable cycle. After this
change drivers must call pci_iov_vf_bar_set_size() before each
pci_enable_sriov() if a non-default size is desired.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5937
Signed-off-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
---
 drivers/pci/iov.c | 61 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 19f4dca4eec1..42b935265b3c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -646,6 +646,40 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	return rc;
 }
 
+static void sriov_restore_vf_rebar_initial_sizes(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+	int i;
+
+	if (!iov || !iov->vf_rebar_cap)
+		return;
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		int resno = pci_resource_num_from_vf_bar(i);
+		resource_size_t orig_sz = iov->barsz_orig[i];
+		resource_size_t cur_sz = iov->barsz[i];
+		int size, cur, rc;
+
+		if (!orig_sz || cur_sz == orig_sz)
+			continue;
+
+		size = pci_rebar_bytes_to_size(orig_sz);
+		rc = pci_iov_vf_bar_set_size(dev, resno, size);
+		if (!rc)
+			continue;
+
+		pci_warn(dev, "failed to restore %s size %#llx -> %#llx: %d\n",
+			 pci_resource_name(dev, resno),
+			 (unsigned long long)cur_sz,
+			 (unsigned long long)orig_sz, rc);
+
+		/* Re-sync in-memory size with what hardware actually has. */
+		cur = pci_rebar_get_current_size(dev, resno);
+		if (cur >= 0)
+			iov->barsz[i] = pci_rebar_size_to_bytes(cur);
+	}
+}
+
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
 	int rc;
@@ -687,36 +721,42 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	}
 	if (nres != iov->nres) {
 		pci_err(dev, "not enough MMIO resources for SR-IOV\n");
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_restore;
 	}
 
 	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
 	if (bus > dev->bus->busn_res.end) {
 		pci_err(dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
 			nr_virtfn, bus, &dev->bus->busn_res);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_restore;
 	}
 
 	if (pci_enable_resources(dev, bars)) {
 		pci_err(dev, "SR-IOV: IOV BARS not allocated\n");
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_restore;
 	}
 
 	if (iov->link != dev->devfn) {
 		pdev = pci_get_slot(dev->bus, iov->link);
-		if (!pdev)
-			return -ENODEV;
+		if (!pdev) {
+			rc = -ENODEV;
+			goto err_restore;
+		}
 
 		if (!pdev->is_physfn) {
 			pci_dev_put(pdev);
-			return -ENOSYS;
+			rc = -ENOSYS;
+			goto err_restore;
 		}
 
 		rc = sysfs_create_link(&dev->dev.kobj,
 					&pdev->dev.kobj, "dep_link");
 		pci_dev_put(pdev);
 		if (rc)
-			return rc;
+			goto err_restore;
 	}
 
 	iov->initial_VFs = initial;
@@ -758,6 +798,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
 	pci_iov_set_numvfs(dev, 0);
+	sriov_restore_vf_rebar_initial_sizes(dev);
+	return rc;
+
+err_restore:
+	/* pcibios_sriov_enable() was not called on these early-exit paths. */
+	sriov_restore_vf_rebar_initial_sizes(dev);
 	return rc;
 }
 
@@ -791,6 +837,7 @@ static void sriov_disable(struct pci_dev *dev)
 
 	iov->num_VFs = 0;
 	pci_iov_set_numvfs(dev, 0);
+	sriov_restore_vf_rebar_initial_sizes(dev);
 }
 
 static int sriov_init(struct pci_dev *dev, int pos)
-- 
2.43.0

