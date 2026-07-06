Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800340A925
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342781; cv=none; b=D+oyAcFEwe3+AsY3KTRXXKbHxQjbVWBjqXG13tUEEjFUQ89LsIJJSpthmlPHD2EPuPR0zNYwMuxVyjlzWxmAzA4Qlp3aK+b1C5U9Ewi8GCqayBMAjvvSLZcyu669YbxFgcfouqf43rbJ1C/Q6jm2rzViUwJlZz0jTlg/Ob4KPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342781; c=relaxed/simple;
	bh=FlJPmYkcI/ixq7+2GtoHrDXypZbwDiQSCuksrbF+WSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tuR1RP82vhltLIEwkb2RNCfXxw/UsBNpkBBpnCBbxis0b32wmKMijErb3Txddib1EuqbjcyClDY6vPvlXOA9tBfUUvsv81b573k194MGLRHmoO1a+qLTXx9Qzn49NaG7elymBV0GBU5AHKk2KHah+WPYYFRkn56AoqM3MrCGpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2+m4bLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2+m4bLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BBD1F000E9;
	Mon,  6 Jul 2026 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342779;
	bh=FlJPmYkcI/ixq7+2GtoHrDXypZbwDiQSCuksrbF+WSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X2+m4bLB5zMlCEnuFdfTfIMXCjCh+UmqETyRLpuFEXAc+5mvLeplnMMLn+1gbqRiY
	 UnEIU304kg7hAi1q2uOj4EkrR7ZBInrWRiDRLhFlyM0MJ5uumJjpWuH2Me+ESKmAKY
	 orC2bu6kgLcEi0fP5z4TnZODOFw/spAHAy5DE2HpscY1AKXZoO1TIyHa0eSCMzxJ8C
	 7fLChu19r6QgWIaTXXIYhAsEZYcCIPTv0zxTHmx1bgWXuiZ2b7H0d/3FEyamBh30Iy
	 z9k9Lthd23tSVWkBPZomXixFCL9auV793vWPcyp9Ea+019JH2eKWWK1bnqX7CHzRb2
	 B40HUlINcHu3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-16-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-16-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:59:38 +0000
Message-Id: <20260706125939.76BBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Provide `read_val` and `write_val` that allow I/O views to be accessed wh=
en
> they're narrowed down to just views of primitives.
>=20
> This is used to provide `io_read!` and `io_write!` macros, which are
> generalized version of current `dma_read!` and `dma_write!` macro that wo=
rk
> for all types that implement `Io`.
>=20
> Note though `io_read!` and `io_write!` only works if backend implements
> `IoCapable` for the type; which is typically only implemented for
> atomically accessible primitives. `dma_read!` and `dma_write!` currently
> supports them via `read_volatile` and `write_volatile`; this can be
> undesirable for aggregates as LLVM may turn them to multiple instructions
> to access parts and re-assemble, even if they could be combined to a sing=
le
> instruction. Thus, `io_read!()` and `io_write!()` does not fully replace
> `dma_read!()` and `dma_write!()` in this scenario. The ability to
> read/write aggregates (when atomicity is of no concern) is better served
> with copying primitives (e.g. memcpy_{from,to}io).
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D16

