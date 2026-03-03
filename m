Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8131F99D
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543223; cv=none; b=UIQ+cZD7bRQXWl1B0iIwmT9ArgWz823a9/EEJ0+mqTRXDLkvSj2ZVE++XXu4ogxXw44y31j94BruVHUE1L4PMyOsqsevX4eAQ/0UHLWyOHaN8PcgsQC6M7aqdl8BkqXnsFZIa9vSqVi2Zy71XODPdZTQA5gbBrLJrtB0RUR8QYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543223; c=relaxed/simple;
	bh=aZW7U16ZnWrCiaIdbjd7Y1rWn5DFfXmOOY2Oo42eAMc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cZpm4uPPAp35nDxHn7tfcCywlRi7OzD2NZMz2kQEYpp7W3+A6wM60lpS/Ag1Anp5j43E0cp6F5oPhQQ086OJw9Il3Btky+M6fW1KFqHjFwzXYIRqQw6956dD6v9dgd800/hsy3c0y0g+CTLC7Q6RxX+OUFuNSynQOFi1Jedk4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHYEh4l7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHYEh4l7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772543219; x=1804079219;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=aZW7U16ZnWrCiaIdbjd7Y1rWn5DFfXmOOY2Oo42eAMc=;
  b=UHYEh4l7RH9/TFYmNiEOUTnLR74XsIwSMblpCaSJDtyVp7DgIxfTxYoy
   WJZNtkNgO4GxytwcdfPrj7eDdL7ZjJJh/ywfXRUytvcJ459OpvjBWwZR0
   MD3MH40SCqzA9/PBAev8cWv6OotKfmVdzXjkQSslghXSw2fEydalrmy8k
   79Xhw97ywCgvSjlrRO8IPVFszWFLU9mia8rQNkOn+EsrtcizEmv7Xtqm/
   JuHga4WotMwBY6DyxZRu0yBVDBal+e3xHluLn/uTvS3KO/n1hEHuW6uFR
   +YHpNu1RGdWGxKnHJjaTK8wkqliuYRH+rLg+VrlO1Bo3rZJDEM8+z22Oc
   Q==;
X-CSE-ConnectionGUID: UI1LUGcyT3ummY0DxrTN0w==
X-CSE-MsgGUID: JM3cuktITrSBRxFxxP68cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73540081"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="73540081"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:06:58 -0800
X-CSE-ConnectionGUID: malw/HgASymGzdmx1l+3OQ==
X-CSE-MsgGUID: x9Nnp4Q3TnOTTuZWdq1v8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="255871643"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.62])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:06:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Mar 2026 15:06:51 +0200 (EET)
To: Sune Brian <briansune@gmail.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Joyce Ooi <joyce.ooi@intel.com>, 
    linux-pci@vger.kernel.org, ley.foon.tan@intel.com, mathias.nyman@intel.com
Subject: Re: [BUG] PCIe Stall on USB_PCI=y with SoCFPGA Root Port
In-Reply-To: <CAN7C2SAcJp8nAhbRT9OyLeT2YsvmX=+Y4qhBZR_WQ3aDqNHywA@mail.gmail.com>
Message-ID: <8d5cdf11-b5ba-2b10-c2ba-76d4aedb5197@linux.intel.com>
References: <CAN7C2SC_2k6+dvBTRoV1_trpPEF5h+k9KDOapTwcb90+=BUatw@mail.gmail.com> <20260302235100.GA4037767@bhelgaas> <CAN7C2SAcJp8nAhbRT9OyLeT2YsvmX=+Y4qhBZR_WQ3aDqNHywA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-789237122-1772543142=:1086"
Content-ID: <ff676d9d-09fd-7596-5954-a70f0ed21fd0@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-789237122-1772543142=:1086
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8c95a43b-70f6-d2e1-9d54-3af4c7a15dc6@linux.intel.com>

On Tue, 3 Mar 2026, Sune Brian wrote:

> On Tue, Mar 3, 2026 at 7:51=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> >
> > [+to Joyce, pcie-altera.c maintainer]
> >
> > On Sat, Feb 28, 2026 at 11:05:17PM +0800, Sune Brian wrote:
> > > Dear PCI maintainers,
> > >
> > > Root Port: Cyclone V HPS Root Port PCIe
> > > Endpoint: uPD720202 Card
> > > Kernel version: 6.12.33-g3234b1ed8956-dirty
> >
> > v6.12 is fairly old; can you reproduce a problem with v6.19 or
> > v7.0-rc1?
>=20
> Had tried 6.19 same situation USB_PCI=3Dy simply repeatable hang.
> No message shown or tells what happened.

Hi,

Has it worked with some kernel at some point in the past (in which case=20
git bisect might be possible to pinpoint what broke it)?

--=20
 i.

> > > Sanity confirmation of PCIe RP:
> > > Both NVMe and Realtek WIFI cards are tested
> > > and show no major issue with MSI/MSI-X enabled.
> > >
> > > Repeatable Result:
> > > When uPD720202 card is applied onto the PCIe slot.
> > > Either module or included driver could stall during kernel boot.
> > > The stall can be resolved by setting USB_PCI=3Dn and
> > > after boot under distro lspci -vvv can disable the card info [2].
> > > All nosmi noaspm etc are tested and state the same stall.
> > >
> > > The root port info is shown in [1].
> > > Based on the above behavior we had also tried to reflash the
> > > ROM of the uPD720202 card and no difference was shown
> > > on the stall issue.
> > > The uPD720202 card is tested on another ARM 64 board and
> > > shows no stall issue.
> >
> > Do you have any details about what the actual issue is?  I guess it's
> > some kind of hang, but you don't know exactly where in the code it
> > happens?
>=20
> I can't have tried so many basic dmesg and possible runtime debug methods=
=2E
> It just simply hangs or stalls.
> Maybe more guidance on how to turn on more debug messages could help.
>=20
> The best I can do to know what triggered is USB_PCI=3Dy.
>=20
> Thanks,
> Brian
>=20
> >
> > > With USB_PCI=3Dn it is sure this is driver issue between
> > > pcie-altera.c & pcie-altera-msi.c
> > >
> > > Additional boot log [3] with USB_PCI=3Dn
> > >
> > > Thanks,
> > > Brian
> > >
>=20
--8323328-789237122-1772543142=:1086--
