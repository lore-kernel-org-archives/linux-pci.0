Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119504;
	b=KsOTeeJi/lnOb1dNc4+XOtNSHYeawhPXgfYMmlSF9g68H878/sjyvgZ9ME+ftqhGZmsK
	 ASFIG/tuYz3m6k+wIQGgwvs0TdrV3LH6WrInirZYNodrZDZ6Hl71D8H5oFu9o4+BJvBJy
	 1AN3miCC7kC1yoBcCxl7jLg2Fz6YLX0fXsKcvn1/7SN2qqex5s5KIdbtP2FU44VItZAEL
	 0p9x50BMcbqVWM7XnicteV4FtowvHU1/ejDLdPz4qNuMtb3565yX1UB7ayvvPYEzrUAE+
	 i26K1XAPa0DH8pynyqZ19rwm9N2ObQdYdyYOoDRoKhuzAZ5adoYsT7W3LOwUGM1ELSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119504;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LfCHc2ZbEycHiXtDTzq0f5FcMJE5iktQ7uX6vShIlIo=;
	b=mapzkGvZeeyA6WexuZ9xHpfQY4o2UuEaSgNZ9hr47RuOhS9YinVpTxe2E5d9GyC9X3Ar
	 Kj/to/+ROwtUAIsJWDO3bxrRKLvy0uXmUQrXJjeA4NOaE7ttwwI2dyPSL7QuFhM1PFBGe
	 Q6xk3TxuNFOqL3fVLxxw48t5z8fwGtKqYoPlGa5C56pdl+4cqUa/ZQ4s16hZPafDx14fY
	 S/cRqg1HV+iYLrX89JFYN3gKO6Q9QoJC3V0PIA+j5YfnscPK15eXw3ZI0XdP5cZhGwt3X
	 tgoNsw6YhN/9i6DPhJ3JBs1zYTvor2DGb8+TNnX2KU35wzz93GeX+xDcHMzgflWw+yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTLd7llr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426C606A332;
	Thu, 19 Nov 2026 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTLd7llr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE8E1F00A36;
	Thu, 19 Nov 2026 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119503;
	bh=LfCHc2ZbEycHiXtDTzq0f5FcMJE5iktQ7uX6vShIlIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KTLd7llreHlhGpU7HaXjheT0KFke8eL5BpCE5GNBIYk8E5WmDkS5R8Sz7W5bg6CuQ
	 UaWPlEj1a7zW6Y7i9mTHeM12rRP57E51IRgVFTdCb/hZrWrRK14H0BZqom54TnMV71
	 dFiZDmRkusewWIhfyKu4dDbB0gQwNYZZf87mccpHu5TBc7htSfBuO9v5eFVUYghvw3
	 41Cu2YktQvQmzq6JUZhOVmwA1ldCMLjDTmBxwHUp48UKjaLCSRoo20AqWr66PjUjUF
	 JIIl0MCRlIRxSUGht+crUTms1Mrlsi/HsP24eiIAMyqHkEUc8PMr++KRy93nPpjRnL
	 BiFDk8RNU6yaw==
Date: Thu, 19 Nov 2026 14:18:17 -0600
From: Rob Herring <robh@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: tegra264: Allow the ats-supported
 property
Message-ID: <20261119201817.GA119016-robh@kernel.org>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-1-4d843dda0b02@nvidia.com>
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
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-1-4d843dda0b02@nvidia.com>

On Thu, Oct 29, 2026 at 12:32:03PM +0900, Mikko Perttunen wrote:
> The C0 controller on Tegra264 is connected to the integrated GPU, which
> issues ATS requests. Add the ats-supported property to allow marking
> ATS as supported on the controller.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> index f0114defc04e..3b4f31a4a4c2 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> @@ -34,6 +34,11 @@ properties:
>  
>    dma-coherent: true
>  
> +  ats-supported:
> +    description:
> +      Indicates that the controller supports ATS.
> +    type: boolean

2 users of this now. This needs to be moved into pci-host-bridge.yaml.

> +
>    nvidia,bpmp:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: |
> 
> -- 
> 2.55.0
> 
