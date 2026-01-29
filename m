Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208D35CBA3
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721944; cv=none; b=QQnmDLJyGsnpqDBnxSHr+KIvWXe2jiQfF9Wj6x6zVBUxkTfOE494aPLhTxAqCplj7DoyY5WjdQHDeIOlF9g8OjtryGZD/s0WSWi2ztq9DxF6wKaa6nhyL5xi8E/HqSp8t2R+hVoPElZFG595MJTy77fCTkiT827jsqzlAiZra0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721944; c=relaxed/simple;
	bh=WQ9zgAmCTBZ4bwjQYNH8OonhSwck2yad34xCkVdAyYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4ErxGrKAxzMxduon7wsLP3l1nI2nG9goCEEDdvwJDXjepT4Dtyk0WFBcV3R92FzG7lFGX6o9olzorZzK/MV8/SE7XwuLxcjXgY6iMbMb38N7nQQSGbnx8PJuGcXw6wl3s1P6lF6FTj4Nqn5X/u9OrmszRt+eLuymjlq77ldLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjVaCgTF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjVaCgTF"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso1281552a91.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721943; x=1770326743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1Z3QHTjPxpYvShlt2cO6c78554A0ZIR6ozbVe3TjI8=;
        b=XjVaCgTFQyi6ghx7LAtflhE0rRuGae3zRnMF+wJ64bOcpbaClnEJCHeeFPuNMx0bhj
         Chg5w3+Rx1+NgQiC/X3EpKjOM5AHlPxMXucXPInqNLq5W2iNCZO09+LE2qwLNDBEXIPE
         k6KPrSjv+Nicpr3qeTwLiE4/7n7Eq4kAhYE1RGrPbyQj1PFa5a168R4x8Ag9H2obFNnC
         MioljlYyKnMLyNKbtxL/nZduWIAaIE13aEIZ/x9ZtOBBqDhg6avJOIdW/06RH84x6bAT
         mspO0qAoOXdpPYicKB0pO4XSn/yd4pHPLC5KY91JNeLGhYPPPelvXvLyDFk+A+VUIMw2
         d43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721943; x=1770326743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1Z3QHTjPxpYvShlt2cO6c78554A0ZIR6ozbVe3TjI8=;
        b=eqiwPTowQyoS8AlL/yU1oNShBb8bFnN8IWrlfJxUfGKEYpcrIkvGq4kwN6Z1A/7XlJ
         HDefh3qHShFZ41+/34vPrMqRdHkbYQzQeWg9b/FWXXaf9lucj+btueyZutgE6A71weO/
         0wlUQMz5e0gHCxm8hud0cHpjuSRzTH+1yPND6psC3gNEQmGJwVvbmFyWMk4mzapaOpHg
         WjwJznmr2XaJMvXMF2RPZtBI8zAftY593Cktfu2KV1x9p2uD/7yF1KjR6QYZEieTsoYX
         kJpadlnC/o7MgTkSYj61FE0KJ97zuxBYiZrDBr566gS/kUbBUzb9tCtczoht3Ix8yv+B
         SD9A==
X-Forwarded-Encrypted: i=1; AJvYcCUxjMwaGAh6lFosh5FWGBGBq+S7dgraNqlNCl6hZ1x9eqhVkLnMDvmu2ZEfVODTwUvj+xZncP3x9rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWz43E6JymMinCLyYDWYEjdKMCACrPL/gfvl1CELV6ZPhknnAG
	awoc2o6p2D7WzYotrEVFBHG0j6ALT+WPcMERHXB659JVg8CW5qs7kiCH5hIArd4xLjSyPYcmdhM
	VIhPqNxIx0y5JXQ==
X-Received: from pjblb16.prod.google.com ([2002:a17:90b:4a50:b0:352:b92b:ef8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:28c5:b0:343:684c:f8a0 with SMTP id 98e67ed59e1d1-3543b3ae12dmr762757a91.23.1769721942669;
 Thu, 29 Jan 2026 13:25:42 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:50 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-4-dmatlack@google.com>
Subject: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel during
 Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Inherit bus numbers from the previous kernel during a Live Update when
one or more PCI devices are being preserved. This is necessary so that
preserved devices can DMA through the IOMMU during a Live Update
(changing bus numbers would break IOMMU translation).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/probe.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index af6356c5a156..ca6e5f79debb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1351,6 +1351,20 @@ static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_assign_all_busses(void)
+{
+	/*
+	 * During a Live Update where devices are preserved by the previous
+	 * kernel, inherit all bus numbers assigned by the previous kernel. Bus
+	 * numbers must remain stable for preserved devices so that they can
+	 * perform DMA during the Live Update uninterrupted.
+	 */
+	if (pci_liveupdate_incoming_nr_devices())
+		return false;
+
+	return pcibios_assign_all_busses();
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1378,6 +1392,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	bool assign_all_busses = pci_assign_all_busses();
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
 	u32 buses, i, j = 0;
@@ -1424,7 +1439,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
+	if ((secondary || subordinate) && !assign_all_busses &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
 
@@ -1467,7 +1482,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken || is_cardbus)
+			if (assign_all_busses || broken || is_cardbus)
 
 				/*
 				 * Temporarily disable forwarding of the
@@ -1542,7 +1557,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 							max+i+1))
 					break;
 				while (parent->parent) {
-					if ((!pcibios_assign_all_busses()) &&
+					if (!assign_all_busses &&
 					    (parent->busn_res.end > max) &&
 					    (parent->busn_res.end <= max+i)) {
 						j = 1;
-- 
2.53.0.rc1.225.gd81095ad13-goog

