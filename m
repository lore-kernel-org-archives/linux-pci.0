Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604976;
	b=k+gHaOTb2BeTghiJsFyQV+ibk/Xl7p+iVGDS7RTWmFuYke2qlfGxsOkP/Cla0tIFiMWE
	 7ve7OQL8baHEKuUccU9kC/7ZJLdDUrYQNFdF2ytNeOn/E1DMNpBBnkM4+YX/XdM3kAbDB
	 xPVoRJeqKy8IOo8SvdMcngyNj3/o6W7k+H5ZM6H5j9aQMahtEQZoVFaU8lPtHqbJ+BpvZ
	 z9ypFC/RRetlUIIFnBEpu3kliQywQTJ24bqucdXrHAaYAkHHAUY7L3SH+jPaznbMTcnEV
	 n1eJ+akO3owFqK0zGvkSO83OQk89GcVz2+8WFEuFr5CBwpMXwWwr4ITMeEWocY+N7cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604976;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=LCBfxEU40M79m4igWPgRSpQSIOpMpx1vCbLTCBisKlg=;
	b=d0AQeMfwH8bl17XvQcLW/x32uFh785bH6P2A3zG6t+OSCO6tt4FEwxBm2gjqv+6m/rdz
	 2Sccv7KLTTa/TwDPS3DJ+5VXefXLTAqfupFZEwmH7cA+p7uaq7P1mlZToeivNO32L5dsm
	 h5ov4o2pejXJBSfCgL0rCe8iWn6aS3Os7nbce/K+itCIJA7XYPIVtwVrJNExchgZEszCg
	 D+W4oTpkEimEYuMCGorAQxV+GcYeB5ygK9+S+GTzZeopqDvYlLmXk7s5eBJlL6FVQ86Q/
	 cF9whLX8xEcaA3COIuZu+/Kp/2tYv853cJDcr5aeJsUY8DFlaZ5YFzkOrOy0oH1uG6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4wPKJMF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867A606A326;
	Mon,  2 Nov 2026 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E4wPKJMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074AB1F0093A;
	Mon,  2 Nov 2026 07:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793604976;
	bh=LCBfxEU40M79m4igWPgRSpQSIOpMpx1vCbLTCBisKlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E4wPKJMFLe3PrzOUZSJYiHb6tquc+2PfKSMBRCvfDFVw1R7EVcbcsKTPceYcpSzDq
	 0cYWY3PSmLW8F3GrIgkwjt3kgwps6hY5ca8WBZrEiLTvfkQ4fqdeHRZTkrLPRuTQSy
	 fvBR6UnTWVTUoZvMmxlQtTyVS+pnDeuo2YI/hRc1DhGTzh0GnjwGaHk9z93pK0hY5G
	 Lgro8N6pzpbtRuQcsGePo0tYzDYLUzVmXDWLWmtQsSqr9rkty9gBvSt6+yYNfs5XVW
	 /NY4/q+oeIqe4FuqWu7eyFCHM7FYCCO3CXEErO4O01diw64e0d74aqobvsh33mTCSP
	 FSWZ6KYq+MweA==
Message-ID: <f1df2818-be5c-4019-a86f-4e782a70d3fb@kernel.org>
Date: Mon, 2 Nov 2026 09:36:10 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/14] PCI: rzg3s-host: Add PCIe hotplug support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <atphAmy8ZIjY_JNC@ninjato>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <atphAmy8ZIjY_JNC@ninjato>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 10/22/26 22:16, Wolfram Sang wrote:
> Hi Claudiu,
> 
>>          i2cset -y 1 0x18 0xf4 0x8 # Link down
>>          i2cset -y 1 0x18 0xf4 0xc # Link up: PCIE_SLOT (NVMe Micron)
> 
> So, I applied your patches on current -next and did the above.
> 
> During LinkUp the card (Renesas USB3 host controller) got correctly
> re-initialized. Same for physical unplug/plug.

Thank you for testing this series!

> 
> I don't know nothing about PCI, but I wondered about one thing: after
> removal (both physically and via I2C), the card was still present in
> /sys/bus/pci/devices. Is that expected?

I currently can't reproduce this on my side. Do you remember if you executed the 
below command before your test:

echo performance > /sys/module/pcie_aspm/parameters/policy

?

Thank you,
Claudiu
