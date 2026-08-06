Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CC42AFA7;
	Thu,  6 Aug 2026 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015556; cv=none; b=lrv44JfZjbc3bheph/P0GY69fDzNfLWahBJ0WNCHmPl1KFovuWqOpRwf6FOnlanVu/i5MPcneJznwPsWbrDNdExj2KUAmtestKcUNt42pKf0C+ePkWuYi6T4nEuEpsQ+68KkPDL1J5c9Fg/M6Tp2OGhJw/rY9NzSFc0vH6roLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015556; c=relaxed/simple;
	bh=Rsztl0wRdH7emGkUIVxDm9nPwiptRTJ33/0ZalySuAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhGSKc+WMpMZ3c9NadsvVeEb40CgT+tRcGPfsOZZz/oLHG1xG67Hy+9dn2vv6yND4+7KTV0MPsMuDi4+y8oiu0OAC5o0VsURcbJokKdoc6VEAxC2N6H+rL/svtAlRq+7k9zUpKasT5lEVoVu1tLsSK0Wp3fTIukuZA9/u8poVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKX1Yfl2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKX1Yfl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55771F000E9;
	Thu,  6 Aug 2026 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015555;
	bh=kRCVsJQxui+jwy9YKej4wasXhPcjnuXQRvBcbVRYV74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKX1Yfl2F23rsy1fdZadFzgSegMHYx2q3Cld49itRQHjU+riMrE+RoU1niTabuzMg
	 oViJorx4sVJXiLuzrbRAZ+ZdItaRs3yHy+o7KVka7cKCJY9eDHdSxQ+31Au/OL4Fs/
	 S1mLMeX2cTC8BBuQF92q+z6k/X9uUe9f+xOaSQRHiWeBuZ2ZyEFGmY1ttwmqxVAj/N
	 Rm4pPY6LlCqghTcupPwcV5CXhz3D349S3vMWH1yBWbJuNGLj/ReVKNxC1U+sGLvvpx
	 Tv6oYaz0qpmxL09KUHEBj7TSbT78vAkhUoywNCHrZFHaVnzaD31P9tL0MoSrMMzwjz
	 qf2+gprzlDn1g==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 02/13] PCI/P2PDMA: Report ACS ports when the paths share no upstream bridge
Date: Thu,  6 Aug 2026 14:24:09 +0300
Message-ID: <20260806-fix-p2p-acs-v2-2-0cec14812965@nvidia.com>
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

A provider and a client below different Root Ports share no upstream
bridge, so the search ends without a match and the walk takes the
host-bridge route directly. Neither path is examined for ACS, so no
redirect diagnostic is emitted and the host-bridge whitelist warning
stays suppressed.

Examine the paths before taking that route, so every redirecting port is
named in the pci=disable_acs_redir= hint. The mapping type is unchanged.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
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

