Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD62F3C3F
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613258; cv=none; b=abZ+XesQScXLPOLcWG/1wwtW1eDfByokqnRaLqyocDMe7M5NyS/W/4oRUW6+vDTxrg4pCiHEMY/8pDzpWfDGitLfbC2R59Byshxm1Cyqo/Imsp9lfVE7x7ItoVOuDU+a/tsqQ3zwry9aTsvOc8WxmA2rPQHaBmd4QjHswj8i9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613258; c=relaxed/simple;
	bh=EoSTZAg44ZElNmmflX+QgyvATuV7UFoy/j6x4x39xHo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fx5jrrKZsEdhXn+7KlEY7llugnXCvl+SDAox/J6oF0MKq6Q1YmQ9uypGune/91LdA693J7Rnp8/yL4jrGy6C+E28VP+SuZZgxtZILCDcRJ83ktpnyp3ekaGOLBYHCFSsYBNC6x9Gg07UAXuhGLACaX/rrT/w39WmLeiWeBLboX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxijY6Wa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxijY6Wa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769613257; x=1801149257;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EoSTZAg44ZElNmmflX+QgyvATuV7UFoy/j6x4x39xHo=;
  b=WxijY6WaDrLoB7LGwvLNGf7m7W9deR04JzWXMXIeUjYuYhOv/Ogk4NA2
   IvkTgkhMxVMojCZhen5Hb2ZcS1MGGni8jgrBszxrLJQDhbKrBr4ijrvjI
   sD3VHwB4ukKJmoE9TRhrdW4e35MMvt/7NSPbvHFHNEVVtKSG4IWKmayZQ
   eucWF+kFbjEam9lVSFIpeb1P+PfMBanb0IiCxwsm4RF0Pk9jHFnrlJSaQ
   0nwrl77r0xFOSRrWkRxxxQZ4Uo/eD1as9tYqU/pyzHUkxyRFvnqq+yn/E
   Z8Uc3DE0WZyNeikyFH4aENMCQ4rai96v4QIfvs6kceMULUjUgMtAQEqge
   A==;
X-CSE-ConnectionGUID: OXzjLcZHRziuJqyHu9bUlQ==
X-CSE-MsgGUID: BqZfOerNS06aXB5jw/rAsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="88401759"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="88401759"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:14:16 -0800
X-CSE-ConnectionGUID: oWB1F6HMQWGeHsV3fqlopA==
X-CSE-MsgGUID: FHbYbtecT/WIha/tzPCc+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212851048"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:14:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 28 Jan 2026 17:14:09 +0200 (EET)
To: Keith Busch <kbusch@kernel.org>
cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org, 
    bhelgaas@google.com, alex@shazbot.org, Lukas Wunner <lukas@wunner.de>, 
    helgaas@kernel.org
Subject: Re: [PATCH 1/2] pci: fix slot trylock error handling
In-Reply-To: <aXonNmD1dJ3D5_80@kbusch-mbp>
Message-ID: <a02823f8-ef65-d458-90c4-be777d9d7f45@linux.intel.com>
References: <20260116184150.3013258-1-kbusch@meta.com> <aXji6yYImTyT26Wm@kbusch-mbp> <0637bc5b-afe5-80f0-8d80-7e6d1e2eea15@linux.intel.com> <aXonNmD1dJ3D5_80@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-852690426-1769613249=:1017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-852690426-1769613249=:1017
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Jan 2026, Keith Busch wrote:

> On Wed, Jan 28, 2026 at 11:16:06AM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 27 Jan 2026, Keith Busch wrote:
> >=20
> > > On Fri, Jan 16, 2026 at 10:41:49AM -0800, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > >=20
> > > > The device lock isn't held if pci_bus_trylock() fails, so the code =
had
> > > > been attempting to improperly unlock it.
> > > >=20
> > > > Fixes: a4e772898f8bf2 ("PCI: Add missing bridge lock to pci_bus_loc=
k()")
> > > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > >=20
> > > Ping?
> >=20
> > There's the older patch from Jinhui for the same thing:
> >=20
> > https://patchwork.kernel.org/project/linux-pci/patch/20251212145528.255=
5-1-guojinhui.liam@bytedance.com/
>=20
> Okay, let's go with that one then. But patch 2 from this series is still
> needed.

Yes, agreed. I meant to mention that about the patch 2 specifically but=20
forgot.

--=20
 i.

--8323328-852690426-1769613249=:1017--
