Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497735;
	b=LJIy30+5+X7r/pgbi6pgSo+hwGdoox/WcbWmho+acFsGRhzx82av0ERWNoDo3RwmDSDT
	 i5BODDGb2qc4gNhxClJj4meLbzb3Nj+b6FF4zHsU8wD93Xmc96VRKC48z/Zgw8gCqXzgY
	 DkiLP2pLhPASDfrgoGPH0LQXv1F9bWz+GqNQR4GICOfjj36PrEU0jfs1Pji70543473nK
	 0UxdIIZaONziIYAdroM4BpBiwuP9OSoN6POazR80AFQtHKtozeXmWhUrXLRW6eSic5tTo
	 f+vJlnK/SZsPN+3t1QE9b6WrscI6FNCf5YQhdo0G3L+J5rvm72RO914MsZfw2AR8qnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497735;
	h=DMARC-Filter:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Kk8Gab7bHHed0TipbroioHmY2QtrvO5+tGCMBsd26d0=;
	b=QZH7SiLe+oWEwJKmhrMliPFK7kSoPdmbV8Xg8sVMkEdsi/6srG6VPTB/crqED88gJqLu
	 2vfwAnoOYX1le/z4APB1thtGZIYvBH7Lvzf7jWvM2m/ERLT7krNn8RxHSxRguQ1X5Yzlr
	 4mVD9dBxE00VvbciQCshSmDNGNiiwIMfut7UE3XpO8cR3lV/GFs0gVY8ID0pOwOn1AMF6
	 EGoV7FSTu0ptaUmz3dJKKe8TYJkqZscdCNSwGiYEUvLd+pGhuUxxPDt38xw3+/NJ5o53E
	 Vx4oX8avUfUVhpwEwzI7/8pymkXoAdwKURGrRiCM5ATj1J0Nfla2QL4uu87SAuvCIZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lwn.net;
	spf=pass smtp.mailfrom=lwn.net;
	dkim=pass header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=onf7sikP;
	arc=none smtp.remote-ip=45.79.88.28
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B8606A8B4;
	Thu, 12 Nov 2026 15:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E4B8606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=onf7sikP
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E31BF40904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1794497734; bh=Kk8Gab7bHHed0TipbroioHmY2QtrvO5+tGCMBsd26d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=onf7sikPveRKyMDlQOJvtwf7YcmgQZzASK76daout4PgyRqJseRH680IJEMLZCJYL
	 w1cZVu5ZAF5kl0l3UEyqzVsHdIU2VYz2sGlV0H7W9E6PhDKWkG3ffgKIa9yG9CX63i
	 T+T3KOVZF0vK8PpHpLR9ni+6wje8QZUgHghbS4hFC7K/kE4vib8aEwXgL1paGLgsPg
	 jJqBLeVc48gX+xSYYP6nQOQIqKOLit3A9QZ001tBnuyu+115pJpMP1CousKzKKS/lp
	 OGUwx/hVTcbWJZme5Kf+N3qgsnhMOFIOH7CDUbOQ/INZnR/F3gdnlv8bTMHoe49E69
	 WYWUex3Ls/vDw==
Received: from localhost (unknown [151.38.237.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E31BF40904;
	Thu, 12 Nov 2026 15:35:33 +0000 (UTC)
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
Subject: Re: [PATCH v4 0/2] Documentation: Restore device-ID documentation
In-Reply-To: <cover.1793221199.git.kmehltretter@gmail.com>
References: <cover.1793221199.git.kmehltretter@gmail.com>
Date: Thu, 12 Nov 2026 08:35:30 -0700
Message-ID: <87ik225agt.fsf@trenco.lwn.net>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Karl Mehltretter <kmehltretter@gmail.com> writes:

> This v4 addresses the duplicate PCI declaration warnings Jonathan
> reported on v3.
>
> Patch 1 retains Uwe's device-ID documentation restoration. Patch 2
> corrects the Chinese PCI header path and preserves its existing plain
> references. The kernel-doc blocks added in v3 are dropped, with generated
> API documentation deferred to a separate change.
>
> A focused Sphinx 8.2.3 build with -W includes the complete English and
> Chinese PCI pages together. It reproduces both warnings with v3 and
> passes without warnings after each v4 patch.
>
> Changes since v3:
>   https://lore.kernel.org/r/20260908070031.32833-1-kmehltretter@gmail.com/
> - Move the Chinese PCI changes to patch 2. The five files in patch 1 are
>   unchanged from v3.
> - Clarify the ACPI exclusion in patch 1's commit message using Uwe's
>   explanation to Andy. Only ACPI_DEVICE_CLASS() has kernel-doc in that
>   header.
> - Retain Randy's review and test tags from v2 on patch 1.
>
> Changes since v2:
>   https://lore.kernel.org/r/ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783=
349758.git.ukleinek@kernel.org/
> - Use the :file: role in pcmcia/driver.rst (Randy) and explain why acpi.h
>   is excluded.
>
> Documenting struct mei_cl_driver in include/linux/mei_cl_bus.h remains
> a separate follow-up.
>
> Report: https://lore.kernel.org/r/87h5jq8gia.fsf@trenco.lwn.net/
>
> Karl Mehltretter (1):
>   docs/zh_CN: PCI: Update the pci_device_id header reference
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
>   Documentation: Update after split of <linux/mod_devicetable.h>
>
>  Documentation/PCI/pci.rst                     |  2 +-
>  Documentation/driver-api/basics.rst           | 31 +++++++++++++++++--
>  .../driver-api/mei/mei-client-bus.rst         | 12 ++-----
>  Documentation/pcmcia/driver.rst               |  2 +-
>  Documentation/staging/rpmsg.rst               |  2 +-
>  Documentation/translations/zh_CN/PCI/pci.rst  |  2 +-
>  6 files changed, 36 insertions(+), 15 deletions(-)

Applied, thanks.

jon
