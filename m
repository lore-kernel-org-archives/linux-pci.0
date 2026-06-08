Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B623D3321
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938177; cv=none; b=sP8yOxEoF+MYu1oaPxYVTyX7T8zzyko2F72MT5EGGWsoDwGY0FX5//OXta9cQ+3tG9jRZL3Tuy7jB2xsNduiw2qhiPcXPXJgK05LSOHM5p5dHZ6VviejrRVwVUUdCYUwnnx16S6xtHUY/Vd4vfEmsYtLMNq36JZTM2kek0E3O9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938177; c=relaxed/simple;
	bh=hgytFkZf9V8lV3EKTsvhgdeVMtbq1O3lLdydI4jaXGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aogEtxjgZFwQggmj9HDdmDTYsrLIHEmWojesuLV9+aJo596jpenyKazy7PiDNMBYZYP1gvcabJ/oF2nk/+pJUPUekhsaSzMnlfTcPgm2kF37/FDJqK5/PY61i/qESx3m5EIINPLHtoWqw0ENvyqn00XP/n0hkp0W+DsFGYl5bOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lISURITD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lISURITD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780938176; x=1812474176;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hgytFkZf9V8lV3EKTsvhgdeVMtbq1O3lLdydI4jaXGU=;
  b=lISURITDxUn8JW/1JdRckP3t0Jzf/bbRJZkbHjQ/9czsFvaWiBPkfvLx
   XxeSOzAK41AtyueOuGhwMjE+C+HNh7MjXzadfOSX8/LM//ltqVJ0XSGT9
   vkqMXfwc5nA9lhdsnN5X1tDne+EULK6E7f1mHTlrzRhjZYP6tIQaBp8We
   v7x5P5zhm10khOtoD8BYTIVdMQ5VdsjsHwp21PDASOXTnSJZXo9X0lt25
   mRWfQdbw5tYwtWKkyXO5mSsMZg09qeJv5Ut/0P0XuDDoOH7MvLdTGwTa2
   Bn2UVW3AMfkQTh3LsN6160VRSPBHgt2hbAC14/xDwH3A0rEdhDSaj/PYB
   g==;
X-CSE-ConnectionGUID: yZQBZjTnTqujL7MLB1kfhQ==
X-CSE-MsgGUID: NApZC77/TQOZ+OxvYSuE5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81679522"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81679522"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 10:02:56 -0700
X-CSE-ConnectionGUID: s2ZWQR2KTVuAHktEMCr4uA==
X-CSE-MsgGUID: F8WCSDkCQMW7bV+800dIWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269298466"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 10:02:54 -0700
Date: Mon, 8 Jun 2026 10:02:53 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org;,
 nirmal.patel@intel.com
Subject: Re: [PATCH v4] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Message-ID: <20260608100253.00006fe4@linux.intel.com>
In-Reply-To: <hqcwvmh2kz6sxx4udassaatuwc3foc3v6j7stekpsdbiipmrj7@swazc3hukadc>
References: <20260522150829.5246-1-nirmal.patel@linux.intel.com>
	<20260527120139.00004254@linux.intel.com>
	<20260608073320.000035a0@linux.intel.com>
	<hqcwvmh2kz6sxx4udassaatuwc3foc3v6j7stekpsdbiipmrj7@swazc3hukadc>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 22:21:34 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Mon, Jun 08, 2026 at 07:33:20AM -0700, Nirmal Patel wrote:
>=20
> [...]
>=20
> > > Gentle reminder. FYI, I also addressed comments from AI review.
> > >=20
> > > Thanks. =20
> >=20
> > Gentle review reminder.
> > Thanks.
> >  =20
>=20
> ./scripts/get_maintainer.pl drivers/pci/controller/vmd.c
>=20
> Nirmal Patel <nirmal.patel@linux.intel.com> (maintainer:PCI DRIVER
> FOR INTEL VOLUME MANAGEMENT DEVICE (...) Jonathan Derrick
> <jonathan.derrick@linux.dev> (reviewer:PCI DRIVER FOR INTEL VOLUME
> MANAGEMENT DEVICE (...) Lorenzo Pieralisi <lpieralisi@kernel.org>
> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS) "Krzysztof
> Wilczy=C5=84ski" <kwilczynski@kernel.org> (maintainer:PCI NATIVE HOST
> BRIDGE AND ENDPOINT DRIVERS) Manivannan Sadhasivam <mani@kernel.org>
> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS) Rob Herring
> <robh@kernel.org> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT
> DRIVERS) Bjorn Helgaas <bhelgaas@google.com> (maintainer:PCI
> SUBSYSTEM) linux-pci@vger.kernel.org (open list:PCI DRIVER FOR INTEL
> VOLUME MANAGEMENT DEVICE (...) linux-kernel@vger.kernel.org (open
> list)
>=20
> You didn't CC more than half of the above entries. So you can expect
> the patch to fall through the crack...
>=20
> - Mani
>=20

I will address your comments and add contacts to cc in v5 patch. Thanks
for the suggestion.
