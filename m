Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071165;
	b=vm/XWxtPSPNtyK5V4Qg1F4gcWKrmHVVLmPO3Bq6ur+dIUvYCbrAhvPtBLNoE3JiDTM7m
	 xm/xhdxbljxbBJPa7QqchpfNiL+6fL61yYuKRFb8VrZH6CQZo36Uk3rIN10OPUceOWX0Q
	 IXVI4DPVFF3PFe+lciSeV4HtCukVc1QnKK1GSxbvkO/KkbXMoWDA8+mimC92y8Vr2aklY
	 ifh6xKGFJOESp7n/UOsk6wvPIIjDyhT8hYcWmz0FiTqYWJXrU6oJuD8y9JuEJOZUDv0uN
	 cLBVbVHakV7uYnKaNCS0hHoncIcj8oya5BSoIO5d71C3bJbEpWsEtMLz6Jrya0cRJmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071165;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=yXwGL1AZc0M9lqEVf5JtZMTpSZJEBwrczEg6pRkVWnI=;
	b=1Tqb6HS+gI5W0bgtY8g6uEo80437f+ucCYgutttzVgrdWy+gld/f+S/bsFq7vAGs3IxN
	 jlF971HlN9nlFQCPCi3INQ6RLX/r1F14zNMMaYpkAmbWftmK6aDb1JACUaQvu/wQZzWNW
	 lW/JKbzbINEHHni9LqvGKVCiUK/VSOnS8HqjKhF4OkYfsku4TG3AKh/AkKU91e9WuBLFF
	 nuohohPpRJTcj3bXU7IlfOXs3Fz4NwW0kR70fEBHuFR2ZR2guPhsbcROQVfUDW/Eo0Z1N
	 6lFCgWrg1sspBEVEQ2Bbox97mCK1gH6AntFaLVcbGFi5FXo3bm2Ygnda92cNsBSPVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6yHADH8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D5606A32F;
	Sat,  7 Nov 2026 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6yHADH8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E661F008A2;
	Sat,  7 Nov 2026 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071164;
	bh=yXwGL1AZc0M9lqEVf5JtZMTpSZJEBwrczEg6pRkVWnI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=d6yHADH8x1hJEqQF3nfvVmum2rHernfhB1XW6CMvJadKyl5nktUDfeupkHstjCnNf
	 rvpKZOpwSQ0sZqo/WsBO7E2riroV/Js0ZaRbqHUWd0YoQLe6/5X9rlXIm0qPP7HCeL
	 TZQ+JL9dJTyyQrSBI8rZA+G9xvPgQhEwo0EVih5cpG9gHobzwtMjHSUcTCiElsoNhM
	 1oC78OQ1SSxgHrJrb8KDMxpM1DwgOev9YYXoM7phN2JLHfnc1XCFpShHN0LwErHwBb
	 uKWX/PlHq7oMvCqukq8OT6h2K8+bcwme+AeZaIgVrbRDalKzF2V9Z6m7TzgmUvgDzh
	 d099+0JQQV/9A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: sergio.paracuellos@gmail.com, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 p.zabel@pengutronix.de, Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20261101070121.2714-1-sreekuttan2156239@gmail.com>
References: <20261101070121.2714-1-sreekuttan2156239@gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Fix reset control leak on PHY
 initialization failure
Message-Id: <179407116392.87368.9250979022176600686.b4-ty@b4>
Date: Sat, 07 Nov 2026 22:36:03 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Sun, 01 Nov 2026 07:01:21 +0000, Sreeraj S Kurup wrote:
> The PCIe port initialization code acquires a reset control handle using
> of_reset_control_get_exclusive(). However, when PHY initialization or
> power-on fails, the port is removed from the PCIe port list without
> releasing the acquired reset control handle.
> 
> Since the reset control cleanup iterates over the remaining ports in
> the list, the removed port's reset control handle is never released.
> 
> [...]

Applied, thanks!

[1/1] PCI: mt7621: Fix reset control leak on PHY initialization failure
      commit: 1973b0f280bb753e0810346a9377766c38230752

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


