Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1F372060;
	Tue,  2 Jun 2026 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387107; cv=none; b=AJzOuNd11VUZDLGx31+Frj6Pa6aHXWMKJydcZQRWGIqn3iFIE/c9RiSsWqfobJ+k0+EksWoS4G1NlInn3zSv/jBdZPiHfUuoaqMGV/XjfU5larmWk2V41JNUaczglDreC4Y9MLPFYWTylVT5pabXfIiLeYCjNrbCAorKI2ZMLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387107; c=relaxed/simple;
	bh=Z+wFpdpN9q5VMOna1l7B4znqNx4XniYoBkGVnzAnnO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTYiBTefR73xC4I46+36u8Lye6hphJMKYJC/P0fjjkmWVheOMlUOeqxdPPaX2MpB7HsJnFVC/ez0qoTnjI84R0UrVI31VOuVhsi9+Fh9FqIcYIsd2JqzyBA9WDu55Vgqu3crrFlLjQLHb9Z0uaxLl+esAxVLu9bzb+6wFQh23ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4291F00898;
	Tue,  2 Jun 2026 07:58:22 +0000 (UTC)
Message-ID: <ecf75d2e-5aa8-4d68-b691-47ee03e6a261@tuxon.dev>
Date: Tue, 2 Jun 2026 10:58:20 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] PCI: rzg3s-host: Use shared reset controls for
 power domain resets
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260520164823.436992-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260520164823.436992-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/20/26 19:48, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Switch to shared reset controls for PCIe power resets to prepare for
> RZ/V2H(P) support. On this platform, multiple PCIe controllers share
> the same reset line, requiring shared ownership of the reset control.
> 
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Tested on RZ/G3S:

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
