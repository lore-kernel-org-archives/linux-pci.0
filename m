Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763362;
	b=wD+Tvnmp+O6ll0cUOyAlTDxoAhOgH34JX6USSoMVd1X4kcl/XpnlW6SMSWaHrwun63yg
	 0+Hii3UVC7CT+SQBbHvdeSyPGqJaz9xWS+UcNx8BfpX5UI6VA02TH92atQTjm9n5ybEag
	 8JeBOUsW38wRtppcnnNbH5JCCVO6YQugMO2tIDxEBXoRyTiUv6rnqn6jQj8CDyTXijThf
	 ovj5yCw4rHAvQFWvLJz8oGA4tlkOzB9qzvEKp/87OW7hflc6CzhjIj8MkZ55knML4y3MY
	 K/r7fgGWTTFYOqq0bkWzDt62TQ8sdLiRh2cl76alL/gCpvXo5KTrdNT7pr+iYu5hOzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763362;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NOrnlcSIPkN6lKxW852NS61pWsJiVfI/TpMJ2WL6De4=;
	b=Gdzncik2UU05mkPypm3kIGQURUGWQFuKHXiutfYPZ3PLOhr8lDE4gcwYZ4Vz9FWLAk8t
	 hGItbi/iVeHRbiaVsZZfmKMRsRfqLUeP8S1nFU75SqIHVqCaXw49rLZ9uK1JA8881muEf
	 JmYpxyk+9ue0ZCr636sYOhGmfT9tVIacy8S5bGy0+JfToe9vnFFm1CZm/9ELyY+udzWH0
	 aVuB/H4OrUwvsNF3dP3RGKi9mUgP5HzLwC9jghMBA39m11ULEWoOrjao9B3Irsw6/c9Th
	 zxve98VVFVfeWwC6rDVY3iU2/b21SWGP9K63YzhlMt1oET/SChQJfg4LpjsP7DW+ZFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC25606A323;
	Sun, 15 Nov 2026 17:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC25606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 8473FEB7;
	Sun, 15 Nov 2026 18:22:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 584506024661; Sun, 15 Nov 2026 18:22:33 +0100 (CET)
Date: Sun, 15 Nov 2026 18:22:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Aviv Bakal <avivb@amazon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zeev Zilberman <zeev@amazon.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/3] PCI/PM: Keep hotplug ports that can't wake from
 D3hot out of D3
Message-ID: <avnqWd1gVH-i2Jkk@wunner.de>
References: <20261115171831.1498006-1-avivb@amazon.com>
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
In-Reply-To: <20261115171831.1498006-1-avivb@amazon.com>

[cc += Sathya]

On Sun, Nov 15, 2026 at 07:18:28PM +0200, Aviv Bakal wrote:
> d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports on
> non-x86 platforms") lets native pciehp ports runtime suspend to D3hot
> on non-x86. The PCIe switch ports on AWS instances advertise PME from
> D3hot but do not send it, so hotplug events such as an ENI attach are
> lost on Graviton. x86 keeps the old logic, so the problem does not show
> up there.

Intel Catlow Lake suffers from a similar issue:

https://lore.kernel.org/all/20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Please try to follow the approach taken there.

Thanks,

Lukas
