Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794759836;
	b=DRJ+vtESf+OIQxkHtlJ+nGp5bqHj2GdJ4gXl+g3lYgiq1IoTAbU/2PXQyYgBC5o739B5
	 zqCBcqjoa5Hg4UpzijZubdv1hAj7aCgA0qOFxeqJnzjwwRdpfSOofSyWMg4qTKW5S2QZo
	 Zmrj83L8REx/XJLdA6tFaNS+WkUn+dubkVJB2oRRs1opHwvMeX4MGwDREsy1LRe1eO/CC
	 Q/mJ2k+6NpzWI43xlXLTxkaVR2NvvytdjzogWWkVqNI+QzMXcGoDNFh9lQWKtEfY1SWe9
	 IvjBtTEeX8D0Uy2k9Xmgoq63t3DmZBAYO30t7WnZ4gOQcRvqwQj9EyCpCf3aQezFHyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794759836;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=NCd7gUU6HGHaZLtUO73+KIOy/CnHOnCqa5r0SPBNmTU=;
	b=RvNRLtlwPXSNKcvOZU1Bb1k6756ZdycfzMRZWPZTPQHSDzzXXC2oYt46lThV8LTKl5hN
	 tJFIIegpD8osekJxhoGJNe1736yd9UrKSfID14oLv8FQtDzZicxjpyYY8pfqM0fNaJuaV
	 fOpomIOrp3JAr25y3DGk6Gf/DioycUxpikKIZthTufQLkeZEgTR9e24hpxWtfRBS396JD
	 uqhAA31BX0jdKDnxKSH67CPgZbwc6KWAiYG6543UqEB0f3YfZQae44rS33hFD+8ycw9NP
	 ovCnv6u2I1V5gjcAIxAEebbKndvjxxhopJNrIHiTQd/1Yyo6K1EjTIV4n0uVzeZmf6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UM/RNRGo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AA606A31A;
	Sun, 15 Nov 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UM/RNRGo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD02E1F000C4;
	Sun, 15 Nov 2026 16:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794759836;
	bh=NCd7gUU6HGHaZLtUO73+KIOy/CnHOnCqa5r0SPBNmTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UM/RNRGo6lEAU1ZmUJhXH07ppVCefYyTsmrrSDGR94znDL/OTXxidPBXk3JosHgXR
	 UAzJe+b04n9PNxERO7MokrRJvBp5dorTY4N8aLUtLN4P0JDGvq7jhcNKwgw9UCQaC7
	 u9Sgrhmamo/flZ/AEttZN/nS6FNa06nde9sJ0oZCeVuXqlNZyjEw1441M8dqAYly8+
	 bv3Z+3/vVmxno0ipvMFj1PPmeA7lbdw8uWhP7LgDqykpGINt0JeA5ZqE9PW5uV9l7r
	 z7mzSkIDfmTSBtwyMu3A2g5v9zeVfNnJ7bZbSqqFH+UoyJ5dPOEkzxvvdmho0tNGxS
	 BpnA5gGOXm7/Q==
Message-ID: <68bacdb1-41e8-41b7-96b8-22169c6e78ee@kernel.org>
Date: Sun, 15 Nov 2026 17:23:50 +0100
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
Subject: Re: [PATCH v2 2/7] dt-bindings: PCI: apple,pcie: Add M3 generation
 compatibles
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Neal Gompa <neal@gompa.dev>,
 Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Michael Reeves <michael.reeves077@gmail.com>,
 Joshua Peisach <jpeisach@ubuntu.com>, Mark Kettenis <kettenis@openbsd.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-2-0e5ffec71da4@jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20261108-apple-m3-pcie-v2-2-0e5ffec71da4@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.11.26 15:22, Janne Grunau wrote:
> The PCIe controller on Apple M3, M3 Pro, Max and Ultra SoCs are
> compatible with the one on M2 Pro and Max. Add their per SoC compatibles
> "apple,t8122-pcie" (M3), "apple,t6030-pcie" (M3 Pro) and
> "apple,t6031-pcie" (M3 Max/Ultra) to the bindings.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---

Do you guys want to take this patch through the pci tree or should I 
just pick it up with the rest and route it through apple-soc since there 
are no driver changes here?


Thanks,


Sven

