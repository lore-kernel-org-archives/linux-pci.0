Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316590;
	b=nW8e3AXojZMQcqcjeiDKeaqTTBBBsSpFAlOwvc9xZvxcKFVbwLISZ06XOwGl11iaJgBi
	 shJms6dt0fLRZjp2T062pKqaTsHn02Vn9UTCD4V1BZtcyiIUreRq4rsZgEdc1BWBOiJq4
	 2giJdk4brv8MEX+AbyiBxc5RAxRj8utb0w1udLbqRBaFDHZ+bkMb5ooOx+3c11MdSPuT0
	 bkg/c4Y8lZi7bGyL61aAYwm1nPwQZPUjrM8XRByL3vtZUjsDf6XGCleCXqXjzpPS3rSbg
	 H3YX89/H9no2sbqkxEQsXQwName8KEagQsQ5PsOSmZ9JNDIG0J24ErUxVaBYkPlyyXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9+cb67OYAd8qNaddyybc5YxwQ5oWS5QK7bJW5eY8FOQ=;
	b=Bn/+6STqlKFMISVSDII2KmnJK0pVM55ouywmeVoXFqRSSpKOMfIhgyXQQ5oksqJgRNg+
	 ZfjI17ynpfqR96Wv5RmWJRliZ4Zj1A4jfqU0icxdeLCpAUpXkZadjhWTNMC1gERYR5aKI
	 Q8EkXv3w6AqySZ3epzEG1k7Ijv0mLJdaXwQLY3CUHpykuXtzECEAPBhYUYXBQAIvyKjhf
	 OTcmAnHdZ8ogmv6vpgUKBQfIALsdij8YrKBXaTY9WiR1ZJ57TWbVYTZHivHwc4aWquYy/
	 O/82dh8s5oZk0DqFBFJqhNfWc4hrCvx3gqQ3nznap4Zz4q7UCA1vDv7Jy1FU6NxEPyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2QOF3Lr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7756606A320;
	Sun, 22 Nov 2026 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2QOF3Lr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6AF1F000C0;
	Sun, 22 Nov 2026 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795316589;
	bh=9+cb67OYAd8qNaddyybc5YxwQ5oWS5QK7bJW5eY8FOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l2QOF3LrRwShLKnBfuxY3V5MU5PgPIa8vdUO7KV2VvaYWLjWHVZdAb06WqTJFzuOa
	 RpAFCOFhD9SewuEA4YmtXHS88HYbI9VVh7X2Dg2DKuU1paomrzmRfnxjf0sgZewWz/
	 U0QV+S+ne6nvVxrZezEFDLq7hcFfTQyyFj4qpaMpSc5BrPxOYZiOk47xSFTVsz16NP
	 oCrTgHh0UBtKRjSqPsmoc/fAANLedPTh95aYRry+vzPFCUv5rHEDeqZRF1op8GTh9L
	 jt55CZtJ1NLvFVJM9ADcV2KpL0GQfw96Uur4Bkoikw99Exiyl/uZFq+j9hqAFsw4za
	 SA9Z0Wn2lFDew==
Message-ID: <sashiko-outbox-227654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] PCI: epf-mhi: Pass the actual number of MSI
 vectors to pci_epc_set_msi()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261122-nord_ep-v1-1-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-1-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:03:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: epf-mhi: wrong Fixes tag and attribution for
  pci_epc_set_msi() bug
--

commit 65569d8fa7d0b7d1c73f3c6a6921db637279c429
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

> PCI: epf-mhi: Pass the actual number of MSI vectors to pci_epc_set_msi()
>
> Since commit f62da6e7270c ("PCI: endpoint: Align pci_epc_set_msi(),
> pci_epc_ops::set_msi() nr_irqs encoding"), pci_epc_set_msi() takes the
> number of MSI interrupts directly; the controller driver encodes it into
> the Multiple Message Capable field.
>
> The MHI function driver still passes order_base_2(info->msi_count), which
> is now encoded a second time: for msi_count =3D 32 the controller adverti=
ses
> only 8 MSI vectors instead of 32.
>
> Pass info->msi_count directly.
>
> Fixes: f62da6e7270c ("PCI: endpoint: Align pci_epc_set_msi(), pci_epc_ops=
::set_msi() nr_irqs encoding")
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

[Severity: Low]
Prior to commit f62da6e7270c ("PCI: endpoint: Align pci_epc_set_msi(),
pci_epc_ops::set_msi() nr_irqs encoding"), pci_epc_set_msi() already
took the unencoded number of interrupts (1..32) and called
order_base_2() internally before invoking epc->ops->set_msi(); that
commit only moved the order_base_2() call into the controller drivers.

The double order_base_2() encoding in pci_epf_mhi_epc_init() has been
present since the driver was added, and pointing Fixes: at f62da6e7270c
("PCI: endpoint: Align pci_epc_set_msi(), pci_epc_ops::set_msi() nr_irqs
encoding") (which is marked stable+noautosel) prevents older stable
trees from picking up this fix.  Should the commit message and Fixes:
tag instead reference the commit that introduced the driver:

  Fixes: 1bf5f25324f7 ("PCI: endpoint: Add PCI Endpoint function driver for=
 MHI bus")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-nord_ep-v1=
-0-6d8839ffa9aa@oss.qualcomm.com?part=3D1
