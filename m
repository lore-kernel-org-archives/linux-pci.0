Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86B37CD3C;
	Wed, 22 Apr 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874486; cv=none; b=owm69rA/YQ/J3IgbouCNv8JVb66c/rc6LTZdOKnY0z/hBk2X4BrvomPmGSteDs9BNXW/5WV+2qQJgZqzXf51GtBXmIa0f63B2ZGnYwqBJkYmOZEWABq+SUv6fJJRTefr02XqTODD0zzfSUHrkPKSGfbf5z/OMdOrjOr7weTJ/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874486; c=relaxed/simple;
	bh=dlbGO9fbGQS1YQSRBPJiq4zvxG0cWPtDw+JWina0FxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZlmUONBpTrjmJ4mktiY/hrr+jxPWLMIfujWvsG4wpp5soFEqPZ7b4lslZQZcD7CXW/QID8xfN3HBh21Dd7gGr/og8KHuRmVFEkAJAmmJaACxCkBye2WjWfP14Znpq/xbA8eNUHJFuJeeUxAVM7yZejNMEl5NSeykIn/WaDlvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j94rSVTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j94rSVTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE33FC19425;
	Wed, 22 Apr 2026 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874486;
	bh=dlbGO9fbGQS1YQSRBPJiq4zvxG0cWPtDw+JWina0FxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j94rSVTh+5UeOUKQaoN1gfEsKWQkRUzjg3zaC0NSfkkCC9+Ck5gfIdV625AgTuZ+i
	 aRRFtO5I6QN5CBdo4J0VNrNQ6i95dC6HCVTbUubsquI93Dom/qFscn82ZHsOD/DRLm
	 7u0O8rv88/vo9vFlHQ8ISz+pUaX0SI29AlZzV9531SDVeZfu4xvIVEgDvJqXjK8mz1
	 HYlHmUF7qcKDXJGcDh6IKvw2/RgiG+ZODTtl/rbYtf2ViKYVXZMQPPIuIXhPR2hY7I
	 ip8GsC+0qyQhyA4I5TotJZSEZuvlagXZt1eqvaOnyanFFbDnV4mhdcdS7aEJGPk7Yb
	 ifKC2Yvtm5L7A==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v6 10/24] PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
Date: Wed, 22 Apr 2026 16:13:53 +0000
Message-ID: <20260422161407.118748-11-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, pci_sysfs_init() and sysfs_initialized compile
unconditionally, even on platforms where static attribute
groups handle all resource file creation.

Thus, place them behind a new HAVE_PCI_SYSFS_INIT macro,
especially as the late_initcall is only needed when:

  - HAVE_PCI_LEGACY is set, to iterate buses and create legacy
    I/O and memory files.

  - Neither HAVE_PCI_MMAP nor ARCH_GENERIC_PCI_MMAP_RESOURCE is
    set, to iterate devices and create resource files via the
    __weak pci_create_resource_files() stub override (this is
    how the Alpha architecture handles this currently).

On most systems both conditions are false and the entire
late_initcall compiles away.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 517efb6d71cc..d22bc5c48bc0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -37,7 +37,14 @@
 #define ARCH_PCI_DEV_GROUPS
 #endif
 
+#if defined(HAVE_PCI_LEGACY) || \
+	!defined(HAVE_PCI_MMAP) && !defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+#define HAVE_PCI_SYSFS_INIT
+#endif
+
+#ifdef HAVE_PCI_SYSFS_INIT
 static int sysfs_initialized;	/* = 0 */
+#endif
 
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
@@ -1792,6 +1799,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 }
 #endif
 
+#ifdef HAVE_PCI_SYSFS_INIT
 static int __init pci_sysfs_init(void)
 {
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
@@ -1818,6 +1826,7 @@ static int __init pci_sysfs_init(void)
 	return 0;
 }
 late_initcall(pci_sysfs_init);
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
-- 
2.54.0

