Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CA32B10F;
	Thu,  9 Jul 2026 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569957; cv=none; b=AGrG98+oZpOrddZ3Av8HezD5MnVIf6lAxhyImlUmm9D6MJadhwUg5wLlYjJDV8BykDPG4/bGUoknxOLRU8Hc8YjaObrwPCIMSDLwlcQDHgKNvfu1TRgTjm2Zizy4pq4IkCEmSCLUx65Qs48IoQhvKNjHYi8ng71uVYygm8sLtXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569957; c=relaxed/simple;
	bh=AhDNbmvR6wsPz2pSK/BBd6rgkBaH151DPYGJYMhJJs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HV9PVAg1wEEtw4XAxD5eRFTtOk0F5JMCit3tJawvCzfdGDVnJ3C+27Lfk549AbP6jjxJMFsbV+77mURCAsA21zaGOZSnvqrljiM/R2SlhOr+BEpH7a8pzfOJB8I9JaLO4wsKAUdYLe9SAS3kCExxobtx69mU6dSC03QYTCx3KOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZlKHHT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZlKHHT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EC61F000E9;
	Thu,  9 Jul 2026 04:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783569955;
	bh=AhDNbmvR6wsPz2pSK/BBd6rgkBaH151DPYGJYMhJJs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HZlKHHT7e50+Fpa2uPGZPyswVAVN/xQVgLZb999V3NLY41YS0FNKkG+H+0M/4b+tW
	 h8sSWrVfBGPOhgOElOLkMvm2p0S0q/rVWBh+SW70ImOxQTbox6m1S8rSwN5nIa/K4/
	 jlFLjIkw3/sEVseDfWuEv+hbswSZxL+rBb+6VHRwVEkUdaoySIsCBO49KpHHSig8Yj
	 t5KVdp/Dz0E3xXp4gLcR9sWUh39EWt3CtqbDSfj1B+6JxNvIVosnKxNl6r3oDpFVft
	 LxmP15JY0F4qwMSe5wMPXwZKtdNlmz9xhF3awAVycceO0FTU/evnqRqaih0nuH8e7r
	 WTeF7U7QOz59A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] PCI: spacemit-k1: Add device data support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260709040027.958400-2-inochiama@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 04:05:54 +0000
Message-Id: <20260709040555.55EC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709040027.9584=
00-1-inochiama@gmail.com?part=3D1

