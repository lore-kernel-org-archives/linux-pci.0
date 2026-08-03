Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2331386C0A;
	Mon,  3 Aug 2026 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753026; cv=none; b=aULGzkQLYd90zwbSihz6uXQ71JHZWRBPsvCp7o81EclsuYvHh/33lFJaDUVWhjtEHZm55Ot/SnhbuKLEEE/9L69t9jslJWets+AuWqTguZt1ozHLw86em1CiLoap0CiE6SG3Bpc9jScbZP9EiNmxxcpfLV4pSaAOcEDfF532YSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753026; c=relaxed/simple;
	bh=ziAp1mnde7H3MaUN5dqlCIeSsUbwfTYMy5TP04p+19M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcMl6HpV0MlZL7jXMxxayWI0HwbBshVZFwRg9wsSpSie/9v9gTxz/OCqUOPK/7be3nZd1ZhD2fgPsPAEhP8AQqKrSaNaAt4CmbhwFBVnby7I5vKgAS9ftpbsw48iq/Db0S8n+/bj062WuPRMQm1Mcmha2EnBzJxyUsw0oi/01k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEApntbT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEApntbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785753025; x=1817289025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ziAp1mnde7H3MaUN5dqlCIeSsUbwfTYMy5TP04p+19M=;
  b=bEApntbTGFwRw31x4HjuWTFzRKde1kLWNPCLmEepdmU2t3WJr1Noyfr4
   W3DvdWenavtQ4qDvJk2WN7peM2TAxViFn8RJSGhQwcAMkLXD0R23MPt2U
   duihdPOLULZpSALsFHlGUQ1AKtT3xEYc0aCVQl9HsxyKqPrxJjnuUKUc1
   0KIR9kMLTPfLCFO4JOHhEjQNtgDkTJGt73zSD9hg8UtYzty9bWvXJ1SlU
   0jl2I107b/2UmfUpbjA/fV6tZCcorKghwhocj0b8meDxA7xTUgzgKFnWF
   9kco1WYTHsHxKK0kDWvj3MQ0Q7TB9uNhDM2pwuaFq46INMW2MZgXUmFd2
   w==;
X-CSE-ConnectionGUID: 4HFKpkhLQv+CQa06fMTpoQ==
X-CSE-MsgGUID: rdugRCp4SRm98tyNOBUPjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="97446131"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="97446131"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:25 -0700
X-CSE-ConnectionGUID: C2vhqzKSTn6uSiS+x2bXHg==
X-CSE-MsgGUID: KPw2AzVvQ0GN3CztIof6xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="284566538"
Received: from soc-5cg43972f8.clients.intel.com (HELO localhost) ([172.28.182.68])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:22 -0700
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
	intel-xe@lists.freedesktop.org
Subject: [PATCH v2 2/3] PCI/IOV: Restore initial VF ReBAR sizes on SR-IOV disable/failure
Date: Mon,  3 Aug 2026 12:30:06 +0200
Message-ID: <20260803103007.209625-3-marcin.bernatowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
References: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
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
is disabled and when SR-IOV enable fails. This covers both the resource
allocation failures later in sriov_enable() and the earlier validation
failures that can otherwise leave a resized VF BAR in hardware while
num_VFs remains zero.

Restore is only performed when VF Memory Space is disabled, which is the
precondition of pci_iov_vf_bar_set_size() and is true at all the new
call sites.

Note: this changes user-visible behavior for drivers that rely on the
resized VF BAR persisting across an enable/disable cycle. After this
change drivers must call pci_iov_vf_bar_set_size() before each
pci_enable_sriov() if a non-default size is desired.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5937
Signed-off-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
---
 drivers/pci/iov.c | 79 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ae9309fc6dd7..999938163ce9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -646,6 +646,46 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	return rc;
 }
 
+static void sriov_restore_vf_rebar_initial_sizes(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+	u16 ctrl;
+	int i;
+
+	if (!iov || !iov->vf_rebar_cap)
+		return;
+
+	/* Skip if device is inaccessible (surprise-removed, D3cold). */
+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
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
@@ -666,12 +706,16 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_INITIAL_VF, &initial);
 	if (initial > iov->total_VFs ||
-	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (initial != iov->total_VFs)))
-		return -EIO;
+	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (initial != iov->total_VFs))) {
+		rc = -EIO;
+		goto err_restore;
+	}
 
 	if (nr_virtfn < 0 || nr_virtfn > iov->total_VFs ||
-	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (nr_virtfn > initial)))
-		return -EINVAL;
+	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (nr_virtfn > initial))) {
+		rc = -EINVAL;
+		goto err_restore;
+	}
 
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
@@ -687,36 +731,42 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
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
@@ -758,6 +808,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
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
 
@@ -791,6 +847,7 @@ static void sriov_disable(struct pci_dev *dev)
 
 	iov->num_VFs = 0;
 	pci_iov_set_numvfs(dev, 0);
+	sriov_restore_vf_rebar_initial_sizes(dev);
 }
 
 static int sriov_init(struct pci_dev *dev, int pos)
-- 
2.43.0

