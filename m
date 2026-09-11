Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6332C8B
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170145; cv=none; b=AYC66J+l9HEnvvbBg9B0nbabEo9kwjLqkTOpqv011z1vR2GPXemC59ivDXXeZb/Fwm33jTJfC/PkPMed1AiZ/FFERVHF2ZL9D7elXIFbt9aeVQhC2HRuEyyvLAT5JwuzZrjIA0y5BlmXO9MNma4mU68taEoe1MglQIjLh+7WOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170145; c=relaxed/simple;
	bh=a0sB83MLbhB+XHURLfJrN7ULqCeiZuLiQhsEaSgLqiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQol5lDzkAgmdJ5sBaVDrvc4fJvjp9RCV9/Ic/vfwP0BetGDmTKSotsWjOOdjfB69FPuS6wH+yKOs6nKVtcGxJoQIBY9ZSW/UlfYoSCzcaOPv086yqwKrMkqubY3mMDf5qwJrEB005Z8CNI4HjZh+pgzmJap5uPYonNf2LXA65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nirBILSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nirBILSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD441F000FF;
	Fri, 11 Sep 2026 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789170144;
	bh=D6hNjA/bLLKLqSaAU8HwK96zvlUzzL+dQc5n9M35NW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nirBILSpBZhpAOh/srrVAxs269PE/C8liaKds6LAzCif3j9IRv15+7MGO82hrxRIA
	 KPpPCUTtd7z9hy41CyIFM6lKrzl1Ek6IW1nTHWSW5i8q5DR/j/mbM9fSev006jKjM7
	 631yCuj5/Rycoln4JUsDoBp3nbnB/FzSuHxbbblUD4lEY2FYcNjojJa9gjNriCwNJR
	 RHxx31BSAIyNMDXEqBEbIGO0Zp3AUnDGIaRSPyptZwjOpuuA3J9As0JwrGgPgDu6NW
	 IlrFvwL7BQQSadHkiVTlf2KNPgNoxKyYDsysx7Ue6M3Cpi73njb+JOMF37WF0x/YHW
	 VPAS+9Bj99w1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] PCI: brcmstb: Put max_burst_size setting in
 cfg_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-12-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-12-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:42:23 +0000
Message-Id: <20260911234224.4AD441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Rather than ascertaining the max_burst_size setting by comparing different
> SoC IDs, specify the setting in the config_data structure for each SoC.
> Also add a comment on each SoC's encoding of this field.
>=20
> Note: Previously, the max burst setting used for the 4908 Soc was 2.
> However, it appears that the setting of 2 is illegal for this chip.  Set =
it
> to 0 as (a) this is the safest (smallest) choice and (b) the 2 was probab=
ly
> interpreted by the HW as a 0 anyway.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D11

