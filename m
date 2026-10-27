Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104330;
	b=4xLldc4ISLNuMMlEaE63gku2v1kO/6CzitYLNAUDwLlUUZzHnXbKZNrNyDhKF30gmHcM
	 tYyjSSi9xBVluGpsXmNahCcIlBgLI00xaVMcqRB7CvSn2Ew0WNs2b+QJNqIT61TNtOdK6
	 lDpZbXbw7o95lE+hrhyKLciw0QMKKPdBw4esZXVBxLly3o0SlvRnKKEnccO73XkScihBV
	 O2KLjcEpfK8n/ACcx+pX9iw2jmCTgIbO+WP2HRkK+Fw1/n00IQUi/r/3umNuHSAnsjQK5
	 ep7NyENnbY3aovidDsahwuhAkMy4Jh40DsLIkayI863fEKhlMnkHvag18Uwl1r30RaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aFTMmRa70u5jCytRDzP4qo2dsgp6AcwI9KjPOE4emyM=;
	b=xLn1aS4CXJe3EFHJ4fMf7QgdczjdOwXQiDjk35IfVPmobddg35JfVihnR9iPv+7CCtGl
	 6lr+imrQx5qngoEYVrtIdTRl1dkeN7a51uEXNVfthFYDtoj3iP3VSqQK2d5zrGy5jm9Pm
	 JNpudLKsRBubC9LBIa4vJlfHCdCW/yU0I5nenMCaHF9dkhQWs/1528cRwn4/OdCcrcOv/
	 y20lGAEqXe32iDdoC8nCvdR2b2kNfeexLfa0zTeEnWNzmrSmw4fSaWzgE1wqdxDjGuHUN
	 CdHUVE58TFHlrLtjPIuATCTPcd5HWqv1G8+JeXt9eV/WCHNXLlmXYb8C+Vkv9Twr/LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilJKOHbR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE45606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilJKOHbR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042D31F01825;
	Tue, 27 Oct 2026 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104330;
	bh=aFTMmRa70u5jCytRDzP4qo2dsgp6AcwI9KjPOE4emyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ilJKOHbRgbQAQU9MY5aPAVA5KAXfQABQbvcztKWuiK2/saIWRqY9uDg2b+y5OV9nw
	 RN3xSeZDR7U/tVuNrYwAZqFUeOcop72rCSQWFKOZarjGlLhoLFTCR2X7qnAaJWU5GZ
	 0GiEAvZ5nRBIJia8ijGstUWm6on2WNhmSHJfvkp7jdY+YlwhJY1S+loBiQYuZ7Dvli
	 CybsAA0QECWObVXaEnDVVv2gVjoV7z8MvST0qj1TEhwM3XtV7HJmvqtNt/+f1umDHZ
	 YjX15eQjKdQs5Vcu43MzxK6Yl6AzpStw8wkFTDJua3+Wd767idVCS3CRriVDUdeAms
	 bHbf9++Lzw2lg==
Message-ID: <sashiko-outbox-186552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/16] PCI: dwc: eswin: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-8-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-8-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:32:09 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D7

