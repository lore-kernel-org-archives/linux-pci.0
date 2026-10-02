Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151EE3DA7DD
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934791; cv=none; b=Z7tJh2N6D34EpZL9cmwsNqUb1Wxlv5dsxBTlDJjOYgeZGzmLMze22NKZ7SrslJnKeUf74Q7YWD5k7h4ka5tv5BbhDsXJDTZSq4BjHHLDavCofHdPStLhWlqUaWu63WiNn00eysApCeSd5A6jAHBn4ZoNenBz1qocvH62Uhtfh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934791; c=relaxed/simple;
	bh=V9eweX5GzvdtWPMv8Zy3U2sIpaLtu0cxEfa92kCEUO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCFL/FhPPd5IyqFV6TUeUEGT3925wXB9t/Wy9dcpBIrDeBpNPYN7ORMM7oi/y1z/E4dqD5o4TJyGPvGwIvrm9hd1CUnvKOZkH3R+HOP8yOUgEEsSrHQy3vjFvlAeUKRkl9VhHZPb3fd801GCpmzrhoiX3p7wgT0BhBRW+JnqjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev0mzQ8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev0mzQ8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922BD1F00893;
	Fri,  2 Oct 2026 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790934790;
	bh=V9eweX5GzvdtWPMv8Zy3U2sIpaLtu0cxEfa92kCEUO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ev0mzQ8pHx/l3R+grkxPjEE0Bsaq9N539uUU0kye7V3qFKQUa3QcJKSYg/7HlgZ5r
	 e3jocM/kB41pBhO+mrRKXVetVwhKLYiz8FQwSLawwEZ9FHHEM1rOL9iiY1ooE5mMIa
	 18kd02RWcg0T0pTcFhxbps3Rrp1pZ/Ya7fsCSE/ruyzSWDf2soGOXsRqtiblCX4aDb
	 ewTfljJ2053P4+5NM4u9j5FmfX5KguXqdr34mi/hMuMu0TpUt/5UlN7J7dgtSnhi+P
	 S23t+4akEydrJhrdrdHK80y/9J/SvKwZvxLnJr1x0PaEwc533sawj1A9XV2bGS7yCa
	 d7uxCuvX8HUsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] media: Consolidate AtomISP v2 PCI IDs in the
 pci_ids.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
References: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:53:09 +0000
Message-Id: <20261002095309.922BD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> We have a few drivers using same pair of the PCI IDs across the kernel and
> there seems more to go, consolidate AtomISP v2 PCI IDs in pci_ids.h datab=
ase.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002094813.8564=
39-1-andriy.shevchenko@linux.intel.com?part=3D1

