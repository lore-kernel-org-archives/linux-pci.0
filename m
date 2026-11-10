Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.113.20.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330173;
	b=b6dMVTgFZ31TZAkHG2CRC7+NYIONmujkXA499HUGKxU/ysU6xA1Zo46DxjpFpESMS0NC
	 GsHUSkoVuzmMoKXnPAVfADIz7giI/MMoBHIwOhPxh8cKYPgzKsSd5WsWx//DEts3CNfdi
	 ZqEdgtt1dzmB0HcS6nlmdyU2ALo/NTEhtaIdEfmZNnCswX4+TC5vlO39L3z2rfaI3mUuV
	 TDuuiVstNaOjviPtj7MhqGRbeOqFNJNLJBFIIRNX1X9/1YkykIxwnWU433SgoTxty073w
	 QCjpOrgylyZYK9m0gUnkdHm5k4ujvd/xWawN76GFfgNHr432fd4vhsrWzFJbkHzc/eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330173;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=xhc4fYabkGSU9eWtpN1CPVy5C15YRWXRg6W8c0X/O1g=;
	b=fpQGKtmy6cQNY9HFQOaBIgij/Re1hQZz2RNbCCZiGr+2XU8GAt2nDGr8Bfn1buof+TW+
	 e/wTDUywieep3siZVg1Bm0TyRpJqSpJV87J7NF68MlxQKiRtJZXu2JdZeqlQmBU5C7wBz
	 nc7mF0vnEdA3S1PeD4FJDCWc6PlQT4fOyg4p8sMh9lLzH568sak7/ftPmlh7bkilFRDLX
	 /UNJUczpQioBFjXNlu8DqdnrMAgR90tcm+r1SWIFyyjzj48lye7Xh1GB/mvRVNkBXg2LC
	 IKHQfyXuTgpNzAz2oT8f4iTwvhLsIV+ZJK89zRScF2qc3ZAzq40MFI/sAiA9f+omGpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucw.cz;
	spf=pass smtp.mailfrom=ucw.cz;
	dkim=pass header.d=ucw.cz header.i=@ucw.cz header.a=rsa-sha256 header.s=gen1 header.b=Ok9Sq8Hp;
	arc=none smtp.remote-ip=195.113.20.16
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50261606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 17:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50261606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ucw.cz header.i=@ucw.cz header.a=rsa-sha256 header.s=gen1 header.b=Ok9Sq8Hp
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id B632E2878E2; Tue, 10 Nov 2026 18:02:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1794330162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhc4fYabkGSU9eWtpN1CPVy5C15YRWXRg6W8c0X/O1g=;
	b=Ok9Sq8Hp4zAYvJSJN+zBfyWB/T7yVtyw2f4CbpQJj0F7JGUmUz88hfj+caKjazaqY9x1oB
	s8yWOJZuuDn4IKQGAqoIJmRQzpjiu2OYdPouUzEmMaFWWf9gX5tcsvsDEoA/sLqWxH0ixC
	rF1zDNQUIOoFowF6W3NIs32ZsuNZ1zU=
Date: Tue, 10 Nov 2026 18:02:42 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] libpci: Add new direct HW access method intel-conf1-ext
Message-ID: <mj+md-20261110.170232.70166.nikam@ucw.cz>
References: <mj+md-20261110.152044.70145.albireo@ucw.cz>
 <20261110160806.10142-1-pali@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110160806.10142-1-pali@kernel.org>

Hi!

> Introduce the intel-conf1-ext method, an extension of intel-conf1 that
> allows access to all PCIe registers, including the extended PCIe space
> starting at offset 0x100. This method utilizes four reserved bits above
> the bus bits to represent the extended PCIe registers.
> 
> Currently, on x86 architectures, this method is supported exclusively
> by AMD Family 10h-18h CPUs. Newer AMD CPUs require a setup that has not yet
> been documented by AMD and remains unknown. Intel CPUs do not support this
> method yet.

Thanks, applied.

				Martin
