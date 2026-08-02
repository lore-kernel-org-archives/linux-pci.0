Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81493BBA05;
	Sun,  2 Aug 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683412; cv=none; b=SldLymsmZLaIVaOauCQtj7FthUyj5aP5yoyHoouau4CLEsMEn2OZxWmw8D9Cj3YLmPMQkfPibFzY5Ko+Du0lDgUwbEnjM79gMfPOJGRbREvIbM+oCpLyiXiMerd/kiOtAyeOsdFAqoEiShpCNNo+tJ8FrhOFPKAbtkUu9Sa7l/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683412; c=relaxed/simple;
	bh=99bqr/k13EcQwJy2ZnAjwyVCotEV4X6Mc7Ew0quyT3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILbn9gkjInqZ8Lt1sDJxjowCtZP1A0609vJw4RCULv4pecxVEOf3emw1wH0H0orQhCrZm5ihougsPOIXbfDwswQw9xM6NPbP5mJi15UCzViDDDY7LiQnV/BdWC7UrEb+f18xnQKWiNJB6xm7MKNRqHPM3VMqvIvh9OQ2m+4ie+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUJG6U3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUJG6U3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF8C1F000E9;
	Sun,  2 Aug 2026 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785683404;
	bh=TVTa7+WmRi9ddbsfIzMHeqJOKPOtkT6w8ehz3GN72jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CUJG6U3DXiGLW6TDTAPgchsJUsZ9BUOw18WDgIYLMnEcPSndn8/HFWyb04/GLBQbX
	 UPFjmgBmZuNFNOEgPh/yZw8+e8sXv0INzOjj8beWnvYogIE7jcXipmudIzcMpR5f4G
	 VgPSQHCiAAbgqHnoeiClnBI4/TqpW0Btr0GL/mCwlAWRCrGjjEYTUMQEUqqk3rUjwn
	 Y5z9+FqFFrmusblAPcCWqx+H3sZHk0f/71gD+7dqX3kRAIanrz3nEMjzHlr9JRhMXF
	 8XmCD0o/Sru50A1hvlU2f+EiUStASqzDj/8vJha3k/PV5qN124Wm968kFhGOPDNHR1
	 Jh8x64CrOH2Nw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 01/13] PCI/P2PDMA: Safely terminate ACS redirect lists
Date: Sun,  2 Aug 2026 18:09:39 +0300
Message-ID: <20260802-fix-p2p-acs-v1-1-a7c5eb64fff6@nvidia.com>
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

seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
path unconditionally writes a terminator to buffer[len - 1], so a path
with enough ACS ports to fill the 128-byte buffer writes one byte beyond
the buffer when verbose diagnostics are requested.

Use seq_buf_str() to terminate truncated output safely and remove the final
semicolon only when the buffer did not overflow.

Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b2d5266f8653..2d3b380cc578 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -766,11 +766,13 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
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

