Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE9379C34
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478859; cv=none; b=c8gXhIVjPz0a7/bx4K3ykA04V0l75IqzVx83Wedc1zR2LwmxCesBgS1g2vDHN84mz4JOWod0vZkPk5ga2F+Ito7fKL7cUjQJvReZeC7H/w7ZJR4PuBfVOdeu5qohAy9Boxga8V0gEsFDH3Fje6j6B5duClY4aSzPOVWoRbnaEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478859; c=relaxed/simple;
	bh=ebQ7rx5B8yA/1NWkSdnxm9VOTtNBCQXWX+7Aq76fS6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ci/XvoodrTbpoy4+GckYxe/Q7my+MULu28AVMODPB/SYTI7MV2dOP97yvgwXTr/E110Qy18zfjuIiIQQoiHPJ8DTRBmFs+D43+cYCGDFjeUh/8KkjiFmGTM+Jj7Q1RiLCOceskxRhchAmFRFBV394ABS8FbtFaxFJ8cY0wZk7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WucDD096; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WucDD096"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05781F000E9;
	Tue, 11 Aug 2026 20:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786478858;
	bh=ebQ7rx5B8yA/1NWkSdnxm9VOTtNBCQXWX+7Aq76fS6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WucDD096S9sOH1wHS//qsum6uvt840jtjzzoTICoQxh3Qk7bCOUepfVDH65V1pP4G
	 uYIIGstiYVuM5vRHzp4Dyapmw54RW+5V/I8uh3G1p1N+Zixo0qLot29eeBlL2NBY4O
	 jL9Ktqsa6oTGMQy0g1UPVSoYzw4j7qXVS7RP9cG+N1eMQkWczfPyprnBxNWX7tQm7f
	 IFHuFJ5OVzNg/z8ATZLX3hJ7w6I/Mm0JST6Jq1Kn/rWh5+xjSa6bKHskUrNVzjED1/
	 9v9dc2FHemBacAyznKhee0q1QUiYYza6My2aUWfr4TWxgwtrXmI1/Echy3yNLYqvRf
	 K08z7JOLzVYfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] PCI: rzg3s: Fix IRQ domain initialization error
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260811200013.185956-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260811200013.185956-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 20:07:37 +0000
Message-Id: <20260811200737.E05781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> rzg3s_pcie_init_irqdomain() installs chained handlers for the INTx
> parent interrupts before creating the INTx irqdomain and initializing
> MSI support.
>=20
> If any subsequent step fails, such as obtaining an INTx IRQ,
> creating the irqdomain, or initializing MSI, the error path returns
> without removing any chained handlers that were already installed.
> This leaves stale handler and data pointers attached to the parent
> interrupts.
>=20
> Add a helper to tear down the INTx IRQ setup, including removing the IRQ
> domain and clearing the chained handlers. Use it to unwind partially
> completed initialization and from the normal IRQ domain teardown path.
>=20
> Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811200013.1859=
56-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3

