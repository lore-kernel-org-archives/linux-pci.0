Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564A40DB2F;
	Fri, 21 Aug 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341291; cv=none; b=ltWzTQbJZ3NWJGZDmY5suVs4cpZhCEsqMm90zOxWEmewVbQmnvTLzeBqVacp04MifDDnIKSsGygIPwwQL824BZP1kjoDDMshz7fwpOITlv+JnvrDgXGHgwWrFtqsr4NxkKYvA7J7ewTy5kdaIjP24tPtz/r9ta1loKm6vIw5Xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341291; c=relaxed/simple;
	bh=E61HoxnQb1MZXYIHKMRzyt7efWysUdqTpj8YRTlGnpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I37w6Fmj28XfKfPa2SdLxHPDrfUNVmoJkzwxJJ/sYtmfKT43CIQcSNTpNf/amP2bgNdPTOrAwwvXP8poTYFirXmfM0elEa6ke6TUdGF6SQ81nauqBQmuiWU+iIqHE4Geh77Vw+5BpX1DQGQX0e+C7YjH/YGaGb+d0YiOM0Rnp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMuXM939; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMuXM939"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A441F000E9;
	Fri, 21 Aug 2026 19:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341287;
	bh=+h61qyla2gsVzUl0IrDTFky+beKiUEq/sSZRml5hA/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UMuXM939yrAyaFh4Zx77TyNM8+krkv1Wt5UqmU778AwlCuCM/SDfCV7kr0+VYpL12
	 ZsCR8orh44zARRcJgLMzhT8BdW9TdMyMxAgYWtJOE91CrHILUrKvUb/QjSHlgio9ts
	 Ha1nP7IAXaVQbl+cWV1v3ADWgWZZtYShYc0RSemO6IBvdwasqMd7KFNSRvNJGmK9g9
	 RSpOEC1FFE/4jOt2GiZzdwk6hQTcIrsJvyNSm3vVmtcFUl1aUnp+ovqprGwakFXI61
	 p4ubcWiQepI5CSNh17HZNXrbnhM8HxNMJezwAYm2khBm4T9W6WlL62qh1qiyqz3wtu
	 pFYqijjPFJS8Q==
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
	Tushar Dave <tdave@nvidia.com>,
	Matt Evans <matt@ozlabs.org>
Subject: [PATCH v4 05/18] PCI/P2PDMA: Document the pdev->p2pdma lifetime and RCU rules
Date: Fri, 21 Aug 2026 22:38:36 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-5-94426b96de73@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
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

Tested-by: Tushar Dave <tdave@nvidia.com>
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

