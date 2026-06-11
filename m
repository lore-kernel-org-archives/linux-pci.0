Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD26120DD51
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204483; cv=none; b=sZtHtXnoi6y+b8CXU2MwS6vUZWzYC4koJFdiE2F5yMvL7d+wHnrb5Ftyv/tpgMlR/4t6n2q3MUO46C3b0AI9fmzw157bIR9XQ08Fg1m9WOfUwayTKswNvBzWBGWcgEueP2VfBjQBT7OxWBiv8nNOGdbFSJIdQb96iEoAL06FDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204483; c=relaxed/simple;
	bh=OGaHTzGetoiFyFP+L4BrDEgSVd2W2tGjRQhkjxw5jN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UvnSEARb9brRt1wwR0UYMUeh6rlTqNDB+mOtLTWhjwYsWDjcAR+iqtni+gEdYpvZWbkXOPRbZAgILRnAB8sSjpO4/fZ73KlYpY6E/tBo3u3e64mzN656K3sSFpn19V0dAilvAj4TCVQBIFI7HOtZG8OY1y87grQtHm2ttUzXkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddjh61dx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddjh61dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208C31F000E9;
	Thu, 11 Jun 2026 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781204482;
	bh=B1gGSq4M+Oo4WefRsKZvJ4V4X6Qi/uXLlI1VstV5e8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ddjh61dxqq0ldnrSnyKYT1c9cHp49mneFMhx5IFNcLXVWQ/g8P1FHTVmyMhZEi/mG
	 /ibXF/Q+3FljS6usUc3lX4ppjKX1e6o/FULhdKVy6PeMwZ3p6/sNLghaRS/WER4bRg
	 DEP0zsKDVY/jCJJ8dh3qKmq3xnuGomiB32BQNnwYmrf/FIVrhGMCAeMwF2ISLjfw6S
	 yxZAxRf/TcdK8Zj0KV2oJUA9likuANCMbi9/zg8l0nDnJuLc7nkSWWWGUGKkot481G
	 yhjXqqcfnpTWmtvFGRTGNnzFYeKYfoe1RAAGB9zyOrxi5cEsCEnJXJy5eyk5jR/esY
	 8Od5cK2OIlVxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/20] rust: dma: drop `dma_read!` and `dma_write!`
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260611-io_projection-v4-18-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-18-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 19:01:21 +0000
Message-Id: <20260611190122.208C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Removal of `dma_read!` and `dma_write!` breaks compilation for `dri=
vers/gpu/nova-core`.
--

commit 144cedc7de039fdec7f07bf6a514886b83913697
Author: Gary Guo <gary@garyguo.net>

rust: dma: remove dma_read! and dma_write!

The primitive read/write use case is covered by the io_read! and
io_write! macro. The non-primitive use case was finicky; they should
either be achieved using CoherentBox or as_ref()/as_mut() to assert the
lack of concurrent access, or should be using memcpy-like APIs to express
the non-atomic and tearable nature.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index ab6504910e4f..0ff4cce8e809 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs

[ ... ]

> @@ -1265,85 +1219,3 @@ fn as_view(self) -> CoherentView<'a, Self::Target>=
 {
>          }
>      }
>  }
> -
> -/// Reads a field of an item from an allocated region of structs.

[Severity: Low]
Does removing these macros break the build for drivers/gpu/nova-core?

Looking at drivers/gpu/nova-core/gsp/cmdq.rs:DmaGspMem::new(), it appears to
still rely on dma_write!:

    dma_write!(gsp_mem, .ptes.0[build: i], PteArray::<0>::entry(start, i)?);

Similarly, in drivers/gpu/nova-core/gsp/fw.rs:gsp_write_ptr():

    dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES

Could these users in nova-core be migrated to io_read! and io_write! in this
patch to prevent bisect breakage?

> -///
> -/// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma`=
 is an expression evaluating
> -/// to a [`Coherent`] and `proj` is a [projection specification](kernel:=
:ptr::project!).
> -///
> -/// # Examples
> -///

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D18
