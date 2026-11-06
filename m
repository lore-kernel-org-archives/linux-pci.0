Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986639;
	b=0DTzafLJnvoNDd60iqLnocDRG6mO4U9IK8R6naX1WTMQk9C9jWqALRMsuYssPIh0y0iF
	 vXp8MC0d2mHw4pQOieFW0atqpd8pE8BDjLiHghskYI/w3kUUJuHdpEsgfZPkRpcLKVpsf
	 hxJndqaKh4WHruy15iwRrO5Fvf35C8Khmgnvamf1U6dJ5ORF+GI8KsW66HXE6UA1EQRjg
	 agsTYZq8sPLZQwd0gj7BKgNZaxOLdkIDj8z5+Jrai7zRRO8i4G01FQjVQMEvKFNOJqFds
	 BiuSsmVSiDInRxyy8XR4eqa/2qElME3ZtySj4aoohp7TXe09qIwwd+GFoyRTjn4gitA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986639;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=g7Oc6t0HtOz9X6Eiow3ZElCtdl5ie3dXLyf+O1EAwlE=;
	b=2XOj4zSTvObG5pbKk+HL20x4oHnnZlB/b9l7Or3m+qZaQ1X+CTwD0CeJMdsgU0oOs/ZX
	 9O0D9c5+xByG6C67bKHPM334EiVbXfi8wbZxGvJ8p66NC78IqapiQ7YJ2GerM9qFJDqax
	 ith9jOQ65SGOqg46aNbuGf1iouhnffjBNjOoV8/tdgUtwa1iDZHbLc1aok4XmK2pvrBcL
	 kPoSgnhVwt8pEqta3BR67Vv9359VG9e2TZIzn5ca4MJv3S0I5A3S3tz4fX+bGdoHHQHsL
	 3MYpk7VI6osn1jjQmzRYiBf3cSligzLXq/VHcms0bBnC18wry8ywFbGasa46WAIBtyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gh+M0kZL;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5520606A336
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5520606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gh+M0kZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793986638; x=1825522638;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ALLV+zDwOuXdfesWRA5Se2m7/T8+dtzxg4wxXwQjkJo=;
  b=Gh+M0kZLzdS0ExPYWxPRyeDx1TWWUC/1MfA12YWWGz/MldxwUCnOAVA8
   OZcpso/Qz1ZjwZg4ZvAyQAMvX1fMssLusKqvPJbbnnyn+BEcdoyj8OxHj
   FDBOumVJpkXYjobadZddYoB5Oas4Q7vNyo9plPZRypMaq6uY0+U2mmf/7
   q7ocUqn+cWDBlrOhkYFOyhHxnhOABw5fStrttXx5LNVAeDf0HzcnSNr19
   oAERjzt/a2ckpFVbp8ykM7kqLLpBU8DG1/CBK1hoxHBK0AE39PKKqUsI2
   S/duW2fpJGLtzGg927Pa7mO9iW0qYJOk14TotRggWvE216lIfl8QM5+bG
   w==;
X-CSE-ConnectionGUID: CbMhEP3QR8uxhZTwYNXImw==
X-CSE-MsgGUID: YTZYYm46QnSR8roueRSLGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2697678"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2697678"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:37:18 -0800
X-CSE-ConnectionGUID: 8ZcE/OWLQN+eAokLnIMkvg==
X-CSE-MsgGUID: laJ+7Ot1SZ6qlmnjCwDIoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7659594"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:37:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Nov 2026 19:37:13 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI/AER: Check validity of Error Source ID
 register
In-Reply-To: <au4NiO-rglobvYxo@wunner.de>
Message-ID: <36c2c56c-59c4-4183-70ec-5d05e88569b5@linux.intel.com>
References: <cover.1793982724.git.lukas@wunner.de> <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de> <sashiko-outbox-201907@kernel.org> <au4NiO-rglobvYxo@wunner.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-518017135-1793986633=:2032"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-518017135-1793986633=:2032
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Nov 2026, Lukas Wunner wrote:

> On Fri, Nov 06, 2026 at 05:15:07PM +0000, sashiko-bot@kernel.org wrote:
> > > +++ b/drivers/pci/pcie/aer.c
> > > -=09/*
> > > -=09 * When bus ID is equal to 0, it might be a bad ID
> > > -=09 * reported by Root Port.
> > > -=09 */
> > > -=09if ((PCI_BUS_NUM(e_info->id) !=3D 0) &&
> > > +=09/* Some Root Ports report an invalid Error Source ID */
> > > +=09if (e_info->id_valid &&
> > >  =09    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
> > >  =09=09/* Device ID match? */
> > >  =09=09if (e_info->id =3D=3D pci_dev_id(dev))
> >=20
> > [Severity: Medium]
> > As reported by Ilpo J=E4rvinen on v1 [1]
>=20
> Hallucination, this was reported by sashiko itself and Ilpo merely confir=
med
> sashiko's finding.

I agree. I've no problem with this change after the cases we expect this=20
impact are not among the cases sashiko came up so the comment in the=20
changelog is enough for me.

> > can treating pci_dev_id(root) =3D=3D id
> > as unconditionally valid cause a false-positive match on the Root Port =
and
> > skip searching the subordinate hierarchy when a Root Port at 00:00.0 (s=
uch
> > as on DesignWare, Cadence, or Aardvark SoC host bridges) reports 0x0000=
 for
> > a downstream device error, or when a Root Port at 00:xx.y loses the bus
> > number of a downstream error source at bus:xx.y?
>=20
> The commit message addresses this concern, it seems sashiko overlooked th=
at
> paragraph.


--=20
 i.

--8323328-518017135-1793986633=:2032--
