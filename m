Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D23769FF;
	Fri, 21 Aug 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341287; cv=none; b=Ec+JCki02teF6fwwBtKmDe2CmEbtP4OE6z9RWr5cqux+aepdcALMAAawTZoKxK43WI01xIdrPGQrF5bA8a1XtKMutJEy6ffpVtP9jpwbbfF7umxDjWg8aQokM2bHcQZHH8ZXwOG7G+D2xp90JOczyc4RYDHqKJ9vlKxNGd85/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341287; c=relaxed/simple;
	bh=7HgnO5PvRM2c7MdsVmwUsTZRTKHS19oUe64epfxeTeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7cooW+pBwtPFyj8dtwpRFKXj0GSKx8JvMZdEwYO7r/Ib8cb4Ol95zMX+x7XY5x5YdcdXqIp4HjIuUdbfvGlPvrMJgmOXDT6tmwsbWoOgimmURvi0YsYyP3aaa0M9H9i+OP6eNkkGFLSbcHcyCs8zXu16WGV1TbtAgBjvhTm2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWtzUlhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWtzUlhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A251F00A3D;
	Fri, 21 Aug 2026 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341282;
	bh=GCyuBAhR+92AP2juIuNwFAQ+I0JhibYhs3r9JeOnGvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWtzUlhfGgA2U1ew13OlIYqLoghtCVwb+Cv5uSvxQjdtnp+gazxgSXf+vqpg/AZAE
	 f63HoUzT6uJ2zkbHjpusLr8Litx13hEgukbfYuFFPTsrF2ldx+6/hF003siocc7rU4
	 qAZO/pB109USZbnKyAqIb3Zo9PF7J97zCND4Twv6JNZ8iixlAl2sH1EyrGAz4FjP1F
	 yosm6MsGKqpVOZM+hGMwiw8z5XALX4U/qZGgzvUS8Cij2xX4w8y6q+d40fglTZ/TOZ
	 oD3KyTTP0F2wVaGhrB2UUb3ir2Bk2DBAKqS8mUVf5wxkBaTofsSGxky3YVU/XqcDXy
	 o54VV0gel/IxA==
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
Subject: [PATCH v4 04/18] PCI/P2PDMA: Safely terminate ACS redirect lists
Date: Fri, 21 Aug 2026 22:38:35 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-4-94426b96de73@nvidia.com>
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

seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
path unconditionally writes a terminator to buffer[len - 1], so a path
with enough ACS ports to fill the 128-byte buffer writes one byte beyond
the buffer when verbose diagnostics are requested.

Use seq_buf_str() to terminate truncated output safely and remove the final
semicolon only when the buffer did not overflow.

Tested-by: Tushar Dave <tdave@nvidia.com>
Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 6618ef170ce1..a77ef9deb3c6 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -767,11 +767,13 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	}
 
 	if (verbose) {
-		acs_list.buffer[acs_list.len-1] = 0; /* drop final semicolon */
+		/* Drop the final semicolon; the list is not empty here. */
+		if (!seq_buf_has_overflowed(&acs_list))
+			acs_list.buffer[acs_list.len - 1] = '\0';
 		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
 		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
-			 acs_list.buffer);
+			 seq_buf_str(&acs_list));
 	}
 	acs_redirects = true;
 

-- 
2.55.0

