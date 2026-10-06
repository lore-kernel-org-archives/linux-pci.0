Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3C3BCD0B;
	Tue,  6 Oct 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276819; cv=none; b=ccM0Ne7m6ptbKW3YHQYb7UDldVL/1ZJADaEjY+o8DqJO4fzYscaXvbTkFUARFVBu91NPaZe5FoSWqKC9yuzsvCfHtqpijkzusBLC1yfeCj93xAS+qzjhjbKvTtqMGxQXwFbhmAZJ2cr8L2a6DvB6dGNEtQE9j6TNPd+G2T4gVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276819; c=relaxed/simple;
	bh=fdv75Tz1g1I7R8KGVmdJjeeXbG5KhOa3brJMCcLhJPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U0bGOEm6YFNkUvupuLi5RsDxrva3K2QtRtAn9T8nad5U4TAPrXmjDhrAg55LRpJREasf5d9btOvRUsuPKdggObNX70Sv8wWzrQ0JXHsdV/2X3HQq+g7UHztL0fW4s1nGpNhBqLCNUoV8kBuGTq4Tre7CJ8tbgdlqOBwcfSDBQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGHZ7+fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGHZ7+fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1511F000FF;
	Tue,  6 Oct 2026 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276817;
	bh=fdv75Tz1g1I7R8KGVmdJjeeXbG5KhOa3brJMCcLhJPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGHZ7+fxTvmTX1bwhILczMk8AQSJ9qFoYM8K5mdYpubBIr6zq3fU/VH4BhiK00KNq
	 AYSMMvxUG2sO6sRobIp7pfJkCzjkW1ylV5IMWLhukwzYtIVLLLsfPedYhYyFLi/UG6
	 4fIbO/pzJciQXiGuzq8U/wylxPAH8jhABas8m89nU1GI4O5HQTGP9JER21kFw1HnmH
	 Vbm63V/za26Qp9eMvBFZJzhTgEPOr4hXvk3xglgfpfQJqLn3LhO8K3Bd5paYQ3VlII
	 Vi7gkLuiY5gz6nIiqSsVIYDLfZCyEipDK9QDcllTsgIq9LvQdv5rRhf95gmmDUCoWi
	 ldOTRzdti30dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/18] arm64: dts: renesas: r8a779h0: Describe the
 PCIe AER interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org
In-Reply-To: <20261006084638.3821710-19-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-19-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:53:36 +0000
Message-Id: <20261006085337.1C1511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controller reports Root Port AER notifications through SPI 454,
> separately from the integrated MSI receiver interrupt. Describe this
> interrupt with the "aer" name so the controller driver can use it for
> Root Port error reporting.
>=20
> Append the new interrupt to preserve the existing interrupt indices.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D18

