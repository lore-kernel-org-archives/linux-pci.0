Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED99345757;
	Wed, 11 Mar 2026 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208351; cv=none; b=BhXzdH34Px7GXpfv8iNndbPvVGehkRgQ6Zy4VdGzIoKs+qwyuCBl7w2JQvRbjAZHLggS144+Ung/Bssel96xbZUlPnkLvnCKeItQJQQJupmikPHGTwpYHXFkyGZUgTFMjErNIKq0nrzahhNfqAe8zedecwFqOr+J+uqyDDnt+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208351; c=relaxed/simple;
	bh=BWHaQd6X/rtH2bI32zQwke/69AavzK5woTtHsoahkrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCaO8nFlx02Cg67ag76tcNQyr9DaxjJ0Sug9r9x/3qQbb0/zNeca7oeekTtv/bJ18nW0sdu6YEl5n6CakyIHUQTLXd71PqgNfCqFnaD9hr9xdurbIB/h68STjPI0PxYNT6xZYdP67BdGaubNcDOs/1Rxr8VklglYuV8IkJ2RTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofIF83yE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofIF83yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38128C4CEF7;
	Wed, 11 Mar 2026 05:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773208351;
	bh=BWHaQd6X/rtH2bI32zQwke/69AavzK5woTtHsoahkrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ofIF83yEjYLe+0ed/2I1e6ZwoWoIywD9XjwVJRlkZGjo+1Dt9YUUD4siSfFs/mThG
	 80fgvrXiF8ago5yXFzL/frRej37uCyLHMGfxKRvLJhCcyu/uT+DNXLVkUlqXbVEIB+
	 SA7uRh95mkiJVmzGfykg3IgGiV9PehRGeYNH4dZHUn8KoARV0EMfJLmWRrXXRUK1Ub
	 hjsI0/nZemIJwD9l2iRPCJLRCkncKlkwUGIclHgUKErG0RguRWIfkEk5SnduwiNSFd
	 MZKoS+RfE+YTvX6Q9A8McYmn2Xx5ZfTBshD9ueF9jGNW4wWGuFNcdDlCUGtZYND9BV
	 Fgi7eD4vGTgQg==
Message-ID: <168d4af2-5a5b-4564-9e53-fed9f0c062a2@kernel.org>
Date: Wed, 11 Mar 2026 06:52:26 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IFBD?=
 =?UTF-8?Q?I=3A_update_CIX_Sky1_PCIe_Root_Complex_bindings?=
To: Gary Yang <gary.yang@cixtech.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Peter Chen <peter.chen@cixtech.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
References: <20260310065338.2337761-1-gary.yang@cixtech.com>
 <20260310065338.2337761-2-gary.yang@cixtech.com>
 <841c0b46-76dc-49c2-bb74-7fc2e5a2a702@kernel.org>
 <PUZPR06MB5887D091B6CF979DFC46EECBEF47A@PUZPR06MB5887.apcprd06.prod.outlook.com>
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
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <PUZPR06MB5887D091B6CF979DFC46EECBEF47A@PUZPR06MB5887.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2026 03:31, Gary Yang wrote:
> Hi Krzysztof:
> 
> Thanks for your comments
> 
>> EXTERNAL EMAIL
>>
>> On 10/03/2026 07:53, Gary Yang wrote:
>>> add power-domains and power-domain-names property
>>
>> Why? Please write complete sentences explaining why you are doing this.
>>
> 
> Sorry, I did not describe in detail.
> 
> The Sky1 PCIe controller sits in a power domain that must be enabled before the controller can be accessed.
> Describe the power-domains property so that DTS files can reference the correct power domain provider.
> 
>>>
>>> Signed-off-by: Gary Yang <gary.yang@cixtech.com>
>>> ---
>>>  .../devicetree/bindings/pci/cix,sky1-pcie-host.yaml         | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>> b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>> index b910a42e0843..1d8ee8310588 100644
>>> --- a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>>> @@ -38,6 +38,12 @@ properties:
>>>    ranges:
>>>      maxItems: 3
>>>
>>> +  power-domains:
>>> +    minItems: 1
>>> +
>>> +  power-domain-names:
>>> +    minItems: 1
>>
>> There is no such syntax. Open any existing bindinh.
>>
> 
> Sorry, They come from Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml

There is no such syntax there.

Just open the file.


> 
> Execute the two commands below before submit patch every time.
> 
> make O=$OUTKNL dt_binding_check
> make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=cix,sky1-pcie-host.yaml
> 
> we don't find any warning or error. So we think all is ok.

No, because there is no such code nowhere. Please take other bindings as
an example. You miss here maxItems.

Best regards,
Krzysztof
