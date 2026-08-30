Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503B35C69B;
	Sun, 30 Aug 2026 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074587; cv=none; b=HOL4emQkJScHMtGA7ngp/rGEZ6S4kLWXDRcMAfvOrWWl7sOLtb8ej2jmZ0LMWjzSQnewB/2dbRTeJfkPL1TmdrATrIqvBtSPwiIQNuhzjthnIJlVC//qU2mX/OntUo551ETR7yRK4NXSmzL1V8LrP/PIjqMqZ9wpqK6ZRybp0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074587; c=relaxed/simple;
	bh=FrNiROj+6J8I8WM7tFolDxllzBv4gmwwB5Uq/si5Ugg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ews1Vl01tppPO+YWc4Iv+gDECA8BeKRgDTmZIXgluDAmssQ9xQGhOfI8MZv8KP89ysHhuA2kLGH3s0rba5wB11C+u+dUQGenIbWjSU3wC1dhbHW4Zp58U/KoNZ0OuoZbD3ZKVWCUGs6plU8BQcC47W6hGOgIsi1xr1XViu21YDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJFRrIX0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJFRrIX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788074585; x=1819610585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FrNiROj+6J8I8WM7tFolDxllzBv4gmwwB5Uq/si5Ugg=;
  b=LJFRrIX0koguZKopSwolpqXkow6s3ENDo83wHzLYFgmnaXRVOrbcngLb
   BhSIQSgRXe5tWA+lwZ2EG970OvSzzC89YmlG4Bdexlz5hO/qt577WZAMR
   3E73j0qDUeYEGMKCr/R3M/gBcup/8iOODWK2sLgIGKBe8npU4b6fCYp96
   8KNEfgzwVf2tDLZ1UvVqcaclD9iQrMOwti9KkbjhfJNUOAvyuKOxJrF0N
   o8p4uPyzpSjI188R92BUghkbObTxvRnrrN570oVAce38m4QZYP4DfhH2r
   t4PP2OJtpC1j+icbxPs4w51XihRgF4G+OtZxEt6Dqhp5Dz30YsBPBT2eF
   A==;
X-CSE-ConnectionGUID: Y+E+eWLMREuDmiok2oRxIQ==
X-CSE-MsgGUID: 7nfxBdbzRsuPcPVaVShgKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87648957"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="87648957"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:23:03 -0700
X-CSE-ConnectionGUID: g63J9bNCRiGHiIv2jfZGuQ==
X-CSE-MsgGUID: XGzyVKBFQd+G2eGiWHcTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="266710497"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:23:00 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	dave@stgolabs.net,
	arun.george@samsung.com,
	dongjoo.seo1@samsung.com,
	s.neeraj@samsung.com,
	vikash.k5@samsung.com,
	cpgs@samsung.com,
	gost.dev@samsung.com,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [RFC V2 08/10] hw/pci: Add PCIe Device3 capability support
Date: Sun, 30 Aug 2026 15:22:35 +0800
Message-ID: <20260830072235.399551-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2044366277.121787732104098.JavaMail.epsvc@epcpadp1new>
References: <2044366277.121787732104098.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:08 +0530, Shrihari E S wrote:
> +        /*
> +         * A UIO requester must be able to issue DMA transactions.
> +         * Enable PCI_COMMAND_MASTER in the PCI command register so the
> +         * device's bus master bit is set when the requester capability
> +         * is advertised.
> +         */
> +        pci_set_word(dev->config + PCI_COMMAND,
> +                     pci_get_word(dev->config + PCI_COMMAND) |
> +                     PCI_COMMAND_MASTER);

As posted this is dead code -- the series' only caller, in 09/10,
passes uio_req=false (the type3 is wired as completer only).  If a
requester shows up later, the write still doesn't do what the comment
wants: pci_do_device_reset() clears the writable COMMAND bits, so on
cold boot the machine reset discards it before the guest runs.  On a
hotplug path there is no bus reset, and pci_qdev_realize() ends in
pci_set_power() -> pci_set_enabled() -> pci_set_master(), so there the
write does take effect and the device surfaces with bus mastering
already on.  Bus master enable stays under firmware/OS control; I'd
drop the write.

The Dev3 defines already exist in Linux, and they reached QEMU in
January: 49f6b93d0752 ("linux-headers: Update to Linux v6.19-rc1") put
PCI_EXT_CAP_ID_DEV3 0x2F into
include/standard-headers/linux/pci_regs.h.  The cxl-2026-01-09-draft
base predates that sync, which is why this builds here; on master the
0x2f added to pcie_regs.h redefines it, and pcie.h pulls both headers
into the same TU, so that's a redefinition warning under the default
-Werror.  The register offsets don't collide -- PCI_DEV3_CAP_OFFSET
here against the header's PCI_DEV3_CAP -- so PCI_EXT_CAP_ID_DEV3 is the
one to drop.  SVC is the other case: 0x35 genuinely isn't in the kernel
header yet.

Many thanks,
Junjie
