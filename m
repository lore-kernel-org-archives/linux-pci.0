Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586143;
	b=NaKwRAofATIJ87E9VC7a7Na15j11O9xA6pFFQoargURFkYVJNzJmv3Wa6eCGS0XC5Zrp
	 M6Eisz4Y95nbBnmSjBf12/HllM8TnsDxgvVrELdGub8mSFtKy/f2b5lITmsyiTBaZmc6u
	 XRe/yi9RdUgVW2blQc+jDSxhw3pwwHgxJK+KHC+GNPsgskdFoXrPuTx5WTCHPRwUas54X
	 4lhRryOQQBv4RjRAYCwi7l8y1bBcXMQHLT3in/W9u7l8nJfcZlkSbTWE09VfpWSxDZuzT
	 xGp+wIBTaoFps6ffwzca/eFPZ41npzCEarCiZz719n4t77J51pSRZbTMNeXs2FOxzGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586143;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=+c9+shoBVGKMTVRiYFf5APeJCORN4Sf79qlNAFX1wgg=;
	b=4Uu1WvlVf4ME68ut9c79G06Cmqz3PyLg4IZEVOcUSAUEWOGPUEqp0bm5+iSuXl+AKy8/
	 qXZzyUbKsh39id+3Vtbz2WkC/GX85B2roopxHs960EoK2I7xtMoKtUi4m536K2nm+LKwF
	 pjwdG/1YZDnKPWkqO4vdvlvCV6tph51ddOAurfFxhl8ZHTcF5jfdk5kpy+94UsNOzzVAC
	 8wSO6QIt4srv+3fonxou8rlj1uOUpg8AzxdppDelgrLmqt79D+4+ThNOwgnI0GTgc8lzQ
	 PmMvkcQZTCwItdVNVBCO1Po2TQPSEjzBuRq9Pnql9PbulGAbCAmA0T0dyXMngLgw+LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=uhPCu5kB;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C8606ABEF;
	Wed, 21 Oct 2026 12:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8C8606ABEF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=uhPCu5kB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=+c9+shoBVGKMTVRiYFf5APeJCORN4Sf79qlNAFX1wgg=; b=uhPCu5kBqD3gwHLmGX+i3yZ8D+
	RqD4k7y1uAlgvVkz+zgxZb1KFh6bofsoDYvnRySAHrBApQMB0r4g9M8amF+ZFJznEVL6WISsDawON
	brLaQ/BwqcOVG9tOK/xBEziZPyku17B+bnSQMe5eQXm+WxaFtD77WgRZNdN/ecHx3zWoqeFMHvdUK
	H7GDGR7BkGsqOGW7V0mUx9JeAsQ6T9hS9RkVeN3RSNRwaW/ODNL9YXcry+rtmIR5CRwn/Otv8LFJ8
	J/9cWyHG8IjCt7gYh/8Ky1Yte1lmbgNH+rn2nSzg7G+jH6k/miHIwseDTfhc5M6LyeJt5bFiR23/F
	94CenVBQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Diederik de Haas <diederik@cknow-tech.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
Date: Wed, 21 Oct 2026 14:35:37 +0200
Message-ID: <3711913.V25eIC5XRa@diego>
In-Reply-To: <20261021101533.609118-1-diederik@cknow-tech.com>
References: <20261021101533.609118-1-diederik@cknow-tech.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 21. Oktober 2026, 12:14:57 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Diederik de Haas:
> The devm_request_threaded_irq() function already automatically logs
> detailed error messages on failure since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
> So remove the now-redundant driver-specific dev_err() calls.
>=20
> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


