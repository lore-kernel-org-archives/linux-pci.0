Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B8E2C029D;
	Tue,  2 Jun 2026 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387111; cv=none; b=TaCxDZ7/wBzlaU6BPVEsTfIiXxeAsQpZqdj46cFY8NaVXawRNhgFsgv2C+e0/c61uubigOXCf8TvsmNOr1sBAZs2i1H9gHVUTBRmkd2NbzMlfhLkaE/MQg4OMbaBcrK62qIiLqofL/AneXIzd6oyJpqma7vvRguvNc0gqX2OEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387111; c=relaxed/simple;
	bh=fPhIVUl+47zpfZ7LUJdtEMaCzAB6l58q2iwFPhSxUQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9Qg/G8gDVqm8e/cJg/GcSkLmki0XKdAzTJ53ORMQKGx7XjaKrMY6ujtpiEHna+0ldU1XYGcBjZPK4vF2a0UyVq/1HaAujJRheER0tD2NrC2D8nMIEC0D8ThAvB3NZUBdatUNYKCuQyTMYFtkaCHreSIt0sel0VPs8QAhN51m28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6BB1F00899;
	Tue,  2 Jun 2026 07:58:26 +0000 (UTC)
Message-ID: <52d6e1e0-ee68-4932-af20-b353655bac77@tuxon.dev>
Date: Tue, 2 Jun 2026 10:58:25 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add
 RZ/V2H(P) support
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
 <20260520164823.436992-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260520164823.436992-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/20/26 19:48, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add support for the PCIe controller found on the Renesas RZ/V2H(P) SoC.
> 
> The RZ/V2H(P) controller is similar to the RZ/G3E variant but includes
> additional registers and configuration bits for PCIe lane control. It
> supports multilink operation configured as either a single x4 link
> or two independent x2 link controllers.
> 
> Unlike earlier SoCs supported by this driver which only feature a single
> PCIe controller, the RZ/V2H(P) SoC implements two controllers. Both
> instances rely on the system controller (SYSC) for configuration, but
> the required registers reside at different offsets for each controller.
> 
> To correctly identify the controller instance and map the corresponding
> system controller registers, update the "renesas,sysc" property to a
> phandle-array. For the RZ/V2H(P) SoC, require an accompanying cell to
> specify the controller instance index (0 or 1). For all earlier SoCs,
> strictly restrict the property to a single phandle with zero argument
> cells.
> 
> Additionally, make the "num-lanes" property mandatory for this SoC and
> restrict its values according to the hardware capabilities.
> 
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

