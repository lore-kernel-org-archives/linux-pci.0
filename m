Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4713BADBA
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979427; cv=none; b=RmH6w+bOclgQSqhdzK/tMehVi1cAwFHDtikHbZ0To+e0kBIJXErYv0neIyN5tvf246iCc27Xo3FVk+HpeOt+IXkide8277sooTL7IFhSq2uuP4X//IceJyljWBqPuBwj62Iil7Qi95Lpe1AWHSPXdZyxv1H6rlyj0OirZdN4oJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979427; c=relaxed/simple;
	bh=TAk9N0onkf1LhiBL762i+SXrkfm+35fT9FFl7hPmejg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cy6Hu3G25+J7ACYIMLqRDTC2NVMxQa+1ntiwa50bqWenEYkKRmwCD+1gUpAJ1ui6T06NyUjUPAQMDx14kS26isgqUBeGEamIujs5coC6SjRoZU5jNfZ07kUF+XwzCeM/Gp/tZ/YN1UofksvvnVqUZVYQPoxl4kQsIW7igDol1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKgJaVln; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKgJaVln"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so135111905ad.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979420; x=1777584220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4E3v8P9Bgd+PvGMRS8uoO/TIv3RrWRtb2HfczKdNV9k=;
        b=JKgJaVlnR8hG+u7YpR5pb79KVryCkxD8SKpnMekLWmpAIJRl+oUGY+B5CsJE0YShSo
         l853HXv0wtILtDRYHOUPMdEs7E79lCAzHNbXLX/TMHc1pH+3EaIPW6N5+A/uGs+Gng13
         Z8L+KqtKLsgLT2yFRNz7tFFm2OsWkwCGXjNU15uiPMGVNCqK9EDUYlG6UVFKqYf9bS4q
         8f31+D0vW+zZm8Y/raiL+xPaAjZcN3naU43OgaWKmZM1xtdmaf2UsZT/GQs+Hn4a9/zX
         wZsDkQeBvaQhM1a3qL94fgzo0aR/Gx+Y7I7iER4cHQ/ulsaYgtmM0OdrnIkuP80LRQNH
         TEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979420; x=1777584220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E3v8P9Bgd+PvGMRS8uoO/TIv3RrWRtb2HfczKdNV9k=;
        b=tYEaBLZNwC/6QlyM/1zy6pSVT7xuAQgJHtpdVQmBIIQ0rEuW1F26yc76AZZHbh84Zp
         TajJItUBaQH8oGpNYbn/oPJ4PRH4rOnx1/5WF28JF6p5YlwcN97NMQjEoQpYuZs3F9pi
         1+gYa7tjE8FEBwu3GTXfASYpz5SrpmVhp8aS2kbnMGd1EZvBeVzmFhOTeoMZ+CHRww78
         +rEBWfg0dJ2W9paY7FbXRgk2UZXUAJ1jHCYBENzK5Fd6f64iSTE+UjlQU1xkhDGFu7kt
         sX6LRsJXBfbXPKUq7r0hKOQcigQwq1qCXRk2kBs3fJkz5XWO4abLKfsRwEuNcwJx0zpU
         VtQg==
X-Forwarded-Encrypted: i=1; AFNElJ+XtDyj4C19TKP9yiio0ksjtb/qHPU2giU+iNwVyAkjAfRlI8DWLeOqsrtt5CNehIJ+jeaRr1XyUB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTqU5sboQDYEfqNvVJw3ibGRcQ2tL4sg4edkoE1tq+sq9onE8
	EBkrRAHAvCFRNurzS9i1kFfUppLOQmn0lBpwlOOP8EW/79S3STCEYHdXi9cv/UY8Q5g+K4jN5wm
	EerOidONUhg8XFw==
X-Received: from plon6.prod.google.com ([2002:a17:903:1a86:b0:2b2:c9d2:11fd])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2984:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b5f9fd146amr301151585ad.37.1776979419527;
 Thu, 23 Apr 2026 14:23:39 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:15 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-12-dmatlack@google.com>
Subject: [PATCH v4 11/11] Documentation: PCI: Add documentation for Live Update
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation files for the PCI subsystem's participation in Live
Update.

These documentation files are generated from the kernel-doc comments
in the PCI Live Update source code. They describe the File-Lifecycle
Bound (FLB) API, the device tracking API, and the specific policies
applied to preserved devices (such as bus number inheritance and bus
mastering preservation).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 23 +++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 26 insertions(+)
 create mode 100644 Documentation/PCI/liveupdate.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..23fb737ac969 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   liveupdate
diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
new file mode 100644
index 000000000000..04c9b675e8df
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+PCI Support for Live Update
+===========================
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :doc: PCI Live Update
+
+PCI Preservation ABI
+====================
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :internal:
+
+See Also
+========
+
+ * :doc:`/core-api/liveupdate`
+ * :doc:`/core-api/kho/index`
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..d56a7760978a 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -70,3 +70,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 94af31837375..42dbac2c2ed3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20564,6 +20564,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	include/linux/kho/abi/pci.h
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

