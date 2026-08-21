Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA843A5E65;
	Fri, 21 Aug 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341298; cv=none; b=u1nBxxR0Rvr6OwCDOqRoUJTwOkWZK/SENt2he7jCeNconJCngo65kzFzV8gTnZ9sM0ShhMXzqCDYw8W4vvZXBxlAuICfxrwISzAhp0GcZDI8wXA0NJoKrRSSlpAmvFQNkgxedtNdd2DFsQm9q6G0xvo6bsfyuwK6u5NkCKNHQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341298; c=relaxed/simple;
	bh=yWgALl/+z6M81dHDtdqaEeWbrbdwsDnt0sdb6KyckRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D40AOG5+8/QBM6K3v3cNbp5jTI1y9WNmf44/5KiuhI475Rg2VNMovObq95elPUrrEzEsj15W3qru5+gOyUpW0Q3vmDC7UcP0huGe7U/9p5SiibD1oNvbfqBtTs0/wKrErsHSrAPZvK1S5kFBFrDpcAIWRTu8eMd+VjSn9GGdaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y07bCQQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y07bCQQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D4F1F000E9;
	Fri, 21 Aug 2026 19:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341297;
	bh=G9P6okZFaRWxkSocLb8NE6FiGRXf2Et5DYwty/Enemo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y07bCQQFEZguqWxXNuoy0kQI375WfXNaqjHxKGx0SQXg8DSFaelwhYNWmEwYkYk32
	 Da+AFebeNrvAyUuIOUgnfX0Z0Y16ZTteTcpEnv86ptfktR4AdnsO63LOL115svwUo/
	 jXCGz7sFqc2mGk5CIGoMpeFdXAnBLBq1LfhzB0RyvxlcKy8/6lGaO5oddY/aFvru4+
	 mErxyfkL+rQOQQI8rE6wWX0E0tl7PxHtK40pFkPD41BeDbT0dH1FcbE6nHOBXAHsSt
	 K0jUQAihfiaAr51gWFHNbVwAcgCGiP598o1n2CJ59FdQhd2Gcp7Dnsl0nfSX/J6mh8
	 riUB3FKrCwkrg==
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
Subject: [PATCH v4 07/18] PCI/P2PDMA: Document the Address Type assumption
Date: Fri, 21 Aug 2026 22:38:38 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-7-94426b96de73@nvidia.com>
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

P2PDMA selects a mapping from the ACS controls that govern Requests
carrying an Untranslated address. PCIe r7.0, sec 6.12.3 routes a
Translated Request directly to the peer when ACS Direct Translated P2P is
enabled, regardless of P2P Request Redirect and P2P Egress Control.
Translation Blocking takes precedence and prevents that direct route.

Document this assumption because an ATS capable client can otherwise
reach the peer directly whichever mapping P2PDMA selects.

Tested-by: Tushar Dave <tdave@nvidia.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/driver-api/pci/p2pdma.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index d3f406cca694..a7fd426c3685 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -15,6 +15,13 @@ then based on the ACS settings the transaction can route entirely within
 the PCIe hierarchy and never reach the root port. The kernel will evaluate
 the PCIe topology and always permit P2P in these well-defined cases.
 
+This evaluation covers the ACS controls that govern Requests carrying an
+Untranslated address. Unless ACS Translation Blocking is enabled, a Port
+with ACS Direct Translated P2P enabled routes a Request carrying a Translated
+address directly to the peer regardless of those controls. An ATS capable
+client may therefore reach the peer on the direct path whichever mapping the
+kernel selects.
+
 However, if the P2P transaction reaches the host bridge then it might have to
 hairpin back out the same root port, be routed inside the CPU SOC to another
 PCIe root port, or routed internally to the SOC.

-- 
2.55.0

