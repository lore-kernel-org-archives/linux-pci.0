Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03428437847;
	Tue, 11 Aug 2026 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440720; cv=none; b=PXMreIEmAwbv9McU+JT7ALS3Ft6gXOOEcs5BYC1BPGc1FbnP6lxFLIUQfzvhJUjy0o6yLhiNqGDAE55aaDwyCOZwTUg0EQ4xiEEgv3dCB4v+ExiQlWPH0KIOSZCx3K6Jfc+RpFiMCclsJrQIsxUkUePRaNqlyCb+KVOpmeTpEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440720; c=relaxed/simple;
	bh=eTInsLR85gfWDKjsvkqG7KAzrkPcyAsKb8FqdKSMXPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6oTpBnBuOSHfsGRrxoWz05REkmV/eFGa+RaQM28D91l6nM41+w+WN7Bpc3IH7ZZY5BibT204jiUBY35XEAI7FoMMeifG+DoiSDm3GY523IICk7+ACR5MrS5s2MWoT6INu4QbjesuGFVxx3yvAMrg62V5256LNzoqw36fDyOCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBjyWbfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBjyWbfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4021F000E9;
	Tue, 11 Aug 2026 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440718;
	bh=1lqvi2W8LPNtWb/wvNjdUeGAFyD0nbgTZu4Qg0okxTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hBjyWbfmrP7U8ajJNRSTArgqifEy21v0yjeVilRNJOaKDBqGQrp7erwxfyNiV6z60
	 Q5Wx9nr6HBXmDfI3EHAu4iM9l2POicFusC1RHnDDDpFmC341DoFjtCT6vJp6+pTctU
	 gpMIiF+drFvyZisTTorUSLfAwuHM2E+sjlWjD8deeL1yF+NgnhbkXhrsEkOeexzVzn
	 Vw/MqdWPtlfpMEJaFuxS6Q7lOpXX+Q4unMXe8CIqMlJmB7lzBJWzPO45AKbdOHTeR0
	 Q915Kg9ri/EbuCSZcPFvEGqM73oqfVPmwXdS1W7N6R0I+WoY7FGePEYjGjJT6K2MAw
	 uw9O1VHIxTZGg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev,
	Matt Evans <matt@ozlabs.org>
Subject: [PATCH v3 05/17] PCI/P2PDMA: Document the pdev->p2pdma lifetime and RCU rules
Date: Tue, 11 Aug 2026 12:30:47 +0300
Message-ID: <20260811-fix-p2p-acs-v3-5-efc488ee7c03@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
References: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
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

pdev->p2pdma has two lifetime models. Provider-based entry points are
quiesced by their driver before remove completes. pci_p2pmem_find_many()
and the p2pmem sysfs attributes can race with unbind and therefore rely
on the teardown grace period.

Document publication, teardown, and how the grace period protects both
the struct pci_p2pdma object and its optional gen_pool.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <matt@ozlabs.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a77ef9deb3c6..49bc8cf06240 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,39 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+/*
+ * Lifetime and RCU usage
+ *
+ * Within one driver bind, pdev->p2pdma is published exactly once, by
+ * pcim_p2pdma_init(), and cleared exactly once, by the pci_p2pdma_release()
+ * devres action that the same function installs. It is never re-pointed at a
+ * second struct pci_p2pdma, so a reader that observes a non-NULL pointer
+ * always observes the same, fully initialised object. That object is devres
+ * memory allocated before the action is installed, so devres frees it only
+ * after pci_p2pdma_release() has returned.
+ *
+ * Most exported entry points reach pdev->p2pdma through a struct pci_dev or a
+ * struct p2pdma_provider owned by the provider driver, and
+ * pcim_p2pdma_provider() requires callers to drop those references before the
+ * driver's remove() completes. Those cannot run concurrently with
+ * pci_p2pdma_release(), and their rcu_dereference() calls are simply how an
+ * __rcu pointer is read.
+ *
+ * pci_p2pmem_find_many() and the p2pmem sysfs attributes are the exceptions.
+ * The first walks every PCI device, so it can reach a provider whose driver is
+ * unbinding: pci_get_device() pins the struct pci_dev, not the driver. The
+ * second is reachable from userspace until sysfs_remove_group() runs at the end
+ * of the release. pci_has_p2pmem() must dereference the object to determine
+ * whether it owns a gen_pool, so even a poolless object must remain alive until
+ * that RCU reader exits. The sysfs group is created with the pool.
+ *
+ * The grace period in pci_p2pdma_release() first protects the struct
+ * pci_p2pdma itself from being freed while pci_has_p2pmem() is using it. For a
+ * pool-backed provider it also fences the gen_pool: gen_pool_alloc_owner()
+ * walks pool->chunks under RCU and gen_pool_destroy() frees those chunks
+ * without waiting for a grace period of its own, so pci_alloc_p2pmem() and
+ * p2pmem_alloc_mmap() hold rcu_read_lock() across the allocation.
+ */
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -235,9 +268,19 @@ static void pci_p2pdma_release(void *data)
 	if (!p2pdma)
 		return;
 
-	/* Flush and disable pci_alloc_p2p_mem() */
+	/*
+	 * Stop new RCU readers and wait for readers that observed p2pdma before
+	 * allowing devres to free it. This is required even without a pool,
+	 * because pci_has_p2pmem() dereferences every non-NULL p2pdma it finds.
+	 * For a pool-backed provider this also fences gen_pool_destroy().
+	 */
 	RCU_INIT_POINTER(pdev->p2pdma, NULL);
 	synchronize_rcu();
+
+	/*
+	 * The grace period also ensures no RCU reader can still be accessing
+	 * map_types here.
+	 */
 	xa_destroy(&p2pdma->map_types);
 
 	if (!p2pdma->pool)
@@ -255,6 +298,9 @@ static void pci_p2pdma_release(void *data)
  * for a PCI device. It allocates and sets up the necessary data
  * structures to support P2PDMA operations, including mapping type
  * tracking.
+ *
+ * The state is published once per driver bind and torn down by a devres
+ * action on unbind. Repeated calls for the same device are a no-op.
  */
 int pcim_p2pdma_init(struct pci_dev *pdev)
 {
@@ -786,6 +832,12 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 done:
+	/*
+	 * pci_p2pmem_find_many() reaches this with a provider whose driver may
+	 * be unbinding, so the store runs under RCU: pci_p2pdma_release()
+	 * clears the pointer and waits for readers before destroying
+	 * map_types. See "Lifetime and RCU usage" above.
+	 */
 	rcu_read_lock();
 	p2pdma = rcu_dereference(provider->p2pdma);
 	if (p2pdma)

-- 
2.55.0

