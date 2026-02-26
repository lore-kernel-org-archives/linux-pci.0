Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B02DEA74;
	Thu, 26 Feb 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089787; cv=none; b=d4DdoomxNB+B8+i3x0u7X+IkzIenYS/StbGSEZPUxSnTWmQ+2pYiaaTIoP768Bw9CTH1T8Ra+uw7gt1spq+gEvwuyC89z2TdaKP5HYYAsQHYyxqV4BmCQ7ag9TUwo9Ea0GpfBR8TeCoodWXRLQfaXKmCNp4lpdUUEwr8y4M4/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089787; c=relaxed/simple;
	bh=4pn1M7qsn+PIMka5vqZd6ooy+lAfq/v/u5sfMvm/f90=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbiW6CYeVZ89bdDrGefLSloAnoELQkOFqgKGEFLXNf6QZppEY6ZeYgok+/LKrRo7xmw5QubSHijA07PzLXH1q7nKXN1W5joDTVfQEAMqt8CkInO2BLTD1sQYBReWOvtFqDCKYkpu9VRbhtz1ohzYxTz4F3fcjWXx1KjwgzF942E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=cUQqAjek; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="cUQqAjek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772089783;
	bh=4pn1M7qsn+PIMka5vqZd6ooy+lAfq/v/u5sfMvm/f90=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cUQqAjeke9yHJg/esZCZv2gceO7gysCnd0uLGIiwOlE8k86iZC6rpKKe/dY4zNJ9y
	 ad3KgJKjc4G2xwA2/LRlKxm6zrveCQuftbUvEwsO60jMwaBDbiGGPXH/eYJaIl2MAv
	 2AaJtyhEwtXR55nJIqoY16uPhnPmnjtMk4h18wmY=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E03D31A41CF;
	Thu, 26 Feb 2026 02:09:36 -0500 (EST)
Message-ID: <1d86afeeb6f9e7aa4ab1310d6339ad8dfb349a00.camel@xry111.site>
Subject: Re: [PATCH v7] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
From: Xi Ruoyao <xry111@xry111.site>
To: Manivannan Sadhasivam <mani@kernel.org>, liziyao@uniontech.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?gb2312?Q?Wilczy=A8=BDski?=	 <kwilczynski@kernel.org>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas	 <bhelgaas@google.com>,
 niecheng1@uniontech.com, zhanjun@uniontech.com, 	guanwentao@uniontech.com,
 Kexy Biscuit <kexybiscuit@aosc.io>, 	linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	loongarch@lists.linux.dev,
 kernel@uniontech.com, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lain Fearyncess Yang <fsf@live.com>, Ayden
 Meng <aydenmeng@yeah.net>,  Mingcong Bai <jeffbai@aosc.io>,
 stable@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Feb 2026 15:09:34 +0800
In-Reply-To: <taoupjxwaewzvolh2n6bciji36j4dx6jtvjf7k6tt5hdt54hjw@rrgbu47umz4v>
References: <20260121-loongson-pci1-v7-1-fc79c85a574d@uniontech.com>
	 <taoupjxwaewzvolh2n6bciji36j4dx6jtvjf7k6tt5hdt54hjw@rrgbu47umz4v>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-26 at 12:01 +0530, Manivannan Sadhasivam wrote:
> > Cc: stable@vger.kernel.org
>=20
> Since this is a bug fix which needs to be backported, what is the commit =
SHA for
> the Fixes tag? The one which added Loongson-3C6000 support to this driver=
.

The PCI controller driver didn't have any change specifically for
Loongson-3C6000 before this one, but the kernel will only boot on
Loongson-3C6000 if the AVECINTC support (commit ae16f05c928a, i.e. Linux
6.12+) is available.

--=20
Xi Ruoyao <xry111@xry111.site>
