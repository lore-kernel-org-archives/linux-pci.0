Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AC38AC7E
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611743; cv=none; b=D4i5CtfLYLAAhxgnIR4BaoUgDspWizQF8hHpvB7iAUHftyxkVrMwZIrZ8d6xrVDXvBFwYVv8iDIQlMxUiGtRtfUUIgA0Ba+NU0WguL3uI50+p82UwBZu7qjfGNiIvTHSHSj8TRzaP136ca0GFu0zuKDmGZP1/APvXIc81Xuyym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611743; c=relaxed/simple;
	bh=tFqeEQKMaB83wQ8MqIL4frH10LjGIU82dN2Tu2Y3Xzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dkFDdy93LjQayj0aXKoPHjkfOaRD2sg9v1muoHYhi1xsheWXzoufJKxNenfZZh7JQFDyiCeAFI3L9sc43qh8W9E0IOWT39qPztdBptyJcsNHFHZ/I2wAN9yPqLw4MegVMFC8aHqZA7w1SsnCmq+BlEG5lP7AG1LLnsl15A05f+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBdSX50G; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBdSX50G"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso752816b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611741; x=1779216541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uszo/pEOiCKzj7JLqUzd1dVCJweWOYTEHSWoFKhDRKY=;
        b=NBdSX50GKSsDAKh/DUQdVVu8CJDZ3LAaqfLep+lcYIzSh3S+hcrokkiu0oRihTN+Yx
         ltOq5Ja4aUZzusKHH7hI5jInzSWbBQwZM5Hm/V0CO20q95ykjyiLpbOAicY0Ghknq6F2
         qO5Y0q1G/wQ8+HOHWhlptXUjFy5uu2Yi7HrmBk6fqYfYlpca+9Uix1ZSv4G5vnIRZHph
         AUwc9tFEwAJjPqrFQktcM19bwxD2xg7ZmMxPV49XDnL0m72RilnfkFBrNF9rJaxF3GXy
         g7scMepjHvE6Mgc50g6tZMdtQYXWTkT5O+Va/ve90afqxR3ga4a4uLw8tRVve5O5xp05
         SLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611741; x=1779216541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uszo/pEOiCKzj7JLqUzd1dVCJweWOYTEHSWoFKhDRKY=;
        b=jvuLRzxb8rOUdRDRsrJDqz5ffJd5j6MdkeArVXi/zuE4UvvS0WmdtGHVUSs6TJRItt
         DdAw0RrpXWSHKFJ3CAEb59xGAIEmTkU1ufpffE5MsO/HHyxkXM3/Xb6hri0mkc4fKvb/
         dTqXJwUg55x+RmVq+P/dK1dB+lkMSITlVWUPreRwbf2BqpYj5mL0LrAbHhERlTDP48in
         7ctXD0qklBtLI8Ad7Sl4kry38ya52nof9n81DuASWOXV2UBm2/Xk2M+dhJYJa/BUXiWq
         XSou6DzI4gVjC2E6zCkQQ79/yKWtHBGlq18OYgmVvgJX8Oaip62PAA8PCkL22hztNmUU
         ujVg==
X-Forwarded-Encrypted: i=1; AFNElJ9oqwWUEQEdrZnh8BOZIU5rcl4klojYXKAX/U+c4ktEeqDrV2IV7uXvao2OyzY3xJal9lrI9wOFGgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzde74zz7V3pMOBFqCs576orJL/P6MWsvmfc4vo3YgIVicSSCna
	X9xZoQ8olnWmv+wjbjrdTzFaSLBr6tbbqVM9lObWotFI/rvkT8Lh+hFS/nYgHww8bX0LAj+PWf1
	DnlO4uN8swRmaDA==
X-Received: from pfll21.prod.google.com ([2002:a05:6a00:1595:b0:82f:93e5:c64c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88d6:0:b0:835:3f51:730e with SMTP id d2e1a72fcca58-83a5b8d9aa3mr27781326b3a.13.1778611740692;
 Tue, 12 May 2026 11:49:00 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:46 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-12-dmatlack@google.com>
Subject: [PATCH v5 11/11] Documentation: PCI: Add documentation for Live Update
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
2.54.0.563.g4f69b47b94-goog

