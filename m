Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866717;
	b=dBXvJRMk4OsX4vZKwK3Uw1Y5FKzI5h55hw/bN7ifhuLTapWHoQ7weG8drMgSsD6Sztm2
	 P/cCCkJXiCr14KIboboRZb/Z/LOadYUMKDHs6kU1LqkFiFe6oIzrvj/H9/hnHwuS0Mb0H
	 WILASLgm7LvO9b9J7g11tZ0A6qHACbtt5cOjZZKr5utau9TKNTKOIl6lYozp+r6/J0QKA
	 HeOJH+ggRMvcUgpYrhLOKy+pc8Q9GXNG3kY2ccTEyOL5rv2T8VAJJxVW2xaKBQWw8NFT3
	 G2PzTSdGfGsWIVEq4Rs10uGp4/xzK2neE1tELaHhjXuokKRZfusyC6AgC4Yn2Abrk3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866717;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0HlTvpFWS8FhEdttvvfOO54uc//aea4NxdAMgv16Lzo=;
	b=iHE24kQCPNq7yCYeCrc3oMXZRRmWTC65Y5YmfOUO63fl23eFBQVM0YIwqXWLE3/SF5GD
	 y2fpVeGuZqdaXHxhvAmMaECcXjZ/BzLVryrQdSrSaa9UV9iOoSt4OPaDdvb9pgQOntY1y
	 BK4p8fIpt2GWxm6psZOFZNmskDVGSnmuJt3bTD8Ac+SVOrPzI41pRxH3fqbm04hfrlvDg
	 gJw3blttzdU7XhU5RFf3YsYcgqzWw3p3fB5Pae35INBGmaVvhfzOc63oLpWNGL2Fpaya/
	 nTeUEBv280JShPBfE5nNcR9HukBmE2ehYjjjkfxt5psx6LXqtp1uD+toHhxS2EXxbMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C342606A332;
	Mon, 16 Nov 2026 22:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C342606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 3C89B2832;
	Mon, 16 Nov 2026 23:05:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 279AF614AF2C; Mon, 16 Nov 2026 23:05:09 +0100 (CET)
Date: Mon, 16 Nov 2026 23:05:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jason Perlow <jperlow@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Darshit Shah <darnshah@amazon.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Do not advertise DPC on ports without an
 AER capability
Message-ID: <avt-FbT69lemI4b0@wunner.de>
References: <9ed2d8fb-fad5-44b3-82a2-0021edb405f4@gmail.com>
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
In-Reply-To: <9ed2d8fb-fad5-44b3-82a2-0021edb405f4@gmail.com>

On Mon, Nov 16, 2026 at 04:39:23PM -0500, Jason Perlow wrote:
> Commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS
> controls AER") makes get_port_device_capability() advertise the DPC
> service on any port with a DPC capability when the host bridge owns AER.
> It dropped the earlier per-port test for an AER capability.
> 
> dpc_probe() still returns -ENOTSUPP unless pcie_aer_is_native() is true
> or pcie_ports=dpc-native is set, and pcie_aer_is_native() is never true
> for a port without an AER capability.  Such ports now get a DPC service
> device that can never bind, and every boot logs an error for each of
> them.  For example, on a MacBookPro16,1 the Cannon Lake PCH root ports
> have DPC but no AER capability:
> 
>   dpc 0000:00:1b.0:pcie008: probe with driver dpc failed with error -524
>   dpc 0000:00:1c.0:pcie008: probe with driver dpc failed with error -524

DPC does not mandate AER support, so the condition in
get_port_device_capability (which you're changing) is correct whereas
the condition in dpc_probe() is wrong.  There's a patch pending which
removes it:

https://lore.kernel.org/r/2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de/

I'll respin the patch shortly.  The patch is tagged for stable.
If you can't live with the error message until the patch gets
picked up by the kernel version you're using, replace the
-ENOTSUPP with -ENODEV to silence the error.

Thanks,

Lukas
