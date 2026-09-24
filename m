Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CB382283;
	Thu, 24 Sep 2026 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216129; cv=none; b=a07gefaah6QLRhyLTHWiuu2f2rvaw6RamP6uPL2hgoN0SgB1AcKxN09WsqeNFNXlHLubq2Gn1eV++g3BgHI4itmTO1AwidZwu0Ypc33uLDXycJXAkuRG0KNs1U/mg9ivt8gwf/XDg68fwuDWKMzhSZsYBSKUfbvGeCLTwnibN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216129; c=relaxed/simple;
	bh=Ukq4s/g2LbAcLSo+DPv2hScrAIpjP5dVSjl63kehKK4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gBY5j4FQVURTXSXg5MSet3X60EoRhUhV89fOtRGWdGf3s6gcWkks6rL3rbXeCAs/yhGxadWxZyyPUX3IsBlkNqzWUaTPvo4gSO8sao5M2U8zxB8JgS6UAW6UZeQO6QIx7vC+M0x1ZVJCpA5hMH1sFw8S3/pQdrq3lBOet20BJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=l7ojbSQt; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="l7ojbSQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1790216057;
	bh=Ukq4s/g2LbAcLSo+DPv2hScrAIpjP5dVSjl63kehKK4=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=l7ojbSQtnSA+IEl/Dtycf7jzRcDTbr0aqBhVK/j6h7ZpXOAY0txHS3u8xz1KXD/A9
	 Nk9TC66qAvtw5EP+sQH5WTx8bNsIdxu8UMXh7tcb4X9D9zLPAkaEei6AoHOnjkMLjf
	 MSDkhgpJ8CCupBOZIh/ah8kx0KIFmQmaAh1rhPs4=
X-QQ-mid: esmtpsz21t1790216051t6a98fa04
X-QQ-Originating-IP: 1SD5VCR6xWCfe2vzl2aIguq6PDEir4epJ5QDcl9DXTI=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Sep 2026 10:14:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5874928214263819641
EX-QQ-RecipientCnt: 18
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8f62a79aaf3f531d7ad204d4c4b9ef58a31bebd84138d89c089572e5c418;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 24 Sep 2026 10:14:06 +0800
Message-Id: <DLN6MI8PLD0A.3ELK15A3DA9NF@linux.spacemit.com>
Cc: "Bruno Banelli" <bbanelli@gmail.com>, <linux-pci@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>, "Alex Elder"
 <elder@riscstar.com>, "Yixun Lan" <dlan@kernel.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, "Krzysztof Wilczynski" <kwilczynski@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Uwe Kleine-Koenig"
 <u.kleine-koenig@baylibre.com>, "Javier Martinez Canillas"
 <javierm@redhat.com>, <linux-kernel@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Subject: Re: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with one
 endpoint on Milk-V Jupiter
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>, "Encrow Thorne"
 <encrow.thorne@linux.spacemit.com>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20260825052249.66921-1-bbanelli@gmail.com>
 <DLKRGJBNFVQO.15WZ2SXQLOY0T@linux.spacemit.com>
 <xuafb5qshj6rowe3v6sxyfvtemy4wg2ttqs7lcwu3txu2mpyzm@fr72njh6zgvi>
In-Reply-To: <xuafb5qshj6rowe3v6sxyfvtemy4wg2ttqs7lcwu3txu2mpyzm@fr72njh6zgvi>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OW4JKxETGMY2ZtXC37cQOMjtmvJ65GqUQyhRbehIHzwnmoGlMeejKfbj
	ulQMC6wYWFuKeP5DLmRXzz6ULrJOtc/MWhr6rjSjmKy579MregMEBkbKAb4OmrefCbjSQBI
	xDcDgPI48wyBJej8VGW0c9l/XbZOIvkVP+uaQAFV2Qi4u4TlnNOLAjEmS1cRaSuMnohISnq
	kCyAKYcA6MYyl/6+xUom8XmoQaBARF0EAeEAbdiGrZXiRkCAhQMjMvhdjx3Cz2myZMih6Pj
	INZFCr0Bkw0CCVcyr4kWymyh733r9XcMXs+SrurY+redH8iV62UWTSurc5ejQD03oyaEqDY
	9as28qi4jTlQmQjHiKL7schxs39ntwoc/67wuWVL+2Kx2Mk+lu5kP5JUDvmJrLzQDg2fOVD
	NzvH70RXO8jfplOc2iyFJCu7xVnoknR224BuweBi+mMRSrahE0uOz1LfqlvXlMwiv2oLLqQ
	rJBziovNn/EO+bqZiJmnKrV8GWHq+2s4xvcMiZ5kB+pVyTdFBQdsBKWLpsqzNbg1GBzEk+W
	U5NvztKZpw5MV/sQLXMxyUUu4omrkP8njO04ys/mvX0mg4f95Wo/EJKJ1OjaXdUbGekQXVe
	0/KN+PbomqS00hX4EAFiIlfwe+1dkkNhk4w083R4r1iz2G457/TJf/cJWP7DakHEljhw4mh
	9RjcknB2H8gDyrCWUg06p5OxoF0fTfoI4uO0CpzBzbO5jSynglYO0uBRppZmW99l79Crrej
	Gz7l6iMljZiK8F6Bwj8vVhoLzoTr9wsMRh0VAZEiusE5t3K+zYdkhusf4iuCLNW4jSN7sXF
	jBaQSQSIunhAudlEZ1qPAYJzPIHOA2pjsI8zUIjGXaKDVld2DdprWWXJibsDJ6D2ZGWPVM4
	TCzvtOQHhY4+pU611HophJhseE1sI5A0aQc2Hc6Hy4ml0aJ8D093XopymMiCj2GjV5cDK7z
	+ZI2a5G4YbYLJg4Y3Ys5mFct8bMn6BB9jt89zQypNBYlTOkkdg6hWNE7o/7kRno6GBQ4YEK
	NmvBH0wzggEJur8VcyIzQgFljc22DPLfPA/xyLorBoXlC2Q5fImPmGitxl1A0FEX1cCbWF7
	lGVyiV5VjDHrVsSfRKOcLT/TyC2QjjNGBwrFlsGkPilLhl58GK+W153g55XHytAZw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

--8f62a79aaf3f531d7ad204d4c4b9ef58a31bebd84138d89c089572e5c418
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Sep 21, 2026 at 4:03 PM +08, Manivannan Sadhasivam wrote:
> On Mon, Sep 21, 2026 at 01:55:42PM +0800, Encrow Thorne wrote:
>
> [...]
>
>> Hi Bruno,
>>=20
>> The issue was caused by a missing hardware configuration in the K1 PCIe
>> initialization.
>>=20
>> The PMU PCIE_CONTROL_LOGIC register contains an IGNORE_PERSTN bit (BIT(2=
)).
>> The hardware manual describes it as follows:
>>=20
>> =E2=80=9CWhen set to 1, the PCIe controller and PHY ignore the PERSTN si=
gnal from
>> the link partner in both RC and EP modes.=E2=80=9D
>>=20
>> This bit was not configured during RC initialization. As a result, the
>> controller and PHY could still be affected by the PERSTN input during th=
e
>> early DBI accesses. With the Intel I225-V installed, the first DBI acces=
s
>> could remain pending and hang the CPU.
>>=20
>
> What does this 'PERSTN' bit controls? PERST# or something else? PERST# is
> controlled only by the Root Complex btw. Also, why does this missing regi=
ster
> configuration only affecting Intel I225-V endpoint and not others?
Encrow has already posted a patch here [1] and explained the reasoning; it =
seems to
depend on the device's behavior.

Link: https://lore.kernel.org/all/20260924-spacemit-k1-pcie-fix-v1-1-002b5c=
1ba9fc@linux.spacemit.com/ [1]


--=20
Troy Mitchell


--8f62a79aaf3f531d7ad204d4c4b9ef58a31bebd84138d89c089572e5c418
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCarSHbg0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvxO8A/1764CfP8OTcIm5rW5emuurOXkqTKQ7BL9ChVP5g
Wre/AP9SDdlVovEUp1d9V4EYidzXJuHBOkk14Z04haPo5wMhAA==
=KKPr
-----END PGP SIGNATURE-----

--8f62a79aaf3f531d7ad204d4c4b9ef58a31bebd84138d89c089572e5c418--
