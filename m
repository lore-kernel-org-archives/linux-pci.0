Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F840DB4B;
	Fri, 21 Aug 2026 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341329; cv=none; b=FYIWNkq1v2M5UNPHp7z30lA6r7KYiAwYfYBbfR2QJZz5bm6wrP8TNM3zb+7DMuj8bAcvg0+aotzcq9T/at3/lhFzP884yJEK6UwXrDgThLPDSlgFF5DqcXqg8itIcQfJqBMbSQjTyjmV1zlXy7ak2286RW5W3o1NhGKruX22kmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341329; c=relaxed/simple;
	bh=LMvhgH6LUmo4fxHlYX8ajmD8cHYJoCj4jo+mMIAOpRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA6O3i4m0mp8T3SaCOvKeuDQq35rSfcQg5INOmweFieblRMCU+MN6ZitWHlj46FsFLmtRBUIGQTRawcnTeac/pO9cDobkmSBcTq6Q5SCD9LUzDwCJVCijG+4NQeL52fcjptT4+6S+M2SD746MlFEq2bSoXAJF8XqAIwoufJVXfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUef1Zqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUef1Zqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FA71F000E9;
	Fri, 21 Aug 2026 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341328;
	bh=KNsaL2xN6oXqbf61jQYxhGakuH1AEsrVQlg6bAS+D7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kUef1ZqppWfnTA28oBx306aZjZKBLX74aDQkEQDqmZj2uitdO6fBfC3SyuYqDXXoh
	 ALIRCSk7GK5U3VTYa3lQxIzFk83XNQeNTgLtwdtjZN2GGCJdo4nCzfmWKee+lqRwNZ
	 cOaParbp/xUylI0NS7aHeR7SFIMkpZSMHGJTL9VsDNsnDMHe/E5b6W6Z2x6z6SCfyV
	 GaiIIjzbDUzpwST2+9H+CD2jVpCLQ+fhmbNrWo7mah4SCOCxClSTWlT+JTeVd9G49s
	 Ipov2inq/qUK6YHqGT7O09cJ/QFF1OUYV7iiqgjaFcB43OO8G41XxLjRtrDCxPweLL
	 yljIIDRu479Bg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>
Subject: [PATCH v4 13/18] PCI/P2PDMA: Document ACS egress control handling
Date: Fri, 21 Aug 2026 22:38:44 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-13-94426b96de73@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
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

ACS controls are directional and affect only a peer-versus-upstream routing
decision, but the P2PDMA documentation describes them as path-wide. This
can make valid asymmetric or nested configurations appear unsupported.

Document the fixed transaction roles and the two ports at the path
divergence. Request Redirect and Egress Control apply on the client-side
port, while Completion Redirect applies on the provider-side port. Controls
below the divergence cannot change traffic whose only route is upstream.

Distinguish redirects, which establish a host route, from ACS Violations
and unreadable routing state, which must be rejected.

Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++----
 Documentation/driver-api/pci/p2pdma.rst         | 17 +++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

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
index a7fd426c3685..4e21942eab65 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -15,6 +15,23 @@ then based on the ACS settings the transaction can route entirely within
 the PCIe hierarchy and never reach the root port. The kernel will evaluate
 the PCIe topology and always permit P2P in these well-defined cases.
 
+ACS P2P Egress Control does not, by itself, force a transaction upstream. A
+clear Egress Control Vector bit for the peer port permits direct routing; a
+set bit redirects the request upstream when P2P Request Redirect is enabled.
+When Request Redirect is disabled, a set vector bit causes an ACS Violation
+instead.
+
+The client remains the PCIe requester when it reads or writes provider memory.
+Where the paths diverge, the kernel therefore evaluates P2P Request Redirect
+and Egress Control on the client-side port, and P2P Completion Redirect on the
+provider-side port for completions from a read. Below the divergence, the route
+toward the other branch is already upstream, so those P2P redirect controls do
+not affect it. Redirect controls for the reverse transaction directions do not
+affect the mapping. P2P DMA is routed through the host bridge when either
+applicable port redirects. If an applicable port blocks the direct path or its
+routing cannot be determined, P2P DMA is rejected because neither condition
+establishes an upstream route.
+
 This evaluation covers the ACS controls that govern Requests carrying an
 Untranslated address. Unless ACS Translation Blocking is enabled, a Port
 with ACS Direct Translated P2P enabled routes a Request carrying a Translated

-- 
2.55.0

