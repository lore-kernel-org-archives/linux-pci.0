Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE33911B2;
	Sun, 30 Aug 2026 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088617; cv=none; b=emINDZq10BAUVhQjaL6RLpzcppWShfgQ0nLB5w9FPefe47iA+0kvw3rARd4dxZHXERIiluQ7537sH9N/jaE8ccSkpEiBrToCJxwHynp8FJtIdfa1lPQqFFp/wKgRU+VavfyfZwpAKgIumy8xrvXS8BFehTakBuP0Vh93iNVnlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088617; c=relaxed/simple;
	bh=BgPyX35b9suPNW2T4JOwnyvPa21cbCukwwK56ZZK7SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgOy0Y4loLM4zILl40OSXssmzyy9bQv2MN8kKcgUX2FDrGY7rkRD6gqLco6PJJ8YXQUhqEeECD4wHKAZ1fyO1X28XT7Mtkxp110vhcUXzYdLIIERJl5JHC6PRuQZDtgVWNSOeNfFN9mU5K6eA6WHLLUoy3V/668mSznmecLW7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU2FB3Ms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU2FB3Ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11A11F000E9;
	Sun, 30 Aug 2026 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788088615;
	bh=Lc5Iaug9KuYhX8qYuPq3mQvPE1l5alFIeiwqy+WRyOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fU2FB3MscpdV26VVD0Aony0aB6ijppmBXgYaAmN3LLKIuPff28UgmMyhfCJ0o7M9D
	 hy+u8mGBqhau7p5YdMjI2j9inB598HVbvAGRR2PMeTMDNhO8Icc0cPRPbOf7m0hfd4
	 5XHAgD584gHRD1egBcPXEOutXngd5TPwa6lplTgLwHOV7HqOxVdH1nXe6g8+NgKz+t
	 1HNv5v6GCXfAmJIa1tRDVUY5jnNiqBdXhgwUrxExGAuSoZ5c4yAPTplYUfejP/gmrG
	 ks3D9Nw73PxaOHz0/9UMpnIKGKFpz6Y193RJx92Vt74gGKVZZsSN8ShlUfQmJhov2m
	 EGfk70WqpVPwg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tushar Dave <tdave@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5/5] PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
Date: Sun, 30 Aug 2026 14:16:23 +0300
Message-ID: <20260830-batch-p2p-fixes-v1-5-5044e8dfbe2e@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
References: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index becc869cbc17..349537b4fa42 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -709,7 +709,6 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 	struct pci_dev *a = provider, *b = client, *bb;
-	bool acs_redirects = false;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
 	int acs_cnt = 0;
@@ -780,11 +779,10 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
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

