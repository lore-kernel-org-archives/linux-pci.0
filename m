Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626393;
	b=2EM4WS4qxbonPlttLKg+FcnnCvPUQprC7CSm+LA3rwI1dIHzuUqK75AHfAwnzIstE87T
	 1/D6mfbW81uWWHN6g+Oix3WaS9TLWrdPc36IzCF3bXCIWmofv7L1Stb2ZifdEpgjTnMHt
	 1pPlSNM2PcabF6l11FaQzTQQJjlD6aYprBbhTPy9kpvAn3M8X4fd035yIjGllG+UeNVGe
	 Nk4ol1Gn0IXH39NQd1qAuYUdtfc9cF1LjGPYixOSG6tAOCfU97DNoD+DGTLWaVeK5e9fR
	 /EuP1qRGGhKH7JZ+MsCni0WStIbMlreUaSoHw9Fv7aZN+PIs4PVqR38jiIYhqLIYobg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626393;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hAziCjBKJ1SNEkdmXajn5/U751Y1KrQeNWYi7A07S5Q=;
	b=t+pFMw9+b+nAzuCHrZgNRB3VnaUkjYcdUgFT9/btBEQqUc28Cz4BQcCWIw+RoroeaEON
	 2eFWyYRyN1FyhuMOQ3l6KxoBmHKrJq+kZA1grKqeRFcrL3cR/gRhGKrQuXHXjc4C+X8ft
	 WlWol6Ii8p7FIv3biDQdiZhPOoqf2sJT8bUn74p/zl/ZxOSZXv7gIaU0Cslkx2uuLkO4W
	 NdFNo3nN7m8Pw4B6FL3C2GyfuquXuD8AZzHqrx6/wKu9uyNjCVa1vtjjJTOPcapm5NmM2
	 PfHYrR2+lWPEhY2Ae6jb6fmaiLBedZzTYUqhRa1siR1kGGKSFWaMxqWyA7zZBfGwMlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNycARcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4112B606A326;
	Mon,  2 Nov 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNycARcY
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 07D031F00A16;
	Mon,  2 Nov 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793626392;
	bh=hAziCjBKJ1SNEkdmXajn5/U751Y1KrQeNWYi7A07S5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nNycARcYpMixoGYRsTaFVHjXPmsuh3YpeRGT6dJ1ybjgj8XPnfgkftA7mrRE23lWP
	 fGsQypeGA/LB8JdhB2sb63LBlW/Ep6UCtTCzJBlu8Q7q8jrsi/KAqKzk3zPet6KFeC
	 TB2zj5w/xghQgqRa3313y3ryJ7eStfMtfA6lkvCJGSshmtTBEbOyKkRrDGX479qqi/
	 wrAvNXZvNk9zqOL4PlLi1QHI0di/CkEayU4DD93kBsc85BOhu4gx88B+SreCL8WFLq
	 xO6rgCryfbcCUmCFJZ59yv6OCcdn0LiI1DpLC+c1pAev2m5crqq4ncqu0VZ8BsZcnK
	 CeRpshELVoeNg==
Date: Mon, 2 Nov 2026 14:33:09 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: generic: Fix leak on clock error path
Message-ID: <2q3obuvuoingldhprjfmpq4oabfwfqqj5nwecn7zghqkapnnuy@vcsvziqmqky7>
References: <20261031-pwrctrl-v1-1-405af11c5662@gmail.com>
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
In-Reply-To: <20261031-pwrctrl-v1-1-405af11c5662@gmail.com>

On Sat, Oct 31, 2026 at 01:49:08AM +0800, Felix Gu wrote:
> The devm release action for the slot supplies is registered after
> devm_clk_get_optional().  If clock acquisition fails, probe returns
> immediately, so the resources eallocated by of_regulator_bulk_get_all()
> is never freed.
> 
> Register the devm action right after of_regulator_bulk_get_all()
> succeeds, so the resources are released on any subsequent probe failure.
> 
> Fixes: 9cb64f61ec7a9 ("PCI/pwrctrl: Add PCIe M.2 connector support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
 
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
