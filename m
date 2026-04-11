Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0613D8B1;
	Sat, 11 Apr 2026 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894548; cv=none; b=HmuYu+9e5J0BALRJOXjqjRrTyYG+oUQEyOcIMQQsoNUABAtmOhRXzaUm02kubD5625dkAnf76S80NoyCSK7+k7s7bfzAfhBN+xnE+ScupU0s3PjP+j62wDZIRT0crGt5knORasosLBFWvUOsIpGTiziLJRbTvYeFl79du1k9r28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894548; c=relaxed/simple;
	bh=z/qUE/WCrDQr3RvpHa7YYVIuPRUsL1w2bKCzec+b0mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nnoj/Q9jQNfLz0LbLKyzZh4AYMCjOCLEVNX4Qd7Fxmysztyt+wg7KOd0MBf6YRPYIpxYpQUmK35InzjpPy25fCs0ujczPrG8BGNK4q1avE+3yq+HxZEzQjsT9m9kz16HZoumN+tEV9IqEAcCXdDBRSDqkDjNQxjodmPZRokrWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVOHS41H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVOHS41H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62414C2BC9E;
	Sat, 11 Apr 2026 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894548;
	bh=z/qUE/WCrDQr3RvpHa7YYVIuPRUsL1w2bKCzec+b0mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVOHS41HZ7O7pGPF9br8SY1u7sHcyqrpjKdi/qFbedrMDNdsefupHlKuvayTRXp2P
	 9CKxMY7yNwr7P4gtKaVpTsrfZqcqfQZut6uVBxEDOfWtox0qPo/jvefLb0Wl4+XbHW
	 v1rCyjfQsqsGW/wnS+lTpTEudhdPgGlhaOLjzuP3gZxmotOyQ0QrWIZjF6a1rjt4l1
	 9OuTnEN+bDhZfhG2CDDwzMOuOQocZBhTFzCYmadriPBC2Eg3sUm8DsqbF6t12bUaxu
	 OvL+CxxTZjB4wgimS3tRHbg0z33RLpZe52g0fCkFW3903L2ztkBnOcN4kMd61rFwZF
	 vEHFsBQjsLAhA==
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
Subject: [PATCH v4 10/24] PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
Date: Sat, 11 Apr 2026 08:01:34 +0000
Message-ID: <20260411080148.471335-11-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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
2.53.0

