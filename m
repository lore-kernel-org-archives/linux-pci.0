Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F4388397
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310342; cv=none; b=OoOZIEKlYh6sElC8W4i3j9CU+aHwOjyT7udL5frRBGZUlSLrAsGIBuXX211KYgG4I4KR+Wz+YXKVxO738j2dJwnyPNirno83Syg7kY+2OP3cYVCaW3fpa1VZ8KcDPZVjvSIuvgFkS1a90Ty5QS+YTmvvXVvU1GfPZwc3FtAmA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310342; c=relaxed/simple;
	bh=+70kIpVyn2x8kiDDC1PyFViZ/JQI+XUMMGbOcdpeoO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PjpcY/yJ9SHFSVcrpRas574mxpvglf/5ytc4EyEwTjxIheNaXNTtJdzo0Yhr6Q3bY5SkPZtsL2SIC8HQP1fpc3XYqsOWuKTeXR9u99j5TlEK/flbnINAfcb9N4B4YOwcbMqSHnjPsl5mDyTv5EmUpGkCkFkTLqey72aSHx6I7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnYq/8lh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnYq/8lh"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35b93be1227so4036247a91.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310341; x=1774915141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aeeFxLRNeEzMbfk8m3pX/GNMnylfMV1s3l1hGn54HBA=;
        b=AnYq/8lhCPBNSn2YRnE/JoWaqsOkwL4HrsBVSGCkpW3VupjdoG9UrfJtzuKZqsYTiv
         hWP8xiNG51JINa2b60xWTA3TcXYVOhVSVN/2+9R/s7B0vmY1JrIVPH69PcwTWZak0pqH
         GaXCRYvDZC8+/UEI1Vvhz9FVScZ5dNhlZKexU3Z0IOGgo7ajIf0XMVRBZIgMneU+BtqM
         8lybecVaejztJ1VUVUNJTXOehWUOqGRUXWXEXaW9IglM4c+fpwr+3888WnNVXzORuKF0
         /cv88pCiQwXHFZOvyC18lxPTNHpgnoBCS0KzJ95vJDCSKsCLz0+eahuXFhheHMQlsi/u
         1Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310341; x=1774915141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeeFxLRNeEzMbfk8m3pX/GNMnylfMV1s3l1hGn54HBA=;
        b=c4+saQjyKnvFWOEWoLmiISwvP2hHAaWPWd6G7PrgUBnjQ5PCQBWu08w2oqIcWSVxAi
         ASEEWTe8fUxrFRGGXkuViFZ2abFrnho9zsSOldaiREuQeT72D4jgQ8anNnAGkENm43OK
         FtZHvR8ZsprTOdoVNHF7DaOD8Ab+HzFd/HScHqmy4V5lFoMzVjW95D4ONi9BDfepH1F5
         0mU4p2/8F3QfeXfZSU6tID1LTQQjGq6bCkzxST2NZeFkoIvb1kWMSwE/QdTt+We3W8dX
         /DBKLgs+n5Zv/H2XKGQrZKyjvMcdK2SuCFZR/BBcqYgj+WxzYYK1BXnA1/dVNPKthef9
         pe1w==
X-Forwarded-Encrypted: i=1; AJvYcCVchRpdvoClS9FvD+4JBaa1thB2T+FvFg9YCSSUpQuWxhwlYyrORQg3s4ZlZHwhv8av4qBT7mbu7XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXyIKtE+cTU/zb1njrQYDc5sRMzTsNo+E9cUaz2J2p7AZqcGpW
	NnqlggID8hYr6qjApz9URr41jxKepqpMo68GUgdl+6t0BlPGHgdcY453KV6acnIHwbP8+5eAbM3
	n5e2DS5ZzIxuKDw==
X-Received: from pgbcl21.prod.google.com ([2002:a05:6a02:995:b0:c73:90cf:9638])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3286:b0:398:7ca0:43a9 with SMTP id adf61e73a8af0-39bceb46904mr12137508637.36.1774310340303;
 Mon, 23 Mar 2026 16:59:00 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:05 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-14-dmatlack@google.com>
Subject: [PATCH v3 13/24] docs: liveupdate: Add documentation for VFIO PCI
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Add documentation for preserving VFIO device files across a Live Update,
generated from the kernel-doc comments in the code.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/core-api/liveupdate.rst         |  1 +
 .../driver-api/vfio_pci_liveupdate.rst        | 23 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 25 insertions(+)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index d56a7760978a..c55d0d9d1d3b 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -34,6 +34,7 @@ The following types of file descriptors can be preserved
    :maxdepth: 1
 
    ../mm/memfd_preservation
+   ../driver-api/vfio_pci_liveupdate
 
 Public API
 ==========
diff --git a/Documentation/driver-api/vfio_pci_liveupdate.rst b/Documentation/driver-api/vfio_pci_liveupdate.rst
new file mode 100644
index 000000000000..1098b84e5ecd
--- /dev/null
+++ b/Documentation/driver-api/vfio_pci_liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+====================================
+VFIO PCI Device Preservation via LUO
+====================================
+
+.. kernel-doc:: drivers/vfio/pci/vfio_pci_liveupdate.c
+   :doc: VFIO PCI Preservation via LUO
+
+VFIO PCI Preservation ABI
+=========================
+
+.. kernel-doc:: include/linux/kho/abi/vfio_pci.h
+   :doc: VFIO PCI Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/vfio_pci.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/core-api/kho/index`
diff --git a/MAINTAINERS b/MAINTAINERS
index a16a7ecc67a4..a6a31b94a4e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27684,6 +27684,7 @@ T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
+F:	Documentation/driver-api/vfio_pci_liveupdate.rst
 F:	drivers/vfio/
 F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
-- 
2.53.0.983.g0bb29b3bc5-goog

