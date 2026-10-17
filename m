Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3215E5BB
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257895; cv=none; b=QHdp2fQn7zwGhQcQ1vV08Xu1udGmH88TGZf3Mx8qdp9DmchaFsIvBkHVR2biv/o+zITKF9bx5mz9Z1fI+muTOPFf4z86lw0UPwIjDftRk+grSXmzhP7hCBvkTcwuY1xCy0eYJj9OzslpeARfB1T7EHye2ldDuxZV7K8re1VuRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257895; c=relaxed/simple;
	bh=/oFToxEoLeUZOJAZxB6FswlB7mvQFdg6GIrwAdXwcD0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=AQRSNM262RDnISdbNzHFY9vnmJpuImoguTOPe/UrlU1P6gJR3XYEQuf5WLyqIPh0s5N49Y59bhK0rjExBCLaN5hxJT3dryqTqLSGYveOD+3r2ZE4hq9KrPeTyq6NEOoSbYvhHOL5G5FSIVKQMC7LBi8bW7sExuF/NExe7tPP2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSMC9Pk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSMC9Pk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A501F000C4;
	Sat, 17 Oct 2026 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257894;
	bh=/oFToxEoLeUZOJAZxB6FswlB7mvQFdg6GIrwAdXwcD0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NSMC9Pk8Bc6avl8ML36qiXHg0EXGu0w+1J+2dM7fABlEgKiiIJlREpZYRAbqzHtbQ
	 HqkPWH4R29q7VIiT4eXNRLMhFMtwQVtFlLccvC/T7W8yK1KvievsiINAogurWfVoNY
	 b58D1NFbgcNvZrt/oSt6tZxv/bKLY5wYkFQtADLKevG0Uw1UcjsBgayo7UC8oUFxDX
	 thhNQuRE7jJU8aQssMqBs829chdgjYSjX0gaoWwLZlkVt962uTWUpxNKwpD21FTk7r
	 W70foefyNCdYJC65jQhUrRH+hSRIuILvQUeehYlu4+BL1BeXXq0fv7APHfGVIUE9uE
	 9eVSQW8E0gRUQ==
Message-ID: <sashiko-outbox-175702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rcar-host: Validate IO/MEM resource count in DT
 ranges property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
In-Reply-To: <20261017171845.225769-1-marek.vasut+renesas@mailbox.org>
References: <20261017171845.225769-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:24:54 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The R-Car Gen3 PCIEC controller supports up to 4 memory area mappings.
> Count the IO and MEM ranges described in DT 'ranges' property of the
> controller DT node, and in case there are more than 4, refuse to probe
> the controller driver, because such DT does not describe valid hardware
> configuration.
>=20
> Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017171845.2257=
69-1-marek.vasut+renesas@mailbox.org?part=3D1

