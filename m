Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA73BB9F5;
	Sun,  2 Aug 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683443; cv=none; b=tz7SrF7HcrKWln1l8Wtj1/t0jsYqUGL70t7gs5ZT7Sm0F2TJaXYKcJIoKc5etb++vY3jI242yTUWznjE/VllgOyNdlRAYW/QO/pAdSUnc9WFqJ6JgAxh4gctiTySRocrrij2Eq0Z0wHmhrXE4G8krMVLRS3xSN233TTewUFs0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683443; c=relaxed/simple;
	bh=+TSRkZFgOzjHlqf1dhIxAq2ILzG8Xob7INfRZCiCw0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JG+ORq6Ie1k9p++kPI8K0yAvV0ty5JNxTRnU3ZcVYnDYRpKigLcHQKiTis0gyvCT7IMOYtFs7NspqEkVX2NwdTff9Pgkzn+LdWPqkYT3dkOrInr3Ern7u2eTVuzq21PGMSG7q05xMQVzwYJxkbEQm4ju2ugRk7MSlrh5IgqBotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/WgBDtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/WgBDtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588101F00A3A;
	Sun,  2 Aug 2026 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785683438;
	bh=0LbBCEMB73kHkfgnChHArhyM9WSvUEjBlEKOk1kAohQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/WgBDtTaG5ZMfmHVgiA9xQUgf6Ik+V8JrakjvuIt1DssboURTYdOx8xXuBuhst2z
	 V2pdPynO8KKztJeN5fbKtbj49Wlv7DJb7AP8gfop4IY8QvumLIc28WmmSqq6GEC4gT
	 XE8TzI7dDbVFAyBMhkpqdFLxkqOGBjbVfOx/cZTfTxfrpoBN4DDtHCcY6iOJdO3AY+
	 /UoPz8x0QGrbi1A9oYuj/nFSoEButbo+7o8P5AryQjssONbMGwT1u1XB2pCTfeXJqM
	 4jql/8mhpRIBmd7OlEA7BhXEa60bZuhFGuqvX/cEqjk7kzT2OLYeiTLMF9sBvxYeiS
	 EN7PMUCfHW0qQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 09/13] PCI/P2PDMA: Document ACS egress control handling
Date: Sun,  2 Aug 2026 18:09:47 +0300
Message-ID: <20260802-fix-p2p-acs-v1-9-a7c5eb64fff6@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Document the ACS P2P Egress Control outcomes used by P2PDMA: a clear
target vector bit permits direct routing, a set bit with Request Redirect
enabled sends the request upstream, and a set bit with Request Redirect
disabled causes an ACS Violation that P2PDMA rejects.

Also record that pci=disable_acs_redir= clears P2P Request Redirect,
Completion Redirect, and Egress Control.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
 Documentation/driver-api/pci/p2pdma.rst         | 8 ++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..5c3ed4fd439c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5226,10 +5226,11 @@ Kernel parameters
 		disable_acs_redir=<pci_dev>[; ...]
 				Specify one or more PCI devices (in the format
 				specified above) separated by semicolons.
-				Each device specified will have the PCI ACS
-				redirect capabilities forced off which will
-				allow P2P traffic between devices through
-				bridges without forcing it upstream. Note:
+				Each device specified will have the PCI ACS P2P
+				Request Redirect, Completion Redirect, and Egress
+				Control features forced off. This may allow P2P
+				traffic through bridges that would otherwise be
+				redirected upstream or blocked. Note:
 				this removes isolation between devices and
 				may put more devices in an IOMMU group.
 		config_acs=
diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index 192e9717b62d..85d4426847a1 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -15,6 +15,14 @@ then based on the ACS settings the transaction can route entirely within
 the PCIe hierarchy and never reach the root port. The kernel will evaluate
 the PCIe topology and always permit P2P in these well-defined cases.
 
+ACS P2P Egress Control does not by itself force a transaction upstream. A
+clear Egress Control Vector bit for the peer port permits direct routing; a
+set bit redirects the request upstream when P2P Request Redirect is enabled.
+When Request Redirect is disabled, a set vector bit causes an ACS Violation
+instead. The kernel evaluates these controls together and routes P2P DMA
+through the host bridge when the direct path is blocked or cannot be
+determined.
+
 This evaluation covers the ACS controls that govern Requests carrying an
 Untranslated address. A Port with ACS Direct Translated P2P enabled routes
 a Request carrying a Translated address directly to the peer regardless of

-- 
2.55.0

