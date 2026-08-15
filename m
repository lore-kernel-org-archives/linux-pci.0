Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E272C3757
	for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801946; cv=none; b=dPm2C+6JYxlQT7mAf/5kGt096rXuZvSX50O9trX9jacz3vAt5NIGUgA8d1vhh3eqxGCO2WCvAvxxIFb5pkkIzV9JuxpGDTI6kIpN8xbhnIv47nfGb5ZH1AfYUX9SDx/JG2//aczRIHWPsAmx6Hea4RlCugp4KopJTb1JjdyL6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801946; c=relaxed/simple;
	bh=oWCkVaUtqmGxwM1pr8xRwjtQkKYAHBYix9ENmXXsuoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VE0DO9Qmifway9TnwfzBK1YEOR9Osq0ipP19fZna0ZXQhCv8dAGsj1DUes5EluOF/UIf0q0hl80wgxTojuBm4VoTfQCEHAU7n8r2eFAvoRXiP8RlRH9unX3RjuOEe/OdwADLOgFmQSKd5r6KLgNtEKgwMQx4dSIvjCB7fuXOEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXbj5qJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXbj5qJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F021F000E9;
	Sat, 15 Aug 2026 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786801944;
	bh=oWCkVaUtqmGxwM1pr8xRwjtQkKYAHBYix9ENmXXsuoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXbj5qJwrThAtMax1LCNQbSOvYLTWr2Azm2om7Eg/tP3lox9Aj/v4Pjd7RCXOlt0f
	 FC5Z0idRSgkVz3Qwn37DtsecDAgH4g7sjSUMlFs1L+X6ShmHP+Uaomr3XR4aR6+yfR
	 4jiLU8JI43UXUBckKXUF5evXD98/ZaEWdPuAcOJ1kHUtMpX4dIBX+1KbnR9e9jLy2G
	 b2ayqbnpRyguHGoqwF/RrXCN0one5yMH78WMAMS+aS3CNMqmbmOQpCbUEDR6rBhNmz
	 ufIxJbANQ1aKHSHRuAPuyZUw7AUDFxBSKIRn3ISVfjdAsnYWKEEyuilITuABu8Mj26
	 sZkku7SyhOV8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/AER: Fix ratelimit and log level of Advisory
 Non-Fatal Errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <120da0565eac0157ffd913423c7cfa66e985ff59.1786800931.git.lukas@wunner.de>
References: <120da0565eac0157ffd913423c7cfa66e985ff59.1786800931.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 13:52:24 +0000
Message-Id: <20260815135224.B9F021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When Advisory Non-Fatal Errors are reported, the Uncorrectable Error bits
> should be reported using the same ratelimit counter and log level as the
> accompanying Correctable Error.
>=20
> This is done correctly when they are handled natively in aer_print_error()
> but it is not done correctly when they are handled in Firmware First mode
> in pci_print_aer().
>=20
> Fix it.
>=20
> Fixes: 21963e6e4e04 ("PCI/AER: Support Advisory Non-Fatal Errors")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/120da0565eac0157ffd=
913423c7cfa66e985ff59.1786800931.git.lukas@wunner.de?part=3D1

