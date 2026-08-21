Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566603FE352;
	Fri, 21 Aug 2026 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341293; cv=none; b=UGPbZtkxZTa39qtkcgFlMwU55+j58cx1xh5UkBsSzOpmxSj/rFellQy8Hz6lAkZvRmFzyiU04yVDhMI2Hj00z6VnJoPbI4NjpNHIuSZVX659CyaRQ1M0Q5Yz76Gg+tkDgwUP2S/MHY4oZ+x62ohwOfzcGdKC2jPCB5x/yesytBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341293; c=relaxed/simple;
	bh=W7Dcml9dj0bvaCeKUsEYd4dI5Lrou3Y+oBBPgw8InqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjOpCwSqkPH9cMxBCDEgwRbj/ZuhiHYlhcq6DOWlhC+hmX9POQ8WmJ1Q5ZnkTnmp/hfgPsNQ91vtfLowHEIJqD6Idu+LiLzHprKci/SJ8emlMHc2GOkvkQF353/+L0GjxQ4L/idgDbp85okVRv1sXzi4DvlQqdw5aBMLXCo3u7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lch0BQMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lch0BQMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ED01F00A3A;
	Fri, 21 Aug 2026 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341292;
	bh=6mP/Avgd5Tl1taSSLkPX27T1qbI/rJ9gHsfGNDpMRyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lch0BQMYnWBGI7Cbe3pS8xzu4b7PBmAUFOsXPTTFUbbUmRnMxMNcFPm+9+X48GQfJ
	 FirxDi1SaTIHNXWf8u24EHunbX1dPMrl+eRJwWyU3GSFXXNJ6fQglYH7H/PMs0EmGx
	 JVAjvuPDy8ct2YTN9jpVaz+4014cu+OgC4PjQltCaO3NLJA0/XnFT7WWhk7Q3UVlk8
	 c+jvkGLDQK7NxJyY8LztLTOmi12ezk6sc9r5oOqtImXL4sNB1MVPePgPoObX6B/+/v
	 Ase+v6W+qUNXGMFCqBf6JKQoQhKAcZ2E8kW4YqE3M0zBAMo0qpxI/iSh3dU667dfAY
	 EnqGpqYNkNkXQ==
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
Subject: [PATCH v4 06/18] PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
Date: Fri, 21 Aug 2026 22:38:37 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-6-94426b96de73@nvidia.com>
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

calc_map_type_and_dist() prints every other diagnostic under its verbose
argument, but reaches the "Host bridge not in P2PDMA whitelist" warning
through host_bridge_whitelist(), which it hands acs_redirects instead.
A caller that asked for a silent answer still gets the warning whenever
any port on the path has an ACS redirect bit set, the CPU is not
whitelisted by cpu_supports_p2pdma(), and the host bridge is not in
pci_p2pdma_whitelist[].

pci_p2pmem_find_many() is such a caller. It sweeps every device with
published p2pmem and asks for the distance to each client with
verbose=false, and pci_p2pdma_distance_many() recomputes rather than
consulting the map_types cache, so the warning repeats on every sweep.

The argument was never meant to say "ACS redirects were found". When
commit cf201bfe8cdc ("PCI/P2PDMA: Warn if host bridge not in whitelist")
added it, acs_redirects was a bool pointer that the quiet entry point
passed as NULL:

	if (verbose)
		map = calc_map_type_and_dist_warn(provider, pci_client,
						  &distance);
	else
		map = calc_map_type_and_dist(provider, pci_client,
					     &distance, NULL, NULL);

so the argument was true on exactly the path that commit describes.
Folding the two entry points into one verbose flag turned the pointer
into a value and left the call site alone, silently narrowing the
warning to paths that carry an ACS redirect.

Pass verbose. This also restores the warning for a verbose caller that
takes the host bridge route with no ACS redirect on the path, which
until now was told it could not use peer-to-peer DMA without being told
which vendor and device would have to be added to the whitelist.

Tested-by: Tushar Dave <tdave@nvidia.com>
Fixes: d1b8dc09dd71 ("PCI/P2PDMA: Simplify distance calculation")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 49bc8cf06240..a364008bbf50 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -750,7 +750,6 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 	struct pci_dev *a = provider, *b = client, *bb;
-	bool acs_redirects = false;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
 	int acs_cnt = 0;
@@ -821,11 +820,10 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
 			 seq_buf_str(&acs_list));
 	}
-	acs_redirects = true;
 
 map_through_host_bridge:
 	if (!cpu_supports_p2pdma() &&
-	    !host_bridge_whitelist(provider, client, acs_redirects)) {
+	    !host_bridge_whitelist(provider, client, verbose)) {
 		if (verbose)
 			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
 				 pci_name(provider));

-- 
2.55.0

