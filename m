Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E948F006;
	Mon, 12 Oct 2026 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816179; cv=none; b=HyXtieGSE5sPDKhIaBRZHl1YIPamstv0WDavs7VUFO70POUH1ukzIX3+ukf64FHfm1yXr0tNslXv7e3IZ2yVgEeAwFP4U6UjKR1G2yTHOflorQT/tes8gGEW2KpyrkCB1aOxPEHp3VdvwqlCIu6UP45CCuJQEva5snhkhN4rn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816179; c=relaxed/simple;
	bh=STzorNFGHHAw6gqFRhjiwkUzna+xlmuk54ASwGdYCNg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jAb8oEx0rfuQ5PQujaRbgJ175AaNhMrB2WM7YXyhrnf0HdF8UpWTOm3v0IxVxlFPD0cTQFOd2S0QCAuV3kGOSavhVYGo7vSFfXHlMabo7cRUe3C9pk4GCcH+g6A034HkYzxj2+Pz1ardBrzNzHSoBndtQf1msamcd1dNnt65w4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq+fhG8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq+fhG8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED37D1F0089D;
	Mon, 12 Oct 2026 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816178;
	bh=STzorNFGHHAw6gqFRhjiwkUzna+xlmuk54ASwGdYCNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xq+fhG8Nt1nY68rVA/RLFqacqR4aLtVMPEazNhhbrureKtVpz+7/lqq2tbskCUobd
	 qATE5uiPjl3EN5lG+PARpLXfBelRoxMrMII7aZ5kA8yLDaVr7STad/gleiG278XdqI
	 +NSO13hsD26EA//m/UqUTKliLZLv+203jiUr6DDuP4PXxLg/iHScIvIpJjTzq16iRP
	 ulptOnRWd6dsPhRfpP5keQZW5Kt8h3vHnJO503Yr04nJ4JGmyanXM4OqSrXdDIM9FD
	 04m5Z1v3GUujwNt2JX8y28FAV/WmcvStb1RaTttsskAlwYc19wvW3zW2evHPnA70gt
	 z8NTJZjbrx8kQ==
Message-ID: <sashiko-outbox-168279@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/10] PCI: of: Avoid np->data usage for the node
 changeset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261012142826.159178-11-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-11-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:42:57 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_pci_remove_node() and of_pci_remove_host_bridge_node() check
> whether the node is dynamic but not whether it has valid private data.
>=20
> During the node creation, an OF changeset is used and this changeset is
> stored in np->data to be available for removal functions.
>=20
> If, for instance, a PCI host bridge is created using a device-tree
> overlay, the related node will have the dynamic flag set but np->data
> will be NULL. This leads to NULL pointer dereferences.
>=20
> Checking for a non-NULL np->data pointer to determine if the node has
> been created by the PCI node creation process is not enough. Indeed,
> on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
> (e.g., in the pci_dn_reconfig_notifier() function) intercepts node
> additions and populates np->data with its own structure, such as a
> [ ... ]
>=20
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: <stable+noautosel@kernel.org> # Issue not triggered but could be a pr=
oblem
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D10

