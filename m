Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C73AB269
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121737; cv=none; b=HaA/kRbmjA8wlmUv8xK+iFKnRirjmAG8tbiy2t46Q7wW8YwFKTzvHcvC5jVuRWp1TI19PficDZhCwmit68gGkZyzTDQZ+vbKz10GyYDGEKX1UJtwUdrwYXGjWEc2ZIfbOq26PpPmZuptNGEjin82wli23wdnSK+QVpj1eY7sajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121737; c=relaxed/simple;
	bh=oe2JgUZuLpTYvieIrgXCrnFIfj1HnSk3HFGK1Vkh02I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4GzG1SS/xmdM0nSyZZbUmA2bVv4Za0FKzZO1GwXtqq7FX+ooi4hfZ8mbTNcSv+aN4ewQ6nTDrwxNaUvxbHVLmpfmVhyEsfAdgFLutsA2CzZvgsmxGMVjS75My1deZ3ypt11y2ZimFvAZq8g3CQZ7WeHWUcI9ZnFnW5CYquB0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOkYIwbd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOkYIwbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787121736; x=1818657736;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oe2JgUZuLpTYvieIrgXCrnFIfj1HnSk3HFGK1Vkh02I=;
  b=IOkYIwbdWybgzEdtHEzd1FTjO5foUjWc9pZ65mhq3NeQF3i0yZ4TOHDe
   pJ9HF+ydIM40XgAlnbF9qlo8TPGryKLDeBXDeuHtvqD48NzjphMUO1BXy
   aRQLPOhZo6QcuH70AjNwYkO+VJ6UGxqokbwXJEsRPQ8R13cPPhjAV5HJv
   3du7cEfpOlTu2RiA+eKidZXfcWv8jFWGq2YipGgqyVnHV5AZ+ULZgs+Et
   zS8NiOJuqg8phaOIEvaAeJQzbgq0xG5uv4f+bWlfLu85IT1zrTGPbblCs
   kV0fKuJ6HPQ/Zdjsx8K2Xe87+Of7S3QeRQKmzqH2usYW3+NDWgNIB53TC
   g==;
X-CSE-ConnectionGUID: n1g1q834RLyVH2jvzjMQ4A==
X-CSE-MsgGUID: rIuDHEiDTX2it/YNMYeScg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="99150333"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="99150333"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:42:16 -0700
X-CSE-ConnectionGUID: wX61uHauTAueUkuXbqkL1g==
X-CSE-MsgGUID: Ym74HnTLQUymqHvl04NaQQ==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.127]) ([10.245.244.127])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:42:13 -0700
Message-ID: <60d8bce9d63f7c14a39c49b3c7c4975a4d3eea62.camel@linux.intel.com>
Subject: Re: PCI_P2PDMA_MAP_BUS_ADDR and PCIe ATS?
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	leonro@nvidia.com, hch@lst.de
Date: Wed, 19 Aug 2026 08:42:10 +0200
In-Reply-To: <20260818190342.GA61595@nvidia.com>
References: <bc44b89c7996c8417a2126ada2cbe7c7bfe7568f.camel@linux.intel.com>
	 <20260818124309.GA5432@nvidia.com>
	 <00455fb0f42ffe5335c4256618b66cded7c36a37.camel@linux.intel.com>
	 <20260818190342.GA61595@nvidia.com>
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

On Tue, 2026-08-18 at 16:03 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2026 at 05:20:51PM +0200, Thomas Hellstr=C3=B6m wrote:
>=20
> > From my understanding, ATS translated requests would use the fast-
> > path
> > as soon as a translation is established in the device, without the
> > BUS
> > address being explicitly programmed. ACS redirect would block that.
>=20
> Oh it's super complex. There are seperate ACS bits for translated and
> untranslated requests. You need a PCI expert to design your fabric
> and
> devices to get a working system unfortunately.
>=20
> If you use ATS and don't set the ACS to route all translations to
> host
> then your IOVA space is no longer uniform, you have different results
> depending on which fabric route you take. That's a pretty
> unreasonable
> fabric design, and can't work securely with virtualization.
>=20
> > So wouldn't it be better to be safe than sorry and return a host
> > bridge
> > map and make something usable and potentially fast out of something
> > currently unusable?
>=20
> What we have today works for lots of devices and if you change it
> like
> this then you'll break existing users.

I guess if there are setups with devices with PCIe ATS enabled but only
ever sending untranslated requests, indeed they would see a performance
regression with this approach.

>=20
> Probably what you want to do is add a flag that the device is going
> to
> use ATS for the P2P DMA. Then we can force setup an IOVA and check
> the
> fabric path for translated request routing to make sure it will work.

Yes, sounds like a way forward. To be honest, we don't have an existing
use-case yet, but taking the union of how we want to configure our GPUs
moving forward and the support requests we see from p2pdma users, this
is probably something we are going to hit sooner than later.

>=20
> And yes, there is an existing issue with DMABUF not being able to
> negotiate these little pathing details with the importer when the
> exporter forms the scatterlist..

Yes, it was when looking into that I actually stumbled upon the ATS
issue as well. I recall you and Christian have touched upon this in the
past. What is an acceptable way forward here? A dma_map_resource_p2p()
interface that takes into account the mapping type?

Thanks,
Thomas


>=20
> Jason
