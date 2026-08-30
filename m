Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BED2C08BB;
	Sun, 30 Aug 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088613; cv=none; b=Q20k5YvCDIchJiGHoFqtCLqNa8HbC7dbMyOGmvGOei51F7mFcdwvpHEg598We18Pzk0DO6431WTHbszEvTb11gMMCgnv5lYGOIOyypcWbSN68EnpSfBy6UTHJgSTgeVqbcivsWw/qrmPhEf1NRNtrsMB26zXjuJrvn/eZYDGQfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088613; c=relaxed/simple;
	bh=5N7JkjQRgXMOd9K27Ip3vidVUtsrPx/4to79EI7m8lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smZIS9CYcW4Cf4+X9PJghN0X4vN+jdf+5akzbbkaq+XURfbu2d2SnHBLIA1NYAJHQSCUM23ks5R7Lp5SQttl7a/+LekpXUshgiqZALFhrpQTxdPkLsJld+1YY2vy8FxCTIUCeQGgD39mKP4ussN4lssHUgXFWIBQVeOq0h7kbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU8LPYwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU8LPYwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A1C1F000E9;
	Sun, 30 Aug 2026 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788088611;
	bh=vEfiAdgfV9OK268PtYpN2GbfHnKznFcN2c5SD+05258=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fU8LPYwUYnp7VkN63nSlcPS42IRhxLi9p2lF4B7HSyISrBTidREwRWVihQA4pxE49
	 li7PZ/HCSbGkoh+XsAvjYA9eotHT+JAEQYhrmq3W+l0dL1BGAnVzmG16I5cqh4mlia
	 /IN0gqI7HMulyBQrQC1ehXItFMiWNndIAqBRrBQTD2ZrguVzJ/7GkFSuSoh/cCWXLp
	 GhuEpLd+QH6aZCTge9u2h73PBdbWKa61i92I/RbU0CuAlzjQKuyx1fRwcV2zRi9A8J
	 vq8RRU02eA1S9wDs0MJ07TobU6tfjPcQh+gIfce8bx78YAu8W8RyZDq6RWcTjh13u5
	 0q7wd55t/1U4Q==
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
Subject: [PATCH 4/5] PCI/P2PDMA: Safely terminate ACS redirect lists
Date: Sun, 30 Aug 2026 14:16:22 +0300
Message-ID: <20260830-batch-p2p-fixes-v1-4-5044e8dfbe2e@nvidia.com>
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

seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
path unconditionally writes a terminator to buffer[len - 1], so a path
with enough ACS ports to fill the 128-byte buffer writes one byte beyond
the buffer when verbose diagnostics are requested.

Use seq_buf_str() to terminate truncated output safely and remove the final
semicolon only when the buffer did not overflow.

Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 914848a993ba..becc869cbc17 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -772,11 +772,13 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
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

