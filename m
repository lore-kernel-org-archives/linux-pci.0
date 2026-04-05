Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6097352C39;
	Sun,  5 Apr 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775374898; cv=none; b=WfJrTfWpLz1Hj3ueeJslZt3i4jrVuiyf7Zivp7qWjYFsqOXw4UtSCc3Wh26rg7W4ppzFrV2zL7aP1iwyYVdUUQxtZWY5i2jNQXHozvY05v3IEyh1OX6uMqbKissL5Y4tmjad1ErVvfuvUq+I6V808pcRXNdoIov2mKbOfrlP1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775374898; c=relaxed/simple;
	bh=wS1jZr+D+MBb1j20p+mntmd1V+UERSMnJjQRALjDea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfpPoz3BJp1D9BAil1ejCD2r2R5xfI+EmoU5sLdT21ym41HXpV0LewrYou+Y8sxVXZNazALckYFERtrdax0P8p+DxhBb0qJW7jytNHeu7Lrl89fDsr3WCcAAUTHDIOVmlTVPGgFp/z//8MreHDZIsMjFIyiziL1gl5PfPf3ig5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 2FB0314C3;
	Sun, 05 Apr 2026 09:41:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D87EA6029C49; Sun,  5 Apr 2026 09:41:34 +0200 (CEST)
Date: Sun, 5 Apr 2026 09:41:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Richard Cheng <icheng@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jan@nvidia.com, newtonl@nvidia.com,
	sreddym@nvidia.com, skomatineni@nvidia.com, vidyas@nvidia.com,
	kristinc@nvidia.com, kaihengf@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH] PCI/NPEM: Set LED_HW_PLUGGABLE for hotplug-capable ports
Message-ID: <adISLoEPYQaKMRWt@wunner.de>
References: <20260402093850.23075-1-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402093850.23075-1-icheng@nvidia.com>

On Thu, Apr 02, 2026 at 05:38:50PM +0800, Richard Cheng wrote:
> NPEM registers LED classdevs on PCI endpoint that may be behind
> hotplug-capable ports. During hot-removal, led_classdev_unregister()
> calls led_set_brightness(LED_OFF) which PCI config on a disconnected
> device, returning -ENODEV:
> 
> ```
> leds 0003:01:00.0:enclosure:ok: Setting an LED's brightness failed (-19)
> ```
> 
> The LED core already suppresses this for devices with LED_HW_PLUGGABLE
> set, but NPEM never sets it. Add the flag since NPEM LEDs are on
> hot-pluggable hardware by nature.
> 
> Fixes: 4e893545ef87 ("PCI/NPEM: Add Native PCIe Enclosure Management support")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
