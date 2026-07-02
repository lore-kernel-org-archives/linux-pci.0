Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078638B12A;
	Thu,  2 Jul 2026 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028835; cv=none; b=mQbqrMezHbVoCtLJttRCtR1D4NQgxEf78MXCqpA1aFvQ9RLXdeQ4ZCyrnH3knzDA4YNeWSiZtNEfdIgyTpJ0vWJ6rAh6ruBdKSXLdMCw8Ss1irSuhIq/YKl/Jxe8XwThiDE0XBCL+USy2x6LtPKlhuonVx9xT/GLxPXIAOJ1FO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028835; c=relaxed/simple;
	bh=kVWMa+5idqRpE6t03UroD1b7PjdnCpBR6QQkXH6ANqo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=koubMuFB/CnWYrHl0KJ9NZnIZHXpY2SIkIJOnEfJcycd6sgD20UTgix165jKNTb0lrtJzQT5X4jyaAmpbPqMVF8cci4eMMtCPTSNYK0RLEyNmMmiZslCNBY3KyKwBQO9dphi0oogsFdad/SJPmonTSEokruidhPiV+1EWokHOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxFTIjT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxFTIjT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED501F000E9;
	Thu,  2 Jul 2026 21:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028833;
	bh=KT5HdsNfDV/GF6jjLE9pPi+2j+UMB4nG5h2CmRBqWMo=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=YxFTIjT0Owbu7L6cLqITHQ3wj+b1b7kmmi1DGamwmMCBXFIJhjUUU1pJaym7fFb4D
	 aT9lsziOwhoBrCXO4M/hIe5S4uLx6MEzltbv7WL0fITNQr3XFD1h33YryHjapOCCgU
	 5gxBqgp398u8cTy4abPLdXPR1EKKEAqgGRCAVEzcplvjZ/nmtlooxVI5w+TVaHQm/B
	 fbpDhUYCdHQOAXByoz1UDdYCRcz844a3i9M91z+CxR7Xe7zgpl+OOriZP4SubAfVQC
	 +eXP+3YaXf5VX6F9OtN8RipaKCYNy/iLT1poUHpbTk06wFbFS9uywdgqNrCahLGBM/
	 eXSF8a0yDvAcQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 23:47:07 +0200
Message-Id: <DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org>
To: "Maurice Hieronymus" <mhi@mailbox.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: pci: rework device enabling API
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Beata Michalska"
 <beata.michalska@arm.com>
References: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org>
In-Reply-To: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org>

(Cc: Beata, runtime PM consideration at the end)

On Thu Jul 2, 2026 at 11:32 AM CEST, Maurice Hieronymus wrote:
> - `enable_device_managed()`, wrapping `pcim_enable_device()`, which
>   registers a `pci_disable_device()` cleanup that runs on unbind; this
>   is what drivers should normally call in `probe()`.

The concern pointed out by Sashiko that pcim_enable_device() silently also =
sets
pdev->is_managed =3D true, which also influences the behavior of other unma=
nged
PCI paths is valid.

Of course, we could easily overcome this if we have to, but on second thoug=
ht I
think it would be nice to just not have the managed version at all.

(Note that I also have a patch in my queue to convert IrqVectorRegistration=
 to
use lifetimes instead of Devres, which will also address the topic in [1].)

The advantage of not having to store another object in the bus device priva=
te
data is minor, and a lifetime annotated guard is the more idiomatic solutio=
n
anyway.

	pub struct DeviceEnableGuard<'a> {
	    dev: &'a pci::Device<Bound>,
	}

Note that obtaining this guard would still require a &Device<Core>, but dro=
pping
it can only be ensured from a bound scope, which &'a pci::Device<Bound> ens=
ures.

This is the tricky part, as this would imply that pci_disable_device() can =
be
called concurrently with another DeviceEnableGuard being acquired and
concurrently with pci_set_master() and pci_clear_master(), etc., which give=
n the
current implementation on the C side would be UB.

It would be interesting to dig into this and see if we can find a solution =
to
this problem (which might also include improvements on the C side).

For instance, struct pci_dev has a C bitfield that also includes the
is_busmaster field, which can race with all the other bits being accessed i=
n the
same bitfield.

I think (most of) the fields should be in the same locking domain (the devi=
ce
lock, which is held in bus callbacks and in Rust represented by the Core de=
vice
context state).

But there might already be issues with this, e.g. it seems to me that
block_cfg_access is protected through a different locking domain, the same =
goes
for a few other fields I think.

Bjorn, any insights on this?

(We had a similar C bitfield in the driver core, which we recently replaced=
 by
using bitops, as there were subtle race conditions.)

> - an unmanaged `enable_device()`/`disable_device()` pair, wrapping
>   `pci_enable_device()`/`pci_disable_device()`, e.g. for runtime PM
>   paths.

If we could find a solution to the above, we could probably avoid having "r=
aw"
accessors that can potentially lead to an unbalanced enable count and inste=
ad
could consider something like a DeviceDisableGuard<'a> which could be deriv=
ed
from a DeviceEnableGuard<'a> for the duration of a suspend.

The runtime PM Rust infrastructure could provide a storage container which
lifetime wise spans suspend =3D> resume, where this guard (and other data t=
hat
must be restored on resume) could be stored.

[1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/top=
ic/Re-configuring.20interrupt.20vectors/with/577596401
