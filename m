Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A22771B;
	Fri, 26 Jun 2026 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509462; cv=none; b=KUTr8sqh/Kpx8WXyxNKQUki/M4fy50ydR9IpCzzKMVtENfkpFpDkAqwjSBvQvlYXcpdkP1gJVI1X4AVIQDjYlqNUnmmvwefmKUVPZTXXJu+HoOQkvA4yAfcVrUVrenBTbpDRzfB6i2DShjLC14BRcZ4aLoacWDHA0n7UVAxQa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509462; c=relaxed/simple;
	bh=qPEhsGjIBtTWj8zlkj202NfoqNvV8026b3MIa1YvcH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cx9EBJjKWnrb1Ez+tp2w6h/5Ng5DVNL7sLQrEzq7d1J/JVohGVitig4/+omMfjQVTSt1I8b+jL3KPMk8+VONnCzAC6ycrDPLIm/JEE9NCNDpAROE5dvY5Mm8N0eaErH+cRIdKO3DagwVsFqzelI5/Nond/WzKDUem9XHBot1bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIGkMATW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIGkMATW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5651F000E9;
	Fri, 26 Jun 2026 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782509461;
	bh=zdpKRYAtt6LgXV764ZcapDMCcYdnNjp+F8mLcmqhvWU=;
	h=From:To:Cc:Subject:Date;
	b=eIGkMATWU3+5yndL6XZItqpGSS97SeL5dGa9stbI4j6Id978zAdCu3CLj+q0CxbNh
	 MD8l1E0Y4ZXTBf7BfZBUtdWT1jJc1KNswjHtTpkPj46cqWDRM3bsb5e2Rz08TTNRg1
	 I9sX3m4XE7iF8YceAO6eScoYm25Y14Ez+Hd/uIDm1uadV7fB1AkD7/AvI09ivhIHj+
	 izaMVdZqw2xhqC/8sp7gkFniYYSO4WHmTrmOsff6N3lBzMoxpu6XptChDuCaQip9h7
	 BshtezGmGRGU7WlMqXSbhEgnzft5z1tphGARUcI2Mpcav5t5IEpl3tQheVzGTMvUfG
	 BoewkWQDha81A==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] sysfs: Include bridge window address size flags
Date: Fri, 26 Jun 2026 16:30:47 -0500
Message-ID: <20260626213047.189951-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_get_resources() fills d->base_addr[] with CPU addresses of PCI BARs
(the CPU addresses in sysfs 'resource' differ from the BARs when a host
bridge applies an offset between CPU and PCI addresses).

119c1376f9ca ("libpci: Add support for filling bridge resources") fills
d->bridge_base_addr[] for bridge windows, but unlike for d->base_addr[], it
did not include the low-order four bits of 'flags'.  For I/O windows, those
bits indicate 16- or 32-bit addressing; for prefetchable memory windows,
they indicate 32- or 64-bit addressing.

ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if range behind
bridge is disabled or unsupported") tests the d->bridge_base_addr[] flag
bits to learn those properties, but since they weren't included by
119c1376f9ca, 32-bit I/O windows were labeled as "[16-bit]" and 64-bit
prefetchable windows were labeled as "[32-bit]".

Previous output of "lspci -v" on a bridge:

  I/O behind bridge: 2000-2fff [size=4K] [16-bit]
  Prefetchable memory behind bridge: 48030000000-480401fffff [size=258M] [32-bit]

Similar output after this commit:

  I/O behind bridge: 00002000-00002fff [size=4K] [32-bit]
  Prefetchable memory behind bridge: 0000048030000000-00000480401fffff [size=258M] [64-bit]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 55ac7a6f0699..77ab99e2d5d2 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -219,11 +219,14 @@ sysfs_get_resources(struct pci_dev *d)
 	}
       if (i == 7+4 || i == 7+6+4)
 	{
+	  unsigned long long flags;
 	  int offset = (i == 7+6+4) ? 6 : 0;
 	  for (i = 0; i < 4; i++)
 	    {
-	      d->bridge_flags[i] = lines[offset+i].flags;
-	      d->bridge_base_addr[i] = lines[offset+i].base_addr;
+	      flags = lines[offset+i].flags;
+	      d->bridge_flags[i] = flags;
+	      flags &= PCI_ADDR_FLAG_MASK;
+	      d->bridge_base_addr[i] = lines[offset+i].base_addr | flags;
 	      d->bridge_size[i] = lines[offset+i].size;
 	    }
 	  have_bridge_bases = 1;
-- 
2.53.0

