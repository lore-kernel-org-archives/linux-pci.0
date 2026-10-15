Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C552269C
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068271; cv=none; b=dWshO3xuoJ1HfIzlGXzAkz6vGPmisG8GXkb7caGN6fPNrVc/HL1Rpbcjd1qmEagx7H1vvBKYR7l73nOIraYf6qjNBwhKTEOEegH7QLZ0dzgXah+qr2NEbjIJYEVNs8mryI3swzbz0oIM0yKG3gqGS5VHSLa7wF9hFl9cGSR+rcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068271; c=relaxed/simple;
	bh=qzNGyo8gBPNLDCZJt3toYTjW3+LN4geNpN1IC3srM+w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZURlekDPfPT1Mi4wUKFL4y/akCLx328xGWAGK9Pff8v2GNaQUAGdRDdKu/Kys5Gz1rztgdW+5a8cIV677i17YEfZbPplJFkKekR3knkFWgZX0h59OsBFuO/re2kGVhKiocQb7S/IGxE3MpU80woWgHLmCqgnPMR7ukndViIwkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCA1w9X/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCA1w9X/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0451F000C4;
	Thu, 15 Oct 2026 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068270;
	bh=qzNGyo8gBPNLDCZJt3toYTjW3+LN4geNpN1IC3srM+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OCA1w9X/30OZjt4oMJrJGUWe+fzv86vCZ7JYiJK3R6wcbIY6huUoWg+Oxz2Ba765y
	 98b7MsTFzT+fgM9YhucnEOu/Wt1tTPiL7n1ASsJJdB6XMDsix5widNcFpPspbk0d8Z
	 jhOtR0Ea3uIh8bfqKoAaQfApALfc61PnVywc52+P8Vwy2WUadHib3zQk9YCSRAiW8G
	 YWx2SDGesbzwciBu0t5tDxHvZT0ER2zCuCBxLiOOYReJjue4PmcyzHqwnzdYq9jgIL
	 gHNyFoZd41fd7H0BOblc+OaKxTabuVwUzEC6eDmbFyYHa6kLa7bk0RYWcinZUSE3y7
	 5wY7uONHWTRLA==
Message-ID: <sashiko-outbox-172854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] rust: io: split IoCopyable into IoCopyReadable and
 IoCopyWritable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015-io-access-modes-v1-2-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-2-93611b84b5e3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:44:29 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `IoCopyable` provides both `copy_from_io` and `copy_to_io`, so a backend
> that supports copies supports them in both directions, and all four copy
> methods of `Io` require both.
>=20
> Thus, as done for `IoCapable` in the previous patch, replace `IoCopyable`
> with an `IoCopyReadable` trait holding `copy_from_io` and `copy_read`, and
> an `IoCopyWritable` trait holding `copy_to_io` and `copy_write`, and
> implement both for every backend that implemented `IoCopyable`.
> `copy_read` and `copy_to_slice`, which read from I/O memory, now require
> `IoCopyReadable`, and `copy_write` and `copy_from_slice`, which write to
> it, require `IoCopyWritable`.
>=20
> No functional change intended.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-io-access-=
modes-v1-0-93611b84b5e3@collabora.com?part=3D2

