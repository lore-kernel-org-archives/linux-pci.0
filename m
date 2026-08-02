Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A093BE141;
	Sun,  2 Aug 2026 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683414; cv=none; b=fV1EdRS/6f30X8jobZDeYbKJBlBEZ5CvVrI7PUk562dyTSgNVUyKfJrO+64pCmS45oOoj3IFJ9yYAvX/O+KJS9hqg2rsoUCydi4ohQGSVmNBkWBHCpZOU5Vw5tWUAZLQWMOl1CWyQPLbN4+Cp0ScbA21HJ3ukfVtfJPKA55gYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683414; c=relaxed/simple;
	bh=zD7Z3XRx/NnAXg9ZpYq2hi9Ww+d9uV3hgJk/VddNRCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLX4LcCoayBnGHVOe475V0i2J8pBQrMe+/ddCP0A/WNhDmlskAGi9lGQPq2jDQWUb1ccNpqdnQYPlmcljV9Df+HY1Pqg3NG8m+40WI9xjehS6NIb7e1PPsJNr9YIX5CGzXIRPBYpyGpSai+V4Txo3KhceexFoZOor/xLBDsQwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU5XJQlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU5XJQlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E461F00A3A;
	Sun,  2 Aug 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785683409;
	bh=YfhVjG228lRhqeGWl3QV3O1en3dT8BOAamHtMgvZSlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FU5XJQlZSRogA14cxOb79WrnnN65Xqq9F8tqranThlTuu85pOZtqWUxxAn5f4wKns
	 Inu/xU6smQ18MlaTwa4GxTLs+5CLo3MuK5nztgki+GMeDrWdI5wwSMmuhskoxKBO0A
	 aKs7JtT6hR+vWYQoNVLKZvuWFqzjzoMeHbcWpT6mON6KxxuJfhrJaUOvFyDDILzLrT
	 gPu2Rc5QeQASh/fgD/bCXUWvivf0KnuegbEm5x4PYMNryCfxzAy+ObZoxXgXPeFw4a
	 LLwvmOPUqmHAZTzC3ZTNjR5euqDOTiqNhIIoxrakd4MisdvbsaZfIF7yBxZ5OhfrGg
	 syIaNOhPZUNew==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 03/13] PCI/P2PDMA: Document the Address Type assumption
Date: Sun,  2 Aug 2026 18:09:41 +0300
Message-ID: <20260802-fix-p2p-acs-v1-3-a7c5eb64fff6@nvidia.com>
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

P2PDMA selects a mapping from the ACS controls that govern Requests
carrying an Untranslated address. PCIe r7.0, sec 6.12.3 routes a Request
carrying a Translated address directly to the peer whenever ACS Direct
Translated P2P is enabled, regardless of P2P Request Redirect and P2P
Egress Control.

An ATS capable client can therefore reach the peer on the direct path
whichever mapping is selected. Record that assumption.

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

