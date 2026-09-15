Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C02F83B5;
	Tue, 15 Sep 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500272; cv=none; b=DSR5lecAsI0fHGsgD7aXn24r8ftm2n4uRD+ciq4/FXzAynTUh7CIXz5c6tHzj1ZHCaOksWEFwaDNHCtF/ZbG+rlxdm5VVsF3IXLAJKhymL5q23rMBto/874y5VdJGgZYGpkkwW9jIXwoVfX0wFgWk/GU3Zf8IOzB3hFSRZEQVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500272; c=relaxed/simple;
	bh=ryg6nKUTx68Fy1dXWgSE+1SwKBJ00iCeTFDkDWlbsGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fl3mPd8DaDPtkokLjGCWOFiD/WAWkPLGYgnHNtUZRYY+De7PJd0xmCqVuy2HGFxxPbYYYQS5+fo9cLjaH4BXG9Ts9xEcTd8QKiUxzyhKyRnGoUSK22LTFBf7sIEBdpsH+GBvQ+cKzscjRhs9ByXTyzXOVlTDfVArGt+8/51uCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SjgS7EqU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SjgS7EqU"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A67FE408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1789500270; bh=XeBqOYrRmdMVCcJUy+mieps24xpx7J1+H++2XiHOYfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SjgS7EqUiA0XnNYKrm0TM3g1+MJlKS7/WeYv+9+XqRIRzPrUrDNpDad0LSBXOjoSP
	 2ch7CTHosjos9JTPzeWb4W+o/lpooNW3iHrzniKxPROYddY185J/h8NI1tf/foJomG
	 8rSC3GgEaLyOPQOt4Un1xurephTnah76trFTWbqZMoVVcBXOHw9rbm9ErG4CfYZXEL
	 cR2OUZTcx5KKY4BX1LuozWzoWC40YKjV7TsPHzi18kl/yQ7BNnv555/5vNjYaKKZuh
	 FYc4+Um3dYockbKbDSft9TRnHoW6JcOcU7kYd6l+3peU5euHLonU2F9KIV4a/nh4Kn
	 J5+J2H4mZIT7g==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A67FE408B4;
	Tue, 15 Sep 2026 19:24:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Alexander Usyskin <alexander.usyskin@intel.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, Bjorn Andersson
 <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Alex
 Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu
 <dzm91@hust.edu.cn>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Update after split of
 <linux/mod_devicetable.h>
In-Reply-To: <20260908070031.32833-1-kmehltretter@gmail.com>
References: <20260908070031.32833-1-kmehltretter@gmail.com>
Date: Tue, 15 Sep 2026 13:24:29 -0600
Message-ID: <87h5jq8gia.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Karl Mehltretter <kmehltretter@gmail.com> writes:

> From: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>
>
> Most structs that were defined in <linux/mod_devicetable.h> before were
> moved to a bus specific header. Follow the movement to get the struct's
> documentation back.
>
> For the list of device ids in basics.rst use an explicit list of all the
> headers that have kernel-doc annotations and that are not described
> elsewhere (i.e. pci and mei_cl). <linux/device-id/acpi.h> is left out on
> purpose, ACPI_DEVICE_CLASS() is not a device id struct.
>
> Also repair the referencing in the zh_CN translation of pci.rst and
> don't duplicate `struct mei_cl_device_id`.
>
> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers=
")
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> [Karl Mehltretter: use the :file: role in pcmcia/driver.rst, say why
>  acpi.h is left out]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Changes since v2
>   https://lore.kernel.org/r/ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783=
349758.git.ukleinek@kernel.org/
> - use the :file: role for the header path in pcmcia/driver.rst (Randy)
> - say in the commit message that <linux/device-id/acpi.h> is left out on
>   purpose (question raised by the Sashiko review)
> - carried Randy's Reviewed-by and Tested-by from v2, the diff changed in
>   one line of markup only
> - Uwe asked me to take over the patch:
>   https://lore.kernel.org/r/apv6yQ1U-HhNglyV@monoceros/
>   It supersedes my PCI-only patch
>   https://lore.kernel.org/r/20260905084916.40196-1-kmehltretter@gmail.com/
>
> Randy's suggestion to add kernel-doc comments to <linux/mei_cl_bus.h> for
> struct mei_cl_driver and include those instead of the duplicated struct is
> left for a separate patch, it touches a header outside Documentation/.
>
>  Documentation/PCI/pci.rst                     |  2 +-
>  Documentation/driver-api/basics.rst           | 31 +++++++++++++++++--
>  .../driver-api/mei/mei-client-bus.rst         | 12 ++-----
>  Documentation/pcmcia/driver.rst               |  2 +-
>  Documentation/staging/rpmsg.rst               |  2 +-
>  Documentation/translations/zh_CN/PCI/pci.rst  |  8 ++---
>  6 files changed, 39 insertions(+), 18 deletions(-)

This one adds some new build warnings:

  Documentation/translations/zh_CN/PCI/pci:98: ./include/linux/pci.h:3: WAR=
NING: Duplicate C declaration, also defined at PCI/pci:3.
  Declaration is '.. c:struct:: pci_driver'. [duplicate_declaration.c]
  kernel/Documentation/translations/zh_CN/PCI/pci:106: ./include/linux/devi=
ce-id/pci.h:3: WARNING: Duplicate C declaration, also defined at PCI/pci:3.
  Declaration is '.. c:struct:: pci_device_id'. [duplicate_declaration.c]

jon
