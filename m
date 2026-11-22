Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384996;
	b=t63xVsiakKDnGHiygTRMkmOhAIVnCiIBFVX82G3CYd5S1PCoUA1wN7/knxKKlihNxwja
	 b99il4AFnfb+fE3lCyLdMTJlo/3BV/RtyWV8MZul+5hotbREXcqZqrMosdXIzstlsEzj7
	 qBbDx26d+gpX7XrVcJNnbhKpUoWEzTLsi8gWMtuY+re7MWt//GJXS8uqohGC/qgm6MvOy
	 yyBObvJgWBJSWIR1VwQVCafpGZJ49/zngO5ihBkgLCZAPKC5Y17KOrG0+Ecir44vzrbMw
	 SY69bFBeh1GcpMPlZA+qwwwM46fWLgWF9gn1bdhHVXrRiGaRoDb83ujTINncfJCaxvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384996;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=Bybb0KwOvis1rKSsjZu64GzGwowQo2jgCy7Dlcn92pY=;
	b=JXDIOy9QARq52DEGxt9GTpAJMzXklfGG8S+BX65L5Xe4uqOf5pPQnITHOFc2n26GKQ2I
	 FD3Kx7arVn7lQ0JHgsOHu7PzWIqsWdQ3Xyji72enepxvF2hbQYHN99DqMjcoyTc8oWqxF
	 TIUrRlQj+cB7OuOAA6gabVWk8z+wbRK1TeNcXnxvxMc7z+1gZVBB4wELYvi2AlV7Sc/2p
	 weEO5mfy0r8jOyH9pp9atvSjA1wEg+fT2x5majbBpii9EZKEpWLAR/J7yQmI1WIvmLIiy
	 cwx5qIIsjzPBk/hoQv+sxjzHsP076Za6Djm7Rfo0lL+PVj5h9CRJ1NsKEPe8hKSjXNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b="Wb/so95c";
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA0606A6AF;
	Sun, 22 Nov 2026 22:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3AA0606A6AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Wb/so95c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Bybb0KwOvis1rKSsjZu64GzGwowQo2jgCy7Dlcn92pY=; b=Wb/so95cJ9kddKWhnYYipbulEM
	0scYKO6Pg39vdQLbaZb6yOzPBQbE55H9EymYx5w+jka5TlSJi6EdJPhXnJm/UAcZ6iIYXgsxTQ05B
	smKW4DnQRwRq84gQbVI+xfDFuPSt9y98MmVAFzyfn9jUDmq+WZeWUBazzdeeLGyjjBDs0neA86zvt
	AR2ztYLrq8ZntyDz/i+oMqbE/g93izRzm3GQ5cKolxJ0MPvdpSXKvJbrJ6jmRIsbzsr68j2eag+lp
	A4IA0rHPS2mb6AX8V3svW/8MBy3iavrfJ7kuNeex6uQDJKRup5zGoQA1UhdJJQ6soiGJS5VtqlGLI
	anH7awwQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rockchip-dw: Allow endpoint supply
Date: Sun, 22 Nov 2026 23:03:01 +0100
Message-ID: <b0JWF81HTBuNN9Ysjciedw@sntech.de>
In-Reply-To: <20261109184948.477095-1-robh@kernel.org>
References: <20261109184948.477095-1-robh@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 9. November 2026, 19:49:47 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Rob Herring (Arm):
> Rockchip PCIe endpoint DTs describe the 3.3V PCIe regulator with
> vpcie3v3-supply.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


