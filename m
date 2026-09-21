Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65298375AC6;
	Mon, 21 Sep 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022815; cv=none; b=Y7zKVn8T4nJta3w/bIQI7vvFu/MAedS+Cmdvhg3qiNfSyUBFWmcWPNjUdKY7Fomcblwp0f0ZMcI0p8hZttFrPiKDuTogBL67kKsVEzDUc1WzVf8k1GNAr8GcuiLg3zdab788eU6toBNMZNBtY6GS/Y4ZBQJTpnc+lBxU/CUmw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022815; c=relaxed/simple;
	bh=hN3p7J3DC6i4Y+uybUq5x5Cf3MeWN/184TmYE82fX38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sBfO05PvjZce29iKit7lacB8XM4y0XSyVFMTWMQlXuPGTvV/SBqG30DhsGljgcR5se1Em1VYQYzRoe4EYsYobRGPjb9ghlNkj71CZS0OdU8UGb4JgXe0tZuYhJID8c8T6tCLV2mtkZUhhJ9XsupQKel04yE0TgvrcWR/8h2np/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzIYjmwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzIYjmwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F481F000FF;
	Mon, 21 Sep 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790022814;
	bh=hN3p7J3DC6i4Y+uybUq5x5Cf3MeWN/184TmYE82fX38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzIYjmwQGrKUmW+7P1h8whKEmmqCP/AI11pXmX+A0/iHwz1c7+hxyeG9UDV0gPGAM
	 BdGsDcFqTcAUQTdUCtkAaZxbsI6DSwKUxqIoX6e4lrT04RT8tl7UrYTbm30NKtWQXI
	 mAI0YpLqIKwrpVLSVcN8lQJINLBcCSKQjiZGn03QGsEb8aHVWiUAn8CT4LdGoy4t6v
	 0JXmTpsGIQzq8YjKqbillF/MChsGEWiakHIwwWNLs2YqX6A0Jv1xbBoiuhc3VurCPB
	 gPfZOSOc343DT9wTzmWIj6qO48g2AlWAA20cviFhYkzavQ0s+k7T1TV+kP73E6/yjT
	 vlHxBAvi42oDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] PCI: dwc: rcar-gen4: Split .start_link into
 ltssm_control and speed_control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260921202823.72620-5-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
 <20260921202823.72620-5-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:33:33 +0000
Message-Id: <20260921203333.A1F481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce new .speed_control callback and implement it on R-Car Gen4.
> The callback implements the second half of what is currently present
> in rcar_gen4_pcie_start_link(), and rcar_gen4_pcie_start_link() does
> call the .speed_control callback. This is a preparatory patch for
> R-Car Gen5 support, where the .speed_control implementation is
> different.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921202823.7262=
0-1-marek.vasut+renesas@mailbox.org?part=3D4

