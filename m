Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517F1CAA79
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606517; cv=none; b=eIrPKmwx4wqSuJnRyVQb0Qt3gFQVYqIMrSekd9Wx5Cvww8S4bmNh9QLpv5OYEiqdsU/nl/tCRbAE7moFRksoPwMBJQBJndRd7cmn1/rJBTGSeryrfQWrGZAgCuJaswpGCUMaquL/FkYq2zlehloijPYK6lAnqiZGkuXmy5jDcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606517; c=relaxed/simple;
	bh=8cwG8UhSGv6gLOmG1eM9KwhEsKQ4xoFm1WIgfrOg+6E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sPSXp5gnvFyXNKVqNTD8u1VzjrH0lbEko9qMjj2YLansCw7rDQzQmaV4hALuNZj72VH3dgB4IiK/Ws9rvzgbSL1jpdA8/dnTCpmgZ9y7SjAyPWTHeRRGVXwz0EMN1eoAkSwbBeQv5dsxNnPvYFhXps8AhBUMiWt5AwuXc3AZ2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIDgzxP7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIDgzxP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774606516; x=1806142516;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8cwG8UhSGv6gLOmG1eM9KwhEsKQ4xoFm1WIgfrOg+6E=;
  b=IIDgzxP7q7UcErvlp5MthVzg13wXfdYB5a59hgAiEhJza0pTEynRGr8P
   JRHzWDui2RJnKpK7ZHUai/mOoCj0ZqajUUqnvyKk+PLkykg3UOUsGryvd
   snHSvgPTJ8p1t9jU/i3r5b7TE01kihOEt8oIH+6FDkUavwV89ELrJgio/
   ndgWgDicHC+SusBZlX5kT5PCr29d1Udj8MwgiKcanaJkvOYoeBM/u54NH
   1951qHpcTsmVh+KCw0hI4u1ZXYwZfHO80nH56eJpwaFbz67sX0Pl87iXB
   s1DQ7GdlGJqnPR+lfZ1ZGncUYcaRj1ro/zx4J0jXR/T5k1hIfNKKuEmAd
   A==;
X-CSE-ConnectionGUID: ePnXyKFOSHmzxeKp697FmQ==
X-CSE-MsgGUID: 1EMURWpKTPuZVTgqKp9h+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75644227"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75644227"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:15:16 -0700
X-CSE-ConnectionGUID: YgH3BNwQRHGQOq1CEmYxSA==
X-CSE-MsgGUID: kZ9vWu7qRUqTwdeZ9rC4aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="220878425"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:15:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 27 Mar 2026 12:15:10 +0200 (EET)
To: Cristian Cocos <cristi@ieee.org>
cc: linux-pci@vger.kernel.org
Subject: Re: ReBAR over Thunderbolt
In-Reply-To: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>
Message-ID: <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
References: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1896109958-1774606510=:1037"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1896109958-1774606510=:1037
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 26 Mar 2026, Cristian Cocos wrote:

> [This has been previously posted on the linux-hotplug list, though it
> has been suggested that I post it here as well.]
>=20
> The short story is that ReBAR does not work in eGPU hotplug(!)
> scenarios: hotplugged Thunderbolt eGPUs are forced onto a 256MB BAR
> regardless of the system's ReBAR capabilities, and this because during
> hotplug the Linux kernel does not consult the ReBAR capability. As
> eGPUs are becoming more and more popular, accommodating eGPU hotplug
> scenarios has become imperative.
>=20
> The longer story:
>=20
> The current Thunderbolt eGPU *hotplug* sequence of events is this: BAR
> 2's hardware register powers up at 256 MB =E2=80=94 the default size prog=
rammed
> into the BAR's address decoder by Intel at the factory. The PCIe
> Resizable BAR capability advertises support for up to 16 GB, but it's
> passive =E2=80=94 software must explicitly exercise it. When a Thunderbol=
t eGPU
> is hotplugged at runtime, the kernel's PCI subsystem enumerates the new
> device, reads the BAR at its 256 MB default, sizes the bridge windows
> to match, and assigns addresses =E2=80=94 all before any driver loads. Th=
e
> ReBAR capability is never consulted(!) during this process.

Hi,

The intel GPU drivers do attempt to perform the resize at probe time,=20
though it's often not successful.

You haven't indicated what kernel you run nor provided any logs, but there=
=20
have been some improvements to this in general in the recent kernels. And=
=20
then there's also this patch which relates to thunderbolt cases (which was=
=20
only accepted yesterday):

https://lore.kernel.org/linux-pci/20260219153951.68869-1-ilpo.jarvinen@linu=
x.intel.com

> A workaround is available for cold-plug scenarios only, and is
> achieved by means of the **thunderbolt.host_reset=3D0** kernel parameter:
> this preserves the BIOS's PCIe tunnel and BAR assignments from POST
> (where the BIOS *does* exercise ReBAR). This delivers the full 16 GB
> BAR but, as just mentioned, only works for cold-plug(!) scenarios =E2=80=
=94 if
> the eGPU is power-cycled at runtime, the new tunnel gets the 256 MB
> default.
>=20
> The proper fix would be for the kernel's PCI hotplug resource
> assignment to *first* check for ReBAR capability during enumeration,
> resize the BAR to the largest supported size that fits within available
> bridge headroom, and *then* commit bridge windows and assign addresses.

That's being worked on. But it's not as easy as you depict it as kernel=20
needs to be also able to fallback to some intermediate size if the largest=
=20
supported size fails.

Thanks to how size calculations and assignment are done at different=20
phases of the algorithm, it's not as easy to fallback to something else as=
=20
you indicate as the secondary failures would still persist from the=20
attempt with the largest window. So effectively, the entire sizing has to=
=20
be recalculated.

> This is essentially what the BIOS does during POST. It hasn't been
> implemented yet because eGPU-over-Thunderbolt-with-ReBAR is (was?) a
> niche use case.
>=20
> Seeing as eGPU-over-Thunderbolt is poised to become mainstream, this
> can no longer be considered a niche use case.

We don't consider it unimportant usecase. It's just the resource fitting=20
and assignment algorithm is very complex and hard to improve, because=20
something usually breaks when trying to improve it. Thus, the progress is=
=20
slow and everything has to be done carefully (when things break badly in=20
this area, system doesn't even come up so there's not much room for=20
error).

--=20
 i.

--8323328-1896109958-1774606510=:1037--
