Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075B3264E0;
	Fri, 11 Sep 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148760; cv=none; b=UB/8w3/q/B6icdDnuYHdGhjHZXBHm4ww6r4dERKI0RPlNdUhpFQEULFhtUVd/tnmBLtp6t9mAVLzz/iWpJtVkxF5nVQPLBI8XN1+wPWoLhCZDjg5twoRqoDhbzmhPSDOSSknu5VofDw7UjToypdfFOp4j0VewLGn2gp/jpuRsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148760; c=relaxed/simple;
	bh=vqNXLstQ6G+A9gRpKcQ/FaWOMhaFZmotqLSI45wThoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7bQUnhfcS98XXF4QoqrtqSIR5z2YXVvYEA5JJuR3QUCVCKWWHalLnm8FsVjc/pXT7w0QNRBLLkjToarcsg92T3mxZc8WQKcQfpFPFDNLhjzy5d6uubR2mM5mCDE9wXRFP7ndzAAlbe20zvK0Opy781WlSPJJCIrYHP8J6dn5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pJMm1oNc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pJMm1oNc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6480C16F2;
	Fri, 11 Sep 2026 10:45:46 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C8A33F8C6;
	Fri, 11 Sep 2026 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789148750; bh=vqNXLstQ6G+A9gRpKcQ/FaWOMhaFZmotqLSI45wThoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pJMm1oNcdYKueu9D95IWWioliFwd6SXi9fhAyOnY6niH5LkpKAyBF4t3YZaJzMTCO
	 9ydzebNZ2ZfRCLTfyifsBjaCV9dabFWStUcgmAyVVpNAeysxrg4x+aJaeUq6AMnoq6
	 hRdklboGrqiwEwID3cGK+Xmq9bqjnJG+2W7lUED0=
Message-ID: <1785d4ce-03f5-4226-9987-d267a10a360d@arm.com>
Date: Fri, 11 Sep 2026 18:45:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] iommu: Reduce iommu_probe_device_lock contention
To: Pavol Sakac <sakacpav@amazon.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 nh-open-source@amazon.com
References: <20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2026 1:58 pm, Pavol Sakac wrote:
> iommu_probe_device_lock is a file-scope mutex held across
> __iommu_probe_device(): every device's IOMMU probe serializes against
> every other. With "PCI/IOV: Initialize virtual functions in
> parallel" [1] fanning an SR-IOV enable across CPUs, it collects 94.7%
> of all lock wait. Patch 1 gathers per-member sysfs publication into one
> all-or-nothing helper (no functional change); patches 2-3 move that
> publication and first-device default-domain setup into per-group
> finalisation after the global unlock, under group->mutex, mirroring the
> removal path and bus_iommu_probe().
> 
> Lock statistics and SR-IOV init time for 4x PF (NVMe, 255 VFs each), on
> the reproducer from the parallel VF initialization cover letter [1]:
> 
>    lock_stat:
>    Lock                     wait: Before     After   contentions: Before   After
>    iommu_probe_device_lock      25507 ms  10471 ms                  1143     841
>    &root->kernfs_rwsem            942 ms   1834 ms                 93208  116316
>    &vfio.group_lock               425 ms   3614 ms                   497     736
> 
>    avg wait per acquisition  6.3 ms -> 2.6 ms (4080 acq., both arms)
> 
>    Stage                 SR-IOV init time:
>    S0 (baseline)         3027 ms
>    S1                     999 ms
>    S2 (this series)       995 ms
> 
> Reproducer disclaimer:
> I lean primarily on lock_stat numbers to defend the improvements. In
> the reproducer, this lock's residual hold dominates the window and
> masks the later series' wall-time gains, more in [1].
> 
> This is relief, not removal: the lock still has the highest wait
> time in the profile after this series. Wait per acquisition drops
> from 6.3 ms to 2.6 ms, which is what makes the smaller
> serialization points behind it measurable for the later series.
> 
> RFC on the direction: The comment in __iommu_probe_device() expects
> the lock to narrow to device_lock() once the ACPI/OF replay calls
> are cleaned up. I could not make that work for the whole section:
> group formation in ops->device_group() is a cross-device decision a
> per-device lock cannot order. This series instead moves the work
> that needs no global ordering out of the section. Is that an
> acceptable step, or is there a scoping or removal plan this should
> wait for?

The point of probe_device_lock is to prevent multiple threads trying to
probe the *same* device concurrently; it protects the per-device state
of dev->iommu and dev->iommu_group until the latter is assigned or the
former is cleaned up (depending on how the probe goes). The replay calls
are mostly gone, but the main reason device_lock() still won't work is
that the same problem exists for driver-model-based IOMMU drivers
themselves, since we don't have a good way to avoid bus_iommu_probe()
deadlocking on IOMMU devices that are in the middle of registering
during their own driver bind (not least the caller itself).

> A second question: I have measured where 90% of the residual hold goes:
> get_pci_alias_group() walks every PCI device in the system to find
> same-bus DMA aliases. It runs once per device probed, so once per VF,
> under this lock, and the VFs keep growing the list it walks. A prototype
> that skips the walk when no device has a dma_alias_mask and this device
> has no pci_real_dma_dev() override cuts this lock's hold time by about
> 90%, for the same acquisitions and the same groups. I am not proposing
> it here, as I do not have the time to get it right this cycle. How can
> we optimize this preferably in O(1) time?

TBH that makes it sound like optimising pci_device_group() is the better
thing to do. We were never really meant to have a global lock here - it
was just an acceptable compromise for simplicity at the time - so I'm
still not keen on adding yet more complexity to the probe flow to work
around it as if global serialisation was necessary when it isn't.

Heck, even if you do just want a quick bodge to ease contention then I'd
still lean more towards something more self-contained like this
hometime-on-a-Friday fun I couldn't resist sketching out...

Thanks,
Robin.

----->8-----

From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] UNTESTED: iommu: Reduce iommu_probe_device_lock contention

The purpose of iommu_probe_device_lock was to prevent multiple threads
trying to probe the same device concurrently, it's only global for the
sake of simplicity, as there are still reasons why we can't use
device_lock(), and adding a whole other lock to struct device itself
just for this would be unreasonable.

However, we're now getting sufficiently large systems with enough
devices to start seeing significant contention on this lock, so let's
scale it to a lock table to reduce contention between unrelated devices.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/acpi/scan.c      |  6 +++---
  drivers/iommu/iommu.c    | 37 +++++++++++++++++++++++++------------
  drivers/iommu/of_iommu.c |  6 +++---
  include/linux/iommu.h    |  2 +-
  4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f48715ed827c..33d6a758042a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1620,10 +1620,10 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
  	int err;
  
  	/* Serialise to make dev->iommu stable under our potential fwspec */
-	mutex_lock(&iommu_probe_device_lock);
+	mutex_lock(iommu_probe_device_lock(dev));
  	/* If we already translated the fwspec there is nothing left to do */
  	if (dev_iommu_fwspec_get(dev)) {
-		mutex_unlock(&iommu_probe_device_lock);
+		mutex_unlock(iommu_probe_device_lock(dev));
  		return 0;
  	}
  
@@ -1633,7 +1633,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
  	if (err && err != -EPROBE_DEFER)
  		err = viot_iommu_configure(dev);
  
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(iommu_probe_device_lock(dev));
  
  	return err;
  }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..11519e195aaf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -381,9 +381,9 @@ int iommu_mock_device_add(struct device *dev, struct iommu_device *iommu)
  {
  	int rc;
  
-	mutex_lock(&iommu_probe_device_lock);
+	mutex_lock(iommu_probe_device_lock(dev));
  	rc = iommu_fwspec_init(dev, iommu->fwnode);
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(iommu_probe_device_lock(dev));
  
  	if (rc)
  		return rc;
@@ -400,7 +400,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
  {
  	struct dev_iommu *param = dev->iommu;
  
-	lockdep_assert_held(&iommu_probe_device_lock);
+	lockdep_assert_held(iommu_probe_device_lock(dev));
  
  	if (param)
  		return param;
@@ -457,7 +457,7 @@ void dev_iommu_priv_set(struct device *dev, void *priv)
  {
  	/* FSL_PAMU does something weird */
  	if (!IS_ENABLED(CONFIG_FSL_PAMU))
-		lockdep_assert_held(&iommu_probe_device_lock);
+		lockdep_assert_held(iommu_probe_device_lock(dev));
  	dev->iommu->priv = priv;
  }
  EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
@@ -483,9 +483,9 @@ static int iommu_init_device(struct device *dev)
  	 * found no IOMMU to wait for, so there's no point calling it again.
  	 */
  	if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
-		mutex_unlock(&iommu_probe_device_lock);
+		mutex_unlock(iommu_probe_device_lock(dev));
  		dev->bus->dma_configure(dev);
-		mutex_lock(&iommu_probe_device_lock);
+		mutex_lock(iommu_probe_device_lock(dev));
  		/* If another instance finished the job for us, skip it */
  		if (!dev->iommu || dev->iommu_group)
  			return -ENODEV;
@@ -622,7 +622,20 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
  	return ((struct iommu_attach_handle *)xa_untag_pointer(entry))->domain;
  }
  
-DEFINE_MUTEX(iommu_probe_device_lock);
+static struct mutex __iommu_probe_device_lock[4] = {
+	__MUTEX_INITIALIZER(iommu_probe_device_lock),
+	__MUTEX_INITIALIZER(iommu_probe_device_lock),
+	__MUTEX_INITIALIZER(iommu_probe_device_lock),
+	__MUTEX_INITIALIZER(iommu_probe_device_lock),
+};
+
+struct mutex *iommu_probe_device_lock(const struct device *dev)
+{
+	int hash = ((uintptr_t)dev / roundup_pow_of_two(sizeof(*dev))) %
+		    ARRAY_SIZE(__iommu_probe_device_lock);
+
+	return __iommu_probe_device_lock + hash;
+}
  
  static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
  {
@@ -637,7 +650,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
  	 * probably be able to use device_lock() here to minimise the scope,
  	 * but for now enforcing a simple global ordering is fine.
  	 */
-	lockdep_assert_held(&iommu_probe_device_lock);
+	lockdep_assert_held(iommu_probe_device_lock(dev));
  
  	/* Device is probed already if in a group */
  	if (dev->iommu_group)
@@ -711,9 +724,9 @@ int iommu_probe_device(struct device *dev)
  	const struct iommu_ops *ops;
  	int ret;
  
-	mutex_lock(&iommu_probe_device_lock);
+	mutex_lock(iommu_probe_device_lock(dev));
  	ret = __iommu_probe_device(dev, NULL);
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(iommu_probe_device_lock(dev));
  	if (ret)
  		return ret;
  
@@ -1803,9 +1816,9 @@ static int probe_iommu_group(struct device *dev, void *data)
  	struct list_head *group_list = data;
  	int ret;
  
-	mutex_lock(&iommu_probe_device_lock);
+	mutex_lock(iommu_probe_device_lock(dev));
  	ret = __iommu_probe_device(dev, group_list);
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(iommu_probe_device_lock(dev));
  	if (ret == -ENODEV)
  		ret = 0;
  
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a18bb60f6f3d..b5e3a425ca2d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -121,9 +121,9 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
  		return -ENODEV;
  
  	/* Serialise to make dev->iommu stable under our potential fwspec */
-	mutex_lock(&iommu_probe_device_lock);
+	mutex_lock(iommu_probe_device_lock(dev));
  	if (dev_iommu_fwspec_get(dev)) {
-		mutex_unlock(&iommu_probe_device_lock);
+		mutex_unlock(iommu_probe_device_lock(dev));
  		return 0;
  	}
  	dev_iommu_present = dev->iommu;
@@ -151,7 +151,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
  		iommu_fwspec_free(dev);
  	else if (err && dev->iommu)
  		dev_iommu_free(dev);
-	mutex_unlock(&iommu_probe_device_lock);
+	mutex_unlock(iommu_probe_device_lock(dev));
  
  	/*
  	 * If we're not on the iommu_probe_device() path (as indicated by the
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..3b876cb285e0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1201,7 +1201,7 @@ static inline void *dev_iommu_priv_get(struct device *dev)
  
  void dev_iommu_priv_set(struct device *dev, void *priv);
  
-extern struct mutex iommu_probe_device_lock;
+struct mutex *iommu_probe_device_lock(const struct device *dev);
  int iommu_probe_device(struct device *dev);
  
  int iommu_device_use_default_domain(struct device *dev);
-- 
2.54.0.dirty

