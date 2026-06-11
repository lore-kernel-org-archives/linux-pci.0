Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E14963D1
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200481; cv=none; b=cV6VXa5hRzkoGfhkeS/DsGRr9T+O2YwxPGgmEQRthgO3a68wlE8omY60DvoW+fJOQLUCWslG+2NfLxRZPHkkmmh/hO5tD6wxdi9u5msye1BR/vcCV5vPIN1JnzqKlnl/zC9MUELMQoqJAtKvM+5qWQbJ/etgA8T5Prlf508vdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200481; c=relaxed/simple;
	bh=hp/gCLzbzu3DaDPH/KOU1Ugt6gxOZY68U4NFkPTqkuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QcfxT2lkxgIJSugq/S30WOUL9wNBd/Ta5nvT2wuqcKgH0+TmmFWmODQz2lyWZtId0oTaz95v9HlbGbJDeywM1iVBARDMllSODmrZthZ+cs3x2K2v1Aj1JghuTCD6gFO9eqlllhN4U5O+14eEvdN5jVQ2iz0Mz7Dom7MiSqjK8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQF8l7mM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQF8l7mM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA451F00893;
	Thu, 11 Jun 2026 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200478;
	bh=Da/+XeWrfw2jIH5jv4uc6acrrte8hVk38amU2xgKWuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KQF8l7mMnjKFOAZXyXicM+mxJmq8DnBqWtnq7dVzCAniGUhwws+qmD9oNpZLbwqb8
	 NR9v3ejpwVO5A6EjvxZjkoAHBR7RQBq3ldj42iBj9qQC6qDBeYEO8um9wbQ2Agd7tg
	 TFBaD2XrrZntozHgIN3yRVHqG+SnrVElxoQ46wOmgeNm2MF1C8iO+T8ZlLOhj39aQN
	 FRqjOtFun0QtbgfXbhSkA2I0ACmPAdg7+FnG8/dn0ma974tiSHIkvteTn6bzR6q55Y
	 futR1P0MZQWiAkR97lVUKksdrbe5zVW9jq8als/Dym89QVwM6ZhP28/z2FLL752PhX
	 17L7wKx4HJOIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/20] rust: io: remove `MmioOwned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260611-io_projection-v4-10-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-10-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:54:37 +0000
Message-Id: <20260611175438.0EA451F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect vertical import sorting in the `devres.rs` doc-comment.
--

commit 44ae5967f8fb0af22e020970c5e4e5cc392db95a
Author: Gary Guo <gary@garyguo.net>

Io trait is now very easy to implement. Thus, implement it on Bar and IoMem=
 directly and remove the MmioOwned struct.

This commit simplifies the Io trait usage by implementing it directly
on Bar and IoMem. It removes the intermediate MmioOwned struct and
updates the relevant device resource documentation and examples to
reflect these changes.

> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index aed0c994fd30..3545ffc5345d 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -68,8 +68,9 @@ struct Inner<T> {
>  ///     devres::Devres,
>  ///     io::{
>  ///         Io,
> -///         MmioOwned,
> +///         Mmio,
>  ///         MmioRaw,
> +///         MmioBackend,

[Severity: Low]
This isn't a bug, but the imports in this documentation block appear to be
out of alphabetical order. According to the Rust kernel coding guidelines
for vertical imports, shouldn't MmioBackend be placed before MmioRaw?

>  ///         PhysAddr,
>  ///         Region, //
>  ///     },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D10
