Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37D42AF9B;
	Tue, 11 Aug 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440711; cv=none; b=NK1gXA9T77x78ioZ/4Otgbtd8bExBfXq0KP6e9ZjgOLuL0ksiVKl9lbmv0mLT3/grxH1jO6FVVJARw51k7fcBY7480YIcAKT78y5fU9NsRz55zpHoBL/COQpOu8NRbZNjBq9GtJQfeI5e6oJ2yZmNrfSiJ8K80uxwZvfQHdUpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440711; c=relaxed/simple;
	bh=nxWNJX3YUnQ3wS+Ge+YXFuztqyh0Jb5li7SRLsAC6nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VL4SH8KlSsNTGW/BAXdJc/5gxCB8P7agxKQTkT3m7jSDfOzrE04WsRm4E7FPPQGUr/SilfBH/mlWd7yMAH6a249R6MplPhHPMR/EAKx1xWIA/GzbIYKKtiePUR/yfPhSq89mxSAqaoQXFFYHyYUmS8btrR2MnlU+EX8VD/6sjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpJ1NCVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpJ1NCVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C78B1F000E9;
	Tue, 11 Aug 2026 09:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440705;
	bh=mF5n3YOfW5QrsqIP73nDBBVRmhqCEMlU86R6zm1GxNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jpJ1NCVD2jjpQURmMMkbm0pOkveTCWptwy52n+JyUOt8zZpyBX4im0Hz/vQaO7pJj
	 /0s7h4KpqsQc7uV/joZIM+t0bhPfxfkQd8OJKIHGsO2PGREhO404xXo+iyrEYzv+7s
	 snvAqElSUZFBIJLyaHWeIPjC77U0i5WAiRBaN+j24xcM/YV/xVbMHhQ1oTsXf7eh7S
	 sKn4k0WApcOEGMgp24Ms7pKexZho4In5zfhjWstnJ1+K/wThBxGEjJw1E5s2aHuKHY
	 FOTlXmhXbkabcjn5HI0SP2AxzoVIamlb7ucwbSzdtubhdQpMgf85V5s4+25C1KKbTa
	 qqYkvZhJo2KoQ==
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
Subject: [PATCH v3 07/17] PCI/P2PDMA: Document the Address Type assumption
Date: Tue, 11 Aug 2026 12:30:49 +0300
Message-ID: <20260811-fix-p2p-acs-v3-7-efc488ee7c03@nvidia.com>
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

P2PDMA selects a mapping from the ACS controls that govern Requests
carrying an Untranslated address. PCIe r7.0, sec 6.12.3 routes a
Translated Request directly to the peer when ACS Direct Translated P2P is
enabled, regardless of P2P Request Redirect and P2P Egress Control.
Translation Blocking takes precedence and prevents that direct route.

Document this assumption because an ATS capable client can otherwise
reach the peer directly whichever mapping P2PDMA selects.

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

