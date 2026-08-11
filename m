Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690A43A80C;
	Tue, 11 Aug 2026 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440726; cv=none; b=ceAcpto2S3/N4mrdOGLRdVRFzBbbIFpU+QD3yuqF5vUnRr3+m2UMJ+YbDAvtdC3n/kwO5Pl2kbAuiHS0qm1IzcU1ENEX+korGMegFSVARl3O2rGp9sGXCQwjSm3PGCu6D8JgQBaff8eUHiuoErNR/qYczd1dRhNO6nUTYR4e7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440726; c=relaxed/simple;
	bh=TLQDvKOAPD4WOMF0kj2k/X8n13r0aMes4uuRLi3koa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wwyq4B13yD+XQOtoB22rKhFG1OGxLEiAc3vdWxt9H0pdgh2mNgcnoPsYRYbX+FdBl59O8p9QyPNJEhC/BnKl3iE14mzIlgPeVzh7WBOz/z4ocOECGtHIQElmOBEIeNWYjeEJlYU1MVuFWteJbOFS32TdrJq/OYyxcVhXXCH3rpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/OnwWEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/OnwWEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB741F00A3A;
	Tue, 11 Aug 2026 09:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440724;
	bh=09VxA+XpyBE+sTpo60zn6eYSOkH91ZUsB7fB5VsT4XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/OnwWErtDUuZVKKcmxlNIq5eiLWannOsjjzs8nu5OotwpyNFKnKH7pg3gncEsL48
	 qy22p8mlq1ayXEltVZXCY0Oid8jqZPWkBm7M7mDT/9VnkB3/Pou8+Ssa7MvRB13BeT
	 +/BGlJRetFiXxcwex9kAJUHwo5Nf8edJMYKLB8OewTVdy0cKEzLFTg2sujBMw1VWnQ
	 hsMzAcUyu7z+lPmfUuDN0075AagKR94h43f6O+p0kCdcm9QmTD7N+bbG1BhQZ1+IZy
	 1A3s3KmwvTXiObejfh3AArGuZSyTH3sD5U4C6v/nE17aqrjCrbxIM/bhpqN5WNfnZ1
	 BppWHg73GxvqA==
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
	iommu@lists.linux.dev
Subject: [PATCH v3 13/17] PCI/P2PDMA: Document ACS egress control handling
Date: Tue, 11 Aug 2026 12:30:55 +0300
Message-ID: <20260811-fix-p2p-acs-v3-13-efc488ee7c03@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
References: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
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
index a7fd426c3685..b759a1b828e0 100644
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
 Untranslated address. Unless ACS Translation Blocking is enabled, a Port
 with ACS Direct Translated P2P enabled routes a Request carrying a Translated

-- 
2.55.0

