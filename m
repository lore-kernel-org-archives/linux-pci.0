Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656937FF75;
	Mon,  3 Aug 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753034; cv=none; b=VgDjTYQZgSrAhc/wUWOJDUXoBfml/4t/GluFNhW2NUmQiUHyNOp0DSgatlxkDMS+OBqAu/LMsPh4VxYeaofhYFv3NQTT7lzfNt3SNBlVnmBONSfiJ8q/k9wAOoWwGO0u5xf0B5RfkrkWSRoacYVaB2x+xat/SU8GJuQLUs+B/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753034; c=relaxed/simple;
	bh=Jc9ezVgCCeYzRms3oEKKtkNwbEmHiSp2OS+gnMOLnXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRa8ZiwJY9bGd3Krb+g+6kxEX6kvuvGcx19ALQGGEryEWJDzUlnFW4EfqGQxin7SDEIBWx/DYRZiGdAoep9N+e0PR90j+RhizaJIa4OsVyfwzyDogsf6CtyUEx9zJ2zuJXCSQZqlutH05FUGmqyXIJzkwycD51vNdE5oFQfhbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNmKYYw5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNmKYYw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785753032; x=1817289032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jc9ezVgCCeYzRms3oEKKtkNwbEmHiSp2OS+gnMOLnXA=;
  b=SNmKYYw511vkz8NvAGdudKcUz1S6mAPs4ZzMmVBftlzvH6FEWo1yCJQv
   b4W2qpNYQ8wb2Q7CkIT1/mBECMrZdOXVY/PE7bBNPzlEvcAl6szPoJXvi
   YoRLdigv2TGT0++WelTYpx9DrHnUUKLbFeCkCjEAh5eiK40RpxMM5LTml
   pxinWUasIQDE4tDATl6RXPY7moberyO9yAkh9tDPBdgAOuLNtpyWQxeFY
   Dfp70+Yn/KsrJ4hR3WphTdfwvboig+UwTYS5iu4HYy0Hn6gFiDztLidjg
   9MIfLViIgECHfT+PD0oqDqx1UPkvEnEKq2vEBwwuJRdzkfOfXfwbSJN62
   w==;
X-CSE-ConnectionGUID: yrhxkU0mRVikDeLkBE+NZQ==
X-CSE-MsgGUID: C9PlT7LVQu2GBbw+XfRuUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="109080989"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="109080989"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:32 -0700
X-CSE-ConnectionGUID: FDbvWnJdTZar+Wh3N+v27w==
X-CSE-MsgGUID: Q7t6uBkWQrG7T+EAG9uQNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="299410205"
Received: from soc-5cg43972f8.clients.intel.com (HELO localhost) ([172.28.182.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 03:30:28 -0700
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
Subject: [PATCH v2 3/3] PCI/IOV: Restore initial VF ReBAR sizes on PF driver remove
Date: Mon,  3 Aug 2026 12:30:07 +0200
Message-ID: <20260803103007.209625-4-marcin.bernatowicz@linux.intel.com>
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

sriov_disable() and sriov_enable() error paths restore the per-VF BAR
sizes saved at probe time. They do not cover the case where the PF
driver is detached while VF BARs were resized but SR-IOV was never
enabled (or was already disabled).

Restore the initial sizes from pci_iov_remove() as well. That hook runs
on driver detach while the device is still live, unlike sriov_release()
which runs later from the pci_dev release path.

Skip the restore when the PF driver leaves SR-IOV enabled; in that case
VF memory decoding is still active and pci_iov_vf_bar_set_size() cannot
safely change the VF BAR size.

Signed-off-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
---
 drivers/pci/iov.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 999938163ce9..3739825c84e9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1085,8 +1085,12 @@ void pci_iov_remove(struct pci_dev *dev)
 		return;
 
 	iov->driver_max_VFs = iov->total_VFs;
-	if (iov->num_VFs)
+	if (iov->num_VFs) {
 		pci_warn(dev, "driver left SR-IOV enabled after remove\n");
+		return;
+	}
+
+	sriov_restore_vf_rebar_initial_sizes(dev);
 }
 
 /**
-- 
2.43.0

