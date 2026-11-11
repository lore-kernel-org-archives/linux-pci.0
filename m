Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405328;
	b=QRHXBbVls+nzLZOQ7ScMf6TEM7K9zxy9Srcl5KdDmbRmphgRVbF3T/Uo3PXqlV7MfFsG
	 NIzP3/GtzJW72niFhBeazBsJMPM5KiROmdEnvSiP6GiXtXs+npRMday4lh+KqcAcJdkKI
	 jLIOpDVSq3zcP6MTsNQbmR9qavVlh6Npw9ffhDhhSxdmbdpZ6cS3lklA6flUcxNyhonH3
	 c4OWhdP2X6cD4+K9wMey5GsYXnk5hlqtE6yz88HI2GFLdUqlJ29AjaO2lWeHrR8H+prIm
	 LY/aS7z1/8MQ1ZxRAquvpRCFsUdDRX78R52Ya6loqt0ITiclQ+ISDyhoBvngAPP3FVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405328;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ddCUeiN3E1ZZymg8J04D9Ehoo5C6Buvuv4KFxnyLfl0=;
	b=uXWt/EGQabiASaCw88H9CEH0qy/TKdatnUzgJDp11NiLZ/lApp7xbYwyItx/oIDqWdyX
	 eyyeVyIn64ZMgNO4elegoIMhgMH94xrnn1W2sDKLGaGEeyJeADAaZVCm21HFPGVIzlNPX
	 hP1Q6oPlGxBQcN4XsPxyZZvUtetdHxOAB/Oo7CGqYbiuhcPKbX9asJ9MndJ8c1hMRf8Pg
	 dA68jEFDo+D5x1k6WoheFtxmUyDYbqibJIJ5fpQypw/3y6bZ98HLSsLhKqnL6ZTnM/8gA
	 /UuMaMDrAAWc0SMb6MTo26yYw60oAHfAXt3KwqRr7Uiut8XtB+SkvMBzn7KUR60lEHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H01VzIsw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906E606A31C;
	Wed, 11 Nov 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H01VzIsw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7194D1F00A06;
	Wed, 11 Nov 2026 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405327;
	bh=ddCUeiN3E1ZZymg8J04D9Ehoo5C6Buvuv4KFxnyLfl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H01VzIswK3JJSNRKc+p58OHa2otZ/NkOzlEw537v4yIRU6L3mh4GwYplZ+QrHn9q8
	 AcQm9Fj74s9B1s2NmzWraQbZyTNa/6ySuWu6CuqetG03q/8jp83/AhgFH3aCGOpMjI
	 rzqwz0H1Y2vnN+JnuVfngMJVfMRvbVN5BjQifdQwfGCWm+POzZwqBvT4aLe3y+rX+p
	 cn99+YqsEGcbi3ioJgjSwFqrx956J9X4JQp0+SKlX1I2SUFS0AelXPjtO0OCEEaf+Z
	 Z6FVZjYFGftSMkX8QFB9IEaywrwW7oBHdfXc2/vEjdmY94UdSn9zt+drHrdkyGivE/
	 LjuEqrzdYMPkQ==
Message-ID: <85acc16c-01e7-46a4-af68-3d6f24fe90c1@kernel.org>
Date: Wed, 11 Nov 2026 15:55:21 +0200
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
 <avOBDu8XaZ-kZIsF@ninjato>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <avOBDu8XaZ-kZIsF@ninjato>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 11/10/26 22:39, Wolfram Sang wrote:
> Hi Claudiu,
> 
> finally, I got around to it...

Thank you for checking this.

> 
>> I currently can't reproduce this on my side. Do you remember if you executed
>> the below command before your test:
>>
>> echo performance > /sys/module/pcie_aspm/parameters/policy
> 
> No, I did not and it makes a difference. With the command above, removal
> also works fine. But leaving it and letting the policy stay "default",
> removal doesn't work. I don't even see this line:
> 
> pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> 
> Is this expected? I'd think "default" should work as well?

What I suspect happens in this particular case is that due to the PCIe link 
being in a power saving state (when ASPM policy is default), and since the RC 
don't have native hotplug support, the RC is unable to see something happened 
with the link and to trigger the link event IRQ. Any subsequent operation that
gets the link out of a power saving mode should  make the HW aware of something 
happened at the link level and trigger the link event IRQ as well.

E.g.: if you keep the ASPM policy to default and generate a link up/down event 
that will not be seen by Linux. A subsequent lspci will trigger it. Steps to 
check this:

1/ Make sure the link up
2/ echo default > /sys/module/pcie_aspm/parameters/policy
3/ trigger link down; at this point Linux should see nothing
4/ run lspci; at this point link IRQ will be generated and Linux will take the
    action to remove the PCIe devices

Thank you,
Claudiu
