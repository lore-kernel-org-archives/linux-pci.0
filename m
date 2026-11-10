Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.255.230.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324083;
	b=CW5eqV/NFizbg0FyiV4ShTHAjPYmb3iADpd05i4sfjk9Mf40H4WCBe3Nt+rWGwkY+G27
	 fbte+FqNqAUzO35/+QMqi9z0U6BGFJNTTs+TEuTd1Us5mG1Yn/splfRtyArooVhXxDSPn
	 efk6OMifBPV9K0xlVGjDOodsBPpvLCvCdzEsBRV997d+ttOTmmfvo0CXlL0EG+Zr8QfMa
	 WXSIhMsAoZTtwzBpY0RKHedcMMQSLxuV2kVaazJUS8m3m6R4xwd6upbKYO9/MRJQbKMHE
	 NdPpDHIZ2GYZw1I1FqW2hUXxs1jc1RQyg+egPGD7xblRErj0LnnGXjii/G2tHPBJBuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324083;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ZDzEOtB5HxLBhdC2gitZjniK6UVIE9Xj9pNQpsrzKSY=;
	b=2x607UI0AmEQFrEPQDVgT6ICNs2Pe9Mgx/lchrB1cQYYw/nm4DgVoraehcVBy+J9c3FK
	 w+sEmIgbtr98Uj2nk34UNiBKa9/Rbj1WzUBYGyDYkvdaPVBj8Bv9Qh7IM/Z0b3l9Rqexg
	 kTq7y9HdeOwgy/8zbgo1y8pbPn+QsRi87jjTFsLh6GZA3UHLKXgKOHQYBIsZeubl7PNZe
	 1ghstq2vBm4spq9L86Pe66tFqNqrHk2fXgDsoZxGTChAUEj+yiokOa85dlc7HfI283Xnu
	 UzcQNjxhSA05ahtjdAEmauBiTqeiKk62f0EmNXDRIdGs9hQK9yGn0BGd64c8pcM4QVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucw.cz;
	spf=pass smtp.mailfrom=ucw.cz;
	dkim=pass header.d=ucw.cz header.i=@ucw.cz header.a=rsa-sha256 header.s=gen1 header.b=BSKUK01k;
	arc=none smtp.remote-ip=46.255.230.98
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC760A260A
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 15:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DFC760A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ucw.cz header.i=@ucw.cz header.a=rsa-sha256 header.s=gen1 header.b=BSKUK01k
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id F35C432984B
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 16:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1794324073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDzEOtB5HxLBhdC2gitZjniK6UVIE9Xj9pNQpsrzKSY=;
	b=BSKUK01kAB2mmaRdTPnZlPoKdlFpt4s3T4/pvfUa8boi0vrcN6Lc1+Mq0K2GLZo6GeEbko
	9jLPwDwxuH2hFW29KOx7cg3mfl5iQmeWVLa5cE8/S1y8CwrmTaxRIVJmj8YsxF82LNok/h
	RNb0HmyVb5UmYIJZDszmWi7e7gUIdSg=
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id C893CAC07D4; Tue, 10 Nov 2026 16:21:12 +0100 (CET)
Date: Tue, 10 Nov 2026 16:21:12 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] libpci: Add new direct HW access method intel-conf1-ext
Message-ID: <mj+md-20261110.152044.70145.albireo@ucw.cz>
References: <20260827233400.3224-1-pali@kernel.org>
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
In-Reply-To: <20260827233400.3224-1-pali@kernel.org>

Hello!

> Introduce the intel-conf1-ext method, an extension of intel-conf1 that
> allows access to all PCIe registers, including the extended PCIe space
> starting at offset 0x100. This method utilizes four reserved bits above
> the bus bits to represent the extended PCIe registers.
> 
> Currently, on x86 architectures, this method is supported exclusively
> by AMD Family 10h-18h CPUs. Newer AMD CPUs require a setup that has not yet
> been documented by AMD and remains unknown. Intel CPUs do not support this
> method yet.

Thanks, I will apply it. However, the patch no longer applies to the
current version. Could you please update it?

				Martin
