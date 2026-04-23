Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6913BED64
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979411; cv=none; b=SIg3vfhvW1hHSy/t/E92N2xofhpDtWomd3ry96xzv1u8DYRyOd43c+eLeV1NJikNVoUn/uFzXniTiDDKRoPPjl1r4POSf/WS39HFtwrE11kvYuHXtTfVB/xRu7GwDqHWAkv2hJIwRHhmVQGMBttYqIwBydSkxM4q/A8/hulJ9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979411; c=relaxed/simple;
	bh=dE5Wu3i/3oTCNIY4DxPIO1WQs74yLAprf78sku84Hgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYCnxZiBXpUIcdK4fE1rzfHmXddgmRAZv4VknpNXoVBMDL+L7CiXgOh0KYANDKsSgHra+L8eieEJE+kmgM+YvibEnL4GFEDk3HcyYgLN2aJWwv8JzbRil253H+xCEdBz5GxfVsezkyBfsme5I1ckJefrIBy4tB8nE/xG6/3mpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpCaZjJy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpCaZjJy"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7a77b8ec9so10515385ad.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979407; x=1777584207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/8iRDD7lhVYHGAuqnc3aBzPoZ7lUU2DgL4E3vJPEc=;
        b=UpCaZjJyglexDgqkb/6vhHNODNhfFff4wOY7JRTtVdk30fxK+tz5WI3aAmJfHms8lj
         qcx8taL6eEz2wgUHxlTKGm05dinaGUQ5hrTwWaXSfRpacdrCM6bBvbAUfsv/2T2IoJlA
         4/aUxDgEDaA2fDUeJdUmv2lRowKRUDwLirJN8II8XBEyI0Rxhc0poz6ktLDomsLLgcil
         GQfoKNfCBuj5J9R/XsgkUpP0+MM9XjoCB47zmY0iM8xAA/EDF1SyOyYM/0Vs2RwC6NIH
         cNsIZNjEUzmsx+Q4ZQRgvpNp+aiDwNCwqfXir3pdDjRuk01Hur6FPePl/vpQEzC+tBsU
         n2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979407; x=1777584207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA/8iRDD7lhVYHGAuqnc3aBzPoZ7lUU2DgL4E3vJPEc=;
        b=A5sK9Bug7GBBM65wrH7WlwvozyOAdpql0vpIbkj8plW22nnqnJwg4Xe5m+RaJsLjSu
         ei3Pvoj2Vyzo+juC2th7sGPAemtl62L0hFKUx6ekAJBr7FdLBDa8Xymo/VqMgR/Gqqzv
         aEVlBSEbCdj2N9LYSSjsp+jkF4n9t8rQYZtDb4OvLldAJ/71bCZlVHRrM/nftbI2qn/n
         /pWK4ZYt9FjOcbkNHNkp6ZRE4hRvh1LWBrUgix1xNcH/fIiWM6KspjUH5rzWRNEfDkck
         egCBA9SqTHardpjNwxVsD0Eurs7/hkrAp0k4NBJ6N9onLf14Db8aTKEww+RkpTR45O8L
         H7/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ojANVA0g8oh+cdzCy0CUer3adb74/Ucazp5egGYCv91udHd1ucYKIbNfBb4tLRZulyzz3Gfv2R+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEr1zRMafcxsKgSz4i7K3PWPFsmEgbW4DPyxLHx23e8gz0eSp
	AHoSEoTTN9emGGj/hV8aBBnNP6gmKKpQp+ejg9dyWQzaVBi+P0m/51drAnM/AWTIkODZBDYwNGm
	wWsbegANXWDjY2Q==
X-Received: from pgjm19.prod.google.com ([2002:a63:fd53:0:b0:c79:7f30:5d18])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3399:b0:398:7982:21df with SMTP id adf61e73a8af0-3a08d687673mr31625673637.9.1776979406884;
 Thu, 23 Apr 2026 14:23:26 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:08 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-5-dmatlack@google.com>
Subject: [PATCH v4 04/11] PCI: liveupdate: Document driver binding responsibilities
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users. Note that this is only a description
of the current division of responsibilities. These can change in the
future if we decide.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index e616cecc37c8..c0a30d16d9b8 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -77,6 +77,22 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, it is the driver's responsibility to ensure that it
+ * does not release a device between pci_liveupdate_preserve() and
+ * pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, it is the driver's responsibility to ensure that it
+ * does not release a preserved device between probe() and
+ * pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. i.e. The PCI core does not protect against a
+ * device getting preserved by driver A in the outgoing kernel and then getting
+ * bound to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

