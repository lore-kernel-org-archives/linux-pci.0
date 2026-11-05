Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903063;
	b=JbaKR1OmHvLzkGn7D0/WNp01jBRsZKEfspnPzIg/J5hKhALwj0g2jvYzABztXPZ8nBN0
	 RWYIl/y7PDGoLIXryAf2EYYG015YCsmyBuunh+vNlDciRo3F2EAAnLaR0TWs48GGh4ISn
	 AsaWdswZzkPmfon+QhwvwyDrDHP+fMxltOGWPh/5lBKKNVGqmmAVWq86TgUfYDA4MGRzH
	 CFxZHNWt1vrgFn55CL8r+2m60McO+BTzVpEbSqTRXpKcew7OuEjQvPXd6pt9mkFJ1EnDL
	 stv79qscxiGvX9MbmnNsM0LLkQyGOLrcxcZt4Uefh7ulWS5zSB2/OKs6s5qb7yukDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903063;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cjUElBqzPluT7QSjt/7lModkJ2Ig4dFvcYSz+eg2RbU=;
	b=E3RnQFP4bUzfUvnqUkxlkVR6EtOp2ZRmOC1tK6dIpQMz6dV69B7whBU0UyJrzOiV+Iot
	 8Kc2XyzzrbBCoFx2q9lvr7RT7Uef75JzeVFSUtvH6qJR5WzToM87GZcATh/MoOfwMIGIk
	 fx+M9KnPEOBGuiwffUDVAZnUNjOp/gRI4pdqbvQ2KzX+2bUitg6WTuU0JUo8JwSh3hgoT
	 OqY9hY8vvRsNZAKdNV2wUGKOqvtmwBQzcN0M5KASkW4b3cfaoJSf8G1Bk7q41Lxb2EyZQ
	 tlnt9OIyK67Z/ng2PSMM8gymKl1MGQHpe9DiNe7zLNXp9If6ViHLjZ5wfoKW0NpJMeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD2aCl8r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F67606A31B;
	Thu,  5 Nov 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD2aCl8r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C4E1F00919;
	Thu,  5 Nov 2026 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903063;
	bh=cjUElBqzPluT7QSjt/7lModkJ2Ig4dFvcYSz+eg2RbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BD2aCl8ryPB4H4ifilP0HoKNxJrE3LkzDcHnc1GOhqqO09ag549Bc6WQDr5ixwtS8
	 zkyMJkM9JwQ62U/YHXrczFfQ6L0mWX5u67BFPPe2elik8/x/0otCRECNlx6FLnOJtw
	 GQ6eUI8iYMkN+re4rVqNG2LZ9wnG1lWgTK4Q2EuGFc/P2poedu5vTRLq8XNFK2U0yR
	 4XTrfa2AKVSgz7Cx0/OqJqptghvWSLDYxND7Of6dlboNOaRVRgPGu1knF54Ykc7sh/
	 tuuVC+LvthIg1J11BJp5xuGAYjDxPNnTsHT3UpynFhly7WBkbWugbX4l1ZR5mT/E32
	 051o+m+YKGn+g==
Message-ID: <b865a3ef-3a69-4bc0-be25-29d3ddfb3385@kernel.org>
Date: Thu, 5 Nov 2026 19:24:15 +0100
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
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: rockchip,rk3399-pcie: Add PERST#
 inactive delay properties
To: =?UTF-8?Q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, bhelgaas@google.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, dlemoal@kernel.org, iav@iav.lv,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261104215848.2087944-1-ehbello@gmail.com>
 <20261104215848.2087944-2-ehbello@gmail.com>
 <20261105-exuberant-finch-of-domination-3fbd6c@quoll>
 <20261105174042.2307139-1-ehbello@gmail.com>
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
In-Reply-To: <20261105174042.2307139-1-ehbello@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/11/2026 18:40, Enrique Hernández Bello wrote:
> On Thu, Nov 05, 2026, Krzysztof Kozlowski wrote:
>> Vendor driver does not matter, it is antipattern. Do not mention it here
>> as reason to do such change.
>>
>> No need to repeat the diff.
> 
> Understood, both go in the next version.
> 
>> us or ms?
> 
> ms. The 0 case is badly worded: the driver never holds PERST# for less
> than 100 us, whatever the value, and 0 just ends up at that floor. I will
> describe the floor instead of giving 0 a meaning of its own.
> 
>> What is the nature of this timing? 100 ms is a lot. Are you sure you are
>> not describing RC delay (we have bindings for that already)
> 
> The 100 ms is not something the board needs. It is the driver's current
> wait, T_PVPERL from the CEM spec, applied on every board. Because PERST#
> is already asserted when that wait starts, it is also the width of the
> reset pulse.
> 
> On my board (ROCK Pi 4C) the slot supply is regulator-always-on, so power
> has been stable for seconds before probe and there is nothing left to
> settle. The problem goes the other way: the JMB585 behind it stops

So maybe that's JMB585 issue? Arguments so far are rather against
controller-based property.

> answering configuration reads when it is held in reset that long. A wait
> of 0 to 15 ms enumerated 17 times out of 17, 20 ms once out of 3, and
> 100 ms never in 5. So the board needs a shorter value, not a longer one.
> I do not know why this endpoint behaves this way.
> 
> Which binding did you have in mind for the RC delay? If an existing one
> fits, I would rather use it.

The RC delay binding, gpio-delay.

> 
> I also plan to drop rockchip,s2r-perst-inactive-ms, since it describes
> an OS power state rather than the hardware.
> 
> Thanks,
> Enrique


Best regards,
Krzysztof
