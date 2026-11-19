Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095209;
	b=wid6MnkeerPFQbFczr88M1vfc9wS1Zklfa5s4WLkelekimWNY/CBF/BnYzSxVhd7bx9/
	 ag7djpF+QOPz4Y9u3Q9lYoRSAFGSONbaXiwrkKi95aIo9ktJ2ea3Cz9PWwEatr7waO2h1
	 I/YsZNI0HmX/5ZjDp8sdSaWUU+7AddCFzZjEcypZm3P81SXltJwnCpi5lXSZbTwyOMy+O
	 g4GZmJe1MHrGIVmR2Cd1OEs8VcJDTJf5JxElRoPogsIcuS1zfnK6Gp+T2zvIAR3fuCwPd
	 /75MD9RxZxlw+/EaUTqxRP4p4Vwez8BDZvT8Qzj8xNuc4tBhQDXjMPaFykBJyvLVu4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095209;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f84ZTb0Is/JEuUgfe+xn+07VPHBEGmbhmWywDa7s0OM=;
	b=1dRsWUlShhDBvVEz+/ajb3nv09I4rjrCr4seb46Xp/KdP+rg6XTTFNDOARiwxkKbxq1H
	 qytf18jOgU52eBbsojuXh9xTFRydlP0f6NY6IDfkVXYq7Dca+W5LLn1R+DjHW2iQcXrMi
	 AJEhE8PIn2RpdZfJcGIDkrTv2YYG+ykOvcSBXqC65cZjsJdkq0FayxXPrAYTX577uGV57
	 wiiM5y8mKpFkW3Mhqg0sYwhWkp6zY56ZKcGQ7IjuS90XjzV6knm4KB4f2NL0qH5hI9qfI
	 qkn2WxX3hDSm/5Dk0Aq4ayeAHfAKV4G5LszmkTE8tGN7AGTR6csdVW/8uNcBKt3VlRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCrt+vDh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E26F5606A325;
	Thu, 19 Nov 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCrt+vDh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C099B1F000C5;
	Thu, 19 Nov 2026 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095208;
	bh=f84ZTb0Is/JEuUgfe+xn+07VPHBEGmbhmWywDa7s0OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HCrt+vDh9QnPo7hQVylfXGTyMADakLhx2YRAKar9jsF+ty007XBfYXuGwPq3vjMYx
	 OJ+7bHN1ldtu5d/lJt5MiW3gwRUoLrvEu4zNkO4G1a1vV8PUdCFgOOrV7nrEcrhLWZ
	 dB52xRttNfAoeJO9k1uW9UHLF6fCCddJlEkiyZAmEIpsFsoQbaGkKGfL0KfTKq+lP3
	 Vd9EcYZrL8uKmVdLwrcxEOja+4z3WP7B4lZXpfqe3z/ONbH7+bX6LdEFM901aiU5dk
	 EPwsiHqm7dCeRhNooivMlkn47oI4J6JXd//Uqt5UUM2OHGsRBWSc5if0yYT56ILPdv
	 VCHoPaudAgFPQ==
Date: Thu, 19 Nov 2026 14:33:25 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Xiaolei Wang <wangxiaolei01@kaihong.com>
Cc: bhelgaas@google.com, jic23@kernel.org, aik@amd.com, djbw@kernel.org, 
	linus.walleij@linaro.org, bartosz.golaszewski@oss.qualcomm.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IDE: Destroy host bridge IDAs on release
Message-ID: <4zoge3uvwwni6qixfxo5or7finph27hmg5nwfekb3wbyxhzjco@wbfhad4y374q>
References: <20261119065429.1824738-1-wangxiaolei01@kaihong.com>
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
In-Reply-To: <20261119065429.1824738-1-wangxiaolei01@kaihong.com>

On Thu, Nov 19, 2026 at 06:54:29AM +0000, Xiaolei Wang wrote:
> pci_ide_init_host_bridge() initializes two IDAs embedded in the host
> bridge and reserves stream ID 255 in ide_stream_ids_ida, which allocates
> an 128-byte IDA chunk.  pci_release_host_bridge_dev(), however, only frees
> the resource lists and kfree()s the bridge, leaving both IDAs undestroyed.
> The chunk becomes unreferenced once the bridge is gone.
> 
> This is observed at boot with CONFIG_DEBUG_KMEMLEAK:
> 
>   unreferenced object 0xffff000100d4df00 (size 128):
>   comm "kworker/u16:3", pid 52, jiffies 4294892598
>   backtrace (crc 6f8346e1):
>     kmemleak_alloc+0x34/0x40
>     __kmalloc_cache_noprof+0x3c0/0x56c
>     ida_alloc_range+0x42c/0x554
>     pci_ide_init_host_bridge+0x130/0x170
>     pci_alloc_host_bridge+0x16c/0x1e0
>     devm_pci_alloc_host_bridge+0x1c/0xb4
> 
> The 128 bytes is IDA_CHUNK_SIZE, and the trailing 0x80 in the object hex
> dump is bit 63 of bitmap[3], i.e. the reserved stream ID 255.
> 
> The leak only exists in builds with CONFIG_PCI_IDE (selected by
> CONFIG_PCI_TSM), so it is invisible on kernels without TEE-IO support.
> Every host bridge that is freed leaks one chunk: a probe that fails or
> defers, and a driver unbind, all go through the same release callback.
> 
> Add pci_ide_destroy_host_bridge() to destroy both IDAs and call it from
> pci_release_host_bridge_dev() just before kfree(), symmetric with
> pci_ide_destroy() which handles struct pci_dev.
> 
> Fixes: 079115370d00 ("PCI/IDE: Initialize an ID for all IDE streams")
> Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> 
