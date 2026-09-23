Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0848035A
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187172; cv=none; b=bQqpP8EWhILPLecRejbh8PS/ilatfGo19rhlaiDuIStU2IRFeV3IjsfVZ+LvLv0IuXJiqi3Vjdc++ucKPN91y4rwtEr9PJeWlfbAhhsiR4wKfb8KTaif7IxPem0xEUMwKw6grvPYP4V5d0haM9dEokv2++oCNwlRfmpIS64jRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187172; c=relaxed/simple;
	bh=D8NFlpv4XnsBlEBJp9+PhCCeXsM1RlI7UQlth0udO6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HnYk3g0JVKsGgISnNS8Syd2Ugai5qaFzdEK3PQadYbeNlzhAHUpSflDVToXkaDDmdE3/FI9JiUhxlU3Su7gGVrB4AIeEK/cJnG5hkvqiCWiRopfixHwpXz+kFBXFum8I+wAmIWE3PRnaO/Y2JEyFqVBYnIllPT3Ow4tiTW65rAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfYXQoGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfYXQoGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E5D1F00893;
	Wed, 23 Sep 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187169;
	bh=D8NFlpv4XnsBlEBJp9+PhCCeXsM1RlI7UQlth0udO6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hfYXQoGgwXVwjbsQ5q7Vajqv5Ah3+QTk6xSgrhkUxkpoXfFyYIwS3OKdvNOl8Y4y9
	 d/hpm/l/sMr+1ND5gkoL+oV2xBHZYhpEfzsERJurdEYIJQbnwEtdgatE8sg07gREIJ
	 WZ9jIRSQZApA3K4DEbcIavZSL/Cc3Miq9j2HGnjaP6IFXPWS+Psr1oVlfPOFpgXYva
	 17i7FvJCKmiPsKJlxS6aZqktDLAPrgv3C7yY4T6G1eeGdPIvBxxqezQfNbXWL7Qbye
	 LHhuUvyCF6vXxlgWPvQa+YjhK8GnDxFsGnTcRLmgVcPUo5/KXKDfNplvR/2336mRkn
	 kA6g3NC/YxGZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Fix device_node leak in
 rcar_gen4_pcie_host_msi_addr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260923180749.3906547-1-fuad.tabba@linux.dev>
References: <20260923180749.3906547-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:12:48 +0000
Message-Id: <20260923181249.17E5D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> rcar_gen4_pcie_host_msi_addr() calls of_msi_xlate() with *msi_np NULL,
> so it receives the MSI controller node with a reference held, and every
> return past the NULL check leaks that reference, the success path
> included. Declare msi_node with __free(device_node) so it's put on
> every return.
>=20
> Fixes: 8d6af27c0a73 ("PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not=
 used")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260905213855.8D6671F00A3D@smt=
p.kernel.org/
> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Retronix R-Car=
 V4H Sparrow Hawk
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923180749.3906=
547-1-fuad.tabba@linux.dev?part=3D1

