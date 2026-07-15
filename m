Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3D40EBA9
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129093; cv=none; b=No6nWKyzggbE7mhazCnGu8KZBGh6esDC0C/m7HYSQDES8Zu/KrrDA6raBycTle9b8WPs4gagp3iOAbWH9jzt1y3zO0vHXLAZl9XECGIxHSiFdyYIeYneLhAPDgCBGXi7XrBJAFryaOunNCwfQg9CZh8KpxLHbo45UE6j12q79Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129093; c=relaxed/simple;
	bh=3E46ftJWMapUz5i4J+PjidiOxIRQA+ZAeSkshbyXWEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bjMjqfTaR67A2/eQys6GnTlVTdTGynoF5seuYYEuHDG0LzfBVkJ4iEEXkGSH47LDiRF+wzBo4ciSKbStc+MIwMnM9MwMmSIQDTIbSsL2Egrx9MD2vguV6gOjZY4g88vvnYoX/KD92mnTA46VvKNlNkff4bUzbPT+94rHm59TT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRU23EXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRU23EXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7B61F000E9;
	Wed, 15 Jul 2026 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784129092;
	bh=3E46ftJWMapUz5i4J+PjidiOxIRQA+ZAeSkshbyXWEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRU23EXRlq738Q4nB/BXA+8Um2Ke5SOn0eCOwp8q9n5AUYgybk3/HmlkEm+1/W+9K
	 sl0aouxBJap9VkZ1SXpPkJKnKoCTEkPXKKOMp6QFbe8mHPTnO3g53UGUa2DvwvNzOL
	 nDAVE3wCpNf/iEVvZwn/8RPbYDTD++WLQg7suDGl4MBksyqKd6/tItMuSdzDHbNVxs
	 MYAxN2i7Hy1YjEl6I++zAxtf+IDaUr+UYeNa9OFrlqmXE1xG1UfQcLrQanoqtqCQ/W
	 3miZdfGRt68SLa/OCnzKhd+2zD4tP398pMoUS1fL7fUFslNMEf4ASis7q/6xAFSXSx
	 xOzxDtFqfk9aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] ACPI: PCI: Use a mutex guard to simplify
 acpi_get_pci_dev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2417350.ElGaqSPkdT@rafael.j.wysocki>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
 <2417350.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 15:24:51 +0000
Message-Id: <20260715152452.4F7B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Use a mutex guard in acpi_get_pci_dev() for the physical_node_lock
> locking and drop local variable pci_dev that becomes redundant after
> that change.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5115219.31r3eYUQgx@=
rafael.j.wysocki?part=3D1

