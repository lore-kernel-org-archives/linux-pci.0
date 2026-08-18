Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB43009F2
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066457; cv=none; b=b72YL5hKrBHdSR4+8W6hYtDwPchjBNU5OneYbBsLGP9uLm/rsnreK/7cIpcNHn1tA0sIR3u6OAlvaHilHgafrJrYpwnrpsoc/otAJhZpSaqlaU5VhLlSEKM3xs0w1LrCerDdrJP60hXMXDijcysS+snCOg4Hd0q7CEUDskvcMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066457; c=relaxed/simple;
	bh=DdS7iXpdq7Y1u+nt8v0zKg9x56DCPiiQoVzmtoZT+L8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiP3l6gRRk/iwoYbzuHRcpfPGHYl7hf1cASpbsWBxHcnM94NvF8sPudmVARcMYNbutw7k8BYwXRhbDLxsogh507DptFObMDFmUVcHS2/5xJOnj9O6/pOckz8E0z0yztq//rxFP0smDeehIhGmGfORfjfXwhy56+SJYTsU9OnD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGABoLBw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGABoLBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787066456; x=1818602456;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DdS7iXpdq7Y1u+nt8v0zKg9x56DCPiiQoVzmtoZT+L8=;
  b=AGABoLBw3fY0Ba+5MEYM/qn6dB4612aThlKUlubIWKd9XSRSJt4iWXcT
   SG++UyAMEG6F7M0DOrntXXD6bLXyMOfGLV/czM7LQtM17A6W8H0zlx24U
   fc098ARrlDNY4GbjJR9CJYHDOfu4zBvfHvXP5EOycplhT0ofIA2rA8Fpz
   xiRWqj/Yyho4yXf3udaEsxcengjD1geeliEN07pu7QR9ynXwo/l3JpKnD
   R7XoDgm8jDBHSf2gt0jje3crSCz8uHOFiiLqHhInutDNoa4JSNehEBdYW
   z7FC30NVB+duHcrEMDOSACDciIBTifdXyjh+W/AMoHC22ZweLfBgMDdjl
   g==;
X-CSE-ConnectionGUID: 34Y3IPegTRu34dpHixWz7w==
X-CSE-MsgGUID: 44SsCVLaRGKy28MOfhbzWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87578837"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87578837"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 08:20:55 -0700
X-CSE-ConnectionGUID: QSkp+oL/RvCRFn8APDvvjQ==
X-CSE-MsgGUID: eDymtkzfRXmBu4d54UWdyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="265867022"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.14]) ([10.245.244.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 08:20:54 -0700
Message-ID: <00455fb0f42ffe5335c4256618b66cded7c36a37.camel@linux.intel.com>
Subject: Re: PCI_P2PDMA_MAP_BUS_ADDR and PCIe ATS?
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	leonro@nvidia.com, hch@lst.de
Date: Tue, 18 Aug 2026 17:20:51 +0200
In-Reply-To: <20260818124309.GA5432@nvidia.com>
References: <bc44b89c7996c8417a2126ada2cbe7c7bfe7568f.camel@linux.intel.com>
	 <20260818124309.GA5432@nvidia.com>
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

On Tue, 2026-08-18 at 09:43 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2026 at 11:33:07AM +0200, Thomas Hellstr=C3=B6m wrote:
> > Hi!
> >=20
> > I was looking at the way pci_p2pdma_distance() returns
> > PCI_P2PDMA_MAP_BUS_ADDR if devices sit beneath a local switch with
> > ACS
> > disabled or not present.
> >=20
> > The client then programs the bus address directly to perform p2p
> > dma,
> > as handed out by the dma layer.
> >=20
> > However if the device (p2pdma client) has IOMMU turned on and ATS
> > enabled, the device may or may not send a translation request to
> > the
> > IOMMU. Wouldn't that fail returnint an IOMMU fault if the device is
> > programmed with the bus address rather than the IOVA?
>=20
> There are many goofy configurations you can setup on PCIe, something
> like this would be one of them :)
>=20
> Linux only (barely) works with a few mainstream ones.
> =C2=A0
> > So if ATS is enabled, shouldn't the device always be handed the
> > IOVA to
> > avoid this?=20
>=20
> No, Linux has no idea if the device will use ATS or not for a certain
> request. ATS is not an all or nothing feature in PCI.
>=20
> If you want this kind of configuration then set the ACS flags to
> achieve it, or disable ATS in the device.
>=20
> IMHO such a PCIe fabric is misconfigured. I can't see a reason why
> anyone would want to have ACS flags allowing fast path and then Linux
> setup to never supply an IOVA that can use it.

From my understanding, ATS translated requests would use the fast-path
as soon as a translation is established in the device, without the BUS
address being explicitly programmed. ACS redirect would block that.=20

Admittedly untranslated requests would take the detour around the host
bridge, but a GPU device that would otherwise enable ATS by default to
offload the IOMMU TLB would outright fail with the current code with
little clue what was going on.

So wouldn't it be better to be safe than sorry and return a host bridge
map and make something usable and potentially fast out of something
currently unusable?

The only way I can see one could support the fast-path for both
untranslated and translated request would be to set up a 1:1 IOVA for
the particular mapping.

/Thomas









>=20
> Jason
