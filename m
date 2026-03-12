Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C72D1F40;
	Thu, 12 Mar 2026 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318866; cv=none; b=NolJ+lH3NWDLkotKnxMgP4A0sVGv44PLg+TNVWws2aFhROY5Q3BtREyU7pPkSw3hnKC9gRgAbfOuh7HvW61nGJ2JkeQEDupiPly4ljf2i4m4Urq8kh+uf/VSxWi4+WJJRt2xES36pcxUAX8ukSyWb98ZcAc+p2fvq67zNXbc7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318866; c=relaxed/simple;
	bh=AvklWLdyZf2RgsoCwjnzcB7jYwrR6nw0YhHsxd9E8PU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qn/5GVmRyCsqmbCaZqVqLZz/SfqzVvaaanRA6W7LMwx0uvDbRiSAW3IHVp8/Sw1QjAHVb419aV3CAXsxXO0FXZLtN5wrrkwVcrwIRlqWM68vvZRF9kucwcDA78jnoqFB7HXOz6c+IRWpqBCIBjIa8z5Mqabbsp5Q5r0fnmNIANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWn8s6jd8zJ46Zt;
	Thu, 12 Mar 2026 20:33:33 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C404C40587;
	Thu, 12 Mar 2026 20:34:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 12:34:20 +0000
Date: Thu, 12 Mar 2026 12:34:19 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <alwilliamson@nvidia.com>,
	<jeshuas@nvidia.com>, <vsethi@nvidia.com>, <skancherla@nvidia.com>,
	<vaslot@nvidia.com>, <sdonthineni@nvidia.com>, <mhonap@nvidia.com>,
	<vidyas@nvidia.com>, <jan@nvidia.com>, <mochs@nvidia.com>,
	<dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Message-ID: <20260312123419.00003aca@huawei.com>
In-Reply-To: <20260306080026.116789-1-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 6 Mar 2026 08:00:14 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
>=20
> CXL devices could lose their DVSEC configuration and HDM decoder programm=
ing
> after multiple reset methods (whenever link disable/enable). This means a
> device that was fully configured =E2=80=94 with DVSEC control/range regis=
ters set
> and HDM decoders committed =E2=80=94 loses that state after reset. In cas=
es where
> these are programmed by firmware, downstream drivers are unable to re-ini=
tialize
> the device because CXL memory ranges are no longer mapped.

Hi Srirangan,

Firstly this might be because I'm behind on patch review and there is
a lot going on right now!  So this might be addressed in a different series.

I'd like to understand the whole use case + flow here.  In general I think
we have a problem if a driver is relying on the bios having set up the
decoders and simply doesn't function if the bios didn't do it (and
that applies in this reset case as well). For starters, no hotplug.
Anyhow, that's a different issue, so we can leave that for now.

I'm thinking the reset flow is a good deal more complex than simply
putting the bios programmed values back.  In some cases that might
be a very bad idea as autonomous traffic can hit the type 2 device
the moment these decoders are enabled and I'm guessing that may be
before the device has fully recovered. There are very few spec rules
about this that I can recall. On the setup path the BIOS presumably
got the device into a state where enabling such traffic was fine
and hopefully the driver bind doesn't break that state.

I think you are restoring CXL.mem as well so that gate isn't
going to save us.  Note it would be good to document what is restored and
why more clearly.  Sure we can figure it out from the code, but
a document might make life easier.

A device might handle this mess for us, but I doubt that this is universal.
For type 3 devices, I'm not sure what we want to do on reset in general.

Anyhow, this is really a request for a more detailed description of the
expected reset flow that goes into what the spec constrains and what
it doesn't.  Probably something worthy of going in Documentation.

Thanks,

Jonathan

>=20
> This series adds CXL state save/restore logic to the PCI core so
> that DVSEC and HDM decoder state is preserved across any PCI reset
> path that calls pci_save_state() / pci_restore_state(), for a CXL capable=
 device.
>=20
> HDM decoder defines and the cxl_register_map infrastructure are moved from
> internal CXL driver headers to a new public include/cxl/pci.h, allowing
> drivers/pci/cxl.c to use them.
> This layout aligns with Alejandro Lucero's CXL Type-2 device series [1] to
> minimize conflicts when both land. When he rebases to 7.0-rc2, I can move=
 my
> changes on top of his.
>=20
> These patches were previously part of the CXL reset series and have been
> split out [2] to allow independent review and merging. Review feedback on
> the save/restore portions from v4 has been addressed.
>=20
> Tested on a CXL Type-2 device. DVSEC and HDM state is correctly saved
> before reset and restored after, with decoder commit confirmed via the
> COMMITTED status bit. Type-3 device testing is in progress.
>=20
> This series is based on v7.0-rc1.
>=20
> [1] https://lore.kernel.org/linux-cxl/20260201155438.2664640-1-alejandro.=
lucero-palau@amd.com/
> [2] https://lore.kernel.org/linux-cxl/aa8d4f6a-e7bd-4a20-8d34-4376ea314b8=
f@intel.com/T/#m825c6bdd1934022123807e86d235358a63b08dbc
>=20
> Srirangan Madhavan (5):
>   PCI: Add CXL DVSEC control, lock, and range register definitions
>   cxl: Move HDM decoder and register map definitions to
>     include/cxl/pci.h
>   PCI: Add virtual extended cap save buffer for CXL state
>   PCI: Add cxl DVSEC state save/restore across resets
>   PCI/CXL: Add HDM decoder state save/restore
>=20
>  drivers/cxl/cxl.h             | 107 +-------
>  drivers/cxl/cxlpci.h          |  10 -
>  drivers/pci/Kconfig           |   4 +
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/cxl.c             | 468 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c             |  23 ++
>  drivers/pci/pci.h             |  18 ++
>  include/cxl/pci.h             | 129 ++++++++++
>  include/uapi/linux/pci_regs.h |   6 +
>  9 files changed, 650 insertions(+), 116 deletions(-)
>  create mode 100644 drivers/pci/cxl.c
>  create mode 100644 include/cxl/pci.h
>=20
> base-commit: 6de23f81a5e0
> --
> 2.43.0
>=20
>=20

