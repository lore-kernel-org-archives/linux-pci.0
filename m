Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EED389111
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481466; cv=none; b=pNZCGQeREl0gRZ5E6NWVZ7km3+VENxykmijWW/3B/L5K6OVS46gAWsoiCih7IQBCv+5SDJPAigeiMgK03/qcX86+Lc6Wy1jzWyj/4MSJYO4Q0MoQvGj2eBsJ31r+KRD7q8EmfGq86z8uC79LRDoal06U1R+i2k+L4UNsgPZy9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481466; c=relaxed/simple;
	bh=6ZVk6YJvJGNI1hdkC2SsSYmezEigbBslp8F9CBARniw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rOqv84CvXFlmngXZ3RA34kh2UrBcyFDCYoPLeQg5Yb5o+5UYkJpzOVbn98/bnNRC96EjCKAewW/dW2Hm/wqGfdxhiHhvOURGt+YorlfMV3q22hTiCAjTiY3r1bY3yzSDiEOp5Ze5C8DdkCo+1GuM8bcTOTjIWIvk33FHmj81b48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apcKP8Zb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apcKP8Zb"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82c84be9c3so3625200a12.0
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481463; x=1780086263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jD8Dp8WjVDfBtyvW+7yZYOtj2UMzN2TZIRigqz140zs=;
        b=apcKP8ZbFfxk9mW1Z5BZ2RJ8HInvFGwLKvWm7oStZiScZvCS+yRmuAqKefsLHXODpt
         kfQzQYFv3G78oXA6ieimPMuTBOf3fquOUeTAonleDpfSopLeOLYI9Ai04tfBRV7Q5m1V
         xx8kMNFxrUtlCjlWgZzHHSusyZThTJq7mEQxec/yOCizDms/jQvSH1SxsiBXixNr3jGd
         OosnbBOcW+kDyWUbG5DVuN0Wh4e82+QM8JRHy0nFZGN84oI/Dq1/PkodTQovc9F68JDr
         sUvSdcDGdRZx53ddkiokKOY6y0WikVZ9qyEYaIjwtzpC1fXuKodsJnfWAFTYa9fowxBi
         yGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481463; x=1780086263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD8Dp8WjVDfBtyvW+7yZYOtj2UMzN2TZIRigqz140zs=;
        b=YlbdFF+WDaHaHTOWHkdkqkaJpDg8CbSjWk1lNvN+5v39EfEUhwQH4JjG7VkR+p2YBV
         6uP6kmpSq1y0S/18XMxrBxUN2S6/N2Zc+BtMRb3HzGXxeSo8TX8jA884gKWNy3XMzvPB
         UL/QwFshvGYWfcmTbt1h5WNCfPa42hV/P6ZtDr/D9JBWpTclpzL+/oKWFdywxF3vBB8B
         SgcB3tzEoGCzKiqf76fGhRLpttoZOeqOF1k/Xw6IBMbd1bXHWkdCnlzMDSXK4FHsbOgp
         s2w1uotlitcJOOAXXpox7OT79OGNyUuUCBd2gkwy5xUexpCb90otF5ufFmEriavdyaz9
         1QtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9suN+Kq8YpJo1DWCnYQ1bfAO1QmQwB1PxxTcTem+2DuUw8hbXtwGParnnN25i+ikWWWObQNMg70XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SYhOpNEZ9Nme8S9qvI/FN+pgrPPd3Nhla8/vpzTT2vca8KP+
	3CwBbVGFIhvB+TF0CNUB8UnNFNGJKnf0Ohf4BoeQpSYaTV4tikHXTgny5zdrsXxlxZiTGn6Nw79
	zWUybqmR3p6eIug==
X-Received: from pfcs23.prod.google.com ([2002:a05:6a00:6fd7:b0:82f:6a57:a9aa])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c8b:b0:82c:7f08:8826 with SMTP id d2e1a72fcca58-8415f15b50emr4877330b3a.17.1779481462682;
 Fri, 22 May 2026 13:24:22 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:10 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-13-dmatlack@google.com>
Subject: [PATCH v6 12/12] Documentation: PCI: Add documentation for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
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
 Documentation/PCI/liveupdate.rst      | 29 +++++++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 32 insertions(+)
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
index 000000000000..eba55f8a92ae
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+PCI Support for Live Update
+===========================
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :doc: PCI Live Update
+
+Driver API
+==========
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :export:
+
+Live Update ABI
+===============
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
index 0e262c0ceb43..6f0b0ebf67cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20536,6 +20536,7 @@ L:	kexec@lists.infradead.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
-- 
2.54.0.746.g67dd491aae-goog

