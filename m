Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41A484227;
	Tue, 25 Aug 2026 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665612; cv=none; b=rRAahVo/jpnA6Nrkm9ebNIoJJMH17JHxHB2PDJgHF+d6Z8nfGYKPJpS+LuVKLBHjnZeT0YuV1SQj1Q+eVrTpujUM2ka/PD9Djqm/g5/bJ2I2mZ8krsbd1mf3TLDYKV5qJozoVAKD5o6OIuCAlcx+teGHLjvaK6Pj2cyP9Ikxuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665612; c=relaxed/simple;
	bh=i1s5kI1v30AEbJiF6ya5DQVhaJFLpKlvr86fshWQ3kw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mjBwirqpdTW8AEG5g2wTz72RntUbDt08raIeha8GV3GKQyLITOIpsKA/QCs2PAQDbBXm5WE9yzkF4bt8IuIjdT2vHKIM3qZHZLhI9XY4Olnm76XMyIexvRv+jNy++m44hwTE9J6ANQXeoTyHVl06FW+etIn8bMXudDdwexWbatM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=I29sFMK9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="I29sFMK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787665572; x=1788270372; i=markus.elfring@web.de;
	bh=i1s5kI1v30AEbJiF6ya5DQVhaJFLpKlvr86fshWQ3kw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I29sFMK9Od55/lzQYOOz9a0tMqZnq4IZNZ5fE841gSSngDO1Fr1eZxVXqCXQKgqY
	 yXhlLpDZCPGrBa1i3VZ2TG8ZY3ZWmfgWjdiN/zEnOhv+UYkX0tlKL5VFu9a/sFnJm
	 q13yrEJB5i7rgxy+r7hBsbfjdgz5yJyV5vHkGQM4JqEspflqmVynjqX2azniVXDqF
	 dAbjAEJ4lQXHMOxTniw/U56vig0oC6BVE0eKcFjzevFITW4GcXE9CGzz7YzwnSkbq
	 RyZGOWc4fWgAgEO0zU8CxuoP1eqy24/9LsXBlp/9kP6CxOtX67NP3YScgaAWOaBvl
	 ZmUNONPIFKoeS66riA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovnY-1wZyuo1Ld0-00lfnG; Tue, 25
 Aug 2026 15:46:12 +0200
Message-ID: <c1b5027c-5044-414e-8a4a-d2ce135a143c@web.de>
Date: Tue, 25 Aug 2026 15:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hanzhijian1991@gmail.com, imx@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, Manivannan Sadhasivam
 <mani@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: sashiko-bot@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>
References: <20260825060340.3767635-1-hanzhijian1991@gmail.com>
Subject: Re: [PATCH v2] PCI: imx6: fix endpoint init error handling
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260825060340.3767635-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L5SxaG9PEAO7bLQ1XieZcnAYvOVM9KJxXcOjWSeOrBdnK75Y848
 UOD9zsQF5MVhU6Rosgu68wS6RWg6geqXMgnAATeJKpsLt6pD6uhoZOXZKfTiGVvEKI9VPjC
 MIOLrzzSN0soYHCv/GU4fdI/55wVCWvlN9xC24v07YkfZzoYQDyNPXjijVVoSONLBd+9jh9
 siUl/QHi62lBSKlDFm0vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v3UkBPJZv8Q=;G0zuGlOJc54gElBSS3/zSNbRvLC
 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
 =

=E2=80=A6
> Check the return value of imx_pcie_host_init() and =E2=80=A6

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2#n145
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34


Regards,
Markus
