Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385112;
	b=np3PguMcpfc50nkUjeYh8LjDpSysLkaRRdaRRiOlpmYGByZadyMtjGB7E5a0M8HHDtBV
	 tU6J+9l/FHUSgd+u8/ARyF38owVZNE3OQViHU6MerFQmHAxkuZ9CFmLWDx9lZOV49zX2j
	 7QRPZdCCz0ycl5hGNrvNDPspQeHmyhHrAaMNubGPAozKSMolSypvb45mFcJBy+XOUrTyP
	 hC/Yf6o41yG28ge6ED6hkQ6BZl45DV2Ot4orY/aR6TPyDGGRftSBzjPm3jOyABKItkrOo
	 8ZfCSVgDVG3Gv0f4vvliLOfOeid+ERRUEwSe2dd5+fyBOnfi9cBoM74cRZpWqp9Yewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385112;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Pd4x6KX1MFlbuq4ED0KDljLa80KATn4gc4wWHX5+2d4=;
	b=ZTKNX+RZu4pUy2mmhhpxwH4EeNtKIIEl/ZY9/vnc675IeC77IpaiPLmaJBrKlJJ6p145
	 nJseLf8lIEs4XmV0pcIi2dn6stOXGE3FbkVLhx7AYu2aRAV7sGPNAJpQev8AhOHPkXVoJ
	 /IECl7DvLK5+xEgAoM+KrESo0KBLXQAQDYVpFRTM11OrJC8Ok7ISkceoBQi+5FyWL27/y
	 pD8RbLviHgmTF0fQvf1dEIvfbSDoKgpY4+OM5Xqzib0oEX0goCmENtvOvgcX8Ioj7rxm6
	 a6XC+MU3xzqAsVlwWF1olEjjPaD+vTcK0pRg25KosXM+UZOSfqGeIXSYEtKKzMHaoWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V4IqbMPt;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A63606A31A;
	Fri, 30 Oct 2026 18:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A63606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V4IqbMPt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 88D8D40E02B7;
	Fri, 30 Oct 2026 18:31:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fAISku3nizOb; Fri, 30 Oct 2026 18:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793385106; bh=Pd4x6KX1MFlbuq4ED0KDljLa80KATn4gc4wWHX5+2d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4IqbMPt5+CJfLUEljqZ3/X9PwSKu+UW+l4hb9rDS7XlfiGavm1XLwtApelIy3wLu
	 0Lj0ZWrFqY+SleXYGaqkqSMrCYaK13hdQHEw5jao0Pqp8JC66p9aNC6yLVimFlO90S
	 uoS/Egnu2Reooyp6zek21i+wEQYPQCCsKYFSh5a3YkQ8Gg82fzdaofMb0h0xHbAJxp
	 oQ80pYzMBAD9bS6+wBZCV8XEP+9A9ABEGEiXmPp8EWEFuuarSICdVl2+cEoMF31nfE
	 FaKB6JaSE772qou3SZBYnZJQG9oB8/xpdINd8Frmt0z3IsX8htM2c/+D+U5r20CJzs
	 DhHEYBXab90Nvz+cSB9QA2yThsknJCJWlW4xPzhjy7rOISVC7RyEGkcrXeP45Uy+P9
	 4DLTbJ3wO5TUBEzBNPBhYRtSpp/oFiiRcD9tFDqA5BsWXIZ9PAcyoNNERbKIxz90F0
	 2TgqhXBCAfUkJHrx7CHIo90G2dhDYrqlPXRYUAYLQnOGQRdPI/El09nUIaND62WyLH
	 4qH7/uJZuF+Hn1CFdbNtz5SJRD2AZD20DzvNedZg0CRrOJEZK7F7jfFz0NJ1LI4mLt
	 PoR+3ml7GXsN7THAuZc6z7ldVQNm21gAyeKOqqLlbmNkfCs4XlKqjd/QvUq4Ga51xQ
	 BfmOBwsg2Gq1Z4NnMNYfrI7s=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2DD140E029C;
	Fri, 30 Oct 2026 18:31:37 +0000 (UTC)
Date: Fri, 30 Oct 2026 11:31:35 -0700
From: Borislav Petkov <bp@alien8.de>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: tzimmermann@suse.de, x86@kernel.org, mario.limonciello@amd.com,
	aaron.ma@canonical.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] x86/video: Preserve the default VGA fallback for legacy
 modes
Message-ID: <20261030183135.GCauTih7l-cCDO96dz@fat_crate.local>
References: <20261029162311.3389523-1-hengyul@cs.unc.edu>
 <4379fd92-ac4f-45c2-9f4a-eaabe4b7f981@suse.de>
 <20261030092422.300856-1-hengyul@cs.unc.edu>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030092422.300856-1-hengyul@cs.unc.edu>

On Fri, Oct 30, 2026 at 05:24:21AM -0400, Hengyu Liang wrote:
> > Further below in that code is a call to pci_find_resource(). [1]  Why
> > does it match with vkms?  Vkms is not even on a PCI device.
> 
> It doesn't match vkms. As you say, vkms isn't a PCI device, so
> video_is_primary_device() returns false for it at the dev_is_pci() check.
> 
> The problem is on the bochs side. In text mode, screen_info_resources()
> returns the legacy VGA ranges, pci_find_resource() doesn't find them in
> the BARs, and the function returns false there as well. So no device is
> primary, and fbcon stays on the first registered framebuffer. In this
> setup that is vkms (fb0), so the console is never remapped to bochs (fb1).
> 
> vkms only makes the console part visible. Without vkms, tty1 has the same
> size with and without the patch, but boot_display is still missing without
> it.

Please update your commit message with this clarification.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
