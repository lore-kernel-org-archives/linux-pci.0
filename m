Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763670;
	b=p4UdQugO4SCrwrDwvZ6lStV7g/8epcO+hHUJefFDWK2wojzHyV7e+EB4ThkOf7TDdheA
	 J7whOm9rUn6u7db+FDjcmSKi88KPi7SdXMd0u3FME3hpUamjzheT4SbcLMeUfisn51kOJ
	 YlTOZ4Cs4Q55X7yKCh6zp7kppTJeVl+YcxEVdnvJG3U9Rh70rMbL/w/nXiuL1KXS+BbDs
	 Acxn50Ea1+TKYxG3r4QAvNOJfNsV/BV6+MwisJj3naMGtEbMQZRui4q12ZT957CTbC1IC
	 mT7yC1ax4JhlmIC6G28+oHrAiBQ1w6/R+IR9ZGW3uH64bKQcZEaiJUkDhgk3cYaLMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763670;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ai/vG2bUN5TazXmmmfQ1sSYRylMiZr1yE/+KpUxWjE0=;
	b=rJnz0l90uzqC2rWS1c1IhVQuoF5NtWQbUmmzK2SPT2KvEVXYS2qgN93gj3kd9dORw9Pq
	 aOvs209A66duSooyZVE5vz4GRXXVD9Ldvy3yMCqDCFhOqZZYtE3xAcRt9JH48UVHe1BBQ
	 fRwelRIkc72AF8fTabnzgfgI3/8GpnUir4DiRiLrXzAAgn7VFg05seDaBBEcpZppUZiAD
	 WeNji50/GOQ8kUrTYDG9MkQa89tdPTFlkltP/umOTwi5g3BTxIWvxe3CH1J1fjr02ZBZO
	 yVjNl0tg5hylKK32WpAn5MJglgEfX3zFIxXboHXvBngFklnmB2vs/f9yWsI6mhg1AOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPhUEWJ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856D606A31F
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPhUEWJ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120AF1F000C4;
	Sun, 15 Nov 2026 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794763670;
	bh=Ai/vG2bUN5TazXmmmfQ1sSYRylMiZr1yE/+KpUxWjE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aPhUEWJ2cdMghBRZCQgIRLfqkqZpiIO+0kzZLOl0pZbFUj3KcJ9ZmEb+Zcl08VbB/
	 6MjpzdJ6ca1CwSGVFJgIz8djzt/ZUj9XFOG/UEG4IRhL2yiF3API1SuOiBeVjK8eCM
	 nYZdMs7jhQfTEn0S3iCVmea8e1l5hFB4wJf6dxMrPWQ9lOziOstW3Dhae5aSurQ7mL
	 s7kcC5zpjv68x/sh4y0UHAKqZV6qdITvxhMfzx7kiN2+nHNONL2iAQjdb4OXEEsfm4
	 LtvJm6DIOBjkT4NijuBEe37k1npeUybChNncbxzQuCJkb4wHsC92fPd7oDWBuHTdkX
	 eMaDD7y4YnmYg==
Message-ID: <sashiko-outbox-215679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: Avoid runtime D3 on Amazon PCIe switch ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261115171831.1498006-3-avivb@amazon.com>
References: <20261115171831.1498006-1-avivb@amazon.com>
 <20261115171831.1498006-3-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 17:27:49 +0000
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
- [Low] PCI: quirk_amazon_bridge_no_d3() duplicates quirk_no_ata_d3()
--

commit 23d17d7ee035a77b0f0e403734f5f387abceea6d
Author: Aviv Bakal <avivb@amazon.com>

PCI: Avoid runtime D3 on Amazon PCIe switch ports

This commit adds an early PCI fixup quirk to set PCI_DEV_FLAGS_NO_D3 on
Amazon PCIe bridges so they do not enter runtime D3hot where PME# is not
asserted for hotplug events.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee41..292047804b09b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1476,6 +1476,18 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AL, PC=
I_ANY_ID,
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
>  				PCI_CLASS_STORAGE_IDE, 8, quirk_no_ata_d3);
> =20
> +/*
> + * Amazon 1d0f PCIe switch ports (e.g. 1d0f:cec2) on AWS instances
> + * advertise PME# from D3hot but never assert it, so hotplug events on
> + * a port in D3 are lost.
> + */
> +static void quirk_amazon_bridge_no_d3(struct pci_dev *pdev)
> +{
> +	pdev->dev_flags |=3D PCI_DEV_FLAGS_NO_D3;
> +}
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AMAZON, PCI_ANY_ID,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_amazon_bridge_no_d3);

[Severity: Low]
This isn't a bug, but quirk_no_ata_d3() right above has the exact same body
(pdev->dev_flags |=3D PCI_DEV_FLAGS_NO_D3;) and relies on
DECLARE_PCI_FIXUP_CLASS_EARLY() for class matching.  Could quirk_no_ata_d3()
be renamed to quirk_no_d3() and reused here, matching generic helpers like
quirk_no_bus_reset() and quirk_no_flr() later in this file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115171831.1498=
006-1-avivb@amazon.com?part=3D2
