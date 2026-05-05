Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B542492195;
	Tue,  5 May 2026 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000456; cv=none; b=hVpP6z21AGqvSUU8W+nta5jF9KyS/E/E3iCUt3PBXvtQjKrVBnH+ovR4WDS8EVB7oz8/RRYfGW9d9kcJudoaxZsl2yEPtysNqM5vPbagNRrBoZfndrOjzwcbFNqzaaDrQRiTs3/wB/ZJbeVg2XX8I0fLMGCJBFXZ1TG53P8U96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000456; c=relaxed/simple;
	bh=okVOvgMCxSHoJPtegYQ6LZ+tfsRvJYRXGSCdZrkPhto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGbGo0EFcc6se46MW/VZ+ZMg/Ua5KtzWEzZFVu0gnux+hsS/wRJNgmlPXxP7mNghXRN/tEAS7wXOYW0LgijdN6E1C6Fp/SptEpcgkhd8Oe4QDpgqtj/j11YuOlxtUg7iDZbDYjJdjZ+TO1yq0611uJuAT1m6R1pGDSXyxRlKRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfp46g39; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfp46g39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778000455; x=1809536455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=okVOvgMCxSHoJPtegYQ6LZ+tfsRvJYRXGSCdZrkPhto=;
  b=nfp46g39wlvJts0/9d55+3FKx+0sfwA2vzFP003hhbZcK67cq+uF+ywV
   tinWW4YGqgXGeXKZ3dy8/5R9IzXWqxvrZxUZ0KcVB/h1kBtxVATm9XJLv
   yncRtycviaIMHOK1kwL+YYCIuSIQ9GQqd6+yQ1BkMMbfVb+ZoIpkeTWeH
   4MsEts+mTjC4LiN7ZxpWKvG0BRfafaUuulgzev43TMPRXjPZgyqbpjhbC
   VZlzLonsvoxNe0CfCl1DMh9E7Jp9xcqJcWqzF4KE2dPGisoEe209UdyUD
   zrNPHv6cGVktrajqvSaGdtvZjPiI9x5By37K3TAkvMxqBMFkGB/3/p3CD
   Q==;
X-CSE-ConnectionGUID: NnZHVmqvRBWRK/540r5aFA==
X-CSE-MsgGUID: I5xTxPOeQUy3Y8HnGdwhEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77900557"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77900557"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:00:46 -0700
X-CSE-ConnectionGUID: dAGCgkHvS4OVuSEubfOTFQ==
X-CSE-MsgGUID: 5sltCDfjT9O/rjMBlKNOzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259211534"
Received: from soc-5cg43972f8.clients.intel.com (HELO localhost) ([172.28.182.189])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:00:43 -0700
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
Subject: [PATCH 3/3] PCI/IOV: Restore initial VF ReBAR sizes on PF release
Date: Tue,  5 May 2026 19:00:10 +0200
Message-ID: <20260505170010.3414074-4-marcin.bernatowicz@linux.intel.com>
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

sriov_disable() and sriov_enable() error paths restore the per-VF BAR
sizes saved at probe time. They do not cover the case where the PF
driver is unbound while VF BARs were resized but SR-IOV was never
enabled (or was already disabled).

On the next bind, sriov_init() re-reads the SR-IOV capability and
captures the current (inflated) BAR registers as the new initial sizes
in iov->barsz_orig[]. The restore logic becomes a no-op for that boot
and the kernel may reserve MMIO for the inflated VF aperture multiplied
by TotalVFs.

Restore the initial sizes from sriov_release() as well. At this point
num_VFs is 0 (BUG_ON enforces it) and VF Memory Space is therefore
disabled, satisfying the precondition of pci_iov_vf_bar_set_size().

Signed-off-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 42b935265b3c..d9e745e23add 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -969,6 +969,8 @@ static void sriov_release(struct pci_dev *dev)
 {
 	BUG_ON(dev->sriov->num_VFs);
 
+	sriov_restore_vf_rebar_initial_sizes(dev);
+
 	if (dev != dev->sriov->dev)
 		pci_dev_put(dev->sriov->dev);
 
-- 
2.43.0

