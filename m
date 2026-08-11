Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6381430CE1;
	Tue, 11 Aug 2026 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440698; cv=none; b=FydxmHvWphVDDcJuCZ/l9EA8Zqj4zIpIrBqwZ9p+LNU4WeTeItikXWeWdHedw6aS7DyE7wVX9X8mSSI9rCopgT3c+YCxp9wPx4p4Ixcw4eydcPZjC8X51A4cwvYc36m2FavBHU6DDPpWs6B/3IRLf7vxgwcFStX+GH2urGVqIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440698; c=relaxed/simple;
	bh=Jvc8O9aB4fr5CPxCyMYzfrAWdkXrm+ubP7j0sCQsulE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9vbsl/tq0/QZFfzzDEy7qMzWCpteKzABHiqYGxy+pY5C5Q45nKIBM30wFFTXL+BtrQYJ9VgRz70lRlZ4e+iUczH33K3VStI5Bz7YYH+N3KmujGpSEwW9ZzPB83IDGTxPdeDgUZjoL0R/N1Iaxin6XIXjDYeTnA/nChqR/yOiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAb95SzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAb95SzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BE31F000E9;
	Tue, 11 Aug 2026 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440696;
	bh=atU9QUcTmgMbDE3QFRiM5Hhj+AAChNXCTaJk5Hfy/L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAb95SzXBW2y2NX3+VCObdFzlsE2VUWRMJYljCDqk/vzYrpKXfm7iG7kSnqZ7SaWa
	 qUf+LaaM4NyxyTD2jiSXHYR9Dnu26BpOW7HDlHZTxi6KmYcVyrTmrCbgxTSrtp+2X9
	 6bIWaXIAzO3MZqqPmYd732dLO/RUet3pq36WeSAy9zPVzaadikKsmvHNWxixu4l5Fd
	 7vO/XqCxHXYe+nrLu1Y20+lp6ukVRS6DztmlSkv92ThXWDKXDjPPPF7cEaqo0FGNJu
	 zQFs5XIS5sm5zO8DeaANeocGC+E7o2NjAePVu6Kak8t1NXuno+Pg6+icQmhh8n32HH
	 UyCDG4zLIXdcg==
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
Subject: [PATCH v3 04/17] PCI/P2PDMA: Safely terminate ACS redirect lists
Date: Tue, 11 Aug 2026 12:30:46 +0300
Message-ID: <20260811-fix-p2p-acs-v3-4-efc488ee7c03@nvidia.com>
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

seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
path unconditionally writes a terminator to buffer[len - 1], so a path
with enough ACS ports to fill the 128-byte buffer writes one byte beyond
the buffer when verbose diagnostics are requested.

Use seq_buf_str() to terminate truncated output safely and remove the final
semicolon only when the buffer did not overflow.

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

