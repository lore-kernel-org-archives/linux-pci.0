Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474489;
	b=qnO+flF+uI+JqsiwVCFL5cEOE1g+w1Hgg32uILSylPA2nnGUCC/k7K+bUOD16fyMXRUr
	 0t1zpcjQUlrgbI4haUN6eDS7HmiwV8/9nsXDw7dXPSRRw9H72Zs6CfiZRGqCaflra8JZP
	 SW4/r+0r5qYdJ2ebXlS3gSv80Vzi/JjENYtZpbPzsi78bJd0+/DLITAnWtdHAQtuIfKUK
	 TZlfJlc8h56EhPymymUPEOgiPnEwcUkoS25AflxAD1n0wxfmLGY5tPNvVtaG94NdGug0n
	 Ia03mQ4JoS9boUrohzRUCOMlHp/EXC7S3zII3gonVeIu1y8I49uJWZ5iCkcw12sP1LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474489;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QZY3QEbTazJVBNLfkYhq96DccGik9lwrQlsFGiS8+BM=;
	b=JIOm4HXLyBJkE/3YWA+KQ50DEw7CMciPt3EpuLy35gISGqN1XI8Q6Py7TaGe10NNrlOX
	 5/r+BMxdB+Uy8HT1byAAxXNcNOFZGR2jYoEEDi8jx79O0tLh7JpMXdGrtIk9yv0nqwSMk
	 VfnrjV9CvHukjmMvcZls9FMC12xpJ5aEiFi5uNMrgWuajDNAXO1CDcMok/rcWPotJR6Q6
	 mzIXWPknZSMRdir/twYfwAXQHzGAVL/6o7zfBMXB+eivy1D9jqxA6Ea+XAw59GBSMqit8
	 e4jZSgBQOQTfGxHJhz6OfXm4NSVZH7K9oYexxtxQJehgd/spuY1JrsMoIxaocEjKIIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kud4b5sK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D19606A31E;
	Mon, 23 Nov 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kud4b5sK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9EA1F000E0;
	Mon, 23 Nov 2026 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474488;
	bh=QZY3QEbTazJVBNLfkYhq96DccGik9lwrQlsFGiS8+BM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Kud4b5sK91u5SBmL8lPGIPTN3CP4ATH85EG1moMmnUj+tCyZ0v8511LIpcjMDEoyz
	 hXY8ps3kX6luSVimz1DL6w/4v5XS3DVwUhuQbkGmU/X2il+gRYmCZtVqR23bFanmSl
	 Dl8czKObWKjkuDOOoojGPffwA/hzs17niUNQsMcAce/LLJwD1vtNNMvahJFR3lKBo7
	 91mQ5CLCB3pQclrn2mhzQrNaTb16nOaPOKJcN8Q6chuOiFNmkbvmBcewM9/mdGNKea
	 bh4CHAmXA8WiB8Y2kO9AEWts847SxOKF65TwM1vfTLxrLZ0khTRsDy48k1r9GPMfkS
	 kKKZ03sSSQ6nQ==
Date: Mon, 23 Nov 2026 16:54:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] soc: cortina: Add CS7542 PCIe control, SerDes and
 host support
Message-ID: <20261123225447.GA1119216@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>

On Mon, Nov 23, 2026 at 11:32:14PM +0300, Fil Dunsky wrote:
> Add CS7542 PCIe support with global gate/reset controls, a Snow Bush
> SerDes PHY and DesignWare host glue. The global syscon already provides
> the APB/CPU/AXI clocks; extend that same provider with three PCIe gates
> and controller resets. No resource-less pcie-control child is created.
> The existing clock indices remain unchanged; PCIe gets named specifiers.
> ...

> Changes in v2:
> - Expose PCIe gates/resets on the existing global syscon provider.
> - Remove the virtual child binding and separate gate/reset driver.
> - Preserve early strap clocks and unwind partial registration failures.
> - Put clocks before interrupts in the host binding and example.
> - Enable root-port MSI after enumeration; dispose INTx mappings on teardown.
> - Return 0 for lost-link DBI reads to fail iATU polling; serialize quiesce,
>   config/DBI access and IRQ draining before reset.
> - Link to v1: https://patch.msgid.link/20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com

v1: Date: Mon, 23 Nov 2026 21:43:28 +0300
v2: Date: Mon, 23 Nov 2026 23:32:14 +0300

That's way too fast and wastes reviewers' time.  Please wait at least
a few days between versions.
