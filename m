Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5983C1D74;
	Wed, 29 Jul 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339064; cv=none; b=fgIPcpvnT4bj2R74WTzGMT0uBbpI8oUyyMpb5MFsZGNKFouko9RyyFMLq5bFEjNJd8W1BtgFSHvMcl4QNYFnhd/5wJftFDsFNNjTfp5ocjRXb++YLCSRtpupXCPlmAvzfR0OfK4y+PFxoG6s34CsySlLqRE/+r21Fyuo4+QuewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339064; c=relaxed/simple;
	bh=mPx5cK4wqDTR2j+mTZFizHiWBpudgD8sP3WF4UjU0hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HyV+4pqBLKwm16vgFNYoQxdRvwXvvVD13mFR7xNvTLVW3KZHNaYEP5xTNzsORcPzXywcSKDO9TTsX1LsGJQNRismMyINq036C6oRo9VdV5xaBwxOmwZLG8Tr5yTEKlKxAYWDPafLTtB21318x6OCSDM+zPVq4HM/kXc5S+bg87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwUO/NgY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwUO/NgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785339062; x=1816875062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mPx5cK4wqDTR2j+mTZFizHiWBpudgD8sP3WF4UjU0hQ=;
  b=CwUO/NgYG8AuppA3XtUDJymEcl4+t+cPUbGsfHgXL9DB/Sa7U56blJKf
   kyhFy6KVhJFtKw8i1Oua427z3Uz/V+FARTqR70hLRDE9LU9jPhF+cD/RZ
   Oka6N9FlGXVIWC6R5zmUsVIk+m/5BydZKGsjz1Y6pKLp1I1HQ0QEIB2w3
   ZtWREXQUszqROGN8e+rmb65dafDnpPNpqNyiAGpsUX/SlJwWcJ1UykUto
   IulSzyY4HTsOearGJg/GhluZaXPzDUelrt/jLvUr2zQSy7yGZRs61QCCE
   coihkn7fKGDFlgz2ZvdZrrrZlpPbOf701UhYUN5sg9XPPMxyjvo1C7R5/
   g==;
X-CSE-ConnectionGUID: RVUeV/EOTWaFBj1Ra2xZYQ==
X-CSE-MsgGUID: wbL8Ol4ZSb6NTuKoSFUxfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85964225"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85964225"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:31:02 -0700
X-CSE-ConnectionGUID: p9AQbYzyRJC4nybkh/bKTg==
X-CSE-MsgGUID: +wGs9n43SqOK+Zg19oyQxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="256108785"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:30:59 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: bhelgaas@google.com,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: vmd: Add VMD Device ID Support for Intel Nova Lake (NVL) and Dunlow (DNL)
Date: Wed, 29 Jul 2026 17:52:55 +0000
Message-ID: <20260729175320.1400987-1-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <djbw@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
v1 -> v2:
 - Fixed duplicate text in subject line.
 - Included missing VMD maintainers in CC.

 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..f9d145932155 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1132,6 +1132,10 @@ static const struct pci_device_id vmd_ids[] = {
                 .driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xb07f),
                 .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xd70b),
+		.driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xd73b),
+		.driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.43.0

