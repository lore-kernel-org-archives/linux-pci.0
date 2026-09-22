Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86553F6AA
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090085; cv=none; b=gPm8e1IalbtAyh99kqc+zV/IaAlSmzflKGsJ2XSpplG8WDVZSVF/4HWmyunqPSWUjxXZOUhL9Q3XqsrGu4VrtsB8gG2os6PfKCh6YOY2PNs+Ll0ayF32m6x5JzSfnLoTdjDuKRHLHB+Nbt9lI8gQqaKV+8z/dmZF6745PiurbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090085; c=relaxed/simple;
	bh=rVuKrwdBEE9YA3AYKBFfntaktYTkSKg2xinfAGUDh7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1q+qWkltvLBZU2yRZR+J3KNi11RtAGDj9ihd09bMzIwnd82SVmAn6bEHg0AMC1s5VJ8k4icLntP0Nfnfpa8xxF06gHdrJaMatNF6TbneSfwwWhfu9Nj3wQTg2rALQW9C9YsLEm82VueraG3IQmW9qWD68/9d29OpB//0y93O4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMw61+HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMw61+HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D7E1F000FF;
	Tue, 22 Sep 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090084;
	bh=ItIkvsjR9lmPIsAwSVYVIA8cGPFS7fDE7XlPmCFETew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMw61+HS2umHgJSeogufqqKSCeWttXr5NICKRyGfVU3m/8IkRkGsVftXTO4WWL8kR
	 CIKwooTjdsAGyix5pldzKsiaVAozLwHDZxG0e+j3kW7vPBaAlRwPQO6ad3r5WbPBsr
	 HpF60NieYi/8K99FFwu3XdD8n52dTTxcKJaObFLxZ7f8CrYlvRGTeLC0XkPpzoVzZ8
	 dWzIDw65V+BZ/hwTWbCr3MiSERXaZgQQ1A5g0fdEDPdkxJRReXjg14SMURvTzVmwVd
	 y+X3lcvPWG4rxmbVNkxxrPnrFwUZCNjA63joyxvb6Wc2/AuRmZUr9ZzJz4bRukCVbu
	 ukLKURY3xFSsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/6] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB439336B71D997B10A96651E5DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439336B71D997B10A96651E5DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:14:43 +0000
Message-Id: <20260922151443.E7D7E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
> isolation. On devices that support the PCI_ACS_ECAP capability, the
> controls are required to be enabled properly:
> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>   upstream I/O requests.
> - ACS DSP and USP Memory Target Access Control needs to be set with
>   Request Redirect or Request Blocking to ensure the Downstream and
>   Upstream Port memory resource ranges are not accessed by upstream
>   memory requests.
> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>   areas that lies within a Switch's Upstream Port memory apertures but not
>   within any Downstream Port memory apertures get redirected.
>=20
> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
> support, pci_acs_enabled() skips checking for the capability.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB43935D2C01=
946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D6

