Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B18313E2C;
	Tue, 24 Mar 2026 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378490; cv=none; b=kQy6/1ysmOGXaRVvO2mkty9pE80smDoqMEkFda4oOLnp3cMdDMfcSlYMiNcER899bLSZmB31L+YNlZrdhmc9ROcqS0FJm+jEOuSH/O8uckXWxZsjLrFvV248S0MIFPmqu0ZU6B8twk0ebuRRDhWl5PmkWud8QEGbqaJYyri+bRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378490; c=relaxed/simple;
	bh=qGrGYShj9X/Gsl0O9LrUoheJwbXfkqHTA1XpMcuBu7A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=u838uFSnxjJ7M+nzq3m8M/8x43j9BlB4zF2WXtD49UKmU2aZ6w1TJZC3baBKnzzvzua9CZNe89uPNVeSzTHiy0KTMw8kjovD/GLj90m5oef5v02t57/ha76xkgHgAe+tlhJzPp+ryYuKxTrcP3muXo952IhfiKxBmiIkPNQgcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=H68nQJjN; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="H68nQJjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774378483; x=1774983283; i=markus.elfring@web.de;
	bh=J0iQ3OBbdLnlKvcf8NJMhIMrmMCMx0Q8P3oFr7nGAwU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H68nQJjNhzFE4YnYfrJ6SXFbKPYrJEB2kgai4XItflLcRP67CrV9sPmg2grib0qC
	 8Sn+BVOkgGa96hgypa0Q1Z0W+ubJr/cUXr3j9I66y1vQjwJH2pSD2XglLeQWrnDOW
	 PMT64c2r61EOPqWC2vtw1nPzmepFTr74hiximrn5bxppxsHlsETx9n89WXpYp+Wj7
	 jqbzUYsEmZe/Z7jtq8E4k2PyFE4iYGoxIj5OqR0ZRqAHGkLTBfuZvuia8nsgjPJai
	 B69PhU2FQyc3kwM9RBRFJ25X7Vje+v6GaJM5q0jZm1DWGRnYgd4cosYkKyR30ObQq
	 dtxH7mI8VeO3umxJRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbn2-1vEedZ07Zm-00wM73; Tue, 24
 Mar 2026 19:54:43 +0100
Message-ID: <a9db10d6-6db9-4939-86e2-f8cd169e6d96@web.de>
Date: Tue, 24 Mar 2026 19:54:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Felix Gu <ustc.gu@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Hans Zhang <hans.zhang@cixtech.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Hans Zhang <18255117159@163.com>
References: <177433688851.20261.7315743280318704387.b4-ty@b4>
Subject: Re: [PATCH] PCI: sky1: Fix missing cleanup of ECAM config on probe
 failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <177433688851.20261.7315743280318704387.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xAyUJQKlQ6DA9SaziGFO23pZntfTVfTMH9pIEZjKnniQacGDEME
 sIcJ/RAFka8NNkTaSIn33eAz2/pDin5FygRWVowho0jgmCIvnCflsS4QPc6t1mrBlLYiUjD
 EXqtTokM/pPjriAKvi6sSoJx1gVGvJA2ts7FdA/3STUVcSQSrDsbKGEbQfT0jFzB9+JkYEt
 3AQR4Ct3K5c2Z4lsRtb8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:27rwNnPESyI=;Uqfp/+5yXc6O4+gqplPUAWQS65u
 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
 Dh

> > Add the missing pci_ecam_free() call to properly release the allocated
> > ECAM configuration window on this error path.
=E2=80=A6
> Applied, thanks!
>=20
> [1/1] PCI: sky1: Fix missing cleanup of ECAM config on probe failure
>       commit: 72e76b63d6ff6d1f96acccbfc6c118656f63e66a

Can the application of another goto chain become more desirable for
the implementation of the function =E2=80=9Csky1_pcie_probe=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.0-rc5#n526

Regards,
Markus
