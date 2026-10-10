Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF230DD22
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791653337; cv=none; b=iyoNPnWwPwOiwm9PetOWyHZuPNUxKylwPWOqyXdDFnxaVGtKo1ByFCFAF79LzOXgCanJ9NnLkUw0/mGjp/tj+625gBlR+WeOUuOLXKW3L2QUr9d40QVGtA6O6SqGNF28Lm0TN4LAImq85m2IjT3PpSGzgI2pbCQXr61H0b0J7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791653337; c=relaxed/simple;
	bh=hLveaNtpDt9qcUlIXEC1UxssK4Fl3axksGW2+7Ie4WU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bop4qIo7hJX5+7jUalcqRX6fMHDqxnlO9KIx6hZ/W+L7bCWuIHir1IohrHm+/52QUQhexh5c5l1INAJl35Ez2bxTkPsGMf97bRVZqQrploBoq5J/ZcAMnepeAt8uK2xCRb7rCG8STYepXe2ToalgxNjF41tzB63jkSGXGgF6xHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9ylZi+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9ylZi+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C701F000FF;
	Sat, 10 Oct 2026 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791653336;
	bh=hLveaNtpDt9qcUlIXEC1UxssK4Fl3axksGW2+7Ie4WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9ylZi+P0Jw4S8Kwoo4ozKMNi0avOOuNUHol5P4bHPz6gAHqDQMQzH8q7QMT09XhE
	 IaUVEMvsEOInA/1maThNstJL1Uquhh2K8Zc38FFYL3J/u8hTVIwaKQtxkPuhHImNlL
	 KqruT1Y+IGAxtpn0/dZ1ygX2mNRLMN6B9uLxRFgHkPfM6/hTms4u6PEvLpN3ysgFuY
	 rxwmugbnbKeBPWz4EkiY+eq166Kia0WZ/OuEfnxw1jbPSnOa2Sa/vV2Ah2bdzrL6hs
	 zKpJI60Ok0ElaHISrj0L7brY1efLzrPSVbU+AIDYunB7GZLYZcjjBKA8dn1SDuPAPv
	 bKsoY8S65xuww==
Message-ID: <sashiko-outbox-166774@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-linus] PCI/AER: Skip unmasking Advisory Non-Fatal
 Errors on T2 SEP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <aditya.garg@linux.dev>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261010172301.12764-1-aditya.garg@linux.dev>
References: <20261010172301.12764-1-aditya.garg@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:28:55 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Jason reported that since commit eddba19b8b5f ("PCI/AER: Support Advisory
> Non-Fatal Errors"), the Macs with Apple T2 Security Chip were powering
> off a few seconds after every boot. He also found the PCI Device
> 106b:1802, which corresponds to the Apple T2 Secure Enclave Processor was
> misbehaving and the most likely reason is that the device is ANFE
> incompatible due to Apple's custom hardware.
>=20
> Since its highly unlikely that Apple will release a firmware update to
> support ANFE, introduce a quirk as suggested by Lukas to blacklist the T2
> SEP from ANFE.
>=20
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Reported-by: Jason Perlow <jperlow@gmail.com>
> Tested-by: Jason Perlow <jperlow@gmail.com>
> Closes: https://lore.kernel.org/linux-pci/CABZrw2HcaOh3DHTJtxU5dXrb3Vg19s=
cr6+qR-xe_+R7rME35_Q@mail.gmail.com/
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010172301.1276=
4-1-aditya.garg@linux.dev?part=3D1

