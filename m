Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6D552ED8
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419267; cv=none; b=MiDN8nNASHgjSBR37rKXmc5JGLfasKXOgzPO+vetT4A0N9Jed1fyBsXch9f10ssjUgIxDRTCKctw/9KS5Dc5xy/n0UGeFJpWFQloudkpgKcravsFLH1mOkqeqwBdYXBn+4ZgJmffMH7sda3rOZ+N8KoIrLfwk5pY0hFXKqqXBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419267; c=relaxed/simple;
	bh=j0GiZNEl7W3CTOC+ozDIOmHonzDqvXdvdhPoAIs2oRM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=to5i6tH2WNQeNvkVdqq/wlXw2Kungm20U9ADV1DfsKaMYc84yd7SBgApdvDwHdMCV5gSVGQxS7YA3Dj4WUPqT3CALe98SAmcxfIjSTqLGGxjXOQbaP+5bWlsYxPlAb3z4D+Vw5+lqfK/oHioD4Og0i7mkRpUyFO2NJuDJa9uczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbEQLiKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbEQLiKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458CB1F000C4;
	Mon, 19 Oct 2026 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419266;
	bh=j0GiZNEl7W3CTOC+ozDIOmHonzDqvXdvdhPoAIs2oRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbEQLiKYNyoxzJx82KUj7+c3aUvKE/o9FnpHbbfbKl/DYm2a4wwrqGDj5jrvMs0aq
	 1GtCft2GywjEb9uZ4l7kknf8Rg+8LaHYbjVx+jJmT7tQ40wq4WPQa79KpsBIOwsbdc
	 /niEuFSOmRKoYMFEpGJDz4FCbKtVYON4b4OyePYK4K9Mh3Y5khwr5HO8fb2oVjO76y
	 xOzH8EVpfOxdy7Ro+3WIjS8tUkU5lH+cZjkF61H6RqVi32ac6oi2bE/Tk3TKt1LZS5
	 ZaWua57XSg2gfGLFNePDUO1FUfUJsBTaMgCvfPilNglY6Xn0R4hIwBcrvjubfAxxGH
	 K43x5rhJj06Yg==
Message-ID: <sashiko-outbox-177325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] PCI: switchtec: Add Microchip PCI1008
 device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019135441.1420968-78-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-78-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:14:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Logan Gunthorpe <logang@deltatee.com>
>=20
> [ Upstream commit 0d8a6306c680ee534be131e360f0cafa2bada7be ]
>=20
> Add the Microchip PCI1008 device ID to the core switchtec management
> driver's PCI ID table. Without it, the management endpoint on a PCI1008
> switch is not bound by this driver, preventing userspace tools from
> configuring or monitoring the switch and leaving NTB functionality
> unavailable.
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20260714212010.230606-3-logang@deltatee.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-78-sashal@kernel.org?part=3D1

