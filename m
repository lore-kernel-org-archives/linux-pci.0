Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6B441635;
	Wed, 29 Jul 2026 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318873; cv=none; b=A98W46XOJA/pwx8975s0zYmmcblUGKQfg2ClCXIJmzMl8oRTUNELtLruOTzCI0n7RcsIy7vORdTgB5ggjPpr/67/ouZ1PQBvOmBlhRrC/1JEA3HxEoSK2TYd/3OJQaed1XPETOwe2uHTG1WYe5RjAEGnPdmbq0ZznJK8yVajHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318873; c=relaxed/simple;
	bh=0p0OVf8eEBHecHovXZ3j4B0vNeuwTeVq7d3EyQB37E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uib15rUbCLHe4/+6q2+paIxtdVJcb2TVI1Ng8ak1KKxJfkPZl+VVo/dTUFGEdgtCucCNxDG9gcpNi13w2KtMDREQpgM7GcMWvOYgc/OExt5jeWQBaiSulSNziIVmatMEHhUvcYgnmYy6kQhJE39HedVugbLLT1Al7wgdpQjSVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJBovSoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJBovSoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B001F000E9;
	Wed, 29 Jul 2026 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785318871;
	bh=/m3EqjQj6dh7+d0yty3JfXEFXGnIOmp4aIhXtpHFn+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lJBovSoIXJ8AtGUmY18WXUfFEMtODh2dL2J2gnJJ79jFukasLla8XwOfVEBD8wpLf
	 Xtonpz4zNEAmlKtU6M98gCr2uEHPyvjgWmka6Yi4T9ZHfLpGsXjXPHC7SeNaIRG9yu
	 E0i6WSSux5sSuvOkmg1pm9W1NxHCD4ClNxCmQr1vN9t/Mdj9S8VnUs7Zte6GP4ryU9
	 LJHP1+eLYHGZv2RSLAKsSAtcfaMaURc26Ho0LTi0EZbXpXsqI+aqCtjsJllF8v+lju
	 2k+BS+/QGNWq+nJr/eJ4f5RHUv6PZzZo8PjvWkDBq1KECY6mQV3qXXBp+Bp0DEZQMi
	 HRKtSpna56PkA==
Message-ID: <2918ad67-7a78-4e47-824a-15500edeeff1@kernel.org>
Date: Wed, 29 Jul 2026 11:54:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB PCIe
 binding
To: Sai Krishna Musham <sai.krishna.musham@amd.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com,
 pranav.sanwal@amd.com
References: <20260728202044.1785986-1-sai.krishna.musham@amd.com>
 <20260728202044.1785986-2-sai.krishna.musham@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <20260728202044.1785986-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/07/2026 22:20, Sai Krishna Musham wrote:
> The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe IP.
> Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
> per-controller interrupt register region used by CPM6.
> 
> Update amd,versal2-mdb-host.yaml with separate register definitions:
> - MDB5: 4 regions (slcr, config, dbi, atu)
> - CPM6: 5 regions (slcr, config, dbi, atu, intr)
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v2:
> - Update the CPM6 device tree binding and example.
> 
> v1 https://lore.kernel.org/all/20260402180006.486229-2-sai.krishna.musham@amd.com/
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 111 ++++++++++++++++--
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
>  2 files changed, 102 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> index 406c15e1dee1..d22de24b41ca 100644
> --- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> @@ -12,24 +12,65 @@ maintainers:
>  allOf:
>    - $ref: /schemas/pci/pci-host-bridge.yaml#
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:

Move entire allOf to the end, after required: block.

> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,versal2-mdb-host
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: MDB System Level Control and Status Register (SLCR) Base
> +            - description: configuration region
> +            - description: data bus interface
> +            - description: address translation unit register
> +        reg-names:
> +          items:
> +            - const: slcr
> +            - const: config
> +            - const: dbi
> +            - const: atu
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amd,versal2-cpm6-host
> +              - amd,versal2-cpm6-host1
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          items:
> +            - description: MDB System Level Control and Status Register (SLCR) Base
> +            - description: configuration region
> +            - description: data bus interface
> +            - description: address translation unit register
> +            - description: CPM6 PCIe error and event interrupt registers
> +        reg-names:
> +          minItems: 4
> +          items:
> +            - const: slcr
> +            - const: config
> +            - const: dbi
> +            - const: atu
> +            - const: intr
>  
>  properties:
>    compatible:
> -    const: amd,versal2-mdb-host
> +    enum:
> +      - amd,versal2-mdb-host
> +      - amd,versal2-cpm6-host
> +      - amd,versal2-cpm6-host1
>  
>    reg:
> -    items:
> -      - description: MDB System Level Control and Status Register (SLCR) Base
> -      - description: configuration region
> -      - description: data bus interface
> -      - description: address translation unit register
> +    minItems: 4
> +    maxItems: 5
>  
>    reg-names:
> -    items:
> -      - const: slcr
> -      - const: config
> -      - const: dbi
> -      - const: atu

Leave the list and extend it.

> +    minItems: 4

You need only this.

> +    maxItems: 5
>  
>    ranges:
>      maxItems: 2
> @@ -141,3 +182,51 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie@fcdd0000 {
> +            compatible = "amd,versal2-cpm6-hos

You do not need new example for one new property.

Best regards,
Krzysztof
