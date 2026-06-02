Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E963B9D81;
	Tue,  2 Jun 2026 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387160; cv=none; b=PzAzKZ0hUYEcZ5YGu/AQS0V8Pym84+mcNoOjbdemaHJIh5OBLWPgPDAuDuaKrcfbtDQ19BbK3wdlUc+jqkF5+QocndrMi3hPR/HbYZa1efX7wq9GY8gaeln7c4VOMMFz2GghJNY8nbcn6nEXzMaWjaSmf0KOuX9SMRuKwcKqAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387160; c=relaxed/simple;
	bh=USvygGn8xi6wy+qhNj9yLgMOzfWYPqYBeZvCWZrXsz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqNsgWK0NoICdbjCMMsQ6zD31qkqrmHw/+0ryskB5ahBxdUwYarQagIu8lok+kmejBISDCBUTkoLFJEXmnLrBFpcJxJJTdYQup6zCb/dyp8ZIWHzF9hVJaQrjwXk6TQCqgEdzGL1uasX83lEK0bX2jAltDPWKh2Dj9HFNdy2kR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5731F00893;
	Tue,  2 Jun 2026 07:59:15 +0000 (UTC)
Message-ID: <e6f6b092-b8b8-4dd8-8b6b-93ac2ad70ec1@tuxon.dev>
Date: Tue, 2 Jun 2026 10:59:14 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI: rzg3s-host: Prepare System Controller
 handling for multiple controllers
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
 <20260520164823.436992-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260520164823.436992-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/20/26 19:48, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Prepare the driver to handle multiple PCIe controllers with distinct
> System Controller (SYSC) register sets, as required by RZ/V2H(P). The
> current design stores a single sysc_info structure per SoC, which is
> insufficient for multi-controller configurations.
> 
> Introduce controller identifiers and extend struct rzg3s_pcie_soc_data
> to hold a sysc_info array indexed per PCIe controller. Add a
> controller_id field to struct rzg3s_pcie_host and select the appropriate
> System Controller information during probe based on the hardware
> instance.
> 
> Keep existing single-controller SoCs functionally unchanged while
> preparing the driver for RZ/V2H(P) multi-controller support.
> 
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Tested on RZ/G3S:

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
