Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7937F31F;
	Mon,  3 Aug 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753022; cv=none; b=m4n57zE0uSdy8OmySSpolnt2RVeOy/D0w1ReZTSHPlV1XsQenFe+1j3cS9L8l988We291dVvXQQ6W/mHO/hOGhN/VYynRPFqp7Zo5+8gNa2vd7wuU1czRUWBnSlqT2FaptCQW/zDc/TDtvWIGXGebXmsAVtRNgqRx17Mb4D+BqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753022; c=relaxed/simple;
	bh=1vA3DmCTulej1f3WdCaQL3Cc5X4LwIxOBQssRhrlQtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy7aTBec+9cbmoEZ2F04uaaq/UHDMebbPK8riAiqH+VpDYJEacB12V2LpXk5ZY4pxqlqm31iCTp5JMLlH7V/wxyMuyGEZjw8K6oTxIWls9Wq6oE2qqYGTmovrzmDSSm4M7+ammrczn4gsYPUX65sYzh4eSiqdOq1jS1u1gL5j5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAjtenvN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAjtenvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785753020; x=1817289020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vA3DmCTulej1f3WdCaQL3Cc5X4LwIxOBQssRhrlQtE=;
  b=UAjtenvNKlbFUJz7jiN1118SN1VTYKvLzmH6Z0nACOenfLKb0QWnYTd8
   SQgY71AJhEHPEQXdmuXsIY3+R9Np7i0UEZy4oQ+AUbLPSLO6qaG1hS+BF
   6OscF8WPA+c4vcXU5n1/YchnpSxM5ARGrHINZy0g/Z2KXCOamcUizQJHa
   pk1YK7SvDUcrgJ9npJspQnDlghMYr8rprXAEql/mJvUMeLyJSxohJGa3b
   z2I3Ul12S69OdV3/hqnGtcXqVYRUsek6+zifDkmenUIvUNKka61AVEjju
   m2PQ0VJBj84GXeWwmuSE1aPH3wnbo5g6/cR0r79Ts8eN2f+WrixiscPoN
   A==;
X-CSE-ConnectionGUID: COrkf6Z6SXO9uz641FaaxQ==
X-CSE-MsgGUID: JPrEa10WROm+A5L1L/T73Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="97446125"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="97446125"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:20 -0700
X-CSE-ConnectionGUID: kR4aR33JScG3FweUgJcKQg==
X-CSE-MsgGUID: CskpuwlOQAqY0UnB0j7luA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="284566513"
Received: from soc-5cg43972f8.clients.intel.com (HELO localhost) ([172.28.182.68])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:17 -0700
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
Subject: [PATCH v2 1/3] PCI/IOV: Remember initial VF BAR sizes
Date: Mon,  3 Aug 2026 12:30:05 +0200
Message-ID: <20260803103007.209625-2-marcin.bernatowicz@linux.intel.com>
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

SR-IOV initialization records the per-VF BAR sizes derived from the VF
BAR registers in the SR-IOV capability.

PF drivers may later change VF BAR sizes using VF Resizable BAR support
(pci_iov_vf_bar_set_size()). Save the initial per-VF BAR sizes so later
code can restore them when SR-IOV is disabled, when SR-IOV enable fails,
or when the PF driver is unbound while VF BARs are still resized.

The initial size is captured before the resource is multiplied by
TotalVFs, so it represents one VF's BAR size as advertised by hardware.

No functional change on its own.

Signed-off-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
---
 drivers/pci/iov.c | 1 +
 drivers/pci/pci.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b0d24839c084..ae9309fc6dd7 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -869,6 +869,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 			goto failed;
 		}
 		iov->barsz[i] = resource_size(res);
+		iov->barsz_orig[i] = iov->barsz[i];
 		resource_set_size(res, resource_size(res) * total);
 		pci_info(dev, "%s %pR: contains BAR %d for %d VFs\n",
 			 res_name, res, i, total);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 68b5fb675d1c..71c0d9fe5524 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -713,7 +713,8 @@ struct pci_sriov {
 	u8		hdr_type;	/* VF header type */
 	u16		subsystem_vendor; /* VF subsystem vendor */
 	u16		subsystem_device; /* VF subsystem device */
-	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
+	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* Current VF BAR size */
+	resource_size_t	barsz_orig[PCI_SRIOV_NUM_BARS]; /* Initial VF BAR size at probe */
 	u16		vf_rebar_cap;	/* VF Resizable BAR capability offset */
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
-- 
2.43.0

