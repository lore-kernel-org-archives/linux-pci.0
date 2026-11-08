Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148239;
	b=gDe41oNvSdGRQ/YpBWNPDS4lnLREooixdRVflCWN+LCNLJqWkHwJBC6hlmhfGkG/osPc
	 9G6ap/wircvwP5w6xnWs991UyRH+svQuEsquDFwWt3k6yEmSuv+8CYlN3RyyQ1FwIG410
	 6AiLpejSmjAEWiGhAI2vTGjBZbb/kvwb2pkhREPXeSiNoyjd1PM/3d34irVavCaO7cnj1
	 aZfo69kuVF29eIfAtOdKmru9ba52A/dyg/2wmQO/RxllD9rt/BiKs0y3g3Yo1c905iz4T
	 h6y3nzMMJMN7lZAJISlDH4FI6Q+IEjQSjsrSvZlww1TM30FvK0YuvBMFq8Hnfx3uY4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W9IfBQssGJCwaCyhBTqHkQma6JBkkEiSI+oKw/U+ciQ=;
	b=CEC4MaGYDPEnEMSvzwTKg0YmZ1/We2GljqTM+1kYyO89SLn2Es8nQKSUNh/lWDO6q38J
	 jfiYDmzWXMuhLhAyHNj8wI72wV84rHrMz6XY5qaIDFFy1UelVdSz885W1aDJTu5lCzeDq
	 ywXAeOeQjoNQvoiKpbzziMi+j7lLynpNGqk7214HA6kghbRwN2DJZ5By3dibw+CrX7jbZ
	 Wdykk6f+Ill7pK7XiEUhA+C9sHOT0iBU72B9a712KOkiyvbscg4ylg5hxzfUc/+A15CQS
	 u4Xl5B3COEP10x7BU0pyADKj1i8dh6Ve4qDn7T6hSCdVEfkvv/JuXOmu4d40TENmkXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOQYncZL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33B606A320
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOQYncZL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271401F0089F;
	Sun,  8 Nov 2026 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148238;
	bh=W9IfBQssGJCwaCyhBTqHkQma6JBkkEiSI+oKw/U+ciQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOQYncZL6z0BlG1sIJQkL5bYVaDhA7Ulr7prCVMjEw3D2yTTZeNZbQQrpoPy8uaze
	 7R86I9qkMoQjz9yhz9FEaOnmNfzylUojIMEfpVkjdScGNO3O5j5wYoecCbvOcvAKm6
	 yNDfd2N9XUyQA85lew9iJVNibR0W9m4nFmCLwY0orobe/AwPgQ36FJHjTTwzDK0iVd
	 5pUlFFPWMU2wJ9tKxry7NTev6bxp6RDMv2/EkQp9GjkZ3RgO74+3nizrqzmnKPiroZ
	 8SMYQSgMoaphex9Ulp91jFLizHIhS9/x9mRs2U1IlyFBjuf48LjLh/9bqCo5NAEacV
	 5VjYmqdlmawNQ==
Message-ID: <sashiko-outbox-203807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] arm64: dts: apple: t6032-j575d: Add PCIe device
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108-apple-m3-pcie-v2-7-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-7-0e5ffec71da4@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:30:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add WiFi, Bluetooth, SD-Card reader, ethernet NIC and USB xHCI device
> nodes for M3 Ultra Mac Studio.
> The bootloader will fill MAC addresses for the network devices, add
> Wifi and Bluetooth calibration data and set "apple,antenna-sku".
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-apple-m3-p=
cie-v2-0-0e5ffec71da4@jannau.net?part=3D7

