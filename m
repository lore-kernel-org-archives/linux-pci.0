Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570391;
	b=pU4ze0bg/gSh/vL9VGaNFcBg4touqygU7cGurt4LC0nzJHCUIt3Z3gPhjQVppr+B9goS
	 Ce8bnHw7n7Qm76TxAmbuQHEDpNSxgx9xICkpPH1IfryaNv6WhFKYr06jfAdyVrDjaepUD
	 levQ06dx5ie1GkqgzM0LBMA5h0JKiKMxVaYEUiRA8dypSSrPfQURDqspWLkKAkfiaACYD
	 jH+87L7rDYITll33TkiHfzYT0RJsben9vT3stib8ewl9DKUfYGn1vVS1OyxsLmeT5HVJd
	 BpcYIXY6TVoxG1J3WD0MFkWxpHnnl22qN7Uoo/cHuTrqwl9y9A9a4O6nFZHwfazV/dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570391;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cBIAMH48Bq6QhTsHEqqpvh0bCe6pO6/WSPAzZhj52i0=;
	b=0pg9IrH+Zctye2OcwswyvZRzkhWB4VDOBjvzJwAAUFqTiJmtA8nPYtgkqGQQfCA2GVX3
	 mGvL173rnTBC/4exlvn9bDxh3A9qHNA8sYtx6axK5lnsJRktIVxPMc0yVsb8GCANXS0Ur
	 yD87qFr4niVkE6nRp7F/k/+pFtJwIas5XdWLRX2kSNc2G9Ep9kRtuK4Jn+Dr3TktK9m47
	 MJpDRNZUb7tNVJ3pzvgrhyDHvXTCfrbGh9Yg0ju5Rsyyz5GLIihhXlj4QNi2Zne7s5Q/n
	 E+QKzgvKEa0AZXhVx7VXhmFaQ8FCUz0UQYytyqKmrW82hqzcTPS9VsConj080RyYA5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SeNZJOAH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4A606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SeNZJOAH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFA01F000C9;
	Wed, 21 Oct 2026 08:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792570390;
	bh=cBIAMH48Bq6QhTsHEqqpvh0bCe6pO6/WSPAzZhj52i0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SeNZJOAH8Etd0wzegWszdLLnyHwUrJprh8GRxTq/JFUozq4mqMS2JI77plkP8STT2
	 ba3qlOkcKeIYbdO7Cqjkqi8ciszPQ4xRPlLIBpbxAkmbH+495GFIVSxogX16BnYqi4
	 BZBwo6XEltsQkrrg4NbxfNth3+JLVVCgZW5J9Vg8Cg6eOlRm4TkF30qNrBARTCKd/I
	 Uu3VFZXTFMHb64Tuz+d/XQJ8aNrTREpbsnREcymIH0g1eIdUyGQvUj/ojGMShdpKBD
	 5WDJkvUhZLa0Hs2ghS1PThHm92IgaVM+hDSvFK+jSyXZz7oNgow76W5+2FX7B8vW03
	 drQrO6jSEwmGw==
Message-ID: <sashiko-outbox-179946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: endpoint: Skip upper halves of 64-bit BARs
 during search
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021080644.1346549-1-mmaddireddy@nvidia.com>
References: <20261021080644.1346549-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 08:13:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_epc_get_next_free_bar() skips the upper half of a 64-bit BAR only
> when it is the starting BAR. If the search subsequently passes a
> reserved or disabled 64-bit BAR, it can return its upper half as an
> independent BAR because that slot has a default programmable descriptor.
>=20
> For example, Tegra exposes a programmable 64-bit BAR0 and reserved
> 64-bit BAR2 and BAR4. A search starting at BAR1 skips BAR1 and BAR2,
> then incorrectly returns BAR3. The next search can similarly return
> BAR5, causing the EPF test driver to allocate and program BARs that
> belong to the reserved hardware windows.
>=20
> Check each candidate's preceding descriptor inside the search loop so
> upper halves are skipped throughout the search. With the Tegra layout,
> BAR0 is the only available BAR and subsequent searches return NO_BAR.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021080644.1346=
549-1-mmaddireddy@nvidia.com?part=3D1

