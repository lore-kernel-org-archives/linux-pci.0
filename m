Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB8405C33
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778977886; cv=none; b=GK2ZDDoGim11f4pWkuJ3H8v9t7dv/BioDTkB8uVxU4TJksvAgwDhFCNjs1iZJbVwqSgV+oYgEfqxa31X6w6udoZLvto737jpoeL2HDJaYNhanU9kfVObwAm4b2MaRu7G+sxjwp5xEk3NVVm2qD7+JEDGqmFsaIr9/mrfVi2V+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778977886; c=relaxed/simple;
	bh=uuX8K8o/VYHOiVHGmg4cXZ4d6HdJd/ILciMpFEVi6Ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gWnHHBL69y8aMW8Fo8um6AJsIOAczB+3pCu+Kjyi2xFAvrYzRDECTfJx7UnpUtQ2joXAQyj37ZLQbOb6MFSZ4Dn8GsLRT6IXb32Nh0lcK5gXNXmQXxwhUVhI+iGRFKbSrAITky+Ti30nmSSn4H1NonMfBAnYmiSqtcu+a0NmOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neQ+OANs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neQ+OANs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CA7C2BCC9;
	Sun, 17 May 2026 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778977886;
	bh=uuX8K8o/VYHOiVHGmg4cXZ4d6HdJd/ILciMpFEVi6Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=neQ+OANsuQeTxl4Rf2+MXh7HDrzQ7/etlmruLhyE8R+sF/cLqtOwcrG4+/+m+FJkl
	 U63shhH7+XkEbJyI90pAK+cxhpT6rckAKHv+1HdUAyPPDM9auEHYciP6kKZlCgUeZh
	 WtKGBjKozlWRVSm89/tRc6UPdmfgGqgzCfpQLRCirVmL/bbq0oZ5rDIoNGCJFqxF7B
	 TzZzgHf25lmsq2GmJCQ6JjshxUe6ONl6U+Xlen94ErlOqV0l9T8BaeiD490Y0ifReT
	 o/P40pNJKio8ibytSo5j2WO8RtHXi6y6r+PGaFazTl43yQxHbzf3xsybFrAwefOjXg
	 xVxgjT/rdwDoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/27] rust: driver-core: rename 'a lifetime to
 'bound
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-23-dakr@kernel.org>
References: <20260517000149.3226762-23-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:31:25 +0000
Message-Id: <20260517003125.E6CA7C2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The lifetime parameter in `Devres::try_access_with_guard` was incor=
rectly renamed from `'a` to `'bound`, which contradicts its actual semantic=
 meaning.
--

commit 8a559ac68ebb5e20ec1214cce81f98b5f5db59d8
Author: Danilo Krummrich <dakr@kernel.org>

rust: driver-core: rename 'a lifetime to 'bound

This commit renames the generic lifetime parameter from 'a to 'bound across
several driver core modules. The rename is intended to make it explicit that
the lifetime represents the device binding scope.

> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index ec63317665f4b..58efe80474bd3 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs

[ ... ]

> @@ -338,7 +339,10 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self,=
 f: F) -> Option<R> {
>      }
> =20
>      /// [`Devres`] accessor for [`Revocable::try_access_with_guard`].
> -    pub fn try_access_with_guard<'a>(&'a self, guard: &'a rcu::Guard) ->=
 Option<&'a T> {
> +    pub fn try_access_with_guard<'bound>(
> +        &'bound self,
> +        guard: &'bound rcu::Guard,
> +    ) -> Option<&'bound T> {

Is the 'bound name appropriate for this specific lifetime?

The commit message notes that 'bound represents the device binding scope,
but here the lifetime is explicitly tied to the rcu::Guard. An RCU guard's
lifetime represents the duration of the RCU read-side critical section,
which is typically much shorter than the device binding scope.

This isn't a bug since the compiler will still enforce the correct
lifetime constraints, but using 'bound here might be misleading when
comparing it to the stated intent in the commit message.

>          self.data().try_access_with_guard(guard)
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D22
