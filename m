Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475004;
	b=R19HYWtWhpzi9T2m67Res7mQ29iWhvhVleVcSrAY4v6iyT1XZh6gUA5HwzWqlZhzKN0Q
	 mCMVkYkW6MuK7FXIs0SWPmr23LWcwGP0tKcRyXWDVRpJy4038RXAp/U7lKOxYONofaZiN
	 bYJR7sYcWX4DtDZPNlWMBRmbs4aeuU9/buIDV1tm3qz3Cr3Bjb4IO3Q4bL8/v5MWvyjkm
	 bsalvWzeLvfqSlTIURThIS6xElwrJGIUrcZxKmmuHw8A1qoPVHB4ziarM+NLEfCjq4I4e
	 paOpU0Jjmz+rqm4e9sn83iBhQuuV1lUgPlZ4F10zrfxfne9hq38gXh0y0f0kzqI936g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475004;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=R+961hCl4OVQUnxybpEgQebM0VogMZfSFesxPNXf1IM=;
	b=LUJVqiUsdEsOkRv5+emF7Sz4Qv0INu3rvoO0OdD/if6v1pcxEG8FdZCHpNn9bozUwnIF
	 j0EmAvsqxxa8yepLilVHsVyjVBFoozJF2OJAJKFeZjuNW+aaK/LUrpDro9MM94EqqMUaH
	 pkBtLJO37tK0MIZrBfCKx+RuoThIKH7TNUKfJ5E7FO1C7qlRAmNMQIPvOAql5VcMSag7u
	 ZrjqUlqIfSqoEqKdIxaRa04EFaVyo5JjvcDP6WY8GSCeNu6jRVY/FDZTxTnPp3SB3h7+y
	 btSn6+ZKfFwzfbvzKSt1U5M08rbXC/Dip7zjxEqRynF6SeTWFDBUz7pIhCECkY1/MJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWWI9H5Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1A606A322
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWWI9H5Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489DB1F000E6;
	Mon, 23 Nov 2026 23:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795475003;
	bh=R+961hCl4OVQUnxybpEgQebM0VogMZfSFesxPNXf1IM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MWWI9H5Z6bsS9RUuomZa2JeEZVK1MkMcHjTxiBviithGMXf0PQDK+skHpgpEhvAND
	 a1Smcoiu8z7cqYqLt74DZNtTJJSTDGL8JQV14fMz/WITGjfXFyZlCm3o07Zxx5Hxor
	 CyQHG2RzX//UbTlF6dzkbFaUbfVZH56w6cees2k+IY6XisyMK/F2DxuQp5HBnd9hfP
	 wgqY98sIEfcoB9ZGQpbTe+znFz4oLQwqs1+kgdHvdOWh8mbFVoBAweluVzbvlw3VJb
	 gN5I8Yg1oQXy+5Cmaj9LRUNYIYJqXc/JxOyqQfs8Vv8C6b2y8AdZfcTt0ConnJ003F
	 Bw/abgSuuv8sA==
Date: Mon, 23 Nov 2026 17:03:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: bjorn@helgaas.com
Cc: linux-pci@vger.kernel.org
Subject: Re: Fwd: [Bug 222317] New: pci: 8086:4c43 host bridge enumerated as
 class 0x0604 breaks Intel IGD passthrough
Message-ID: <20261123230322.GA1120296@bhelgaas>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABhMZUUybFWK5+Cy0xcgKZKu8HUmXQivUuBmzfR1tRnf2a+_tw@mail.gmail.com>

On Sun, Nov 22, 2026 at 05:37:27PM -0600, Bjorn Helgaas wrote:
> [+bcc reporter]
> 
> Thanks for the report!  It doesn't look like this would be a regression, right?
> Can you please attach a dmesg log and output of "sudo lspci -vv"?

Reporter did attach these logs to
https://bugzilla.kernel.org/show_bug.cgi?id=222317

(Email to that effect didn't go to the list because it was HTML, and
the lists only accept plain text:
https://people.kernel.org/tglx/notes-about-netiquette)

> ---------- Forwarded message ---------
> From: <bugzilla-daemon@kernel.org>
> Date: Sun, Nov 22, 2026 at 1:51 PM
> Subject: [Bug 222317] New: pci: 8086:4c43 host bridge enumerated as
> class 0x0604 breaks Intel IGD passthrough
> To: <bjorn@helgaas.com>
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=222317
