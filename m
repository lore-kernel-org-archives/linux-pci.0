Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175633438F;
	Wed, 10 Jun 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083729; cv=none; b=uOoh5u7fdmiZv4cVJwvz/egQldzZUw8qXb2zOxC1ixWQbuoqUAPnK+X8XxMQ2WyPo4BTL5ce3EYYqK0sOcHMjVVAhZrH5eB60ipZH4kVCpLNVWm50jArAHoWFjw5aXQYt65QIDmGFfYL06FO0QnXRiwrw8yJKrk2cW6wlpOGg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083729; c=relaxed/simple;
	bh=lwH4ZfrUxirKaBBeG24NcNOxwXVFZDIxg2Ure2KWCW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npcPJciEROc/mPJLjiyljEqTHKEc399KAUHxTUwiKzmjEXQLnwk6i/FcYvgewVS5wBJF5kwSfKvCY4BXv5ga+/48cBy8CicnohyfTasJXiESQgrbCE3+4Q+Iu79zl03Og8sKhc8a4K06VbmGS/SmJu19oqXBArx1o32LFmJIofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VChNE68i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VChNE68i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A021F00893;
	Wed, 10 Jun 2026 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781083727;
	bh=WZrxmTMENGKmsKf33gp0XWxjNcKEiwhVqt+tFHKcI4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VChNE68i9UsIZCwss5eZHoy6gOmeWDyM9xS3xoD1tjxYwUDJqrKNnpGXdaUBk0seE
	 e1lOqYhqSpNQ4o98X5yLxpx5p5Jm1g4cbjYRTp4cbQFUbQrp7p73JuMS5M+4NDDRWS
	 uRMZ8zEQwDav0mfJyXZAVvyTbE3yGenVnEELKjMGw7ZIP1BZrmCgia0ZyFHv5wg8ZM
	 b017KBl7lGo6j2Dso6W4yDo1sRGwEdSdZBgz7j3f13p7ed5HXnNuPzeiqMbHh9zycE
	 blMAk3VrfcpG6O1jMj7QxxpqI9MGlqmWU5piTi8G6UTgekS4FZ25EpY+kwOSA8BvZS
	 i+1YwZSLNX0wA==
Date: Wed, 10 Jun 2026 11:28:40 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"manivannan.sadhasivam@oss.qualcomm.com" <manivannan.sadhasivam@oss.qualcomm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Message-ID: <mvxoynvocxcalxcwogbiovg5yurjczxqfu2fqkji33bunmlplz@zxqjsdjts65j>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Wed, Jun 10, 2026 at 08:40:54AM +0000, Sherry Sun wrote:
> > On Tue, Jun 09, 2026 at 03:44:08AM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> > > - [Medium] The `vpcie3v3aux-supply` property describes a non-existent
> > hardware feature on the M.2 Key E connector to work around a software
> > policy.
> > 
> > Feels valid. Describe which pin on M2 connector are you representing.
> > 
> 
> Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
> Grounds.
> 
> PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
> source, 3.3 V, is expected to be available during the system’s
> stand-by/suspend state to support wake event processing on the
> communications card.
> 
> But the current vpcie3v3-supply may be gated off during system suspend.
> So I  tried to add vpcie3v3aux-supply to let this 3.3 V power source
> always on for PCIe M.2 Key E connector. That means vpcie3v3aux-supply
> and vpcie3v3-supply actually refer to the same 3.3 V power source.
> 
> @Mani, do you think this is reasonable? Or do you have any other better
> solutions? Thanks!
> 

There is no Vaux defined in the M.2 spec. So you cannot define that supply in
the binding. You can define the custom Vaux supply as a fixed regulator in DT
and mark it always on so that it is keeps supplying 3.3v to the card.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
