Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793441039;
	b=lf0ODw051aqpAQzhs4niVCkNw8LeMWw+yavCChOctpqerpEyJN/NC+ZVUFKaBp7lVaJk
	 tTowkVH+k9jeGxcX0STzjDK1DlrHenJRLseBsJdKnsifciB3jMvELsiwz7pzBY1XT7h3S
	 /OHh/QOzUtIXDLSpQUNMXgHOjFUTQIvdLu393zZigv6qQwMr3pg390Kf5OSaOBqaKXLB0
	 aT28r2DcYeMmogM2AjGnPf+PWVmJVCU10fZQZQeHubqW8K5oQKkG8lpCWxtpGCldEhg8T
	 vins4nEghaIvNuBg4y/fOkt/P7tFIAZa8lc1GnoXArTARJxoHd+pbA8CkOiza16zDuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793441039;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QwuMKFsJkEjE6r+r5DktrXfuoTe+FFN/YZ+8LBlDeOA=;
	b=T+Cc1wI1EaSJLEWeovh8c/hdK+6+pXDyFRE28LFjsuyCyw2iUFZAF5ZTX06KrrE7Gx35
	 0d7drJ8b3bE/Ki+AbM0uWO7kHAybYr3JbW/iLqu9pzwuYq+mTpd/5TGpjAgL3YrJNDUHD
	 WAqT+v6D5Bcl6OTQo3FV6gEJjsejFjaWWFUrxtjdo97waZffPcIM85RdR6PSM5nX5dlTV
	 KFJqdewv7pqKd23TINXQjBHMX6wzreXDzPPtQSQ7qVg+3FJJ5fihlFyYcNovF7HQ6g7Nh
	 /DOWAtU4cBwYGbG3QymZNRlc0Tjbzlb0fE7iKtyRQ1UPvOrgfdVtqx1LlFnpeYIpj5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V5IZZAU/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E581606A31A
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5IZZAU/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E421F00919;
	Sat, 31 Oct 2026 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793441038;
	bh=QwuMKFsJkEjE6r+r5DktrXfuoTe+FFN/YZ+8LBlDeOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V5IZZAU/7FWRBmz0bnQvDNLAu1wkPU9jxFLIMEjjXPAXQiT3ourMqTSjaW2nAuhxb
	 ekGYQEdpMxgwPtQR2yQggkvzHvI+vZauA9HvTGAEGZ8cw1HG2pmM35vudw0wMyxjJd
	 cVD3YA0ox581ESQUHW1VMmSN9dpZzK7RU/lM7XA9uWc6zTja7BR8n8kesuaD1uyd+t
	 0p8M8/s4xZ4siSZdVjKvss6QDVFQhxvJNBD1v9bR892p+wEXIOb3K+2MWORTC1GaMN
	 7BHSL2+OBcf2NSqjCh0kaY0Ph5v8JT30cDA36diUBBVTE6WkVbyRiGLlwHHfvxI33C
	 0ijf3/cP/Sx9A==
Message-ID: <sashiko-outbox-191887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] PCI: exynos: Handle PCIe PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261031094911.3304-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261031094911.3304-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 10:03:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Check the return values of phy_init() and phy_power_on() to avoid
> continuing PCIe host initialization when PHY setup fails.
>=20
> Track PHY initialization, PHY power, and regulator enable state
> across probe, remove, suspend, and resume to ensure cleanup is
> performed only when appropriate and to prevent unbalanced
> reference counts.
>=20
> Assert core reset on probe failure after PHY initialization has
> been reached, and handle cleanup errors during teardown and
> suspend.
>=20
> Also check the return value of exynos_pcie_host_init() during
> resume and abort the resume sequence if PHY initialization fails.
>=20
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031094911.3304=
-1-sreekuttan2156239@gmail.com?part=3D1

