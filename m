Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AA522EFB
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068277; cv=none; b=Bx2GKNmjz4nc6SQARUW2HowuDyVDdPpunAOp85m7bC5VZdfEhNXI/THyTrsKh3x2qONIB9Uloygm/5ds9dHM+MrMsHAaicR7JzaXwxFbav/OyHNIYEWcGBk8lLHkIPc0+6UG0yoiIKbIgkQ34EfsuPwFFyjfJDkKyG8/pTHCg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068277; c=relaxed/simple;
	bh=3lqg5Y48vjY/IUwjEft4Ky34JM00BHlqW5M8NQCQ99U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LLwc731cQWKQfy5TLU7l2iKAjg+DEpO5bRXsDKhTnkl62YvbbjQWYmhh/XD0KwTlc55cRIKBjjJNo9w9/uHIEA4jO9wrcWs3zSo2UfRS64qapoHt9K+6D4I7F/LP4GWSVt60obvdeDyrjZzT3q/cwdtIUaHCsxxVNt6DbVC9maw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVdHnfbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVdHnfbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6581F000C4;
	Thu, 15 Oct 2026 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068276;
	bh=3lqg5Y48vjY/IUwjEft4Ky34JM00BHlqW5M8NQCQ99U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVdHnfbPW0DNItmKAgLRbomud3mRPS45ulsTf2lwBmI0hHe59rYXQfxUuhn3fJu8W
	 9kTcA6psDrxZXlS7tkjbnyV0gMNzUGBTXcwW71t5JBdwvYVIxl3ZCrOwry8hHvUWFK
	 d5vO6zkpB3M0dXh/FTIX6C/Mi7kiLlW/KrbZfVXWc7DEE/kntkqUKbjyaTTkbfsTKt
	 oZmeGwSOzIXi045uKhkL0UtlucBuJLKXk/QCgiwAi8ZHnhqeNajHjQR/Aley9GQeD6
	 gcQJoHmB9DXUZDzsvV5RK40zzyYi2g60VLF5b5Q5s72FVi0HMT6rmQJBHTEgQfm8+A
	 jMj2vtwe+nILA==
Message-ID: <sashiko-outbox-172855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] rust: io: add read-only and write-only views
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015-io-access-modes-v1-3-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-3-93611b84b5e3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:44:35 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An I/O view can always be both read and written, as long as its backend
> supports both directions. The I/O API has no view that only allows the
> accesses the hardware or firmware permits, such as a status register
> that must not be written or a doorbell that must not be read.
>=20
> Add `ReadOnly` and `WriteOnly`, which wrap a view of any backend, and
> their backends `ReadOnlyBackend` and `WriteOnlyBackend`. A read-only
> backend implements `IoReadable` and `IoCopyReadable` where the wrapped
> backend does, by forwarding to it, and implements neither `IoWritable`
> nor `IoCopyWritable`, so the write methods of `Io` do not compile on a
> `ReadOnly` view. `WriteOnly` is the converse. Views projected from a
> wrapped view stay wrapped, and the wrapped view cannot be retrieved.
>=20
> Add `Io::read_only` and `Io::write_only` to create them from any view or
> I/O handle.
>=20
> There are no users yet. Register locations with an access mode will be
> the first, in a following patch.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-io-access-=
modes-v1-0-93611b84b5e3@collabora.com?part=3D3

