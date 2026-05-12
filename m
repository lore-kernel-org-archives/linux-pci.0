Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F584A3402;
	Tue, 12 May 2026 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579012; cv=none; b=orUH09JoICz0Fef4p/klLBUDVzS0MyCQnihsCQ5vsiy54slxeowd34KEMuxliQQkre5Pvr0PW83d87+zjL7Ti8sHIzGuFmFeorPlFPN990yMMQagEJUGJtQH/9ux8s8dYfjPyN0vRPZtUQFk0ocsQrqDp00Z7ydno5GUJWQh+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579012; c=relaxed/simple;
	bh=54D7JNIFzhUt8SwirGOyq5wweX1Ji2pAZePehT6057o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s3auRK9P4UB9i1NweA4pGOjx3Lgcg4JsadHgMuPvKujGY7IbdOXsaL4FlwNibVSPi4ohbaYRxKG9kYvsGIrCjWq5qAU+Dz6cQVaXLaEzrt7nE+svUdSzMnZjBtBWuxv80NjvF0jloZSAYZsDO6jRdDjo3oG5JDqjEerdOW/ooqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPRvN0tm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPRvN0tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778579010; x=1810115010;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=54D7JNIFzhUt8SwirGOyq5wweX1Ji2pAZePehT6057o=;
  b=bPRvN0tmuOdVPHDEIqNxpbl2Rl1uj8Cb4IPbCrbvS2ET3gPCeFyuyIUx
   FW/c3LWaC2Ubl8V3RZGvmtJsGaIk3c6+uCThyKv6ZXqwyrWZofPKOWie7
   bmhQIi7rF1vSOBr08Hegyb4tbUMDQh/Is4fPh/DoN8X9SEVKNG4CxH1Ul
   oEXMLaJML2vf4S/0UA7P76/viVAYz2BOZSXpEzo9MPW44SytuAq5xMqAJ
   mwNU38j5ljo84vDMCwbc7Hd5FXq3egfNQmkxV/1JEn1y/w6XHJN5RnTFw
   LwfJDHHfLeilrqKxDUSNIpNHAUFJHwF0Zs/WBT7fq//AWihaPgU+JCPNq
   A==;
X-CSE-ConnectionGUID: 5EDIBm3kQT2InNd0Wd9EYg==
X-CSE-MsgGUID: fPGrVclMQYeiwbA1I5uzPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79504576"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79504576"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:43:29 -0700
X-CSE-ConnectionGUID: LoH9BCRsSBed6E7envLNgg==
X-CSE-MsgGUID: 97Ed/ax0R8OuwGTRtNZDdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="261472299"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:43:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 May 2026 12:43:23 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Ravi Kumar Bandi <ravib@amazon.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap
 handler
In-Reply-To: <20260512091848.GA1539393@rocinante>
Message-ID: <963819fa-1177-7e27-da34-b79013575b09@linux.intel.com>
References: <20260512084315.32564-1-ravib@amazon.com> <20260512091848.GA1539393@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2075155497-1778579003=:1449"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2075155497-1778579003=:1449
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 May 2026, Krzysztof Wilczy=F1ski wrote:

> Hello,
>=20
> > pci_mmap_resource() does not check IORESOURCE_DISABLED before mapping
> > a PCI BAR resource into userspace. This allows new mmaps to succeed
> > even after a device has been marked disabled or soft-unplugged by the
> > driver to prevent further access.
>=20
> Which driver disables resources?  Would this be some Amazon-specific thin=
g
> you are trying to fix?  Or are you just manually disabling a given device
> using sysfs, or something like this?
>=20
> For "soft-unplugged" device we have pci_dev_set_disconnected(), but this
> does not check current flags set.
>=20
> What is your use case here?
>=20
> > Add the check to return -ENODEV when the resource is disabled, blocking
> > new userspace mmaps of BAR resources after device removal.
> >=20
> > Tested by marking the PCI BAR resource as disabled and verifying that
> > a subsequent mmap attempt fails with -ENODEV.
>=20
> Can you explain how did you do this?
>=20
> > @@ -1089,6 +1089,9 @@ static int pci_mmap_resource(struct kobject *kobj=
, const struct bin_attribute *a
> >  =09if (ret)
> >  =09=09return ret;
> > =20
> > +=09if (res->flags & IORESOURCE_DISABLED)
> > +=09=09return -ENODEV;
> > +
>=20
> This probably would be better if it checked IORESOURCE_DISABLED and
> IORESOURCE_UNSET, but then probably using resource_assigned() would
> be even better.

Yes, resource_assigned() makes more sense.

When considering Krzysztof's sysfs rework series in pci/sysfs, this all=20
should be handled in .is_visible and not in pci_mmap_resource().

Also (FYI), alpha has its own pci_mmap_resource() (IIRC, it still has it=20
even after Krzysztof's series).

--=20
 i.

--8323328-2075155497-1778579003=:1449--
