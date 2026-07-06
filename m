Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DA3195F0
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343036; cv=none; b=emPJg8pvR5w9nK2N2QiEHeLN+M36tmaajaQ9YDSVnlHT0303p8Zy7ngMjVVXUTYyA+tSvg3zrEHqzHRHwauhDMepkxR9X1iIt+WsLSPF2UWeLlWQyBdFsKMXhnYJ+jNsPSMDk9FKleQGLKwcEDezV/E1AM0PmfPq/g6lts7cSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343036; c=relaxed/simple;
	bh=bydMBcztW6BIAqkmv+we+pMUx3JD/yllLrVIMywAE2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f7+9X/IdtO90fGzwzn8Ch3SDbzUZnKR53xiUuFiyKEH/X0zwZHPrKJS2NiAKBDPNFkefFvxzV/SmdrKMXtc43YUFDVY03totykKO79RtF+TOaNjYZt/cNO2KF0YOudeCZA3ypBjN7FVIVKQLerbLPtmUq/jUt/tZtRWl27sqVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWZ0xSev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWZ0xSev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39F81F000E9;
	Mon,  6 Jul 2026 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343035;
	bh=T1XaYNNK0CiQFk1JAwIphcm52VlAbKrAR8NvG0QeYy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EWZ0xSevsuDTbAaEQEK7qliTlNNiRlYy5rhwyEPdvd0lYDHD7KPIsGIRtRpFr/ybM
	 pAexvbfeH76C+pSzJk3eT0XAcpkG2aQf+WvCcQxEUMmyt+XWZRwnxdCoQO13k7kY4L
	 P7/T/Bmcf0JGLtwYRx6BB/KrkNofGH9dMrkF/2qSVfOmoROjYO5t2rfTva+S2LY+wg
	 XnBq4LmbfHZJfo5PmxiLKZDl6w2X2PBC/mZbnjXVVrPevxiqpoJAMjGYvGRdk6q8qA
	 XvwhH2hNVE8SypELMlasZHwADGhWk72GZoZoHD8Xwxul0D+THZXWIW/UJP493sMEAi
	 0lme7fb3yJ8Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/20] rust: io: restrict untyped IO access and
 `register!` to `Region`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-io_projection-v6-3-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-3-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:03:54 +0000
Message-Id: <20260706130354.B39F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infallible 64-bit I/O accesses (`read64`, `write64`, etc.) will fa=
il to compile on 64-bit systems due to a failing `const_assert!` in `io_vie=
w_assert` (formerly `io_addr_assert`).
--

commit 9e28956aa7e8253fe2ab41dc7ddbf9af5d160ab2
Author: Gary Guo <gary@garyguo.net>

rust: io: restrict untyped IO access and register! to Region

This commit restricts untyped I/O accesses and the register macro to the Re=
gion
type. It adds a generic type to IoLoc to indicate allowed base types, paving
the way for typed register blocks.

Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@nvi=
dia.com/

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d821ee48ed317..87141eb070564 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> @@ -437,6 +449,7 @@ fn read32(&self, offset: usize) -> u32
>      #[inline(always)]
>      fn read64(&self, offset: usize) -> u64
>      where
> +        usize: IoLoc<Self::Target, u64, IoType =3D u64>,
>          Self: IoCapable<u64>,
>      {
>          self.read(offset)

[Severity: High]
Does this regression cause a failure to compile when a driver invokes an
infallible 64-bit access method on 64-bit systems?

By restricting usize offsets to target Region, invoking an infallible 64-bit
access like read64(), write64(), or write_reg() with 64-bit registers
instantiates io_addr_assert() with U =3D u64.

Region has a hardcoded MIN_ALIGN of 4. The compile-time check explicitly
requires:

const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target::MIN_ALIGN.=
as_usize());

On 64-bit architectures, align_of::<u64>() is 8. Thus, 8 <=3D 4 evaluates to
false, causing an immediate unconditional compilation error for any driver
attempting to perform an infallible 64-bit MMIO access. Fallible variants
like try_read64() use runtime alignment checks and are unaffected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D3
