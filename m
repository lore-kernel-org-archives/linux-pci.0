Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341195;
	b=ZkyVV8/s2heQs4NeFGz/wUT4/EtxGkhz6geJdVBrsn+MQQLbTZPnJg0V5OMCeO8DGKkr
	 STD3Q3GhpbRNQYLS1z8gLRo8QVu33Rzt3b+YoGXGDaX/I1Lz25G5idYDsRlfaOopfAgTy
	 hJO1Mp2LDiam08VMx99GvIOEGFrgMnr69wAspfrk2ddgqhViY14pQNRqsJSM70ozVpgzg
	 zUPzB0+Cawgl3s9RmUqQijN7ONN0UcQGtqi9yznnOHbRcSZYvSfhooGwZIDVaGDn3MVcr
	 x7VlSj+H8VeHu9Uy7UccJiVDNems8pr7ueztOFJND+ZRD3/BaW6q2Hx70jaLUoTS0dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341195;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=efMbBQpSE7PY6ajwU86PUaHLoc8raeHWwmeeNwcIfd0=;
	b=Wp29mjvhNuEnr3EFgXJZDjkwWWdutTZitGlBQgyWzuP7aU5QnhXrxC2AtHKReIp1L86E
	 +xEJd5Hcp2xArpFZBZ8RXjL4zrO1fIoAyp48GSdE+owldE6D3kTOKme1NBIeIBxiulj02
	 MhhRqN80X62aE1+ZVitol+HQk73UU5FoFBFQ28Or7J415YLnTZokgDV0GpBnFGpT+pJZq
	 yv2xE2xdlhxMi/a4aiBi2LKTHwXJTFXG/qmzCne3AQNUyAiNGVgLcmFKYMcPiLYsuNwXo
	 51ktDLyRyUfX/E12YY6EO3jLtVuA63cd0OAWVLbzW266VD38ON3sn19VfFDZU/lGYyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USwnmPZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1C606A320;
	Tue, 10 Nov 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USwnmPZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8661F0089F;
	Tue, 10 Nov 2026 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341194;
	bh=efMbBQpSE7PY6ajwU86PUaHLoc8raeHWwmeeNwcIfd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=USwnmPZm3DY7fxFB3PkAgP5UMifgYLDzbFk9wRj73iKSymrIZv6CJRzaRbOoM5kye
	 V2yqKoXdePDRo2XDnYXKptQx5jbzyaxl6n/duMvjfOm9rWuuA9JjIDHMGexWuHLMjX
	 m5Lq6uQAnF3baee3tby+U6ta8TU767lXhaGM8DAhec080SS0dXcVdpAjXEpP+9G5k0
	 gJvaSjUdCUOuk2SB/lwDmGG3lM8KpLoQVqjdQBmA5t0Zs/l2soVC+kQcGFsivsrRmK
	 19UVYSRadBzB3wgUuNNdmM4geeRdKg5lxKqLtQGmR6jfq9Oxh+yCT7kPXMRhf6RZfa
	 vSmi4GCSfCT8w==
Message-ID: <47e6cb2d-f84c-4aef-b658-7dac5e046434@kernel.org>
Date: Tue, 10 Nov 2026 14:06:30 -0600
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
Subject: Re: [PATCH v5 00/14] PCI: Resource placement algorithm fixes
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Mesih Kilinc <Mesih.Kilinc@sony.com>, LKML <linux-kernel@vger.kernel.org>
References: <20261109232700.GA345907@bhelgaas>
 <f37d6958-086b-0006-8fbc-c4c15369b796@linux.intel.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <f37d6958-086b-0006-8fbc-c4c15369b796@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> The regression is the same genoa iomem blackhole we discussed in the v3
> thread:
> 
> https://lore.kernel.org/linux-pci/20261013130948.6231-9-ilpo.jarvinen@linux.intel.com
> /
> 
> There were multiple possible possible ways to quirk this and it comes down
> to which one you (Bjorn) prefer. I just left my quirk patch out of these
> v4 and v5 series because it seemed the least likely to be the one taken.
> 
> If you want me to test a specific quirk approach on the affected system,
> just let me know. I already did test reverting your change that freed the
> e820 reserved regions for iomem use and that did prevent the regression.
> 

Yeah with any luck our best bet for everyone is reverting commit 
07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").

> 
> (I now seem to realize I forgot to include Mario while sending v5. I've
> added him to this now.)
> 
> Mario was willing to pursue contacting the reporters of the earlier
> problems with a pre-prepared branch to test to see if my placement series
> could resolve the issues reported (earlier). Depending the results of that
> test, we might have yet another way to quirk it.
> 
> Mario,
> 
> There were quite many changes in v5 so I'd prefer the test branch using
> v5.
> 

Done!

https://lore.kernel.org/linux-pci/20261110-superm1-genoa-mess-v1-0-bdcb3a6f2463@kernel.org/
