Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619676;
	b=F6SAz478fUVKv/smzx67w9V1SXRnaWAXwKSqvgQQYxuJOi6n7VTEVRFOOzRwD309Eatz
	 KCGFfyf8lSSdH5rHqt3p+ukTbUETPwC7F80+Vk3z6Az3dtNYygWHG/p4pkOJMjBi6NdQ0
	 53+fkoSd5MxqfKwgInLA2YssRfTl3bR69T+xh9KRdI85U0dYrYwssth8OIBPhji+N1PHF
	 sww1Vi4aOu44u+dKYqn4vjgoSB13/m5uHe8vLGZPgYcTkxK2nHdhMoKB1imBl+X7xpWAv
	 73bVLYPm5h9HrYnnDv+rMzghDdalCrh9nxDiHIaCW4WrweA74ySkdq4M0Wdg6FClIMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619676;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OyowZtWoW/2A3SClO1pCZAWlkcsWEPesQh5GHrmRm7o=;
	b=UcFPTqGHi5AzBYZEbEu6vXPrCj3mAotm5jnV9PbVBmc+ijFnNBGRoJ6e5WoGZj8fPSqC
	 2Acg25dJrh2LslUXb7vKXa+ROfEi4G/MZGdrQQGpFUpUQluI17pnxUtmaNqYx/oPSVc8+
	 zULPqtTTAZcRsHz8hIsr/vARJx4Ae4xCL+maw7LtLnFlITYukKW8TfLczvuNW1aQJYwi1
	 +87Ht6paDAO04ovjacFPD0VAet2WRge3DqdNkyzRAh9890Mg3TGQFPW1wBAFY8xXp9Rml
	 oFUfC9CImdUez7mSD6jsa3gi1UeQaoLxYMMYevo+Mt+cbRGPiz/ohPpWAqufN201KbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMFs9YkE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BAF606A324
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMFs9YkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FB31F00A16;
	Mon,  2 Nov 2026 11:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619676;
	bh=OyowZtWoW/2A3SClO1pCZAWlkcsWEPesQh5GHrmRm7o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IMFs9YkE/NXNxDviYWYt/802lPJ5L8B3iGrqRYjzZwuCOb88LCA8findTGeH/GjBj
	 yxqYctYUMUuzZhveUB5URCQHx0LiCcntdnJJgJobX8KsCGqWwIEISfkleARpykIu0J
	 y5UhR0AovyYtLzEKBFhrBmAobbo445JtHu5P27O7zO+mXUGtzbn007ZNqGpW2vcE25
	 Gx0Y/q4Zk9wdXlBz6OesSBh1in0oHoxRLUGyQE+AqtC1ksnKpVnXtoCpigUQXghIol
	 pI20HbOOXmxek3Yq7R42Z8oe0UNX+RR1ny28h3+rX0HxXle7lp5HkoX1DD6WqjPH5R
	 +4LbCwHihUwEw==
Message-ID: <sashiko-outbox-193344@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] PCI: tegra194: Avoid full Endpoint reinit on
 PERST#
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261102111450.4010818-3-mmaddireddy@nvidia.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
 <20261102111450.4010818-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:41:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Tegra194 and Tegra234 lose controller register state across PERST#, but
> the driver remains bound. The common DWC initialization path now
> restores those registers while preserving its software resources. Tegra
> therefore no longer needs to call dw_pcie_ep_cleanup() on each PERST#
> cycle.
>=20
> Remove the per-reset dw_pcie_ep_cleanup() call. The existing
> dw_pcie_ep_init_registers() entry point now restores reset-lost
> registers after the first initialization while retaining software
> resources until final driver teardown. The allocation guards already
> reuse the bitmaps, address array and per-function descriptors; this
> change also avoids repeating the full debugfs/eDMA teardown and setup.
>=20
> Keep the EPF deinit notification in the PERST# deassert path after
> REFCLK is available and core reset has been deasserted, because EPF
> deinit callbacks can clear BARs and need register access. The final
> dw_pcie_ep_deinit() during driver removal still performs full cleanup.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102111450.4010=
818-1-mmaddireddy@nvidia.com?part=3D2

