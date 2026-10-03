Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39E3382CB
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013373; cv=none; b=JNrU1VUbFv0l0GVOaJdn7jStVO9H3lUxq024zzLIxRl4407Fh3a0aZxYFS3QyxvU+BAR97Up0kl91yTWiqerYXCkZPd4C4Ic8mmCLXb+EaSMAVIp8wOZTQP0vraTxud3zhBhNj3FYC/gtzOnrLM/2R2EmnzgUPv9th5JVybCfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013373; c=relaxed/simple;
	bh=FsJPbklTSC4beHiQnyHcPgZr3yD9MKj4cRCx+wDRku0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D1SnCdQhP+9nXkhI06BZtxa7OaobNApzcgmZNyL+lpQ7ELtBiukozapoMO8hAMa8/dq4uiAlqRxbZZ8kTEItFD63As6u9Tm0wfPzEtnBw9WAFqwT8GyzRFImbusDauSjinMHy/TslPITa0V8GvvJvsvBBSepb0x4nOmwfvhZRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEgUsQ9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEgUsQ9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19FB1F0089B;
	Sat,  3 Oct 2026 07:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013371;
	bh=FsJPbklTSC4beHiQnyHcPgZr3yD9MKj4cRCx+wDRku0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEgUsQ9UoNY3/ruOI8/fOxFbktnBN4GM67BD42m1ZaqqSQnmofRsRUUmWjBQyPTqs
	 xIr3VNCfIhPMfxTopbmMCALR3585wU20SRnDittY5YU4k6rcgnaUP2PnYHfmz7cU94
	 1p36GS/3L/UgNfNXVPWmrxnV3Da5DOEGyoJwrAmYe/SzBSMp9l39ncPfolT3APSkeN
	 HaKLoZ9XZB9iAe7FydKMAk5iLgI7aokHUlpl+TitV+/6H396KH8qXkIBwlAPz0JwtD
	 l4+laIgiMVsHRpHcQTp2WH7s7ur7jZzh8vPwlnRlES7Z33YAjr8pC0pNVHfhTr99N5
	 E021HSogHU6+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rcar-host: Validate IO/MEM resource count in DT
 ranges property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261003073701.354551-1-marek.vasut+renesas@mailbox.org>
References: <20261003073701.354551-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:42:51 +0000
Message-Id: <20261003074251.A19FB1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The R-Car Gen3 PCIEC controller supports up to 4 memory area mappings.
> Count the IO and MEM ranges described in DT 'ranges' property of the
> controller DT node, and in case there are more than 4, refuse to probe
> the controller driver, because such DT does not describe valid hardware
> configuration. Do the IO and MEM counting early to avoid controller
> configuration rollback in case of failure.
>=20
> Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003073701.3545=
51-1-marek.vasut+renesas@mailbox.org?part=3D1

