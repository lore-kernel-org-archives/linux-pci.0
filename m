Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E087D38656A;
	Fri, 13 Mar 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391573; cv=none; b=mjZpcwK9KQ+4owqVeE8RfNcKdJuPjiHgdjgXTvnvc5n2Rhaj8UwW3AWxDpNeh6ZFo1lx2t6Fz32wke0l43vrkAi19ab4mZzOVbEwxL6aIGdymqOMb71UcZbhYTnDutOmcHumXS8hrUcmLAzFd/P6Hv0ttdx79yV/NV6mJinXBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391573; c=relaxed/simple;
	bh=AQYfhlnHFULcRCyiTFUzyCX+jLY+c1nvHHWu6znymH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hRFaX5c45iSF9ZZBJ+urxDLsTH9qRKniVPwzQkwPoYYX/zQAIDV//bqmCXZKQLKJ3u6Dz8woDlYyguS066+/5rLx40RgXvzoxeEdYYEZkESVkSbnYBS9BX8EGNP0TE9cXsHOgIguiSSbT5i9T2Rit0uYRk1WzGkVr+XBK9jes50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OL0i9KAG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OL0i9KAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773391569; x=1804927569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AQYfhlnHFULcRCyiTFUzyCX+jLY+c1nvHHWu6znymH4=;
  b=OL0i9KAGlj74WFSLJM/JhvKQc7VMNJKIIv3KBF8PVf2mRp8N6+5IMnME
   Tj3wBiJfsrNwDg4YmkCcyJ+J8FI1gQ48WKkOocvQ1gseY7vCPpVxQ/h3D
   Pv46DP4yUy8TeVfZ3yY01aPFNEhSdQM09FA/fCULx+Zvs+0GPKLHMxJqw
   TZdCMDM7nfWcGPcMrR2xSWQgvZrxGLPeVBH/IGfexaRoyrbRW7lac+aV5
   dBTBGoNAVtt1BuIdV0fDZeIZNsG3hSHnk55tTM2vxS8mnh7mE3UHP1rNC
   jv1gClkidVbPr62Idj0pdjjvS6prAMwpDtHjFkJjwlDLuQSxlg1IjnGXA
   A==;
X-CSE-ConnectionGUID: 6Qd18UtQTDSoM9qF8KnDLQ==
X-CSE-MsgGUID: sOh5ROvVQkiKh4EBJNC3aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="84813903"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="84813903"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:46:09 -0700
X-CSE-ConnectionGUID: yK2NxuZ+TmqKUC//FS8Heg==
X-CSE-MsgGUID: Lm6pvK6nQ+eCqR8u2PB/uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="259007233"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.238])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:46:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Nisbet <peter.nisbet@intel.com>
Subject: [PATCH 1/1] PCI: Fix premature removal from realloc_head list
Date: Fri, 13 Mar 2026 10:45:50 +0200
Message-Id: <20260313084551.1934-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

reassign_resources_sorted() checks for two things:

a) Resource assignment failures for mandatory resources by checking if
   the resource remains unassigned, which are known to always repeat,
   and does not attempt to assign them again.

b) That resource is not among the ones being processed/assigned at this
   stage, leading to skip processing such resources in
   reassign_resources_sorted() as well (resource assignment progresses
   one PCI hierarchy level at a time).

The problem here is that a) is checked before b) but b) also implies
the resources is not being assigned yet, making also a) true. As a)
only skips resource assignment but still removes the resource from
realloc_head, the later stages that would need to process the
information in realloc_head cannot obtain the optional size information
anymore. This leads to considering only non-optional part for bridge
windows deeper in the PCI hierarchy.

This problem has been observed during rescan (add_size is not
considered while attempting assignment for 0000:e2:00.0 indicating the
corresponding entry was removed from realloc_head while processing
resource assignments for 0000:e1):

pci_bus 0000:e1: scanning bus
...
pci 0000:e3:01.0: bridge window [mem 0x800000000-0x1000ffffff 64bit pref] to [bus e4] add_size 60c000000 add_align 800000000
pci 0000:e3:01.0: bridge window [mem 0x00100000-0x000fffff] to [bus e4] add_size 200000 add_align 200000
pci 0000:e3:02.0: disabling bridge window [mem 0x00000000-0x000fffff 64bit pref] to [bus e5] (unused)
pci 0000:e2:00.0: bridge window [mem 0x800000000-0x1000ffffff 64bit pref] to [bus e3-e5] add_size 60c000000 add_align 800000000
pci 0000:e2:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus e3-e5] add_size 200000 add_align 200000
pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: can't assign; no space
pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: failed to assign
pcieport 0000:e1:02.0: bridge window [io  0x1000-0x2fff]: resource restored
pcieport 0000:e1:02.0: bridge window [io  0x1000-0x2fff]: resource restored
pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: can't assign; no space
pcieport 0000:e1:02.0: bridge window [io  size 0x2000]: failed to assign
pci 0000:e2:00.0: bridge window [mem 0x28f000000000-0x28f800ffffff 64bit pref]: assigned

Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
Reported-by: Peter Nisbet <peter.nisbet@intel.com>
Tested-by: Peter Nisbet <peter.nisbet@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

There's no publically available report on this, thus no Link/Closes tags.

 drivers/pci/setup-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 61f769aaa2f6..b0b00f10e31c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -434,6 +434,10 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		dev = add_res->dev;
 		idx = pci_resource_num(dev, res);
 
+		/* Skip this resource if not found in head list */
+		if (!res_to_dev_res(head, res))
+			continue;
+
 		/*
 		 * Skip resource that failed the earlier assignment and is
 		 * not optional as it would just fail again.
@@ -442,10 +446,6 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		    !pci_resource_is_optional(dev, idx))
 			goto out;
 
-		/* Skip this resource if not found in head list */
-		if (!res_to_dev_res(head, res))
-			continue;
-
 		res_name = pci_resource_name(dev, idx);
 		add_size = add_res->add_size;
 		align = add_res->min_align;

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.39.5

