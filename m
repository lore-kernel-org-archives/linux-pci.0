Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A734398E6;
	Thu,  6 Aug 2026 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015536; cv=none; b=tPxBMCNSPWSP0Ijjba6xyHkNpRDJ52nq0bLRi4rsQMf7X3NQFwmbtm6n1ROhbv/TRoRTmFgIVmDwVtdyBEqSc1QE6GpP1K37NrXaMGpFk9x6tIp9ww7AnzsndBwxS2GP0wAwrMoW5o0Cql7l49+XAPYmaSGQQgehqA20C7NRUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015536; c=relaxed/simple;
	bh=9HF2lPn0NIDL6Gu6Wq3oDuRXpGaDHTFZB6Si15MNHVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjKNVX3i1TRSfd1wU61ARPXoAiTsHHHh3dz1ejC9bTZlkxOIFdV8IpNYfFRcj23t29ws77PPffV7hpGnK5/xX4I0KCS1MNLLN7QGvtrmqGOZ2oRJRHBIJa3PRIBjIowuftLir6oCUz1D64QjPw1OT99Vt9mq0kiHjD4fR8L1aeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAkp2Pom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAkp2Pom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8211F000E9;
	Thu,  6 Aug 2026 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015535;
	bh=pVaFz6uX7Pk8ar0hwI/FKExVZXpiFksW/uzSdZJQdio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GAkp2PomR+HtokwzKbPnCcUQBYBsPP1awuJjO/gXKjceTqzEBU/bpWQearZI8OKSq
	 PVaaBhK3rLQz8qo//rzFPAlr8sVIiz5HKvvvwuNb51V3gTyPrM0+CpaEs8g25oILlk
	 uNfyxwHNsdGU4A1DeYeXhdlNgCwiEeD4ePqLhhOXSAqDGcYmoP5keIZ04QPiW5Xyeg
	 rJ0MBHh0kvCzKeqVqrJyhocbg/1bLWND+liqKRNRrropoJRdX+iRvEVA0bX+IKcjZ1
	 7z1r+3UNzdist8OXC0kIAfsmeUd/6ie0iMpChVwGB5CZ0Bgb/WWZswZHYWD88nRK+T
	 8Zq0K9PqP/xSQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 03/13] PCI/P2PDMA: Document the Address Type assumption
Date: Thu,  6 Aug 2026 14:24:10 +0300
Message-ID: <20260806-fix-p2p-acs-v2-3-0cec14812965@nvidia.com>
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

P2PDMA selects a mapping from the ACS controls that govern Requests
carrying an Untranslated address. PCIe r7.0, sec 6.12.3 routes a Request
carrying a Translated address directly to the peer whenever ACS Direct
Translated P2P is enabled, regardless of P2P Request Redirect and P2P
Egress Control.

An ATS capable client can therefore reach the peer on the direct path
whichever mapping is selected. Record that assumption.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/driver-api/pci/p2pdma.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index d3f406cca694..192e9717b62d 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -15,6 +15,12 @@ then based on the ACS settings the transaction can route entirely within
 the PCIe hierarchy and never reach the root port. The kernel will evaluate
 the PCIe topology and always permit P2P in these well-defined cases.
 
+This evaluation covers the ACS controls that govern Requests carrying an
+Untranslated address. A Port with ACS Direct Translated P2P enabled routes
+a Request carrying a Translated address directly to the peer regardless of
+those controls, so an ATS capable client may reach the peer on the direct
+path whichever mapping the kernel selects.
+
 However, if the P2P transaction reaches the host bridge then it might have to
 hairpin back out the same root port, be routed inside the CPU SOC to another
 PCIe root port, or routed internally to the SOC.

-- 
2.55.0

