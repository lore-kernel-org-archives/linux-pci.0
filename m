Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277D51FCBC
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912452; cv=none; b=LMLOhDAYE5A62tnwp1xOHKJENgx8wY5+Rm/Zly8F9XiQGja6g2NrFJAbu4kuBA544vJum2iMtPXfmc76JWDSxWNWHALJk8+JTtkVSAHbR1aTeDGjjMkaEShN+hiXFRP6zB/pZ6skUSFW8K8YHChb+CxMyq0hT9usLbSsIryb6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912452; c=relaxed/simple;
	bh=AmueZy9RhoTXx1eCMWiqFr14L9qdip9GcM2MFpajx+4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MYHbPsX+EtlBwWGF+YjNz7HN4ULOUkFDGI4Z4o2gbuutSKLhDgomJFcmUO3cadwDQp4BntKxeyhWxNknbgRszNyWo5G0pSODoUlaHXo+f3x22DX6wM/B/1UxAKhZXlyJpl/qj/L++j1G9oIAiRDHmPml2KEUUcNd0+4fYvXGfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ72BW3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ72BW3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9781F000FF;
	Tue, 13 Oct 2026 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912451;
	bh=AmueZy9RhoTXx1eCMWiqFr14L9qdip9GcM2MFpajx+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZ72BW3/De8M3l6gav2egJg+8CXw4J5U1g2DbeqDnleFD5awYePWCs1g4TwkHS4eC
	 asbAU7TCmQbViccyucBCm6H87JQlLldGmzMxjbNUS+/rYcBiFbdiB5o91CvWf+CDBx
	 SmpPRHY1qgUpqe69AP3P4fzjwh2q9NMrvfS6P1J7eS35c3eBossa4XUDeAOcc68q6C
	 SigDDyeo1EWCaxWLNEP4tOd2qEQ6lXuaa7otteqKeIaIeBOailEnrSQXsMhUxl+8hh
	 ndtRTG28Bfb+f+4aeg6unnotPaoyBR3++mctddBOb6Vnlh/OG6D6GGdQ5f+Uw9E9f7
	 nJfvBECQr0nPQ==
Message-ID: <sashiko-outbox-170225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 5/5] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Manoil" <claudiu.manoil@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2a24aaa96c6a0204e3ff293f2a1d22b58cf2171f.1791908694.git.claudiu.manoil@nxp.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
 <2a24aaa96c6a0204e3ff293f2a1d22b58cf2171f.1791908694.git.claudiu.manoil@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:27:30 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> NXP ENETCv4 pseudo-MAC (PPM) ports can be probed as pure PCI endpoints,
> without any "ethernet" node in the static device tree. The ENETC4 driver
> describes their fixed link by attaching a fixed-link node to the PCI
> function's own OF node, which requires that node to exist.
>=20
> Request the PCI core to synthesize a per-function OF node for these
> devices by registering of_pci_make_dev_node() as a final fixup, following
> the existing precedent for the Xilinx, Red Hat and EFAR devices. The
> helper is a no-op when the function already has a static OF node, so this
> has no effect on platforms that describe ENETC via static DT. It only
> takes effect when CONFIG_PCI_DYNAMIC_OF_NODES is enabled.
>=20
> Both ENETC4 PCI device IDs are covered (0xe101 and 0xe110), since either
> can be instantiated as a pseudo-MAC port on S32N79.
>=20
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791908694.gi=
t.claudiu.manoil@nxp.com?part=3D5

