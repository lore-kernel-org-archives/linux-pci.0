Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9274364E9E;
	Mon, 28 Sep 2026 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598905; cv=none; b=uLmm68cC2/JM3YmVh9s3WdfGJlee01gMUZkfBwtBnALoubrArRebiLgrny2TAJkSQdVJM4lfukvl1ELbROQ0MD3djHCrHo9lneVw0yraS2iArq1RVVlKNNG5ih/dnceO3Wx6cFWQnJI1lmiK4wJbNFSa5SSKUa+oBIsVJ6Xy2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598905; c=relaxed/simple;
	bh=tMQNsHgAJKhb60e+kOQk0E7WuNQSqU13wsFzAnqQ7sU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XByrxqd3MeeStk9D99IPc3G/NVsMsoCNqsjfELy89DUFOuEZnyoinldtGfHnpeLAWWLv4VIIeH8YPED1MgBcR0O3e/ov+2nbOGk2lRAk7j4reIE/fco/9ZNYA3kJyrEgzXU/CVgTMM3hJ04c/HE54R4zbylw66ImRsF1B3tBuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lc+QIPhu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lc+QIPhu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790598903; x=1822134903;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tMQNsHgAJKhb60e+kOQk0E7WuNQSqU13wsFzAnqQ7sU=;
  b=Lc+QIPhuwbRkmwtli96giugEX/OMFyLbbbK1xDM9j8DOcCCdIyvpg++0
   v/a/s9pqp/The9oIe5tduy3tJMJAy5wGZWx0NRlzxmohVHX6LqO9CUj2r
   LJ8blfPLheKKLBG3hpuCgGC6zpslGlStvRwyy+28DDauuI/D4dZ3rtjqL
   YU/+Ht7pOZnqRT7ADXOjnUlpFMvE+rQMufI3SwitiymC0j3AuYodnUlqO
   jalUsgVyc5093aDLrAkfykI6JL3LfIP2hX0HzJnBcM+Q6+WqiZ2GyUw7I
   b7TkyUoovTpaxeoemdduUIYkCHwdbwyPSI0dYKtsflCA84XAtAZD59anA
   g==;
X-CSE-ConnectionGUID: E2JzrpsIQ1GTmfR0oLtn7w==
X-CSE-MsgGUID: EW27G76JSZetKmOBMjpgUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="107674843"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="107674843"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:35:03 -0700
X-CSE-ConnectionGUID: Qp8FZqYcRJqyE1OGmpSwig==
X-CSE-MsgGUID: MKJ5drxIQ5+WAnIjbSVQog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="302991371"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:35:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 28 Sep 2026 15:34:56 +0300 (EEST)
To: Nikolas Joshua Britton <nbritton@exabit.io>
cc: Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI: Resource placement algorithm fixes
In-Reply-To: <20260926020040.8750-1-nbritton@exabit.io>
Message-ID: <2407fe7e-4a97-8d24-1462-f45dd8e916d7@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com> <20260926020040.8750-1-nbritton@exabit.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-797499057-1790598896=:1168"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-797499057-1790598896=:1168
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 26 Sep 2026, Nikolas Joshua Britton wrote:

> On Wed, 23 Sep 2026, Ilpo J=C3=A4rvinen wrote:
> > In addition, the series corrects composite resource sizing to account
> > for gaps that have to be added due to alignment constaints and
> > remainder space not fully connecting (filling space all the way to
> > the bridge window align).
>=20
> Hi Ilpo,
>=20
> Thanks, the series fixes the Mac Pro 7,1 case from my report. That is
> two Radeon Pro Vega II Duo cards, each with two GPU dies behind one root
> port, and BAR0 resized to 32 GB by setting the ReBAR control and
> rescanning the root port's bus (booted with pci=3Drealloc).
>=20
> I tested all five patches on top of v7.2.8, where they apply without
> fuzz, against plain v7.2.8 built with the same config.
>=20
> With plain v7.2.8 it fails as in the report: the root port window is
> 64G+4M, and the second die gets no BAR:
>=20
>   pci 0000:06:00.0: bridge window [mem 0x90000000000-0x910003fffff 64bit =
pref]: assigned
>   pci 0000:0b:00.0: BAR 0 [mem 0x90000000000-0x907ffffffff 64bit pref]: a=
ssigned
>   pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't assign=
; no space
>=20
> With the series, all four dies get their 32 GB BAR0, amdgpu binds all
> four, and they form one XGMI hive. Each root port window is now 96G
> (my one-liner gave 128G). The second sub-bridge window starts with the
> die's 2M BAR2 at its left edge, and the two nested bridges below it
> (0c:00.0, 0d:00.0) carry the same range:
>=20
>   pci 0000:06:00.0: bridge window [mem 0x9e800000000-0x9ffffffffff 64bit =
pref]: assigned
>   pci 0000:08:08.0: bridge window [mem 0x9e800000000-0x9f0001fffff 64bit =
pref]: assigned
>   pci 0000:08:10.0: bridge window [mem 0x9f7ffe00000-0x9ffffffffff 64bit =
pref]: assigned
>   pci 0000:0b:00.0: BAR 0 [mem 0x9e800000000-0x9efffffffff 64bit pref]: a=
ssigned
>   pci 0000:0e:00.0: BAR 2 [mem 0x9f7ffe00000-0x9f7ffffffff 64bit pref]: a=
ssigned
>   pci 0000:0e:00.0: BAR 0 [mem 0x9f800000000-0x9ffffffffff 64bit pref]: a=
ssigned
>
> The second card (root port 16:00.0) is laid out the same way. No other
> device lost a resource: the only "can't assign" messages left are for
> the same I/O windows that fail on every kernel on this machine.

I should probably one day make the io assign fail messages debug level if=
=20
there's no io window at parent. It's just noise for majority of=20
systems and there's nothing kernel can do about it (nor can the user).

> I used v7.2.8 rather than your v7.3-rc1 base because v7.3-rc4 powers
> this machine off during boot, with or without the series. I haven't
> looked into that yet.

7.2.8 test should be fine for this.

> Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>

Thanks for testing.

--=20
 i.

--8323328-797499057-1790598896=:1168--
