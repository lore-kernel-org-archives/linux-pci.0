Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157235;
	b=KghtFWLMOn1N1O5AgepMX3b1ln/mcC6FyM3FKt7HF3KNCx0lnkzVNIp32NyRKml0sZ/Q
	 mrnR5gOZ05+UZSDOGBwdf89WnaDxKWDaz+qvqX66e2Ng07qeE50pwTHxg5EJ+ZtrCWdeH
	 BnOERBcEbD0+QDpY+sVuvUtRIOdiatajWK6OqiWjSkNV4Jg099y8uFv5oZxZxPTf+tJU3
	 z+1SosJVPMiwsNPJMCD47wawWlXDo+C47qZy18tZZ7axeUHWjcfDD3q7GfKRfFtG/0oQu
	 zZo2tb4ofE6/pjw2aeTITNTjkNhLGsO2/HKNPZcjUsCYtswtISyBidym09eAjdySM9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iBi/GziW/iZvYsZV+P3MC1VOoaaM77WQ3BPWxx745Ok=;
	b=NPwPnbaJ15XlUUpX+NFBojx+OReiznzmEzh67yd78sVyXEPB5s6lowk1zMozJP/bmuRn
	 1Hqdu8gCUAvTgLzqo51Z+S1W9l+ngDPgQD/7pZtrlC6CNIKIF+RJf5ZiBQPzpuuUaEK+u
	 Wyh5q8eilK/TjVpfoyfgMzV/5BigPDnStLDTtVBrk0hL7igU5w7gU3gocnZ22a2AmYXcC
	 ZF3fgMPmXm3n23QHdIJpjHTPMAHw5AHumFQdWirFImcmdD3YVeYKm7Kv0KFJjcCzcYxXA
	 j0AlcEeLuuFWcNv9rBuiF+B662h3bKWinheh/aojHiQdfMwSwLtX0x/ad7stp8nw4MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6ivunnx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE5606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6ivunnx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EFF1F01828;
	Wed, 28 Oct 2026 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157235;
	bh=iBi/GziW/iZvYsZV+P3MC1VOoaaM77WQ3BPWxx745Ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6ivunnx8xfqOCM/e7o0E5ANXAjtkP20Xjqrnos5teQQUHvvMEQe9UIEloQTE259c
	 prGelAUYri8Io6c8fFMNHGJZr+YdKa8KQuobAxiF2bp06kWLFnifM/MwjsIiaCEznl
	 573Z9Zsp20PEC3xgR70OhPoWB/FPzXJXfpJeh9XEerlbbvfKM9oLvx9dU3rVqPC+iY
	 dxac4rOeFEXo/ERBID348EeWkSx2BnOZYfZbCZ00f61cB21YpjzctAvKqR0eu/D7Cf
	 f8XPCz3ynMiEUekR7liyVQcwvmpxIMHBChni8rzSblmRU7Y3dTFwMJzxiAOdULx3zf
	 SI/R8D8B7sr7g==
Message-ID: <sashiko-outbox-187398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/16] PCI: dwc: rockchip: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-7-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-7-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:13:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> rockchip_pcie_enable_l0s() is called from rockchip_pcie_host_init(),
> i.e. from the .init callback, which runs after the controller clocks and
> resets have been enabled. Replace the capability search with
> dw_pcie_get_pcie_cap(), which reads and caches the offset at this very
> point.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D6

