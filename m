Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820253;
	b=TX6atVYi1zglEMAZd8pg2gu7PEvWZDkMiNK9KvQv43EWA3LxgUxWQx8Lian3Derit6WA
	 RTeJGEaOak0D8JSF3TJIXG5dhLj/r3YDOMiMSwMXsfir2x5CvIsvpYs68mwWlJzIU+KiR
	 uPXZhMM6DKZv7LqVVUDWQP4G89iZRhZhw81AYLuK6x+JQxcVRj2+vx0Ttn/fzNTQhdp4h
	 Ip5Q0XvWlKnpgam2kPWgK3pbC0sJgL4PGFREkgV7/LsSZUcyF2qQT6FjUBgiVnktSRr3g
	 giR1iLmRlEJjYIC+syx3SQUSIT5SyzyO1EXns5HHaMsl4D7O99FIinsb2uroS5mjn4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820253;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yqWbS7bmtABGZQvYR4vX3FNpYVmw7I3lHWXomfTaRO8=;
	b=VDNacnGRNYtU6VyC/4Wic9hRYlC7tbZjN7hfC0VHpMrg6Zu9dnQlt0R7h4tRF6k6uyxO
	 B7vqnDKKBzZzRKScQRng2PnobkAJgWJ3Cdnt09dridBHN5nLAJuyqnnUOgmO85icsfmJn
	 4It1Mkga0Acqu1QnQXqhF4OfmKQftYrQMClZTvIet1t6Z4XRufELJ7/xQwXhp6uvx+ZHi
	 JarSlNCSFcsXGoHEvOkpQNY6J7sqIZjVSbV+S/YqyxgLw5i/FZvk9uhtZ3CYOXP7K/NZy
	 A7ZPxz+UW+ei1qv47AzmAu0E4oFU0+UBt3nnY17jEaIlTPeho2pWIzlUY2L5+3/WmAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koepBkw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794B606E822
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koepBkw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434391F000C1;
	Wed,  4 Nov 2026 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820252;
	bh=yqWbS7bmtABGZQvYR4vX3FNpYVmw7I3lHWXomfTaRO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=koepBkw442MEnf4JWHnfkJbr2Y6+Vcg9867OEOAo9LqcLQx/X0u3+PXQ53aj6AdHj
	 6BxIr0AQSKz8M46hXWbK6Az36OuJHNwPmYnqAWE9PzKPJwKAZgQahxAm66UXOxOwkT
	 t/xzudbRBjF+LUXbjUEvzHPnFaAIL28cKmTKsyblm3XW9ulltPeOc0C6CrdX1GPEL5
	 uGttQz9NhuoW4RKDwbTwJipZhUqrbiPgXqJVHfbLlf654Oj+9DO3s+4PQcsZgira42
	 LUoBZ+sZ/9PZ8+fUFflkmx9FJx4UKLqiAuFh4do6x3koTXeiKXeyY6jmG7jxCDCs0v
	 4/b22vppzVHLg==
Message-ID: <sashiko-outbox-197943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] PCI: dw-rockchip: Add helper function for
 controller mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-5-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-5-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:24:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Remove code duplication and improve readability by introducing a new
> function to setup the controller mode.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D5

