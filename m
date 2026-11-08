Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131240;
	b=Y7/x7KICOZhEQVJVlWUEumaRVE5W8APq9Vwp05CsSujbJdzg9QFjF70PQaBwNWOIg2h4
	 0grMAkNvfb0sXu32mRZzLehMbOcVBeXA2kUdJx0lSKs+zIVejtyJ6PB7wMTZnbVKv5X/O
	 8zUeqlRuiNnwTHII2+ExQpuqfegzkEczWGOzlKcSZBYfKtQg47Q48PixFI9Hza8slyFGA
	 0dHkfRTVsjfCyMo6lUC8DfG9e1i27TkuYydmmw+ArXLg0/JRtLdHglcGMH+COH+NHhXSx
	 Xi+/ZqbLFa+iSeQsEI/16V+4cEzecEZEVWi1Qaun9esD3zC8MYM3FYwjJ8Uxw2JDqUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Gl7g8U+u5SJic9v7V3IRj4HW8bRaxFuFG3xShsHnHWw=;
	b=km2ae1OFyIHOV5/79KGQ4sPkMuaXF7Y61KpWBSSqFH5Saql/vKB4r2HrKPnYSXd0njfy
	 yVLhjeQ9SHpL1Ebfe1hSfkJNPTokbrZsJL06YmrPtlfMe2EFkG3pvXricSAUhP8B8O6nx
	 Iub8L2kUDVnl2YmWyBzH8L9GoSeUwmRicOtq5OUYZ9mwusBiEVTafdxHkjOlQqoUJT9qe
	 DIqrKrn+M4dCcXm9NJmY48L03kaz1LQjakBqclRIDgEEalOa4tTL36hCTTUlmCtny/9Au
	 hAW1/+xl0MEwLDsLD7rJfDbpfCMkDva7n5K2cygu/mT+OIvUgM8TgWM/4VEdjBjQaxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIu5gI8l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CD606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIu5gI8l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F301F008A1;
	Sun,  8 Nov 2026 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794131239;
	bh=Gl7g8U+u5SJic9v7V3IRj4HW8bRaxFuFG3xShsHnHWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XIu5gI8l/a5HX7bj4Q/oktd9eLcvpXisa5WJDY6igCwAQZM3WL74g5hKsUN5x7vpM
	 H17BH39Ozlw8XQq6Z/J+aEJ365z1RC7mcG5dU3OuKseqJzDq4rRDNjXYqlQOd9+f42
	 hWDi2gFc9Py1kCQymJ3kVN2sR38rKySqubpgMe9eAgSAXXOd1T1uStKtESp9hawz5r
	 85L9RxvdPYqNHJSCsr+RUae0zSMQKRjxzMMZNFQPKttbpzqQ+FgYulK8M7XOAFd9nZ
	 0iDxYEqv44C/XloiKhRKkZo0g8/JWBjNJevwEp/990Yc7SgZex/12FsfREKsW5GT7L
	 Mg6rwkJz/gvZg==
Message-ID: <sashiko-outbox-203669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] PCI: Use pcie_get_link_speed() in pci.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108094034.679945-2-18255117159@163.com>
References: <20261108094034.679945-1-18255117159@163.com>
 <20261108094034.679945-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 09:47:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the to_pcie_link_speed() wrapper with pcie_get_link_speed() in
> pcie_link_bandwidth_mbps() and pcie_bandwidth_available(), and remove
> the now-unused wrapper.  pcie_get_link_speed() performs the same lookup
> with bounds checking and is already exported.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108094034.6799=
45-1-18255117159@163.com?part=3D1

