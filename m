Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157256;
	b=HN+5OCf1w3I+aut8PnyMOAnMJUZKJUEsY0mUTDGlUn41oneyK3HxgE5Min8fCOyvU/i0
	 luOJiQx7GQbH+LDnHJLXGovMvOJBZgqKzZQZUZ18BoGfTQ93STERNchVY/MKEQSFrz+p7
	 BAu5UraE+T/wDnQdZjaQUOvzGjzhD+QljKronopvXfVn5ZNYDKsMzjkWFpdO0GtlFux4u
	 ZpWH+TSDfuH0vk265BvKfUxbC8S71U9piDYShqGem9pbtzEpQz34L8wsseM0RMqenvFZB
	 qWHqTEn2STIMUP6O59eI4yzCj0wfaAVPAiJYsUZsBsfa50FoCDABfUKajAYBH44oYhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157256;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tAbzHxticEwm5dBFAGO8uOW6nZ+D3IZvLmK2Cq4CCLA=;
	b=ANfBK4v6bz8ws5dh+d2D4RKcekgiyeqNCb9n2MhcDW8cWVFvhRXMg51Eu0D6Z8ieQPUF
	 GrXEL7CxPs5kGbcivae3nUFX7BNcrVJEOuS28S8RozmgCw18/bAsmSDOfgZi043NW0qYb
	 pZ/XGdthpsU/vLbt8LKoRA0EQgQFkA4QHnE6+4O2w1fV54ARLMLykz3eBAdavgxE0GS3f
	 Pv9GU8OLRtFd65zfqvjvilMpjONQIIBhzqTZ8sYtCPGuvsGY/PfoquFE11YkkL0Vfv1aO
	 hXEt3hMpNf7AVugso7VywwDphTpPXkB518KHuSJ3FG6EePsVYqyomoMKO67kahY0yxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7q4zJG9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91054606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7q4zJG9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0354E1F01828;
	Wed, 28 Oct 2026 03:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157256;
	bh=tAbzHxticEwm5dBFAGO8uOW6nZ+D3IZvLmK2Cq4CCLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7q4zJG9XnUMGvP9jm/BHuF2GEINbcM+f7hL8DEvSUiKRTATj9NIE7UzpEeeia88t
	 vzIVCSqSjCP4ESx0x3K016AZRN7tZNQBpdIq9KKTXF60Y8ya5yxK2m/JujZOkBRIer
	 NAoi9tXVEhzLCWSpwLJnBbNa3Ab0Z0NF4yv5Dz8fQLKWsxdc/O02LK3t98FVv+vyQw
	 Q5tovQuBMWzsN4o614vIu2HSv0aQUKLSktnWqwryekQRba82wxvQusE9BCHVLN2hyC
	 hlpgen6+niwuJhF7YoC55Uqsfea7/XJIPVXK+M94EZiG1ZB7XtdKU3u7ENaGfuItD/
	 HiRWeZUdadlgg==
Message-ID: <sashiko-outbox-187399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/16] PCI: dwc: eswin: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-8-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-8-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:14:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> eswin_pcie_link_up() is the .link_up callback, so it is called on every
> link state poll. Replace the dw_pcie_find_capability() call with
> dw_pcie_get_pcie_cap() so that the capability list is walked only once,
> and store the offset in a u8 as everywhere else.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D7

