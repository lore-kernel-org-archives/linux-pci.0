Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843534;
	b=2j6zMhDvpvsasqBsmFq76AtRUQUb7YOQU/UnE+vWbIYcHJkQh2PHWCL+ifKtoEJjX8CQ
	 pucC0rVre/Z82B1nlSJh9NKw8rgHjbUMFaNOMH4M8vq9RNYJf6/qWQgLVxZhr/Qrw6Q9/
	 v36GiOdvqbZErlM89ua+yvOxsCQW6TbeXtMbfBbloYc+7YcNBdsgJ2sHJTPauEwGf3SBz
	 Jb3k2XHZ44A+2qM+3RHefFPzyYpkuLL1EEi9fKRBqbcgXJ0CvCl5iffD+VL0TYjhAIQ9T
	 8k+KCR1x35kN+ONX+igSrrLX6nYXh2fdAQJ7f8oMX9luEiNqbQvx7lyCVeD8tcytgFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eA0UBFZlDDBY/uJeYDScrqN7fg6TpqFd9QCMnEpmidk=;
	b=tfVUGt3tOn7ZKpq5tiPd0cF4ZUSeVJeIF1kwlxQ/gbuyn7i4N3j7hlwsbtAPRG//OZ+v
	 uMVL4MTChzFNsNARA9EN6EsPrw8+0Xh8/H5mXkgU6vGc/Wj6RCVg6HuvH3M96IHFke2wx
	 svci9NHZZiMrBFwlAwjRcKP2ssA1RdSCmW221jQCBzd7BcpRzTtsdPNxuTSs96h0m3PaU
	 H5kDzD6egQTTYjSmL6qJtCpdp2iv9hjnKrBn8pidgafEWKL0x9TxEuO8lNZnAvKDJeqso
	 Niqt0HTyyB1CvSFsDxs8xR9iWi5R6RLljpgUv5wpJ38WVVv2N9ZkMUioDow6FkuEsAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Igq/By8a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20450606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Igq/By8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8536A1F000C4;
	Mon, 16 Nov 2026 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843533;
	bh=eA0UBFZlDDBY/uJeYDScrqN7fg6TpqFd9QCMnEpmidk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Igq/By8aUACnUZn5GsHoz6mOPWDLV+5gO+zEWXpiPXEvHEHE03R95Do80nRGBGbmQ
	 K3JObIQ8SF5yUwOzpY2k5YNQUIwbBl29PEWWMo6YWO+ozjXVlCKew+EOWZhyF19V0z
	 40I+h8KkkLHitkoaYUmYKZcdEeyLlIkBzgOO3DOBAhBTFdhWdwbJhy9cvEWGY7COhz
	 USXF9n6y8VHErKdh8YrpZ4URLHY9tvjUopmBWOxuYST2kMMiNjwdNabeNaVjk36q9W
	 yQxLQ4UXbQhPloWBm3Ch1bc47f/wl7bo9wvvFdvGwJDiVOzOfh4etae3hmqVMFE2Qa
	 QoMQrD0yli6rA==
Message-ID: <sashiko-outbox-217311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] PCI: hotplug: octep: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-11-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:38:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Octeon hotplug driver scans single device and then attempts to
> assign its resource using pci_bus_assign_resources(). That function
> makes bridge window sizing disjoint from the assignment phase and is
> going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be no-op.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D10

