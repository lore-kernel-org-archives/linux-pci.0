Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0F3C0A18
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045632; cv=none; b=Q/XdDpTzeNbw7813papmCvX9B/h72ebg0q6tQdFr15vxuDOPleMDaPGIT9X4uqeIrVImjnwGUrfGAOMfvfqFkWlWXHkBvS09YQUJZPFoBYMOewzrcORqN27hIQ4ZKgqSCTFja30JfoXI0rRdrrsU80mm+YeEWXRc7VrkJBl0W3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045632; c=relaxed/simple;
	bh=/HUi9ugRqmi++rns32DJEn59gPGcJyWLaxkL0OFdCaI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=aUtZqoMn9jaqmyWZSLSRMlIoJ+Anv+8ouOTgpuK3sN/+3QWHUmSt3tvajMW9lLHCMti0tMhwXHrq8Zbo5E+flzoilFfbW8qP/QXJXMCSsau43twkZhKEqNTWMkMwB6a7l2SfUhVBr6uEcOvWRta6TIZp4uc6xBpyLgX/uWL9bNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/ukW4ZR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/ukW4ZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787045630; x=1818581630;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=/HUi9ugRqmi++rns32DJEn59gPGcJyWLaxkL0OFdCaI=;
  b=l/ukW4ZRL2xpCgt/bWBQBbezbZ0NKf/IGt3EHgJAUZJFoM9DE5Q6UUbr
   hGAC3VwNj+xuwuFpVYCnF49D1wbF2bJreKpaUQ4ia+H6okaisiLgcko33
   usTFpYFtr8Di9WbbDV/3lz7L8vyIAMG95TOwGTjnaiNMegR5zoLbkND46
   S4Vo4/2gKrN8ts2zoDt3Uph77ykuSyq8L2bIkuWKv0UmBtxHwi0/zRd59
   e7V6Gwf710DEu+Byxvhh7BSA7vjIxP2L49dCOO5OyJl+dyXSfb4jew7+M
   P9VSs0cid+9MwFhHU+e9GIqE5mJ7wIX9hFDnh04YKAcuabn9yIy7r2SGD
   A==;
X-CSE-ConnectionGUID: +SRhphwKROC+8aC/EPXm7w==
X-CSE-MsgGUID: +5JIZC3rT+evza04Iu9Kqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="113074081"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="113074081"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 02:33:50 -0700
X-CSE-ConnectionGUID: FmqcsBUcRt+Fba1BgfdNQw==
X-CSE-MsgGUID: /6ziGOHSSBK9fku2jFK/Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264730763"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.14]) ([10.245.244.14])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 02:33:48 -0700
Message-ID: <bc44b89c7996c8417a2126ada2cbe7c7bfe7568f.camel@linux.intel.com>
Subject: PCI_P2PDMA_MAP_BUS_ADDR and PCIe ATS?
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: bhelgaas@google.com, bhelgaas@google.com
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, leonro@nvidia.com, 
	jgg@nvidia.com, hch@lst.de
Date: Tue, 18 Aug 2026 11:33:07 +0200
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

I was looking at the way pci_p2pdma_distance() returns
PCI_P2PDMA_MAP_BUS_ADDR if devices sit beneath a local switch with ACS
disabled or not present.

The client then programs the bus address directly to perform p2p dma,
as handed out by the dma layer.

However if the device (p2pdma client) has IOMMU turned on and ATS
enabled, the device may or may not send a translation request to the
IOMMU. Wouldn't that fail returnint an IOMMU fault if the device is
programmed with the bus address rather than the IOVA?

So if ATS is enabled, shouldn't the device always be handed the IOVA to
avoid this? Granted, untranslated transactions will then take the
round-trip to the host bridge, but pre-translated transactions will
still benefit from the direct routing through the switch, although that
is not directly visible to the kernel p2pdma layer?

Does pci_p2pdma_distance() need to be client ATS-enabled aware?

Any input appreciated,
Thanks,
Thomas
