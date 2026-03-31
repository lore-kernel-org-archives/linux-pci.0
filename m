Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE89288D0;
	Tue, 31 Mar 2026 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774927950; cv=none; b=ZMBEtgARG48HNem+XBelCV8WC41XayV51hN0n3U1ktQzeM3+QjiCeJoTHafEJMZWoZgByQWOopWshj0XZqfiKyAW+T9Sj5v3eq+gMiSdmYxzJ1OBHB2cJGCsuH1LLdf9dRCQiLfy4v9c2P77c/B7e4M2KopPPhZf8qziNQYkklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774927950; c=relaxed/simple;
	bh=uPC6t3Ah4j7XoqiNVRQrTJhNDOCiTbFxwuOpGbLtyls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijg5sWB2IqCO5inzfKvanr35oQqmH57ds77Brph54OnbaVnTTStil0LAZAWP2Hjo5A9CCW/kl5OhOv60Ph4ephTXTsjQnQhMjghuWWjKDBc20y4hDFpc6EvL55WetqcQ15ijrlEcL8cJaLsgPlm/xiSbuP/IosVlltW6ACOZZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbkzO576; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbkzO576"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774927948; x=1806463948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uPC6t3Ah4j7XoqiNVRQrTJhNDOCiTbFxwuOpGbLtyls=;
  b=lbkzO576EbWh0S8hq2969mf/jAF5JtaI1fYBkOotmv5tDSiiBvygPzKB
   tpat4BvdPylO6Kk/81ELkvhZn1o4O0R5/ESZSdPCF1i3UB0mPDyUy//o9
   rBcOgDPISuYOgcYvH7/a73jY7lYXDvIwU0psmWUTiFzHrVk/uEaJ9INl9
   ecjfJnnLS7YUcKJFo2al7E0Z6xeT8jbOzGnCJq83I0rDVrzviVxlB19/y
   IurjB9ViZaW3sSsdqzb5g1BbLeGZtsn7BfozmIhHlyPIc2timv1gFN7D3
   T31/K17luZvnj9Q6L8uBpnOXyA5PPzP9bQZhdNlMXHspcU8VLZNvDrirp
   Q==;
X-CSE-ConnectionGUID: eus3jMksSXOT16PUzAcGQQ==
X-CSE-MsgGUID: PkdahUvUSLu9xZNvWZviRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79790944"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="79790944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 20:32:27 -0700
X-CSE-ConnectionGUID: bhnledyGR6aHGm8BU8tweQ==
X-CSE-MsgGUID: i9Ijzv1gSomcENSmyY4L+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221834925"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 20:32:24 -0700
Message-ID: <d309de55-a1ec-4c99-b464-9ae9c0d9e027@linux.intel.com>
Date: Tue, 31 Mar 2026 11:31:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU
 drivers
To: David Matlack <dmatlack@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
References: <20260327211649.3816010-1-dmatlack@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260327211649.3816010-1-dmatlack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/26 05:16, David Matlack wrote:
> Ensure that PCI devices with ATS disabled via quirk have it disabled
> before IOMMU drivers are notified about the device rather than after.
> Fix this by converting the existing quirks from final to early fixups
> and changing the quirk logic to set a new no_ats bit in struct pci_dev
> that prevents pci_dev.ats_cap from ever gettting set.
> 
> This change ensures that pci_ats_supported() takes quirks into account
> during iommu_ops.probe_device(), when IOMMU drivers are first notified
> about devices. It also ensures that pci_ats_supported() returns the same
> value when the device is released in iommu_ops.release_device().
> 
> Notably, the Intel IOMMU driver uses pci_ats_supported() in
> probe/release to determine whether to add/remove a device from a data
> structure, which easily leads to a use-after-free without this fix.

Can you please shed more light on the above issue? In my investigation,
iommu_ops.probe_device() is always called after the no_ats quirk,
regardless of whether this patch is applied.

The diff of the changes I made for testing is as follows:

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 442271a1b92a..c024964ac53b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3271,6 +3271,8 @@ static struct iommu_device 
*intel_iommu_probe_device(struct device *dev)
                                 info->pfsid = pci_dev_id(pci_physfn(pdev));
                         info->ats_qdep = pci_ats_queue_depth(pdev);
                 }
+               pci_info(pdev, "ATS %s\n", info->ats_supported ?
+                        "supported" : "not supported");
                 if (sm_supported(iommu)) {
                         if (pasid_supported(iommu)) {
                                 int features = pci_pasid_features(pdev);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..c63616d108b7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5714,6 +5714,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 
0x1457, quirk_intel_e2000_no_ats);
  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, 
quirk_intel_e2000_no_ats);
  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, 
quirk_intel_e2000_no_ats);
  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, 
quirk_intel_e2000_no_ats);
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0b25, quirk_no_ats);
  #endif /* CONFIG_PCI_ATS */

  /* Freescale PCIe doesn't support MSI in RC mode */


The related kernel messages are shown below:

# dmesg | grep "0000:00:01.0"
[   15.834944] pci 0000:00:01.0: [8086:0b25] type 00 class 0x088000 PCIe 
Root Complex Integrated Endpoint
[   15.836382] pci 0000:00:01.0: BAR 0 [mem 
0x1e0fff980000-0x1e0fff99ffff 64bit pref]
[   15.836655] pci 0000:00:01.0: BAR 2 [mem 
0x1e0fff900000-0x1e0fff93ffff 64bit pref]
[   15.837904] pci 0000:00:01.0: calling 
quirk_igfx_skip_te_disable+0x0/0xe0 @ 1
[   15.838614] pci 0000:00:01.0: quirk_igfx_skip_te_disable+0x0/0xe0 
took 0 usecs
[   21.205177] pci 0000:00:01.0: calling  quirk_no_ats+0x0/0x40 @ 1
[   21.206767] pci 0000:00:01.0: disabling ATS
[   21.207916] pci 0000:00:01.0: quirk_no_ats+0x0/0x40 took 1122 usecs
[   21.305357] pci 0000:00:01.0: DMAR: ATS not supported
[   21.306925] pci 0000:00:01.0: Adding to iommu group 4
[   42.564912] idxd 0000:00:01.0: Intel(R) Accelerator Device (v200)
[   42.568653] probe of 0000:00:01.0 returned 0 after 87413 usecs


Anything I missed?

Thanks,
baolu

> 
> This change also makes disabling ATS via quirk behave the same way as
> the pci=noats command line option, in that pci_ats_init() bails
> immediately and never intializes pci_dev.ats_cap.
> 
> Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
> Closes:https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
> Signed-off-by: David Matlack<dmatlack@google.com>
> ---
> v2:
>   - Update the commit message with reasons why this is being fixed in the
>     PCI core, rather than applying a point fix to the Intel IOMMU driver
>     (Andy)
>   - Condense the pci_ats_disabled() and dev->no_ats checks into a single
>     line in pci_ats_init()
>   - Reorder the no_ats bitfield to be after ats_stu since there is likely
>     u8-sized gap there for alignment purposes
> 
> v1:https://lore.kernel.org/linux-pci/20260223184017.688212-1- 
> dmatlack@google.com/
> 
> Cc: Raghavendra Rao Ananta<rananta@google.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> 
>   drivers/pci/ats.c    |  2 +-
>   drivers/pci/quirks.c | 50 ++++++++++++++++++++++----------------------
>   include/linux/pci.h  |  1 +
>   3 files changed, 27 insertions(+), 26 deletions(-)

