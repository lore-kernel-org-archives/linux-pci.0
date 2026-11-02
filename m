Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633837;
	b=RMZ4lAMoOF47PAqlrrxjB8Pdk7rPxeODVf2yNX4U33iYPnA6no8bS3TkluXy2olpE+fi
	 CGPADvmz8lXqahh2LT1o3kKm4MKYtxgfIk9ewm+gjpFKMLGxXzTG1XbZFZWLEYRUS24WO
	 OQC40/7edUweCM+h3qrpvW+MdBVUMQZGIVCO/piqhgCOgJZuqjKUmtRGQH0ugNxPBZl+P
	 /1MLJX+DveXztw/fUpPxspzc0cTk8pXtnTU64zS+Rioh6mwexJbvvKncUDTyEs1XY1Sce
	 ORMtVkE2Z6iM5V/G4eVPJM8dl5ySlxmZjjaYPyvuWq2JRww8inNK23DjbQ7jOdmZWVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WePLvWtT/WZKO7Unx2RTF+SOz/N+MuUr8ckMVHiMFxQ=;
	b=IydNKcVb+Vdvvh0oKvgYCZG074kr6Ye+OipDyhyMXc15slDvirjuIIcZ4+hLj1kuE1Es
	 SrFa/9+/ly9Z8705IqpRaRTYeh2GoenJv85LVTHrwMw9huH+MdpwjcIJzmmekIydo3Mxw
	 RRJCq4wsBM5I9vIJ5T9AWZs/nSOWtsx1TjeOAAMaQgsy1C93LLsHUeEr+QdzzU0imNp8k
	 W+qOyFtknyblw9/QcqcG9WRVmGkf5lPzcbymm9QiZXeELtlgOZNA7WTkK4VKZqsePDzTZ
	 nJSg59LWbpBsHsEk74dk6DLJ82w+KZq+iTdAPfN4gh71TyXrVf6NfCWlmA5+a6wmmUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bnp2TJZB;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066B60E7EFC
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D066B60E7EFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bnp2TJZB
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd68b8579f2so1173268a12.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633836; x=1794238636; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WePLvWtT/WZKO7Unx2RTF+SOz/N+MuUr8ckMVHiMFxQ=;
        b=Bnp2TJZBhnZ3Fomnoglqh4+l87hRvNmKBCiTZ6jAjRxWpXxYXsMgUH/cOuHl2dUEDC
         wJ28FoKeqWp3KhY3kQlFAu+HbXoVoKpftFYkfXzXm+aF5o8Yxg5mtJZ1b0uFCxMBxDgm
         KFvTzBa3lyHrYP+mRgVoI+h7ot0pIJHFTheHL5nZjIDui8mUz6RHgdkN1TSB/BqCPeqi
         xhJKJ+mimCLZP0IRb9FUgMCvIugwFwsw6AR1wrMrfwro8rW1hqu/148Rc/p7atFwmIRe
         ZtvNYcFiobuA1Z5LTkhQZGhi14HkwUC/IuKyXu15Eajkx7JixVLOz31OkOV9Cyb4Hcko
         IIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633836; x=1794238636;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WePLvWtT/WZKO7Unx2RTF+SOz/N+MuUr8ckMVHiMFxQ=;
        b=zccVZJcKGX8XrdPs2KBkZCJbPA07gVtetUTeiuB8NXSyKfBp18oRSy7dR+Vhd30B3y
         HIm2Dw40u7mRsTdhOno6qLIur/pUWFpVbtJpO4G186f78oEmJGDfQCbe2dCVs48Q6kYt
         wYXSX9lJ+c7QwkX5xUeX/3BU17QXhuABe+sKXpmWjOarUDtUKyX7a6b1vxBkprDFsxBs
         buTRG0lqbdiL7Y0H5BoiTYr4Y8P+GLVZLJ6F1yVxQOawVilqiaQAowvPZ29sDZ1i44GH
         Dp9XYHjyugDaleUXmGFyE8/7VmHWSDEw2f7wR73vll1ZWOsug90hGgJBNZQauuFlY6Gw
         FXxg==
X-Forwarded-Encrypted: i=1; AKwUvByA2jYAPG+SiWDlfa3bxTzMnvpj1AoaatzuiOZ2m2UgFgvAdzOzRZppGG0oArSfPV5yzdGBmtobUo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FH/XB3StELHbqMy2DYMvPbCz7BDAj1CSFRbArkXUYdH6bMMsP
	60UAAGUDMjHu4eUAAGsneVLm1rAbsY/aKTfHnvZlwlbCBj+U1E6wWwZX+RQGYFCThU2CClwMt5x
	QFeEmvxCSpw==
X-Received: from pjbcm14.prod.google.com ([2002:a17:90a:fa0e:b0:3a6:f87a:f3e1])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3807:b0:3ad:a232:403f
 with SMTP id 98e67ed59e1d1-3ae897aa79emr9013104a91.56.1793633835815; Mon, 02
 Nov 2026 07:37:15 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:44 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-16-vipinsh@google.com>
Subject: [PATCH v6 15/27] docs: liveupdate: Add documentation for VFIO PCI
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add documentation for preserving VFIO device files across a Live Update,
generated from the kernel-doc comments in the code.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 Documentation/core-api/liveupdate.rst         |  1 +
 .../driver-api/vfio_pci_liveupdate.rst        | 25 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 27 insertions(+)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 2bce2644eba2..20f1d2e20508 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -38,6 +38,7 @@ The following types of file descriptors can be preserved
    :maxdepth: 1
 
    ../mm/memfd_preservation
+   ../driver-api/vfio_pci_liveupdate
 
 Public API
 ==========
diff --git a/Documentation/driver-api/vfio_pci_liveupdate.rst b/Documentation/driver-api/vfio_pci_liveupdate.rst
new file mode 100644
index 000000000000..81077ea173d1
--- /dev/null
+++ b/Documentation/driver-api/vfio_pci_liveupdate.rst
@@ -0,0 +1,25 @@
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
+- :doc:`/PCI/liveupdate`
+- :doc:`/driver-api/vfio`
diff --git a/MAINTAINERS b/MAINTAINERS
index 167aa9d66ce8..2b62a0b8a48c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28661,6 +28661,7 @@ T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
+F:	Documentation/driver-api/vfio_pci_liveupdate.rst
 F:	drivers/vfio/
 F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
-- 
2.56.0.317.g454f8302e1-goog

