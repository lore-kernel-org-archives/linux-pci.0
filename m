Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABA383338
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481461; cv=none; b=Tx/rfrytcQPDY6Ymj+EIYZPqjwWiDXMBS8ORL2yuGOK8sSMf0r0IjmSz3miG+6oZoHGYwNp4C0ECH2lXZnK3vbGB+Lc7BquOTpv+mYkvjy+SUZdrVTj+pcW7Ff9OrFRF8U7YVmvQxcP2LQ8q3rAETaRxj6Pg4bukAf3z7h+hPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481461; c=relaxed/simple;
	bh=AmO7W/8gXxOtZVsrp0KtqrBNzzh+t+7NWZozjr0mE5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EnIZ9ZPK512AJLMHuzjCUSGdDC+Am0piv30/3s05VmecjN7r5PVi6+9EqG24/T6O6Sq7bGT9NGYE9pgVgqotiMz6G3+uO+3+oWHFAwL4p2y0pBcvj7Sc78VU8XDiyc2hnHaMXeQCHiMnTk/A5SkhEeal4JvBpwqNIoYiqlYNPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXoMwwd0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXoMwwd0"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3692f395339so7752449a91.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481458; x=1780086258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXxmfHGErf7yBzoXqh/yDUR2jlzP0FOZNAJXyHr7Dw=;
        b=NXoMwwd0KvadGcJFRg9LnDi0To3hwQuoszqH8QZd6P9ucAVwfHqNPWcv6PloyrDNP/
         XMDLDOlyuxYtrYvNQf5pM1T5INq5YIRi9bkZZJCqwTl6dGY5RLpKHFmLAVvXDdFZCoO0
         gZ6Bg0S2JuUkawtsXomAygfRAqURD1wQykOFKkKfmxzbleWGw+dgPuNvN1aptI/Hp8IY
         dsA2Lw1hTidfKnqIbp++h6LqAgceW7MC0xW6ewSXo3V/Xmyxz5l3xURoRv1Bo1fgHGn3
         Cj4SlanpkzcJTdWdj1yCsp1POJj89JrPLxE1k0j++tJLk/9ZQWN6eyNqLHNtOUkpylod
         2RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481458; x=1780086258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMXxmfHGErf7yBzoXqh/yDUR2jlzP0FOZNAJXyHr7Dw=;
        b=Ik6m3TvacnRWPBfPmTVw8u/8y86O0Puq88ss+e+FY+Ht4jSFYYdpkkZBwRBpfb3b8k
         TdvEMN7Cd2Hpp3drtHidXLqPolHvZMhjOakIR4Hos2G8orVqpSHHPt3+cm6ft6PxtDXj
         ammJQ4vcHY+2uuo8GRuie52/+PvNUy6RnwPwn7v6dXxQ/UbFJlGlK5/iufakjrpylmsl
         IW8elFp1PqogynWytENdkc8MPiW9LJzEkqy3esSMjyFLAhZWCQpM5Na5olujG102Up6z
         VGcvqLydHx5WlPfJUAyDbR/4YdjaRAJ2gOnXeZ0NJT5B8lUcBdqtW77vgjjce1dI3edE
         3BGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9o24xS/SBDoXMJGh1AdGVK44RUkHuYptlwpn4uAk3XCiAxAHkSDET+satF9eegQmL8CnMUhJZSh14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk4TeAhvRgGzevWsl5MNtLy3udcfnGslRZRp2aoLqdhAwSkREh
	iXOgDoDea/1rDeNaXBLG7Afb7b0weCq4pvqVf+bly8Jd+agdFPil1P4A20MZx201tE3z+NA7uzW
	fEIN7uuUd4Q6FfQ==
X-Received: from pjbsz6.prod.google.com ([2002:a17:90b:2d46:b0:369:4369:c7f9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3807:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-36a6741dd88mr5140261a91.1.1779481458189;
 Fri, 22 May 2026 13:24:18 -0700 (PDT)
Date: Fri, 22 May 2026 20:24:05 +0000
In-Reply-To: <20260522202410.3104264-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-8-dmatlack@google.com>
Subject: [PATCH v6 07/12] PCI: Refactor matching logic for pci_dev_acs_ops
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Refactor the logic to match devices to pci_dev_acs_ops by factoring out
the loop and device matching into its own routine. This eliminates some
duplicate code between pci_dev_specific_enable_acs() and
pci_dev_specific_disable_acs_redir(), and will also be used in a
subsequent commit to check if a device requires device-specific
enable_acs() during a Live Update.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/quirks.c | 50 ++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..171caec2bc47 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5384,9 +5384,6 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
-	if (!pci_quirk_intel_pch_acs_match(dev))
-		return -ENOTTY;
-
 	if (pci_quirk_enable_intel_lpc_acs(dev)) {
 		pci_warn(dev, "Failed to enable Intel PCH ACS quirk\n");
 		return 0;
@@ -5406,9 +5403,6 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5436,9 +5430,6 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 	int pos;
 	u32 cap, ctrl;
 
-	if (!pci_quirk_intel_spt_pch_acs_match(dev))
-		return -ENOTTY;
-
 	pos = dev->acs_cap;
 	if (!pos)
 		return -ENOTTY;
@@ -5458,22 +5449,25 @@ static int pci_quirk_disable_intel_spt_pch_acs_redir(struct pci_dev *dev)
 static const struct pci_dev_acs_ops {
 	u16 vendor;
 	u16 device;
+	bool (*match)(struct pci_dev *dev);
 	int (*enable_acs)(struct pci_dev *dev);
 	int (*disable_acs_redir)(struct pci_dev *dev);
 } pci_dev_acs_ops[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	    .match = pci_quirk_intel_pch_acs_match,
 	    .enable_acs = pci_quirk_enable_intel_pch_acs,
 	},
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+	    .match = pci_quirk_intel_spt_pch_acs_match,
 	    .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
 	    .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir,
 	},
 };
 
-int pci_dev_specific_enable_acs(struct pci_dev *dev)
+static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
 {
 	const struct pci_dev_acs_ops *p;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
 		p = &pci_dev_acs_ops[i];
@@ -5481,33 +5475,29 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
 		     p->vendor == (u16)PCI_ANY_ID) &&
 		    (p->device == dev->device ||
 		     p->device == (u16)PCI_ANY_ID) &&
-		    p->enable_acs) {
-			ret = p->enable_acs(dev);
-			if (ret >= 0)
-				return ret;
-		}
+		    p->match(dev))
+			return p;
 	}
 
+	return NULL;
+}
+
+int pci_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
+
+	if (p && p->enable_acs)
+		return p->enable_acs(dev);
+
 	return -ENOTTY;
 }
 
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 {
-	const struct pci_dev_acs_ops *p;
-	int i, ret;
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
 
-	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
-		p = &pci_dev_acs_ops[i];
-		if ((p->vendor == dev->vendor ||
-		     p->vendor == (u16)PCI_ANY_ID) &&
-		    (p->device == dev->device ||
-		     p->device == (u16)PCI_ANY_ID) &&
-		    p->disable_acs_redir) {
-			ret = p->disable_acs_redir(dev);
-			if (ret >= 0)
-				return ret;
-		}
-	}
+	if (p && p->disable_acs_redir)
+		return p->disable_acs_redir(dev);
 
 	return -ENOTTY;
 }
-- 
2.54.0.746.g67dd491aae-goog

