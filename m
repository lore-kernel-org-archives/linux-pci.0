Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F052842F
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762027; cv=none; b=ax3rmXRee3w5zYEAA0AhjQyWHeGm64RAtc9eeSEO0OMaX3DqI/CjuLCGPzTxWz4R7gcTZHWTdf2MH9tSYDhYRqqd18XoXQ1P+zMObi8Kbph7MffsiEUNT7MZnFHjgbPeiRkkaWMuy0DlZV85UXKKHz7X4Dd+RU3gSGpuzz2Remk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762027; c=relaxed/simple;
	bh=UfzWz/Vy8dC/P8FblFhguwkyXeiWSwXDoG++vSs9Azc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bTGVB7UF2fB4S2pMZJjqd8qHJwwFOgxRH7GCf+5Oe9QJgl+blGErbA/HZpZEJnb6AsqqHHoGaCUApENvvTDseQlmAkZqiM0kiMpALE7KqlPJToXPAXZdc7izv6nS+kVmLB63I88jBjEqy3WEmsKpY5g+q4CeWYWL31xSxO/jjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQrr/qsv; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQrr/qsv"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1a439db36so995462a12.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762024; x=1790366824; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9IxdwpsNG1RvdTFOh7VCNlg1Z6K9O4n/2FHxAEnlFE=;
        b=YQrr/qsv2XanYxitvXUnijhvSAL5Ea09XnZsjg6uQEojnST7bk+MlKtZgeaYGVbrZ5
         D1+Niqsp4bQTXL+3oXSNMvl0sgcJOYkRylwByRxhkhdS5D0ffunsFb73nxDJuksM6cOi
         cKUrBz/GQFk4eT9PKeODML4NU4hGLIH773sWeGW0nxCG5MH2BKqOenr0BUxvdz2rObpx
         tT30L+hB+d2VT6nQzK/zdN7kexxQ0X8J8vhuvLZFNJ5ZRb5j/EpeXZMZ+JPTCmtn7HKx
         oGIOhLwfvxEwmwD2oUainAJRCXom7AxuXXSPL5BZu3CrVtR7Jz1mFfyoJhHh8tA+oNLQ
         74RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762024; x=1790366824;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9IxdwpsNG1RvdTFOh7VCNlg1Z6K9O4n/2FHxAEnlFE=;
        b=zMjcEfrjc6AbFjBZKpU8qwDRLn8qmPUWajBq1geZYmKmmAeh4E87tUFlBycQC6LtRT
         C9R0enzwHDKl+rvw03zO/6xDO/aDXmYf3usBGYM3p+j7e9P7o81aYlzeqDgK0MzkUG56
         E6J9FjJlFw9t3Occ6zj0uyBya93Kin+tPIXx3FB6lI0zqbVGZP7uc+gFBwTOGKmuc+56
         X9pXOuzqzjoKUziKRc5Y8l395W/bxR8+iTCegsPQPEtTJAkgTzsbN3rE6RU2TBoBS3+J
         qDDve2Avh1kiNYZNiPeYOkB5xivGw2A0tTDvIHWVj1m1mC8DzRxzmSV5NcXvbv4JhkSS
         6adg==
X-Forwarded-Encrypted: i=1; AKwUvByELeEso0UH8asKJWdDl9vTGJ9BmsuQwRxirxOHnsutjmcPiNq5Qu6sXnQSpR8/spL47pbLTh6H39c=@vger.kernel.org
X-Gm-Message-State: AFuF++lmjmquZlLYF++HGPvxkABxfbWJtfMr/iMvTe+OVq5iLQgro6BM
	Ws8MwwkV1LmDWfzWXDMJXRcGd96PAUSKrGlVKqsjRXlUdoJIPnl6I+i50peYoC5FKg31Af+6O5k
	36oeFxH/4KI5wAg==
X-Received: from pgbeh14.prod.google.com ([2002:a05:6a02:256e:b0:cc4:b44e:9200])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6083:b0:3dd:64fa:5520 with SMTP id adf61e73a8af0-3dd8c4287dbmr7496380637.9.1789762024286;
 Fri, 18 Sep 2026 13:07:04 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:39 +0000
In-Reply-To: <20260918200640.887030-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-14-dmatlack@google.com>
Subject: [PATCH v9 13/13] Documentation: PCI: Add documentation for Live Update
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
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add documentation files for the PCI subsystem's participation in Live
Update.

These documentation files are generated from the kernel-doc comments in
the PCI Live Update source code. They describe the File-Lifecycle-Bound
(FLB) API, the device tracking API, and the specific policies applied to
preserved devices (such as bus number inheritance and bus mastering
preservation).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 35 +++++++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 38 insertions(+)
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
index 000000000000..96b1d7f5df3a
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,35 @@
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
+Internal API
+============
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :internal:
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
index b3c689e633c1..2bce2644eba2 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -74,3 +74,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 3eacaa98775c..5d1b58271989 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21055,6 +21055,7 @@ L:	kexec@lists.infradead.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
-- 
2.55.0.1082.g2b9226bbc0-goog

