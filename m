Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8473672B8;
	Thu,  2 Jul 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980763; cv=none; b=iwetyBDNUHZn/g7ni4q2VOMK7ADdFTwUq4wOVxkfB52ZQsrVFCaqZrZTBhHliN5jkuRj0mo1W2MM1EFSlwVvQwKVZAx+orOqegyjHkDHbpPQK7uwM2FbI6FLlnl6Np8RlbKouJR0/KJcana2nCcRJ6vfm1zdACmwuhW7rUGYogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980763; c=relaxed/simple;
	bh=iiv8p5qHlPQWmUtFZtqMFFZMBLNDP6LoFpPF9tl+xrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPvA05hTUs3oqhqxyMgfQ9JKCQ2f/bU6IZ+SP2kHpU1opekYTQkJ/FFuwA6CrZCwfq5apbe4xG3W1s/hU0PQOcTEUgCcNhox3v2fY3T5aOK340Ks0P+WfUhU5t9jOZ2+GXfKFYimFCzQ3nZekGzjUrk3gmyeMBWMEYj4vOTFYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSO+EeXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSO+EeXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB731F000E9;
	Thu,  2 Jul 2026 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980760;
	bh=g/YU9h2/+V7xdUoN4efaSbAo6cmdtLPlIo0ezNZnzgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hSO+EeXaBKdlQzKWkECM/IwvEKdEPNtcQR+uj2ry4hmveWdo4e8F35hw85K0rbtvW
	 tXBX2vI9f0zXgpuRBI2LP9eEsu0I6a3TCzVa95GPMwGtzTYe+dV2qKD2d5wM0dmzM5
	 N9A4+n61wB4w2V4zHEzJNyXUXAyPqcsroOKLphCgdFhI5yjAx7Y3TaQTqQ+eiNK1nu
	 8HhH3IVQ6X3Q3fUP8MlHzRUFUfZTtRGySLuljFAR5PqHEU4I6jXGOBGeq8rq9gXOP2
	 r48vuy5CzjHmiwsk1exQ6Igz9CCBVOlyL0CuaLxmVUnfRrg+tl1j4/Nc49WfDiI7bm
	 eHlx5OMd4YKkg==
Date: Thu, 2 Jul 2026 10:25:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jianjun Wang <jianjun.wang@mediatek.com>, kernel@collabora.com, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for MT8189
 SoC
Message-ID: <20260702-evasive-golden-toad-d3437f@quoll>
References: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>

On Wed, Jul 01, 2026 at 05:27:36PM +0200, Louis-Alexis Eyraud wrote:
> Add compatible for MT8189 PCIe Gen3 controller, that is compatible with
> the one found MT8192.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

