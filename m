Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC36432BD8;
	Tue, 11 Aug 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440704; cv=none; b=O7a6DeGj982OTMrUrXjW7Ht/KNBQnJP3lekLCEl0xAPPODuZxmQnLJ0r22BvqAfmH1R09Iy4KVQPjnaCymR+8jkc18rllLj8oPulNBmB6bz+UgVA2mCfOaZDkd9wBGJdixb4jotqLlIHMqbYzyvkePpnEcp0dUIjMdbORKyHe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440704; c=relaxed/simple;
	bh=sjQq/3/8/CO1p0c3gG4LtOOqzshhDDbyqBdeCh4NksU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYX0IylKRGPq7DOUPE+S3wS2IgMWabeUDmqG3c4i8FWkO0quj8FJJkUBA7fhh3eZjwxy1YTtfPULeRVLECI9Co5UFBRDbqHFTnng2cWtkkHE9Kk+Q91e0QHzk4z61jaCLYwLbSx9xbGQz/5QyCPB0J5cSxbtqW5ptG++A6uh8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1mxOb7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1mxOb7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332C21F000E9;
	Tue, 11 Aug 2026 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440702;
	bh=wFlI5ofQqed5SZyALyQHqTpJ4HaBv8zoy6KujpstP9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1mxOb7xHoTEC80miMPtvsgHnex4Ymp0ItQ25yRiXpiUeYnorUEtc8dSYxKFu8g0Q
	 OF5gqlsp0fCsQVdioJz2L0Im8ZFVkh1q1xDvh0WYGVc8RCchcii2+jh1LmKsED6UnO
	 hvSfuuBLbZohWtidtQKs5HB5fucQTKaaxBVSfmhqh+d0ox3vZbqWBX9vJ+tHzAYE4T
	 Q570Yz1QNZ6TVKKBVU0UKf169uIPakVUuO1vY1WSF8R+8zsi4G6RQUJ2CmcqfWETt2
	 SwEsnY5AgiVSnvJdpX6wdW/sQD5uEGMkj7olA/q9NtBcCydj015fYTn9beB7wuJ6MN
	 2yIPtK09R9b6Q==
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
Subject: [PATCH v3 06/17] PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
Date: Tue, 11 Aug 2026 12:30:48 +0300
Message-ID: <20260811-fix-p2p-acs-v3-6-efc488ee7c03@nvidia.com>
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

