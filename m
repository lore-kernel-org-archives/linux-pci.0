Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533537;
	b=wRTMAwTf/L0fTlKMMzAcyCNGiQzNu740q8RrZYSSuOiPDFTxBuIiSwuPnUO3esNp0vFG
	 CQm9QBt+rN009T0tzmZlkYPlZn9vElZrBFGDfzyPvF0OjFTyKxwF+os6qSjzh4d/P0LmI
	 OqQgeByHOvrotNrzTYEpSr6AIq1d0wuse0uYsP6koO9iKYsaxl5w+ZoSU+KROQBZiVMNw
	 7yRwOxAe1RivCvlPw7eHtE0sveRSBF3TdzPaRnUVCsOoyMY3Tc7QS4Z5wagK5lUliAQsF
	 LL3sRF55M4jpkK/mDdLQQVl2TjEMZH71bp6e0kZs/wqZnd+N8d1GEwaApXfo3lH49gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aFA6gYhYQb9Bho8Od6cVVON2TwN1CzEHu+PP4MvjpHw=;
	b=shGmz7TOYV+UAiloy35ROTU6apLz4pMfRhgLjO0eY+fuZbmiTUuTdFZVTONKiyOZvg5f
	 AxCcGSbzE8QrVX5p+eqWkjYhIgP0ieF8bIjLdfmRyUlIfO6jYNB+vlp9dHbTJaG5cE06T
	 cvmgGKZ4E+TTIjKgcm1NxdHfteRxpnkojH0HIJjkiz/JZcPCGDJeM9MXSsBR4IvJz9ue+
	 TZBYpwjvvHzU6iWWfIGGLqDT9rUMPWrVtu4VVwgNRm7ox9++vpeuD3ynsg3hAXwsmHFGX
	 eGrHxKbZxl3ka1eBF2wOIzphjwHNoTUhkjC462N0i8geD/mwdWkF4j8750EIczAps6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjV3GOR4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAF606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjV3GOR4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BBC1F000C6;
	Tue, 24 Nov 2026 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533536;
	bh=aFA6gYhYQb9Bho8Od6cVVON2TwN1CzEHu+PP4MvjpHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjV3GOR4tY8mS0S2ukQguA+fkzeidpARg4t/yoomWQM5X7QUFvS8pOPOBINMRxRJz
	 To+cwB00rsN2YKOGsQDNiPNS5lE0q3m+9MF53+PVgzEX/623vaykdtjseu+818m9qH
	 k9ItPW7jHQ+vc5iJGDBHwPIdis053LsImASV9BRpiY08IBDqIEjW2qgJ5MAnC7Ros3
	 MZraMjIaIhwFBalYuFT+rPh+aLgw18YFghJs7+Hw2n3DiZ4POPPCxHvZS6DgmdcPqt
	 kMW0alW6F+j6rYLBxvuCUmcoYOyOs+Nwzd1ky0nY08loUdt32Rv1u6eufDdClJ6rIm
	 ys5XJv5ZGyGOQ==
Message-ID: <sashiko-outbox-231397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Do not power off a PHY whose power-on
 failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Huda Nugroho" <mhudan21@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261124151615.SjIkx%mhudan21@gmail.com>
References: <20261124151615.SjIkx%mhudan21@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 15:18:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> qcom_pcie_phy_power_on() unwinds a failed phy_power_on() by calling
> qcom_pcie_phy_power_off(), which walks the whole port list - including
> the port that just failed, and every port the loop has not reached yet.
> The phy_set_mode_ext() failure path returns without unwinding at all,
> leaking the ports already powered on.
>=20
> The first of those is not a leak but a refcount underflow.
> phy_power_off() decrements phy->power_count unconditionally and invokes
> the provider's ->power_off only at a count of 1, while phy_power_on()
> invokes ->power_on only at a count of 0. Releasing a reference that was
> never acquired therefore drives the count to -1, and the next
> phy_power_on() returns success having silently skipped powering the PHY
> up: no error, no message, just a PHY that is never initialised again.
>=20
> The damage outlives the failed attempt, which is what makes it worth
> fixing. On a single-port controller the very first failure is enough to
> reach -1. It is normally invisible because a failed host init at probe
> time is fatal anyway, but it becomes reachable as soon as anything
> retries host init at runtime, as system resume does - at which point the
> controller comes back with a PHY the core believes is already on.
>=20
> Unwind with list_for_each_entry_continue_reverse() so that only the
> ports successfully powered on are powered off, and route the
> phy_set_mode_ext() failure through the same unwind. The PHY core already
> releases the failed acquisition itself, so the failing port must not be
> released here.
>=20
> Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Por=
t binding")
> Signed-off-by: Muhammad Huda Nugroho <mhudan21@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124151615.SjIk=
x%mhudan21@gmail.com?part=3D1
