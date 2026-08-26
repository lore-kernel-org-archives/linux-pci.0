Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC13442B21;
	Wed, 26 Aug 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753841; cv=none; b=oJ6jQMSdvXhrHw70+iLNiGj0D+qyhj6SBQFrNnIr8mR7NtJ9679GTf+IkJn1jRG03nSwfqlO3rHBlzt3tIlM9IU8Mrs7lKYKRA3Gdrv2hYU9/Gpzxs813nD63ut3VXFl3hJoiSSXKaJ6sGjnqc5/cbW1iSAOouEvaMWJZNY6vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753841; c=relaxed/simple;
	bh=h0uPE4rG9Kkem3MpmSNpLl7EPri3OY20t+UV6rkiyyc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=X6MIrOix7CX7RQtq16SLjegp5S3+N0Ruve53CzpAatDt5i+sMDbYoWxCPb7qCuBT9O5sltTW/Bwov75wpEkXXua30Y0gXAXPhSnvNSb4E01EWH7eA0Omc/8FDmJh1JdF//YWfbbcUNGw8gQ0fNeMapm4Jesoi0wpRvrX+Cqoa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=j45sn/6t; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="j45sn/6t"
Received: from ehlo.thunderbird.net (93-33-80-53.ip43.fastwebnet.it [93.33.80.53])
	by mail11.truemail.it (Postfix) with ESMTPA id 3289522746;
	Wed, 26 Aug 2026 16:17:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1787753829;
	bh=h0uPE4rG9Kkem3MpmSNpLl7EPri3OY20t+UV6rkiyyc=; h=From:To:Subject;
	b=j45sn/6t0w6wDMppM3heS+Z5PQ1Qm7PgQFhKzWeWz5PwhL9Ck7oSlbOqTikN6bO3A
	 3AIpQHRx5VnefXy7OHo0viCEeOqy4vNT23zNn1f549AP5P9b4YONPE21xfjWyWg1ow
	 hs4/YOfBDHyIEJdykjLyqTbMpsRuXYPotb53gVNLcw2h3OrkoBE3vjDaUmXfO/4bxr
	 KvCM1Nt3PeMEXAN7vdHX/wVXet7SAU9XhXDOjdUcwYhSr0xJOCsWIYh67kqWtdy6za
	 J2mlaHh/BBToVp82wP84fjJU5RO8vVFKkUJd/Jga+6NeIJqyzes7UmD3BWLwNbmzgu
	 vVnkzVnMu5Dog==
Date: Wed, 26 Aug 2026 16:17:07 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Leonardo Costa <leoreis.costa@gmail.com>
CC: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, Frank.Li@nxp.com, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, regressions@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 leonardo.costa@toradex.com
Subject: =?US-ASCII?Q?Re=3A_=5BREGRESSION=5D_mainline/master=3A_PC?=
 =?US-ASCII?Q?I_link_creation_fails_on_Apalis_iMX6?=
User-Agent: K-9 Mail for Android
In-Reply-To: <04454db7-0779-4a7f-bab2-72fea3480dcf@leemhuis.info>
References: <bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hpgwve6@n2m5uhlduw57> <20260810211209.GB4821@francesco-nb> <04454db7-0779-4a7f-bab2-72fea3480dcf@leemhuis.info>
Message-ID: <67392DCC-0927-4BDB-85D7-7CA0CDF9EBE2@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 August 2026 16:11:46 CEST, Thorsten Leemhuis <regressions@leemhuis=
=2Einfo> wrote:
>On 8/10/26 23:12, Francesco Dolcini wrote:
>> On Mon, Aug 10, 2026 at 02:54:45PM -0300, Leonardo Costa wrote:
>>> We are seeing a regression on Apalis iMX6 where connected PCI device
>>> links fail to come up at initialization, as shown below=2E The issue i=
s
>>> not on the devices' physical connection, as they worked properly on v7=
=2E1
>>> and are working on other stable kernel versions=2E
>>=20
>> just to make this more clear=2E
>>=20
>> 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
>> introduced a regression that prevented the boot=2E because of that we w=
ere
>> not able to run any of our test in our CI/CD
>>=20
>> commit 7678e81498e2 ("PCI: imx6: Fix i=2EMX6Q/DL boot hang caused by im=
proper PHY power sequencing")
>> fixes the boot issue, but now PCIe is not longer working
>Just wondering: what the status of this regression? I feel a bit lost her=
e=2E
>
>It looks like people were really keen on getting this resolved for 7=2E2
>-- even multiple revert were considered, but not performed in the end
>(not judging here, just mentioning it)=2E Three days after the quoted mai=
l
>(and thus even before 7=2E2 was out) Richard Zhu posted a fix afaics:
>
>https://lore=2Ekernel=2Eorg/all/20260813095003=2E356062-1-hongxing=2Ezhu@=
oss=2Enxp=2Ecom/
>
>But that still sits on the list and did not even receive a tested-by=2E I=
s
>it not that urgent anymore for some reason I cannot see? Are developers
>waiting for test-results from affected people? Or did this fall through
>the cracks?

It did fall though the cracks=2E The patch was tested before being sent as=
 a formal patch=2E
We are just waiting for the maintainer to apply it=2E

Francesco=20

>
>Ciao, Thorsten
