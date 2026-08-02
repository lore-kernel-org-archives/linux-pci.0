Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18A3B960F;
	Sun,  2 Aug 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683420; cv=none; b=ksuMWJZXM/afI/Ja977Nqx9Ge4Di3BdOavsowKlC4XzC+kB4cy+mCxMiLBH23Og0SdkDhnVELJZqn5D8puP0Q22rFEPFdeKsAqTU8sHNt5TS+tJutmGSHqXepYeDZNnFzpfdNkTRMWDRhgKeWU1Jfy0hdPju2K2WlEJU1D4pFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683420; c=relaxed/simple;
	bh=lPC11LfxiJlc/7y0U5OYMCkPeg80+7fdxRYVtayCHEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lohj8mtpUUwtPQqe7Hz9MFdHGs4xhV34GS5zK+HlM88KIzsGVU7gcvhZcMVNDwl8vEj8610RaOwQa8hW3079laz76mVt0ENKt+dRinXc5SkWwPWqBhNPP+wxvymXdr/QA1/7VgTH7BC+ISgDDw/LqEFJ5EZkhEvHjaptvjdJ4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt21Kijl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt21Kijl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9751F00A3D;
	Sun,  2 Aug 2026 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785683419;
	bh=22HdukBMyVSh0f8dzFmZVgseWKLJtqGJOxKwgmITFtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lt21KijlP6UglhI744gnvVuLOrQ0LDBbvBvHPE5L5OChDxoM+vrEs9PsM6/Bu2h1Y
	 Pn6T6nXjGcP0DuVNu23A8WD8EvPWWShtKQbghK5feKqjUxchkLkABkeRyrvnQLFPZQ
	 SHMKTV4qbpuMIgx8A6MRjnIJLYteUYDZhOeEcqfGrEO6WWkLHLeyRtNWJMMhNCtZ8e
	 PCpd5rhCKebRP6Szg82zW1+Gwl/J26vNO2aEqT1aK3+hSfCgcHDaLOpQadv11uOpK5
	 GZVXW7uVngwS4FYNYnJJm/24kK1vZXjfE7HJyXeQXK7ZOQG+w3q9lyVJl9EBgRRdg8
	 NcN9Q/HzuTMLA==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 02/13] PCI/P2PDMA: Report ACS ports when the paths share no upstream bridge
Date: Sun,  2 Aug 2026 18:09:40 +0300
Message-ID: <20260802-fix-p2p-acs-v1-2-a7c5eb64fff6@nvidia.com>
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

A provider and a client below different Root Ports share no upstream
bridge, so the search ends without a match and the walk takes the
host-bridge route directly. Neither path is examined for ACS, so no
redirect diagnostic is emitted and the host-bridge whitelist warning
stays suppressed.

Examine the paths before taking that route, so every redirecting port is
named in the pci=disable_acs_redir= hint. The mapping type is unchanged.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 2d3b380cc578..801c183ae6b7 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -703,6 +703,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 	struct pci_dev *a = provider, *b = client, *bb;
+	bool no_common_upstream = false;
 	bool acs_redirects = false;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
@@ -740,8 +741,12 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		dist_a++;
 	}
 
-	*dist = dist_a + dist_b;
-	goto map_through_host_bridge;
+	/*
+	 * The paths share no upstream bridge, so the request can only reach
+	 * the peer through the host bridge. Examine the client path anyway,
+	 * so the diagnostics below name every ACS port on both paths.
+	 */
+	no_common_upstream = true;
 
 check_b_path_acs:
 	bb = b;
@@ -761,6 +766,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	*dist = dist_a + dist_b;
 
 	if (!acs_cnt) {
+		if (no_common_upstream)
+			goto map_through_host_bridge;
+
 		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
 		goto done;
 	}

-- 
2.55.0

