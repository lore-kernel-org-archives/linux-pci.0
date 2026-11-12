Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507820;
	b=kArUMyC3A8o6LyaxTn5CSXpxi4jf5uW7JvZR0HPN1rPbvsXxm0ijvIIRcJnRMiSuGlSE
	 tgQf0dX9aBRX8r7SIYMQDTHYSZ0tBIABeRXldaACR+WPP4rjBXpoa1bFQmzVDh0YMHeuP
	 ncXsxKU1Gas0LVLrxj2c8cbqj4s3P3psePyxvd3JGNUmgRbFAtzKOC7JDI8VUgHwAvJoI
	 k/Lzd4fR5SHQMxrdLdkMn1ISDViMEUBGpY4zwCnIQu4RrgaD02UVC+nyrgYJc0goZW1WI
	 ZIP3LY2+rRRm0z7Lff+CtYQkaEzflMiGopO940bqiUTBzrgRRT/aWE20v9LZRmSg6RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507820;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/ugvi3p+1Q6B+bFi2vdXrchwTSTW2J4vItqHqbpYTlc=;
	b=Frzwo7SBQiBceoZ2dv++FYuY+PwPMJ9lj1fcmUEu9tfqIKQeS0CjbFPjeWL02++t+Win
	 22t6h3T8fDV8QZZj9YrRnHvUiUNq7pxbZFvY1xIVxQLiKR+L8Gj9ONve2bRBEJ7ZP+11o
	 po4FHfe9EyA+K18n8VPSZwpIQvgLf9lboR/2OE4Bbkxb5xBR0tNoMSqU7EBIj4JCTi31o
	 OW6u13t4reiQl60r2xrlgXisLmV3TFAJaJJ1ZnMPvPxnmX9eUSDprt8n6tA/4+wxV27zt
	 rfcErEcd8SbyUjZJcf5SbDYlIwAAaLU1WN4S9vhrA6JJiXWl3DxuPvI87MYJcVXJ3lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3AvEEug;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD71606A323;
	Thu, 12 Nov 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3AvEEug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922591F000C4;
	Thu, 12 Nov 2026 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794507820;
	bh=/ugvi3p+1Q6B+bFi2vdXrchwTSTW2J4vItqHqbpYTlc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=o3AvEEugDRMSiPEcsyV4fok2MwtaQixS9AaTOx7tzHoOVPMKZIwlORX6dUPo88Yz3
	 4SBv0/LGuaYRuqtecNQ9/hz49qrx2n+6kda41NGQINKPa95O22rKIQdt1cIiokOhv3
	 A34nHZtbkvpWE5zuBj4qDtP4fzSDqK4Vsa7vk869JIMZ+566oy/UhknDlxv8R7K+Mj
	 m8o0JC7JoWb8nTl9fJz1orlyt5WsSFys2JdLdZcNvL4ASAlC8LZ+nEFYdA0XEVkMIZ
	 XABg9PhhU7xdZOYkMF92c51msDP4118pa+n8+CWtOiL+lHlNu6QkMj3cf+WvxHHimm
	 cdsZozxw8KdDQ==
Message-ID: <389eac39-87ea-44a3-b0bd-1e097ebf4206@kernel.org>
Date: Thu, 12 Nov 2026 20:23:34 +0200
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
 <atphAmy8ZIjY_JNC@ninjato> <f1df2818-be5c-4019-a86f-4e782a70d3fb@kernel.org>
 <avOBDu8XaZ-kZIsF@ninjato> <85acc16c-01e7-46a4-af68-3d6f24fe90c1@kernel.org>
 <avS4cLVpkXI-Lf0A@ninjato>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <avS4cLVpkXI-Lf0A@ninjato>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 11/11/26 20:48, Wolfram Sang wrote:
> Hi Claudiu,
> 
> thanks for the explanation!
> 
>> E.g.: if you keep the ASPM policy to default and generate a link up/down
>> event that will not be seen by Linux. A subsequent lspci will trigger it.
> 
> Well, 'lspci' does not trigger it (at least the busybox version I am
> using). 

I'm using Yocto version.

> But setting the policy to 'performance' does. Then, the 'link
> down' event gets recognized late. I'd think this also proves your
> theory?

Yes!

Thank you for you testing,
Claudiu
