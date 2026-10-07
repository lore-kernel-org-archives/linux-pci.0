Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C624886E
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351848; cv=none; b=VPrgG+nIaanL5MwrZ9ZjzluEg1ZHDC3tgskNS7kNVscNrJac94LN++ERs7ALE9hqyvchzhBpfKQOIOqpky7NUBoakWWyeJRSa9Br+6mMUqNozr//QaVpdBgdDgn1vQo8M0lkHYV/COtIQO4+jh1sldMYmwApdXLRh5tJVGY4Y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351848; c=relaxed/simple;
	bh=eUwa7gweUoIjgu0A2WIkBRhjqdxcnDgfMhykoSIU25g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I0N3+UkKmxvsx+ibLLk/J9WJJbLADTkQwv7djt7ICmyMLxop2RedxyhtIXzCU7vRY6XYX7uOqSukWP4loGeydfx/bqgWmniMhAj+igzRj3ouHBAAltxjevheSqKNF+yj8XqgAl+Rf4wM9scZJla1IsICEAGm94Ge1ClSSyHjepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/7jFdI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/7jFdI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36841F0089B;
	Wed,  7 Oct 2026 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351846;
	bh=eUwa7gweUoIjgu0A2WIkBRhjqdxcnDgfMhykoSIU25g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/7jFdI86zUeSwIeZSc9rJ5xYh6KSo2QIjFioG2E5IDB/yrU+zx0tRHIc9cu6LZxd
	 U5V/XFGe0PNOpA7XaEOA1LRLHRihrsFV2viXl8oueK6h9AdEf0kRrXbvyf34zbU38q
	 z+jPR0NP1mnIJ1jaNozTc4usVUkrFqWx3Kv15wZthnKg8Td+fd9D5jWYsSdyVPKaKw
	 Q9K7gQERyfMDnYw0HPwRDjqm7f2F+c1rmnzbBti+FevdQvNRJHhJawV7On7WHe1vb1
	 Fqkqshc1MlqmOpYyKgPZOoJWuFmcvG0x6msEs3KqM0jWY1wKVP0hTs4CDgCJ82Ib7u
	 Ee3rfYIt7OVGg==
Message-ID: <sashiko-outbox-162646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] PCI: rzg3s-host: Add helper to wait for link up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261007053645.1391545-8-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-8-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:44:06 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Factor out the link up polling from rzg3s_pcie_host_init() into a new
> helper. With the link up/down event handling added by a subsequent
> commit, the probe will no longer fail when the link is down, but
> continue and rely on later link up events to detect the link becoming
> active. Having the polling in a dedicated helper allows the probe path
> to treat its failure as non-fatal.
>=20
> No functional change.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D7

