Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382273;
	b=hDNIyt1wekP/mRl4VB+6Er7n3OpHcNQQCXAyHyLvyFIuTyHZrW7K4mIvMzlhoBR/HCPH
	 Sg9ix3ztIyrGdb1Y1DvDGyeLmoW/WcLt8/x2PSrIxAB/gSfaqP056ehBhH2ZDaWfzDqkN
	 /dvCgz9JYLXKZ6KvuMoWYwf37VuqsxIVk46eVp/7Z26bAq9ptLo2uhYdouxJ5YW8vLrV9
	 eyrpMeJD080OTM96OkHiV8ngNzwRcTBnui6X5wcFo/fC9q0plAh4yDevtwQQUStwb13xn
	 RX4KRwlRIwFMjXxhD1X4kka3bFxz8Debg9kKiyFCIgX9nFvdWtl8KjMzUdbI2obkm+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382273;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xrEE7uTmE323wt6HSZxT7qh5jw1HK88kniIP1r/imqM=;
	b=r4zEZFpG1jC7BDdWZ5lS3GjtCiKdyP5zmihIwhkYRHIK3oKUIxaUsClOxI/8MUS8MXxG
	 Lon1izl4hFkn6eJHKHgf+VlLdPw2WmiL7zQcI//eNOYazJTk6jmHu+WaoPY2KJiE9JgcE
	 83ls6y9gTwevgsNCUIywC2WB93MbPAiAz9HqGKsTv7n/GrGIRZ3zmuLzPBIcPCd5f3c8T
	 yS1A4w6PSBQgizyc1s4XcVkjzZqgPes4wjJhZDFXeUjOGdud6w3gXxJoYlfceCx9KvEnc
	 vuxAsJRIy+HTvi7LNJZCEH2DMFiCnnBi0FibXqlBCC1SLzGoB0Soj+jTMTzzboaE/Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJyVuyT3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E391606A31E;
	Fri, 30 Oct 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJyVuyT3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CCC1F0093A;
	Fri, 30 Oct 2026 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382272;
	bh=xrEE7uTmE323wt6HSZxT7qh5jw1HK88kniIP1r/imqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJyVuyT3frZxoZt8DsS9qmuxYhZmdpXR208K3rJobCxgALwUFDIb/K3JJq14yIdeu
	 1GZ1iXnxsqwvuXV0+4ZGdnbddglhdhcyY3vdFsnv6ckzU6LUiXwfMoY7qz+b+rLzbo
	 SlHOiAACgE2FX0Kgwm3T7OQx2VYV1tl4YjPemqhWl4b7leHRRfq+JPTcR5vwexG5Yj
	 +CWP9MMg38MkceRLa1dup9oh4i5PPHCo8NKzM81azrrdi67aHFfNr5MRKm5oLRxJdZ
	 kdpX52QJjOeI5F5pItbWgaF9I/1wubkACHZBBzEtqdjXAqhZHCur2feNn0xsg9BrZG
	 g/ST2UKZdNNNA==
Date: Fri, 30 Oct 2026 12:44:29 -0500
From: Rob Herring <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 B connector
Message-ID: <20261030174429.GA781972-robh@kernel.org>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
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
In-Reply-To: <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>

On Wed, Oct 21, 2026 at 07:21:22PM +0530, Krishna Chaitanya Chundru wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> connector is used to attach WWAN Adapters to the host machine over
> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
> Adapter's configuration pins.
> 
> The connector provides a primary power supply of 3.3V/VBAT, along with
> optional GPIO signals for WWAN-specific power/radio control:
> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_ON_WWAN#, and DPR.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 147 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
> new file mode 100644
> index 000000000000..a7f4bcbc5119
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key B Connector
> +
> +maintainers:
> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
> +  connector. Mechanical Key B connectors are used to connect WWAN devices to
> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
> +  selected by the Adapter's configuration pins.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-b-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for the 3.3v/VBAT supply.
> +
> +  full-card-power-off-gpios:
> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal is
> +      used by the host system to turn off the entire Adapter. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO output to RESET# signal. This signal is used by the
> +      host system to place the WWAN Adapter into a power-on reset condition.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
> +      details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO output to W_DISABLE1# signal. This signal is used by
> +      the host system to disable the WWAN radio on the Adapter. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  w-disable2-gpios:
> +    description: GPIO output to W_DISABLE2# signal (default function of
> +      GPIO_10). This signal is used by the host system to disable a second
> +      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0,
> +      sec 3.1.12.3 for more details.
> +    maxItems: 1

On the pinouts I find, I only see 0 or 1 w_disable.

> +
> +  wowwan-gpios:
> +    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Adapter
> +      asserts this signal to wake up the host system. Refer, PCI Express M.2
> +      Specification r4.0, sec 3.2.13.3.6 for more details.
> +    maxItems: 1

Don't see this on any of them. There is an ALERT# signal.

> +
> +  dpr-gpios:
> +    description: GPIO output to the Dynamic Power Reduction (DPR) signal.
> +      This signal is provided by a host system proximity sensor to the
> +      Adapter to trigger a reduction in the radio transmit output power to
> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specification
> +      r4.0, sec 3.2.13.4 for more details.
> +    maxItems: 1
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> +      more details.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Since a single connector can have multiple interfaces, every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCIe interface for WWAN
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: SSIC interface for WWAN
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB 2.0 interface for WWAN
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB3.1 Gen1 interface for WWAN

Port nodes are generally independent. Endpoints are muxed connections. 
As SSIC and USB3 are the same pins, they should be the same port. You 
could use endpoint numbering to define SSIC vs. USB3.

Rob
