Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824224E3EE8;
	Fri,  4 Sep 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553216; cv=none; b=RNlVyf0mAOLTXzzZsJT698p5M3xuk3Sv77dU/YZtZ0VUmTOR/iRL9Mi9iVQt9TmbW3d47zanyZb9BkU1PKAks8pv43IMzq6OST8Ejlr22Z98/AeishmNt70q2Q4k0Q4qikjD32LO/rxGgG4D2Yqzf1fLYd1NcLyOcMn4cSdQnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553216; c=relaxed/simple;
	bh=Ror87dz6TYSCbKbiMSUgMR90TJNW5BKFterfbdl2OwM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PrZoe6Bn45oFyYQEUpsjPvmW0IQxA3lLCiHsSC+nhjlxaCX/WJYGHmpQpil2QW+sr4k9nbv0d+M2AwtO9jKFtXkNdvQ5fkjbYLRNo3+3OzIW9hhzLnrv7A4sQoNpI7TizI744W8PMjkhSfFjMEkEkZDwxC8A99FacKG9Ovg3Gyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Baoa53N7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Baoa53N7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788553212; x=1820089212;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ror87dz6TYSCbKbiMSUgMR90TJNW5BKFterfbdl2OwM=;
  b=Baoa53N7/93VR8CxfxJr2aqtxM7bEStsbChYPIOGY7qy3c+4wxWa3GWf
   JIRpZLsrJ9+MkWarUeKlquYROijQjy2vgV9dAc/FaAcEUDbCrpjjOBIL7
   P4qG2N5jB2hTrzmgmGnROIo/m+veXNMOpLFmcG7033AZ6uiGeM664rjNp
   /5pnplVRm/XUkpCQpXqsycudAOe1r5iEhFxtVM4V+oTZqH++rX0/tg6Wy
   ig9iwGrZetbuE8anXp/IdoaR9XOBC01aYe1vSs1OUyEkE3SrzLpaEejb1
   z7qA/kGBgbXaGE0IHheZma1EXT+ufqw0ivsZE/wv0ejTJMAGOtf9t1lW+
   Q==;
X-CSE-ConnectionGUID: R24qYB3VSKe8lgoJ3h8/wg==
X-CSE-MsgGUID: YmfhhpwIRZq45L/22AeniQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="88204208"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="88204208"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 13:20:10 -0700
X-CSE-ConnectionGUID: MD2pHQeuTpaaG3WHmvxiDA==
X-CSE-MsgGUID: 5YFhksYaRO2aAdIh2xaVQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="300003332"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 13:20:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Sep 2026 23:20:03 +0300 (EEST)
To: "Yury M." <yurypm@arista.com>
cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH] PCI: Stop waiting for link status after config read
 failure
In-Reply-To: <6f916404-63b5-40a3-a429-befe42a08629@arista.com>
Message-ID: <4186a2bb-2f4d-e536-0acf-cfa4994e2cb4@linux.intel.com>
References: <20260904111318.1063858-1-yurypm@arista.com> <apq3kd9_qsURNpKu@wunner.de> <6f916404-63b5-40a3-a429-befe42a08629@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-392614970-1788553203=:1170"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-392614970-1788553203=:1170
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 4 Sep 2026, Yury M. wrote:

> what to you think about this check:
> if ((pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta) ||=C2=A0
> PCI_POSSIBLE_ERROR(lnksta)) && pci_dev_is_disconnected(pdev))
> =C2=A0 =C2=A0 return -ENODEV;

Apparently you're ignoring my feedback. :-(

--
 i.
=20
> On 9/4/26 13:20, Lukas Wunner wrote:
> > On Fri, Sep 04, 2026 at 11:13:18AM +0000, Yury Murashka wrote:
> > > With a nested PCIe topology with multiple layers of hotplug, a link c=
an go
> > > down near the bottom of the topology shortly before a link above it g=
oes
> > > down. In that case, pcie_wait_for_link_status() can wait for the full
> > > timeout while every read of the link status register fails because th=
e
> > > device has disappeared.
> > >=20
> > > Return immediately when reading the link status fails so event proces=
sing
> > > can continue.
> > [...]
> > > +++ b/drivers/pci/pci.c
> > > @@ -4580,7 +4581,8 @@ static int pcie_wait_for_link_status(struct pci=
_dev
> > > *pdev,
> > >     =09end_jiffies =3D jiffies +
> > > msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
> > >   =09do {
> > > -=09=09pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> > > +=09=09if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta))
> > > +=09=09=09return -ENODEV;
> > >   =09=09if ((lnksta & lnksta_mask) =3D=3D lnksta_match)
> > >   =09=09=09return 0;
> > >   =09=09msleep(1);
> > It might be clearer if you check for pci_dev_is_disconnected() directly
> > instead of relying on a PCIBIOS_DEVICE_NOT_FOUND return value which is
> > generated as a side effect of the device being gone.
> >=20
> > Thanks,
> >=20
> > Lukas
>=20
>=20
--8323328-392614970-1788553203=:1170--
