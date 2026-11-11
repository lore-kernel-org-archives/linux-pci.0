Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377805;
	b=FOwtcpldHCyNtL4/lzUeQYY/CQfGezsOdTVhMaHyiClUwpM8KBD1UXh2bEOv+MCIDtj2
	 ezfVcN8KMip0lI5Vfjz0uo1IoGag/9eGi7EDtLLEWQNsq/ovVkQvN8bIdTb2hHzZsD+o/
	 j48zsHPNEVfG3JsP++qWs9qosLLLRMv8XifVkR18MCu+G+THxaORx4xDB/ZjjWatWDAx+
	 q+BzgHL31OPPvanMJEyjMHvpciHwTPHFfHsLUekKcpzxgUA1TslvjX7bgBQFb9tu+XyP0
	 1w9hnhDDBKI4LzhsY3VI9/jb1esWsExJSmKIeD8ak7ILDj8rhlf59EnzVlCx4B4LR9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=chgLcgNWWDGwDS8IqCXKr0ZTijn05W98YYLpF3I9fXQ=;
	b=eJfKiQpucWodr0JdE0d195D6Up3EKpMU0WjrthSqmaQOFGCLlRkLJpHBlGhdGP1Wqu6i
	 gVlg9/vVe/P/0C3zig/AJI7H0TXCJ95EYSZUJ9ohWadGhqEUilICOStq+ez2s4RmLwm8i
	 73bqha8hODt4fDG3lm2L1gThBU5+B7bn7hdAHJHfaSU0HDbKIABIbEcKzp0AAzk+M5tI8
	 snseATHNek6kOM/mjTnOuNMZb7s/odRqnkCzb2ZZ4c980pZUdpfnUdyQjwRosUf4lJMef
	 H8ubaBnpfRDIAIHtUaDk8u0LWXL1SWGnH2ElVXG1eBOR4Jq/jhm8aLDWcvSBrf89smw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXLQGJ8d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B273606A335
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXLQGJ8d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E537B1F00A05;
	Wed, 11 Nov 2026 06:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377805;
	bh=chgLcgNWWDGwDS8IqCXKr0ZTijn05W98YYLpF3I9fXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GXLQGJ8dXsA1/UYCos49+g9Y7cLE5tsm8IwgSlxkiDcmcKHWhhQd2k8M9H2ODszNZ
	 7GgEM0J0wxIL9+ahDrbmQ+YIFYNOn1M6Uiit1BLcGZlyf/h2aGevvQwIcIZ6WTbhL7
	 7mf32uJ/68t+fJRAFgfdlbfrU+qyc/0Ib+s1NJqwpSZC9kB1rIE2FenpZKYkz6izOx
	 YA8lExodMVE9TdZrzRSHqxwPfZnY9bJInGuqkv9z5GVSMJGiYcrIywAW1eTEpVASBN
	 OgO3CQDxvzrjcxiysUPQ4yzC1c6AGmocsTQJTV+K8LsXbOEcBn+/c/kyZNY11hMZWP
	 j7mF45/R67uUA==
Message-ID: <sashiko-outbox-208413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/19] liveupdate: Add feature header to struct
 luo_session_ser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-11-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-11-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Precede each serialized session entry in the LUO session KHO block set
> with struct kho_ser_hdr via DECLARE_KHO_SER so future session features can
> append fields to struct luo_session_ser without breaking compatibility
> between adjacent kernels.
>=20
> Size session block-set entries using kho_ser_size(luo_session_ser),
> initialize each entry feature header during luo_session_serialize(), and
> validate the incoming feature header in luo_session_deserialize_one()
> before accessing the struct luo_session_ser payload.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D10

