Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940E39BFF4;
	Wed, 29 Apr 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465657; cv=none; b=ZFhEVnSeDQD1sQhwsB3yFSvFN4MhRfsz1IMkvsn0FSjyT7xYvOtqFAUepOy5IH2G6GSKiV7hvUUOy3BYl18ufsnRBNTFjXpI5seDT57F/5RDFZUK6vZ4WQfrFY1zqSFc+z27aqicdKyvXgM9mmC1gjz6xL7HcQkH2urCGVqFa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465657; c=relaxed/simple;
	bh=av6nUtlRUMx1I+d/0rUy1n4lGYX7MGYYBRJ36tkOEdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGTK/59g9r4U0mbU7swgSleuUZt24ZwJnTC/pTJoBO6zy5YaRQobqMvKapKZsO3k0j/76KMLs9x2IeRfazspW85A8Jix4K0ACkn4+Ndn4xvmcUAfFsl+e3D4lc206H+f7ystidIS0wd9MiHWLzath3tz/ExJchqR7+CgnA/KTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3oyLOt0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3oyLOt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465657; x=1809001657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=av6nUtlRUMx1I+d/0rUy1n4lGYX7MGYYBRJ36tkOEdo=;
  b=A3oyLOt0yFwE9IlX/JcwAXfLCOaCyYAtqbuNAcFWxkgREen407b6VTwg
   /4WvimpwhIB4nbmt/v5c8ni/yERTkrpOUNpdCwio94jkBgn3kfWTtdSEd
   PwIf5MISDh4KxiakGv+oodSYaJGj7mTekFydB4uuwhv9utifQEpUnIi7H
   8Ro0hX2NZ4j8/NXavlXZtQGOQACU3ftQxB0drA68sRBvPMBm1qcF1hO8h
   3oHzqH5qLyVgfs9gG3QhSp6FcwDATLFxwkNkUNwAgheO2OHfwFSAJJbfC
   XwokChEu5G+IUet7nni92B9L04KX22wkc6tugLYwCd0rLCm4HQKEJQVFF
   Q==;
X-CSE-ConnectionGUID: 9bMLsEyrRZOB8ehaBlNwDA==
X-CSE-MsgGUID: Ma1g6aj1QSGcktZK9K0prA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101821"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101821"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:36 -0700
X-CSE-ConnectionGUID: YbPY7mx3RA+0HaaKTn90OA==
X-CSE-MsgGUID: gjkuTCivS++kW7ekDhzxHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234512290"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/11] powerpc/pseries: Make pseries_get_iov_fw_value() & pnv_iov_get() pci_dev const
Date: Wed, 29 Apr 2026 15:26:12 +0300
Message-Id: <20260429122617.7324-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert input pci_dev for pseries_get_iov_fw_value() and pnv_iov_get()
to const to be able to convert pcibios_iov_resource_alignment() as well
in an upcoming change.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/powerpc/platforms/powernv/pci.h   | 2 +-
 arch/powerpc/platforms/pseries/setup.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 42075501663b..032b2081aedb 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -251,7 +251,7 @@ struct pnv_iov_data {
 	struct resource holes[PCI_SRIOV_NUM_BARS];
 };
 
-static inline struct pnv_iov_data *pnv_iov_get(struct pci_dev *pdev)
+static inline struct pnv_iov_data *pnv_iov_get(const struct pci_dev *pdev)
 {
 	return pdev->dev.archdata.iov_data;
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 50b26ed8432d..b670c6fdfcea 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -658,7 +658,8 @@ enum get_iov_fw_value_index {
 	WDW_SIZE      = 3     /*  Get Window Size */
 };
 
-static resource_size_t pseries_get_iov_fw_value(struct pci_dev *dev, int resno,
+static resource_size_t pseries_get_iov_fw_value(const struct pci_dev *dev,
+						int resno,
 						enum get_iov_fw_value_index value)
 {
 	const int *indexes;
-- 
2.39.5

