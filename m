Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F1883F
	for <linux-pci@vger.kernel.org>; Sun,  9 Aug 2026 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786271252; cv=none; b=SWICWCD3ydr4s4lxosVc7yC32kwwevAUOG49KH7xQklkod1LAPomnf8gXyFgCZD6gY0Xz5yvMVDNUAWBkTcq/mk8hjRxMgPKV7NxUtoL+WkWDKjKpX5yYHvHQkqg9gcXy0ORnRrVrNc6BbDpEtKlcbLN5lZh+TLuEDEXsf7YkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786271252; c=relaxed/simple;
	bh=WgcU/bRRjJx1hvpmv/ZAef9s6Z3u/llyWeiViOK63mA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uIuqCbh3KGCQHpzxyQbYaEiNazCIO25Zay+f626n/Aerbgz86jqqyUPv/hj4ZQhST6g8LImnG+AL354x9rr6/eHhprCjDBa3XbRSy9IafejwZftX156h+gGCZQAvwk8AgcWcdJ+TFRr3xNqBPFBRvR1Zjrmk+DOl7xrubM3fAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wwxIlZDM; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wwxIlZDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786271242; x=1786876042; i=markus.elfring@web.de;
	bh=WgcU/bRRjJx1hvpmv/ZAef9s6Z3u/llyWeiViOK63mA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wwxIlZDMFk8JJt0RdXKM3zpEwxJG/QCTHIb41Zx1HkswpLT4Y5M6kMGxF0oTdvNK
	 eytB5d5Y62ph+/hk38EcEYeJYG7bPFbkCsxj3zy08LlJhLEVP5mGtVPUVp9q1zVJV
	 nWd08yh8q12j+MmFVDoOGcypI5eH/LUHMMd8+b8KrJaN8Wagyf9ajtiLp2T4gvcJS
	 ChJ/pVHao2wajdhZNwnQgDlQ/CazV6QwN81ABTjdbdbCV4KDUwhRz13OPJ8yQU8sO
	 Lu5GgvTDLjQ/3caRUN5fa+dkiv10WEkvuqU/idekUDM+b1sFDpNYCHRr3GsaJC4oc
	 GfqLFokAV9RUupHthA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZQS-1xFA8o1nOa-00hXye; Sun, 09
 Aug 2026 12:22:10 +0200
Message-ID: <94599824-ec4d-4700-b05c-486a5300030a@web.de>
Date: Sun, 9 Aug 2026 12:22:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: starfive: Fix resource leaks on error paths in
 host_init()
From: Markus Elfring <Markus.Elfring@web.de>
To: Ali Tariq <alitariq45892@gmail.com>, linux-pci@vger.kernel.org,
 Kevin Xie <kevin.xie@starfivetech.com>
References: <20260714113029.326207-1-alitariq45892@gmail.com>
 <e9b0d5f8-baae-45bb-a8da-7ab88856dddb@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <e9b0d5f8-baae-45bb-a8da-7ab88856dddb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HrZfQ4wNBHngtzj+9SmBtSIpeP/9xhk28SwCaxSdExCzcm3hmAr
 846og7krAh3/DmAmZYN/tKIfVifqzSvSUTQq/kLQb+kDU3pAR0z6CmLDuq0QHECzQz1DgRq
 fj31+Y+r7SqMa4LW2QKcXQS6R6+OXfXbq70vvPtKIAy12hxUEE9At55IDM39Wwh/SqpGQ64
 cbf/b69FNvQrIT19C5vww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zcOapYiK6Qg=;MncuFL3WzHkkRo3obYsYVzh5xo0
 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
 pfBpuFmGW7hZuO5wbUrx8MkRqNGNmQDhvJIcc=

RRRRRRR=20

Am 15.07.26 um 12:26 schrieb Markus Elfring:
> =E2=80=A6
>> Disable the PHY on the clk/reset failure path, and disable the=20
>> clocks/resets and PHY, then return the error, if the regulator=20
>> fails to enable.
> =E2=80=A6
>=20
> Please avoid a bit of duplicate source code by using an additional=20
> label. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=20
> linux.git/tree/Documentation/process/coding-style.rst?h=3Dv7.2-=20
> rc3#n526
>=20
> Regards, Markus

