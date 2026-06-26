Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98C3E024F;
	Fri, 26 Jun 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471516; cv=none; b=M+MgfR6nSEgLo32Ho2O4IL6mpsb5esQZeGq8myegWhZuQQlXcpWqYevTB52XKZaLaV1vmEkfP0NO9GyssZ9Dk7Pp5JkmVvAyGfL2ZVMxQOLUmtm9vRhqHVH5Uy01CoInQf2ngH9qrwluErGCZF1tTNCGlX0c7gLOq7t/Ntvc0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471516; c=relaxed/simple;
	bh=kkhq87eNHx45rDTRj2aYiXEgmDVbyoXLvkV567xOy14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuvU1yFYa0mrQoJfu/kcnsu7mYk6E5uPSPiDj3tg9dmBAISraRNqI1F/vVyI4AuhTXAoiIq13KYiQL6KiYF65dXqrf47TKEwE5G5uM4rO/lYfWv0uO4fhmh3p/2abkr8hOc8u/B4JNWLZd+BBdk901XpAxTZNOBtZPC2ePrn0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTtqDhZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTtqDhZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164181F00A3A;
	Fri, 26 Jun 2026 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782471514;
	bh=RiRGYMelPViVpJAFJ/+wpKu/uY7s9Tmxp1lwWzuPoWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YTtqDhZWX4gDsM3ZhC+RSSrkB6J3+JXyXalf7KZmvI6BZPpAJGkTDga9CWGHqDQGn
	 LJHpssTXYqG+amR6YdlEILOJENU/76GWqwO9J07I/gVIQuOKuKPxG1P0gZoo7iKOir
	 n5q9Ss+JnmDQJ4iDyJS+T3T595NfO5VNqkOq5RpDhd1nZ+VRhXaL8O6OcAC2ODGb1/
	 tdmbvqX/GoyXHKrGw5iLfPbV32OPxdhF9Lyd+Ie/CiDTl34hXH2yilooJMnQY1yYAv
	 vLIL5WimkP1EXPSZvqgSGY2TsG+++V4xUtmjlcTAFyS9QmoSyjCMwWDOin+YSd+MoR
	 tO4VZbNwqH69g==
Date: Fri, 26 Jun 2026 12:58:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: airoha: Add additional reset for
 PCIe PERSTOUT
Message-ID: <20260626-talkative-cerulean-hedgehog-93ccdc@quoll>
References: <20260625215741.3253212-1-ansuelsmth@gmail.com>
 <20260625215741.3253212-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625215741.3253212-2-ansuelsmth@gmail.com>

On Thu, Jun 25, 2026 at 11:57:34PM +0200, Christian Marangi wrote:
> Add additional reset to control PCIe PERSTOUT reset line for each of the 3
> PCIe lines.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/reset/airoha,en7581-reset.h | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

