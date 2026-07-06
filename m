Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D240A958
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342679; cv=none; b=meC4WoDzreZpRNASU6rmt1qasDIEonTzvzN8HIz3ijAWT6+s1MikR8asMaO836DO8mS0+3tdQhzI+xmYQ262goCtgaX3LaaqaiEvUvfO4e5l42TvH9P1I8sVY6JmEUnd1C5MeRBMOBgeGeHXNDPG8Ft2ffAVxKqwzRc8dFFASgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342679; c=relaxed/simple;
	bh=H8TWbiybvgVZrdX6xCsNuZaidHGq0ZgtQvWQA2K2mFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FGN7X1Pe101QfrRoOI0Z2MGDZVRCdthdGatR4d1KYY+tU936UgaujTkc5I/ZSH/3xVD987A4h58ftkn0Mo6FEhByyxEMV0jHWl2rEtmAzRJqFEotDhJHtG1eWYzqbH6FhKIM8oadpS/wXVlkvg4Yo1xMLL8sycmEl1BF9Jhktl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKxXdybF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKxXdybF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC31F000E9;
	Mon,  6 Jul 2026 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342678;
	bh=H8TWbiybvgVZrdX6xCsNuZaidHGq0ZgtQvWQA2K2mFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JKxXdybFDklmgE9dV1lKD92NCas718FxuvWCW7xn6zApvawu/FZHcHFUy1zk07Fr7
	 N/aoVN+Fhp5T0ugTb61fCPH7BDbS9QApRrLFjcEgh0oW52aJwE5ETEpfk2rxNklfu+
	 VO9a9TUTfRV2ABARScowZKqT8vh1PT9NHKPYv7PfNTLpPR1AxdTISOmoqNJM1gPykL
	 bXlefRBtkkN6GF2rMpEGPi7D9/uUROeNLD5YK5lFulAaA6QWWVz6XM9lDyrgdVlS4w
	 N7aaV7rzAhAxo6t/DYuXNqKGiUa7GTqjUQ34CeZpx55uvyxBfBgNdv/jnAnYroaYGd
	 n9m2lKZWmUgEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/20] rust: io: rename `Mmio` to `MmioOwned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:57:57 +0000
Message-Id: <20260706125757.B4EC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Most users would more commonly reach out to a view of `Mmio` rather than =
an
> owned instance of `Mmio`. Only implementor of `Io` like `Bar` or `IoMem`
> would need the owned version. Thus, rename `Mmio` to `MmioOwned` so that
> the name `Mmio` can be used for the view type instead.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D6

