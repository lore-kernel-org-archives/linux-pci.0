Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4F30BF5C;
	Fri, 10 Apr 2026 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800277; cv=none; b=BdBzfsCODigH1nz8FisUDXQ14cEGf0w60MRZQR+RS9CIfO8bXkxSmpligCPXUdij8oj9QM697zcIEww//D4IsbQy0avBqr5kqGUwzqzsRxx58mzYUJ6cc+O9rLmrRwLHIBZs6iiElOWgM84NhgrH16PmK9y06ZPNJ2RhbZqN6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800277; c=relaxed/simple;
	bh=3hptuhV9yvRK5QFViJmdIejaERCBcfDgF46k3rwUdzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPgruCb45cHsrTZvGaFtVHAcVkWGHL8eZqzgZ5n3kJIeguMq6aoFgd087qD9t/apc9xhiw/I23hsUAcO9e8oLd9alqkGjIgyKK9zVQC3qI0GjE71ydrXdM5syjyf14r9HtIkg37ggW4uwypQlBZR/bPaYbf4djGxu1I/OkpyxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVeUMnFB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVeUMnFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6F9C2BCAF;
	Fri, 10 Apr 2026 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800277;
	bh=3hptuhV9yvRK5QFViJmdIejaERCBcfDgF46k3rwUdzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVeUMnFB92kckEyX6w4AOLTj43SKV6JPyWI+WtBUYmkpZDDOQKifdnGtDYcPQlEPl
	 afN0P4N57mX3XV53stpV1j8HBs+zNnRRsrSDWkSZW2FeRnTy0lYBaKE78W/7GD6iXz
	 to+Zhxoks60apXrm5tH+1kUihP78QNon1tQB4gDPxTrIUjv9To/eMvOTNpYH1sBOaN
	 pzJm/EIB9e7iJ63Tjxx2RJtHBPsEChZ3vdZssI0RN4+ZdYCHcrh3rHGg2cXIUr5LMG
	 gg/NUq3Cu6u2LyDUIPOP81q2j00XYpnfbEUrXfYgt54IOy+Znj7kTfry/QjxyPHBdO
	 7iMU488IS78SQ==
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
Subject: [PATCH 09/20] PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
Date: Fri, 10 Apr 2026 05:50:29 +0000
Message-ID: <20260410055040.39233-10-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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
index e200514bbaed..062921d5df9b 100644
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
@@ -1791,6 +1798,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 }
 #endif
 
+#ifdef HAVE_PCI_SYSFS_INIT
 static int __init pci_sysfs_init(void)
 {
 #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
@@ -1817,6 +1825,7 @@ static int __init pci_sysfs_init(void)
 	return 0;
 }
 late_initcall(pci_sysfs_init);
+#endif
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
-- 
2.53.0

