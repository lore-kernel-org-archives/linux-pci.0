Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62EB194AE6
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778978434; cv=none; b=d/fskrnV0H0p+0X9r/gdXFBt3a9gXpb3ZGfvWTAqkIXTblb1KqSkRZogW78Yt1Kz53h12ig29ufqpQQERiQMc/AGrn4KzIu9ooShWnbhtTBVOUa6IyuEHYkcK+DodGvCFFJyGy9qrwnWH4D8ly3xNIzuMMmR4Mr+ghdx546sVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778978434; c=relaxed/simple;
	bh=aTzrHBIenUPsZ8UDI6ujrNdMVa5ZBuj+wMoJgUidnuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CB7PSwMiAMcGn07p0FXE4iU+RGz5yYgou93iMOhQoG/2SH+xxy6Yngyl+WPUHWufnpWzbEvky7GVJ8I/AvaSBne2p0cHxqT+FKJk00HasTg2puQuATCETxRL9/lqDGzw/e0TIRj4tH2LBYTpn1fFIA8FjF+2P3+4PEA+dkXRap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzatdTTa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzatdTTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6598AC2BCB7;
	Sun, 17 May 2026 00:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778978434;
	bh=aTzrHBIenUPsZ8UDI6ujrNdMVa5ZBuj+wMoJgUidnuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MzatdTTaNVYgOrkdk4pHACEo0QSwAmnybyLOPuWhFbZU2+K+xqUUC64KFhM88wN6o
	 gQYwOuNOeqrFh6I0KxgzEKnd+WjRe6XtoX/ZxdNYghOPDx/Sk8t/ut/oIzOYmcAJ3y
	 R5AvNagAZ65PzvTM5dgt/2a1cJCpCUcl+nS4zvpPM0FXzhWjKHhAEyACpxZ3BQdVIX
	 ScbF3Q+CBx+eI4VxqXYtaDr5J3h+Qf2x+YhrvlSMcdXQKn2qIlKktd9BDX43NtY2IN
	 jlV8oD5DGG7IbAeC1aatDYEKYQ76klGyoPRk1VOAWkKQVcJtHNTkqBRqO8dZ+aKaei
	 ynW4mMHel3VZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/27] rust: pci: implement Sync for Device<Bound>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-6-dakr@kernel.org>
References: <20260517000149.3226762-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:40:33 +0000
Message-Id: <20260517004034.6598AC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Implementing `Sync` for `Device<device::Bound>` introduces a sound=
ness hole because it exposes unsynchronized C state mutations via shared re=
ferences.
--

commit 4843eee61665efed707d8df24917bb38f72f7f5b
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: implement Sync for Device<Bound>

This commit implements Sync for Device<Bound> in addition to Device<Normal>,
allowing drivers to store shared references to bound devices in their
private data while remaining Send.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index ffaf05bf9aaaa..c06ac3fb2a64f 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
[ ... ]
>  // SAFETY: `Device` can be shared among threads because all methods of `=
Device`
>  // (i.e. `Device<Normal>) are thread safe.
>  unsafe impl Sync for Device {}
> +
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct pci_dev` i=
s the same;
> +// `Bound` is a zero-sized type-state marker that does not affect thread=
 safety.
> +unsafe impl Sync for Device<device::Bound> {}

Does implementing Sync for Device<device::Bound> introduce a data race if
initialization methods are called concurrently?

Device<device::Bound> provides initialization methods like alloc_irq_vector=
s()
that take a shared reference (&self). If a safe Rust driver spawns multiple
threads and shares this reference, they could concurrently call
alloc_irq_vectors().

This calls the C function pci_alloc_irq_vectors(), which performs lockless
state mutations on the struct pci_dev, such as setting dev->msix_enabled =
=3D 1
in msix_capability_init().

Since these lockless mutations are exposed through a shared reference in Ru=
st,
could this lead to state corruption when the device is accessed from multip=
le
threads at the same time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D5
