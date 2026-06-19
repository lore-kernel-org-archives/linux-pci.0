Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0918FDBD;
	Fri, 19 Jun 2026 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859206; cv=none; b=s5Y2A+8tonEijkk+7AuPODwOyKMylQIEaBw7gL7h7OR3+ec7V4I7L5OX1Ws6WGiKkCTrBS+C9T6MjBcqTC+vasZVbiBUei4XgjhzOnMpaq5LJww2pRIPk4sPYATIXk9yMXpm696+BgGHXwIsbXWhixiQPlFnmKLvjkS0MS72bgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859206; c=relaxed/simple;
	bh=KiaFd4PpnfmGmqkmxIwHICxty2iDv0zlEZWteQ08I0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pK5dsfLNkIgtUvYe9OKDZ98VAj+oSMRq93jP5HZqhaYfaOl1qzwuyFp7q7o9/s1zjDN5Ont9Byc00e0RjFF/a2hK+C3sbDdoTqVh5wxL2Rci1PVi2O9uKrAG3JDC0tM9kFAeusGWVU3CnhaQN6K+ybyH8ltVe16x1z2Ua4vLIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeVHvZif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeVHvZif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05721F000E9;
	Fri, 19 Jun 2026 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859204;
	bh=dbM84zULMT6V9HfsvwMXiKi7ogKVG6V+A2YJ5SSZgLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeVHvZifatbxVAiajK5ST7eBAaWpvKEy7RWco2qiJbcDFt7S4CdaDZqqMw10hac9I
	 n93h/Uhy81DArat2rMqwHo0hdeZPYgIKY+APBExhNsV8OprLTHMVcmg/AB4lbsDwhO
	 Ii7dAxIt9z4nFsSHm4ayVcP9iIW6EUO/c0HcaF0cdGUuKGe5SDF20gj2L+5Jfxy88I
	 luFSogWk8tOU+WqHjEawg52OKZsMBsAnxvRyawcNx3eFdxicOsHkYXBht5URd8LihD
	 0gjRzNGXrDN174IZm60B91dJQDctAt4aHYqX3cN5TcmRPgc7o0F7m3fLxAsdW6v6Nm
	 sx+g+h4DZbZcg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 22/25] PCI/sysfs: Add legacy I/O and memory attribute macros
Date: Fri, 19 Jun 2026 08:51:57 +0000
Message-ID: <20260619085200.3729431-23-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add two macros for declaring static binary attributes for PCI legacy
I/O port and ISA memory space files:

  - pci_legacy_resource_io_attr(), for legacy I/O port space (read/write)
  - pci_legacy_resource_mem_attr(), for legacy memory space (mmap)

Each macro sets the fixed attribute size.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a861484ac0c0..7f1d8e07924f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -893,6 +893,27 @@ pci_llseek_resource_legacy(struct file *filep,
 }
 
 #ifdef HAVE_PCI_LEGACY
+
+#define pci_legacy_resource_io_attr(_suffix, _size)				\
+static const struct bin_attribute pci_legacy_io##_suffix##_attr = {		\
+	.attr = { .name = "legacy_io" __stringify(_suffix), .mode = 0600 },	\
+	.size = (_size),							\
+	.read = pci_read_legacy_io,						\
+	.write = pci_write_legacy_io,						\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource_legacy,					\
+	.mmap = pci_mmap_legacy_io,						\
+}
+
+#define pci_legacy_resource_mem_attr(_suffix, _size)				\
+static const struct bin_attribute pci_legacy_mem##_suffix##_attr = {		\
+	.attr = { .name = "legacy_mem" __stringify(_suffix), .mode = 0600 },	\
+	.size = (_size),							\
+	.f_mapping = iomem_get_mapping,						\
+	.llseek = pci_llseek_resource_legacy,					\
+	.mmap = pci_mmap_legacy_mem,						\
+}
+
 /**
  * pci_read_legacy_io - read byte(s) from legacy I/O port space
  * @filp: open sysfs file
-- 
2.54.0

