Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BC2E54D1;
	Wed, 21 Jan 2026 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001282; cv=none; b=He4Ny/T+oyc9j+yqlMLwFio7cwapNp53OUBu6RzX6fx//1yL9O8XIj+YXHuXjoNc7ZGVxd3i5iu/waH0yE4xsxe08WV1m267kcHBpSf72X1xXJdaJzx6rvPs2Ag+RT6J/O1JRhS+2PN7fpqHnOuZeS7Ed34J3JTHnNmqU3cELP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001282; c=relaxed/simple;
	bh=RaYvlksJ/SpSfgzayP+dQQSt2W74WOsYndcSkAgl/IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDElqe6rhzUPTAMU/qxEaVR90xzkV+78WM/65U8sTs6wEe+mmGvRu73Jjvv1VYZB15GLs+uqfQ2kSZabQsHmYQbBzA0hBfM/W0wJN5dKl5wXdzSLeGDufUxaQ5HW/x7AxggmrNOcPdnqSSwF90ngaTr/sIxeSLQKooJhx58lUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHEhbICj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHEhbICj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769001280; x=1800537280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RaYvlksJ/SpSfgzayP+dQQSt2W74WOsYndcSkAgl/IQ=;
  b=gHEhbICjljdWsgRiZtO5sRjMDHDl6rMbuPT7R8MRdF0XMXjqyVtCFGtU
   91YdrjnEGcbtshm7TG9kEGr4fzyLlk8kAynpoJ3FFC5SJpmuC8aF+gjnH
   nBXvnQufFmqEaQ9tyqEX5PcE9fq2Lqe23z2p6HqUt+UK1KNxRB8NANKJq
   EAmEE3NCO5W8+gW6CrGjSlMIOrdGx4C/glHNUViZIT/jhbUr1HWIASdf6
   F3gqd2YflwfyPyR/9AytpZ2OfEZbAmMXUWonYfQhoOlgIeDhVW3racX62
   DhyfOWnceexP6ewCzQCim0P5uyMJ5e07+jAdvjFTdse1XNI1AeQFD2Ox4
   A==;
X-CSE-ConnectionGUID: ET6o7Ux5Q8mhfdwLAZu4Eg==
X-CSE-MsgGUID: EW/1UPfDTYuuAQH211ieVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69424281"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69424281"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:14:40 -0800
X-CSE-ConnectionGUID: n7HsbLOYRJmY6N9lQ5fuMQ==
X-CSE-MsgGUID: 5iEdnD6ATmSJ+1cMvUtNhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206872405"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:14:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] PCI: Fix BAR resize rollback path overwriting ret
Date: Wed, 21 Jan 2026 15:14:16 +0200
Message-Id: <20260121131417.9582-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
References: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize
rollback path") added BAR rollback to
pci_do_resource_release_and_resize() in case of resize failure.

On the rollback, pci_claim_resource() is called which can fail and the
code is prepared for that possibility. pci_claim_resource()'s return
value, however, overwrites the original value of ret so
pci_claim_resource() will return incorrect value in the end (as
pci_claim_resource() normally succeeds, in practice ret will be 0).

Fix the issue by directly calling pci_claim_resource() inside the if ().

Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
Link: https://lore.kernel.org/linux-pci/aW_w1oFQCzUxGYtu@intel.com/
Cc: stable@vger.kernel.org
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6e90f46f52af..9c374feafc77 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2556,8 +2556,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 
 		restore_dev_resource(dev_res);
 
-		ret = pci_claim_resource(dev, i);
-		if (ret)
+		if (pci_claim_resource(dev, i))
 			continue;
 
 		if (i < PCI_BRIDGE_RESOURCES) {
-- 
2.39.5

