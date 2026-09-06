Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A53546C2
	for <linux-pci@vger.kernel.org>; Sun,  6 Sep 2026 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788675224; cv=none; b=MRoopQ89TTfFt70L979hfeJpuTruowgbkIRovdu8JKWWe4dIPE/U/EziX2FUAgQx2ccnZICW6pUTVHbEJ6eifyBAblNNzRRIMPTMPYac0GglQ1ihCFXQu1l2DgaDF95sPJ6LgiggF87i83epybB4u8RMX5HjDU294ncJurhRxSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788675224; c=relaxed/simple;
	bh=HoluuiGJwWQiwMuZWcNJqXdhQw2L9vuNjenWY2tKAPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b617hufxKd1XYWf6qV4QPkrdb5Oaj/tOxzSASqULyd7Chv+2bT9z9Z3ovMyJi9w9XctBDG1Kd+EGJaxmnNzEz8yEIJ4fjocRS9AYr20EZ5O89V3RpMrV7v5KQZNUoOofPa0tnzSbub1RFWf+jbqy2Bu71Ojx037ZZDNAbdMywIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONmNi7py; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONmNi7py"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A11D1F00A3A;
	Sun,  6 Sep 2026 06:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788675222;
	bh=HoluuiGJwWQiwMuZWcNJqXdhQw2L9vuNjenWY2tKAPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONmNi7pyWEtzanEhKwJ9H6QF4XaPS7O/Rz6qV3CA6cU7rPtP8SKhE2Do3zjoJjIfV
	 +ksahD/olOG74SN4309iDG3NasnSsdg0yUXEDCb23OAvxNi2CP2EatgbpL97OBL69x
	 gmLnPriMk3aLh8OCv8Mhr6uAMUMf+pEqlDAfvBFcAbCymn6VtWpK1Wn2A3ORiiV7xz
	 si5wqN7hXPj4vOnYtKk1p1efypXAY79TMt3BbPu4U9vza0zTfwaVlTWlAUm29JP5O5
	 uzaKcgmq6xq7S+LfTZMdsqM1ft2wu0/qX0TCprNd/GQCHXDq7tgwIMAq+5WSLmHRtg
	 IOpOgiWaMlJYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/1] rust: pci: add extended capability and SR-IOV
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260906060404.3336193-2-zhiw@nvidia.com>
References: <20260906060404.3336193-1-zhiw@nvidia.com>
 <20260906060404.3336193-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 06:13:41 +0000
Message-Id: <20260906061342.7A11D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Rust PCI drivers have no typed interface for locating and accessing PCIe
> extended capabilities.
>=20
> The SR-IOV extended capability describes VF topology and VF BARs. Expose
> this information through the Rust PCI abstraction so drivers can use the
> existing typed configuration-space accessors instead of raw bindings.
>=20
> Define ExtCapability to associate a capability ID with a register layout,
> and add ConfigSpace::find_ext_capability() to locate and project that
> layout. Bound the view at the next capability or the end of extended
> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
> reads and validates all six VF BAR register slots up front, yields decoded
> BAR addresses and widths in logical order, and keeps the raw
> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() is
> a function-like macro, expose it through a Rust helper.
>=20
> Keep raw SR-IOV registers private because PCI core owns their state. Expo=
se
> the current First VF Offset through a read-only accessor because the Nova
> GSP ABI needs the raw 16-bit First VF Offset in Routing ID space. The
> pci_iov_virtfn_devfn() helper instead returns the low eight bits of a
> calculated VF Routing ID.
>=20
> Link: https://lore.kernel.org/rust-for-linux/2e9d992509299c2f13de48109c4c=
933f53817acb.1787830828.git.zhiw@nvidia.com/
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906060404.3336=
193-2-zhiw@nvidia.com?part=3D1

