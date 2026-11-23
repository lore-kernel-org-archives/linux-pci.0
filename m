Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442887;
	b=APbdbncr4L3SclU208EuEnmYm9IneoMeM9POMoRi6qg4a1NvJW4iz6LOrAUidZ0unIoz
	 yKg1g/7nY1XcszdaFW4NXpRQWtcd1A4ou+W/iBXErrdUxZC9IReOKBTk66VSkb4J72uQR
	 0DGOA/G7+ylHOYENkHTUJg4sP/wrnS3hf7boo4NqYdB6nZWpix+maXJA//WVcVAgFjNzp
	 tGu7DBhEhAhUHhhZUcmcBuFlHY77q3e4BiEgwNODQ42NLH/g4ia/PXkhv66YasAHvW1e0
	 WOZTMF7xpDWX7zevA3SvE3iM98Uj8tCAJxwX6S/7WBALMjyhTDLmNx7rJfasAaqZ1Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NA1WM0AkTBj+AxDqoE4P1rRwETqmv/SMJf37jdLBM+Q=;
	b=Y6IDTPDp0firXwvbYb12bY3x6N4Y2oMMnE9NnZkEFqwvSs6UQLprzNBxceSMEcc+S5WJ
	 zubmSuhNe3KnddOEUhvVO5lESjc0aIW9BM2kgS4tkpSNVNerrsN7QuKdbWCLt0vHlfDFV
	 tVG+gMI+pZm5FtjL6gM9KzNMbGovCwlvAimPkMmYJjAekPrlk++UXMzeRyhqy3qnW0A2y
	 jWORb19fOkZNuYGLtn7j0LSdWXxziKAcFNr8zzNBapKQwWv3hGlVM7ZYEwzRiDhjTzTPn
	 gxrjAfow8oVXf6quKlpd3APg8VEwV6PJpZBGMKsN0ZKdifgIq6dS6bI8Ahvt7ArMmAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N658LHvl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB1606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N658LHvl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4C51F000C6;
	Mon, 23 Nov 2026 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795442886;
	bh=NA1WM0AkTBj+AxDqoE4P1rRwETqmv/SMJf37jdLBM+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N658LHvl4CzedhNGtHOWfRNpDp6k4TvKzQfY0K86HKnmsC5Y/Y/LF/0kpme50DzX0
	 AuDF2Sg5Z5GECawDLdEWGnTXgTgtplDFn67FMPu36Gpb/RY6xmJIT1PZD0p4HokHJt
	 zr+4VvjxXZDOff6/obz4PsiU8RuiyvwRGKn62IbWUbIZKQyx4JwfhReziCtuhjBOQ3
	 1/jY7ozoCo2HrQUSGCgXPivZZ3ZAid0B5DHLomW4ODY8cSEJ+Cz4kIyETqw3qTbtxq
	 xffV4/mrQg/nXS1u9Fox3lAB/Yd2kj2HAbKGiBzRANTVFuXHJ3W8E8uhGPTuVhBv46
	 UfSTUd/SqdrmQ==
Message-ID: <sashiko-outbox-229378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 0/8] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 14:08:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 8-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-monza-wire=
less-v9-0-450d7d764aea@oss.qualcomm.com
