Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795883359;
	b=R1rKyoGH7/lyAAVcYYQhCZYfTH68EaxA6/NxPUE9t2AxSJpBhYmG9Dd6V4CyClWFS7Z0
	 M/n5fTfFCoOJODsb68wy6xVoFLp2FimJmYJ7cS+s42ka43Cn82HUbGG02383kjTRVcNdj
	 vWluOQXYUNUldIrndA81Fk1QRHkf5WGmEwhFyjVDOA6iggGn5lDlYMStrj9+6IK1FbYmh
	 jm18ElkUf+3Xg1Yq45/WiBGj40Ri3q1dR9avYCS57qSGyJ0jsZYe7uSOqLsNe83QOLBzs
	 Z/4zWPSE6MohnFw3krHGFSuE0ShWXtFEjhjDWKKXjJHNiik5GUVJsNTIIOnV3iF7C1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795883359;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=2nVetIzd9bhuIAK0xKb7wKtyE5x+BX0/IoAOasfKqZI=;
	b=4fRO63O73vl8PK9svxisRYDnKu0DXrivF04ET4/xDtbRfAFiOih5lMHhxYKHsq48mjkY
	 v8xWeNYs+2RX9rZte1+aln/vvKk9fCeEYWRS/HGw024ZLa6SfHccOXu/vmuoqii7w+hKj
	 U1F+3lutmX9xWFn+x+vLqlcvk4D2bAzdwAMvp/vB8VeBZMqwF/SshwE9M3kyqz6Ad7Wvr
	 X1x4u8dABQrZeaDUkC2mPhl7qogOEiT3KTS29RZn3l2g4gAXLr83JTkxuk7G1Zh/qieWB
	 28DokHivyD3ypfddGJhtkoHeLAnrdzQmvF2kFZSRl9ry9+f25SbzbeazgnuQsjQLVsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2xIsM3c0;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9D606A33D;
	Sat, 28 Nov 2026 16:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22F9D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2xIsM3c0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2nVetIzd9bhuIAK0xKb7wKtyE5x+BX0/IoAOasfKqZI=; b=2xIsM3c0aPAO2Aynw4taBvTO26
	Hfl7HIOSyCfa0HcWhzi3IYqY+4hyn9VTWCsJQ5drZhorFhCQAS0HefiNpNDKUtS0rCTyL0u6Hp1sN
	Mn5IZ7tDDU7UcbunUmREER+S31cqZ+tZ6yEO0L798lRvn/fQl/INtwwpy1DVd8sCuVzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xXLIJ-0020Qr-TY; Sat, 28 Nov 2026 17:28:59 +0100
Date: Sat, 28 Nov 2026 17:28:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hans Zhang <18255117159@163.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, bhelgaas@google.com,
	mani@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCIe host controller async probe vs PHY request_module
 deadlock
Message-ID: <2d798e7d-5e49-4a37-ab9b-a0d596d4d50c@lunn.ch>
References: <20261127074329.747914-1-18255117159@163.com>
 <00ca72a9-ff50-4842-8aa9-d68416212e8b@163.com>
 <582bbeb8-13ec-4533-92d4-7216c20fb78f@lunn.ch>
 <c09512dc-b926-48b6-99eb-d7ba13cc276b@163.com>
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
In-Reply-To: <c09512dc-b926-48b6-99eb-d7ba13cc276b@163.com>

> Hello Andrew,
> 
> 
> Would you have time to review the previous discussion? Additionally, I will
> continue to conduct tests based on your previous reply.
> 
> https://lore.kernel.org/driver-core/DGZJBMG2Y738.2MU5LXVGEDD47@kernel.org/

That discussion seems to stop without coming to a conclusion. And i
don't remember anybody coming to the phylib Maintainers to say there
was a problem, ask for changes, etc.

    Andrew
