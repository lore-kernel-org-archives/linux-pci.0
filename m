Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E43D7D72
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392941; cv=none; b=KuE6dBnlxWlL2+tDgSXnyAels7tZjzPcwvGMfVi9C6Y+s0uKIuMHo/dLVnE8u/eVwZVKgim8xtr77dFHcMxZClfC+cAKTr/Vkw7YsHSrkOVT9nogJLl7/vz1+uvK2XbbIret4TqOB/w7XArg80ooMTN6aaCaoDcDW3HiqgAqFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392941; c=relaxed/simple;
	bh=eYPYq/vDY/JQ3iOv2vXaAB96KiUyyJo9BkENTe4J2ZQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GK6poB5cgw+G/JOT5cAdEw6JUXYkrodyttdJndEyf7ePXsvDlTABrRhz/AzF4xdw4O8uKBD75LdsZRZjpHISrMuEPi3eDCTLY34rrTbxs5g4doxPTq6bM44VK05wLh3rMgRKhEjY5BdX8q0x4m9RCVvfIxFhwJxZdGsiB1fo2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+d3mkjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+d3mkjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6521F000C4;
	Mon, 19 Oct 2026 06:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392940;
	bh=eYPYq/vDY/JQ3iOv2vXaAB96KiUyyJo9BkENTe4J2ZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+d3mkjPkKFHTkNB6/OCiWONCMD3csKnvVxPebgm4OAfs7nAvcupZfIHVRW/x/kG8
	 RP5oRViIhs3fBAE0CLIS8IDS272jpXvzM5irU9CCmmdzx/i968czG7mv2PjMSfrl0k
	 PBX2gEhDAoFbI1MI4x5XKuhOh0B/U34YrJg8TinnnYFH+iBQLqR6N3wndE8eS0XpYX
	 5Luw9edh4SjRmxKOInYOe/w3xDKlydFyK9op7RUY3fR/VjZwrC4nZUEzC17mr30cCW
	 Xr+yD1MnuVYniRd1LM+s5pgwSAIUoEt/G3pUnUkPPvEmqNJcEyuJ5mU1i+x46MNYRa
	 FZyKZ4lhovFHA==
Message-ID: <sashiko-outbox-176716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/14] PCI: rzg3s-host: Move IRQ domain setup code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-12-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-12-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:55:39 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Subsequent patches add support for the event IRQ to handle link
> up/down events. The event IRQ handler will use
> rzg3s_pcie_set_max_link_speed(). In preparation for adding event IRQ
> support, move the IRQ domain initialization code after
> rzg3s_pcie_set_max_link_speed().
>=20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D11

