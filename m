Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C748F84E
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046745; cv=none; b=h0bkHbEiuIq0qLVizcleKksHKWGOdZci9onzNOXpTkbModRmaqgzbfFHE3Wlf+6SFwtpfgKTuSGpaGhS9WpnO2aRb9JvAwH5VlMYeiAQXjm5ZkHZKjdgyOg9r5Io2Yy++q0HhAfJzA2iZEdWBQ9V7hLutOhexjK4CoS40jHNo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046745; c=relaxed/simple;
	bh=TWm1tmJhi8/zAKe/ZPPeFR9mZKY642s7HCOhX2uDp2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfouW4wIe1NZivcZH86RW/4J9qRCimyV7KaXsOTvj1riD7Unz9VK154mt9ytW1Fyv19vXrHtHECP9+AtWAh1rU2q43rMXN+6WwMVWibae4lu8aFjcqrw9kcFKchD3HCIs8IXRJil8mbgk9Yb1AvFtVYwQ6G4eBzxIuA4ACmFhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy/D5hNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy/D5hNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB6E1F00A3A;
	Thu,  6 Aug 2026 20:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046730;
	bh=TWm1tmJhi8/zAKe/ZPPeFR9mZKY642s7HCOhX2uDp2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gy/D5hNHgt6CdUjUEILFSuN6ByAdte1EJZACA+I9GpEuk2feWL4n9UMSbTjoSkM0d
	 wandpF9dTxrCDy9xpjdnVqWQTy6Wad9QW7BHy5Kc+e1aWd59+d/VVW4R2j4Co9zUS8
	 dBMjE+vxDNhAgsuiVab4wKQ0BO7dFHuR6gBlxkmHlUfO9rsrJSSYRwAa9NtwPGFP0A
	 /aZ8ozGIne6i+RmWWZSSU8ANqpBGfbhCCdBcTLpUjCL0xENZbAORQuqXzmfcgMzS69
	 z94f0p+eAA365Q6wQA5lZOe5vQHeEQyMwGhlAOxdts6r2DlfZP5YUF3n/kKmkXo8Xh
	 qCRybnLBX5KMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] PCI: vmd: Add vmd_configure_membar() and
 vmd_configure_membar1_membar2()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806221351.38592-4-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
 <20260806221351.38592-4-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:05:29 +0000
Message-Id: <20260806200530.6BB6E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the MEMBAR1 and MEMBAR2 registry initialization code to new helpers
> vmd_configure_membar() and vmd_configure_membar1_membar2().
> The refactor preserves MEMBAR address/offset/flags programming, but
> resource name construction is now generated in the helper ("VMD MEMBAR%d")
> instead of using two separate string literals.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806221351.3859=
2-1-szymon.durawa@linux.intel.com?part=3D3

