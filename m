Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAB44C658;
	Thu,  6 Aug 2026 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015532; cv=none; b=EUNFh6Ll5wqoOK3GVTmEvl7J+DFpbZftdDN2x2XmlUwGMFTgczgcoKM4uYXlxr0wDwyHVJcpSQtbZpuwwA2+JnkIPIFd+iTSsEcLvw76fdJZnlo+peuBPu6w37J6grU/HDFJwsJhXWYBqxxZIFtH6IRpPqRGJ5fVQ7p/WoiK6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015532; c=relaxed/simple;
	bh=99jZ7x1IG/AFSnDKR/6q7IQ+i0GsGQQouOLoG1JdPGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELJ6bmJ7i0xL4xeUc3qydxKCmb6odBdHZvqZ/iR+Mxoz7uA/p4SifYPaayXSbvEKfXZzjNqM1HH6Tfcm4OvE01VOG6rVXaKYQzAeNKRGt8j991h5aKtQSsymp/YDWIFonI7PEKgrIDSWoP9srVqqNtB5XNijO/tQRgqDuR26OD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHSYOrP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHSYOrP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B398F1F000E9;
	Thu,  6 Aug 2026 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015530;
	bh=7zoGTEOX19ReumS4MvaPnoxz/k38LD5OPaxQjUc1Okk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHSYOrP/SGq/Oe7mPSfm3/o7FZoqwfZS6d3qj77IZIuLB4KvBU1GM/ZIZKsyG5yhC
	 /oE+sQhCVFmzQrZUyAGL7ins5bAyXQdqy9q/H7tS6wd0jyl6msufkbBm8fTm/fv3eO
	 whUcoFtmYv3sHG8CbJq86PRtQtQbtBi8w5c12Z2Km1Z1d0IxeGVI328HU502VUa1oY
	 GxZOKQvlUcjvB9PatTfodGktw4XNNW55nr8Es6Jvn3r2zai7IXKhw8zLTmCIBuTwVD
	 RFYH/q4eFIi4I3UBVWA4sJB0WXGi89wGY56C0wJY0byfDB7sxl3BH8mnY4/CG/fuaH
	 Jo/Cfc4LkZDEA==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 01/13] PCI/P2PDMA: Safely terminate ACS redirect lists
Date: Thu,  6 Aug 2026 14:24:08 +0300
Message-ID: <20260806-fix-p2p-acs-v2-1-0cec14812965@nvidia.com>
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

