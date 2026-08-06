Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36940445AFA;
	Thu,  6 Aug 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015566; cv=none; b=es1U6g22Zxj1ULO79lfb3aJzlzTmZx2IUiNgI1Abn17fJggMqAReNMGKhobVwXOpxXGUT55dDisCZOSOlWKIZ6LvasX8DQ0y8CVmpXa7wd0Pd8GLZ5vx7KLQCvjsfgcNKQYwvKUAL7qg+ibk3kkqo1zCFtByTt5SIuJpfX2apSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015566; c=relaxed/simple;
	bh=/qB9EPt1SuVzuKHk/38dt/1egMHZPkRfIW0RsxVoujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdgzYNnxUR53vpNwmrsJ2LBK0UhmQ6OhHrJgVm+UFTiloGtl3Z+r4Gwr7Vf2iI8SawQWnoJD6CPoIXCa7nwZUjeIyN+zM/3IfSOlThgAUEBMBW/jl4om3cQIBeNnKmaWH0PQ0LJPOUWODQUfSPcjR71Vux5qZN9gJODG4Ohooo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNolqjCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNolqjCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E8F1F00A3A;
	Thu,  6 Aug 2026 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015564;
	bh=OZZXkIc0GQwiMsud/EAnsqCEGP0vg8WdJvCkLVJM+5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SNolqjCU87djA/Ve1uQV7gC44+woalX04ijCJIEk0SscLiy/35hDGWZC8zQSaOM2Q
	 we94pBLRWaxGSFUFjueLX+WFuTmHOChWuWwuWophc92K39lwEARfEyAvRbCar0WNgK
	 4+SSS9VvhQk2L7eEAdMvXbbVAGfqORKVAFfmkOg75W9JSkMC8qUJotEiI2GzMKZrau
	 KwtY7dxcpV/sR6nm9pp/A05vsVxhraDg8DlKmjnW8rzG9crtXRGOe92qBLa2KfSmuN
	 7NCaJrocYBts73cDrzzNzhTGVvK1MdkP+zLzjHUuYADxTZWkz3mi/H28kY1nwTN1YO
	 pGSvthjvjcY/Q==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 09/13] PCI/P2PDMA: Document ACS egress control handling
Date: Thu,  6 Aug 2026 14:24:16 +0300
Message-ID: <20260806-fix-p2p-acs-v2-9-0cec14812965@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
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

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
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
index 192e9717b62d..79bfe8055b43 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -15,6 +15,14 @@ then based on the ACS settings the transaction can route entirely within
 the PCIe hierarchy and never reach the root port. The kernel will evaluate
 the PCIe topology and always permit P2P in these well-defined cases.
 
+ACS P2P Egress Control does not, by itself, force a transaction upstream. A
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

