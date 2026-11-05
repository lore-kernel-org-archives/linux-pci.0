Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907229;
	b=AaemWYBkfhX3GtKG21aziaLf4YoIuN87wS6watd9PDINeJwlrFUhbisvt7d6vLNnRFni
	 Fw1hs6KPbftWot8cI39CGlR/WGkV4FG+F7fxpzbRqXgfS9ttp9yyTjjBF0EMkHFOQLHjZ
	 LHmFJ0T31MQ5WEP/4e/yMEDzSgzZL5m45Osygf1hDewh0rn0YXL+rPJbOifnRM6BG9e4j
	 8JYanrMlucNnvcot0BL/78JLXyRPBedW42BUjMUJ51YcxpMBYlRIIr9beLsJ0/KayhZ2L
	 829wqMpalunMSY+P91oORJwtzs2f+2b1yOau18UYIUbkH7LP257fHHSbR1l7ZUJJxmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7U59FMNX4DCr6XqUc5APtHx1j8o76nRw6SIZUCXGvNA=;
	b=R0JbCw452zsLl0GeT68K6f7DHmvUpFypVJQNFiZuIIO/P6e2YMbkcUOcmGmpvdJAJRfy
	 VvR030fb7dBmGo3lEwxUotfleV74gPQ2POiQ1VLDEpgEI0IrSSF2J9lkRv87GhEMg3zP5
	 4FR8j0MHLpjLWTaAP8sZUBE7T8TDgaHJIIGk6ly9RFRM8NNUTukE/AdbFrFe3+h0pvOYI
	 lIJNgNJB68pu7kzrbzT+Ul8oLXTxqDOXDqsKV2ov/+1bodAPgFJvsDFRrghxCE3AQv/tH
	 brUmw5iJFRFrC04TU2Ba66rHwdgs0qk74ZjvZHRhk4EEJyFyty9WOXYvd5XxRh0iuuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ly0t1MS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C594606A6F5;
	Thu,  5 Nov 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ly0t1MS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5501F000E0;
	Thu,  5 Nov 2026 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907229;
	bh=7U59FMNX4DCr6XqUc5APtHx1j8o76nRw6SIZUCXGvNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ly0t1MS4/AHH7UPM+wnhImzJvbHZMROuabv79AZ9ia99QWiDYcKc869bLL072lhCy
	 tD3UZUZ8LW9ESLmNA2fvQmqG4KhCwP3lqk2w+U6hab8vVBb58TwthzkvIDhEuQqhMG
	 zfn+tuSuvCjLTCFYwj+fJjNnJwjOknyIEDLjrKf0QNnnDLjunb/QPnbqfCqwpeTeSX
	 R+rPOSQfUXTVntTw3+5ytfINs+HCviXyLlKqgAlM3ICOmmFLuoWwaJLynUU39YLABK
	 QU666843eHrMgP2kC+xJGycPA//PfRwnAJ1b/Drke3/AQ04GWYB2iwNaf4zU/ASHTe
	 F+VxOCLel0uUQ==
Date: Thu, 5 Nov 2026 13:33:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Joshua Peisach <jpeisach@ubuntu.com>,
	Michael Reeves <michael.reeves077@gmail.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: pci: apple,pcie: Add compatibles for M3
 SoCs
Message-ID: <20261105193348.GA1552413@bhelgaas>
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
In-Reply-To: <20261105-apple-m3-pcie-v1-2-e00a72a604f8@jannau.net>

On Thu, Nov 05, 2026 at 12:35:59PM +0100, Janne Grunau wrote:
> The PCIe controller on Apple M3, M3 Pro, Max and Ultra SoCs are
> compatible with the one on M2 Pro and Max. Add their per SoC compatibles
> "apple,t8122-pcie" (M3), "apple,t6030-pcie" (M3 Pro) and
> "apple,t6031-pcie" (M3 Max/Ultra) to the bindings.

Subject line capitalization for *this* file hasn't been consistent,
but for Documentation/devicetree/bindings/pci/ as a whole, the
convention is "dt-bindings: PCI: ..."

Since these prefixes are so long, I would reorder "Add M3 SoC" to the
beginning.
