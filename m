Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A234E744
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160299; cv=pass; b=WGEO8bKhXRiNN63K1C8Al3UcjKdAdmbCmHQgGGmDr0BvK85uf2lx7PI5KnnmyMF/f62Mj5WD3GVRIWk70ccbY9F3hYF5znXcEa1DI0UbGTTK13qyX8zO8KCVo4ZKaS2PJWHRc+XXcwI8rdYs9DfoP02DEQMZKI+gG1mqTdByf9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160299; c=relaxed/simple;
	bh=w2jXqFY53v3TNDlOBV3DbP2Je7MyB/mqigiV1wiMzZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0vj5ZOAyoY7eE/m/VcPckhHS6rCQ6GLuL33YUM744jaTqOpNNaudIKXpKKZR4fZ8Zc2+QdpYS61bnkNrxh6uXqGUbzTCKJcId9veJcMEADvo1V5ZmD4myxUES1/SXFI+gNA9/5l1k9926y2zZ14CEHnVnBDVRFVkqlXSuijmas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ju/dsKbp; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ju/dsKbp"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ad58f31846so4063010e87.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 13:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782160296; cv=none;
        d=google.com; s=arc-20240605;
        b=XIJRSwLs+L8rwqrgTQHfJ2MjXjXa6NqnITowyo6ZaJNTI/c4441K502xT7slMA/Sca
         UCH8+nvA1kQ2g/6VSkfJwlz/W5sSiwkUsMl07C37crPBmd640UFqAnHAIe/JmTqgEicL
         r51vFYlNgXcDckXjwhSYg2xes9pg9n7pWBCul5Sr/GlpvaciUhp7lJ/tfn3er6bQQTrn
         Ov/CvjyUPfDah24lhA5RzY2K4GLd8vSNVb1Qk2bQeLiwOqPBOVJoGtW8ObNLKke+l1ac
         54dv03UnebPT8IrdCW0b3IUr7KjxhNLww+YierWDCzGsJEexFo7buszxIfIjHkw0JVmr
         4kRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+QcFrFZO4BKQ/PztHf8geLXKckCiieNhWmylNiy86y0=;
        fh=c4lVnC/wuZxqfPZ1k4vnLIXkK2+/bicUZO3Fk2EOoPs=;
        b=CFhgeLVPReNt/mfvLo4p199BHcNu4LfdZDs8OvmNDJhcWthRwuAHils5z1Hwz10kV3
         ws5f3mm+vld5QvbuwOykvRoeGW9el744gTXcR+gHvTc+ouO48pjZaLGkdVhwxOz1COO0
         Yv2/6sd5L2ZhJVqbBRaPRYb5N13tR02N3wqAG7VywNkKYg4PXi0GLnjErnIEE//scez7
         RvzOuqjDcmWf+lcXNkRJ9M6+JZeCbI3OwpX9LQ5F+sCKu3vIcRKXbKGG8CZ2OTQ3YeRm
         REf17LRkE8/NRHEcoVdVoKGWdVoO7hXzubX+yXkZi3wc1lTHCAjUGP44mzGzSXYmj/83
         yigg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782160296; x=1782765096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QcFrFZO4BKQ/PztHf8geLXKckCiieNhWmylNiy86y0=;
        b=Ju/dsKbp9de9RBEmswQyyQts8Em9qWl2nAkGIkpFkWTvT6XGOQZqkL4ib5WifabRw8
         vuVlYxw4vpS/ni1kL9P1itp8PqWlKzxbY2jyHezlcBhCHN6bLGb0SPYOI0IW/e9QfZlL
         vLPksoJux1B51sJ3Npg+dC3vf9QShRkI+T4cGXPtDyzCqygnh69XQdnu871ZinWn1EnV
         AA7GJMM4gfjixM100G/oUkxZ4HLXzyhKlD4YdQIbvxzC+pG3vfnOFf0ZsrlSj44+6DAE
         d2cmVeTXYWwjHxneiwMMh7XURXNsmCN5MwBUwnO9BrCTynlTmce1n9HJm6FKRdPud/pr
         LhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782160296; x=1782765096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+QcFrFZO4BKQ/PztHf8geLXKckCiieNhWmylNiy86y0=;
        b=MCEV1M52/Fa+uTOYcLxPnkhqE6UrdQd+eY7AAyNSIm3uwQPGRR2JMYxns62UrfXcDu
         /PwJUeKDCBWyOp7k3uDr1u3ZSzDjzgQ9ekXIbN8exQel0n2d/sAOCXnLof5PcCvpLTKV
         oulb0rq867bq7oUK8pZ7UciZIJudeXKOhnVyZRFoDrO+fUXg3ozQBoH/wtbBju50HOtl
         4K+/5kChapjzli164pZWLB15ArDSgZ+9k9CQQMCQ/RW4+UEXcHBul50h1qWVefYGvceQ
         hv6A17RUcGRmaR7AcCyg/NuemS4FiDkIp3RcD0CU/8ZkgkHLxO+AtvHUl9GkH21iul/7
         +pqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FVSzBNNFmtNF36+YCKmhamf75UMfUYEjAjgBv1qO/VU+iI+PWXQTTaO5P4aRQDPvC82urd5LAJ+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiUGIpVOLKJCIie2XQrpRO4eVcPFJY7ZRkwnWeV9PZV4T0Ljg
	NaEpN9/X6EUoj38NQuy4I453YoMksCrySsBOMZH5SM20jVf/iQtB67bKwoPCglo0hPwpfOI1x3x
	6X63V+9I/tKmPs+6nFQ32TNfum5dZhYMa4P+RgFw/dZFb+gPHghYhGbzJebU=
X-Gm-Gg: AfdE7cmZ2SJINMH9JjjnVqhvl3vj1yXRnCijTDlCCTZyX4SJvebOnUrNIAIz8bLgfDm
	525WXIoeO4QspHMSJf4IOOYe8OEoyO4JEtM57VmCjvq9TJfFj2JnkRDoPlyvtTG9lTSaQfc8fhk
	CaRDMD4iisqUrEPYy8oLAK8i0cEdzb258FSlmlxo5y/Sydy0ZYcjdxvHJK+4ciVihR4TER5pjIX
	4LRHDSR2+9IXpHvPngNaL9l8oBxEJwgt7NWgUeWcoloPAtUi3NXCQAtMHczhjG0awbBo+9HYLN1
	hbmhy/Q=
X-Received: by 2002:a05:6512:2446:b0:5aa:100a:8315 with SMTP id
 2adb3069b0e04-5ad5be78be9mr3636762e87.45.1782160296081; Mon, 22 Jun 2026
 13:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508133629.v3.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
In-Reply-To: <20260508133629.v3.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
From: David Matlack <dmatlack@google.com>
Date: Mon, 22 Jun 2026 13:31:01 -0700
X-Gm-Features: AVVi8Cdcna6hxgiNDcIKKP06oMmyGyQ_ZRaK9uXI74cCOul7f4x8255p0jD_EEo
Message-ID: <CALzav=c0Uud4hU5=xjRW8X3OWAa412Rxs3eteBHuRFTeuJb0yg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/portdrv: Allow probing even without child services
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Pratyush Yadav <prty@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 1:36=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> The PCIe port driver fails to probe if it finds no child services,
> presumably under the assumption that the driver is not useful in that
> case. However, the driver *can* still be useful for power management
> support -- namely, it still configures the port for runtime PM / D3,
> which may be important for allowing a bridge to enter low power modes.
>
> Thus, allow probe to succeed even if no IRQs and no child services are
> available. This also mirrors existing behavior for ports that have no
> PCIe capabilities, where we'd also probe successfully.
>
> This change is a bit more important after commit f5cd8a929c82 ("PCI:
> dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> controller"), because it's common for some DWC-based systems to:
>
> 1. have only have the "aer" and "pcie_pme" port services available and
> 2. not define legacy INTx interrupts properly in their device tree.
>
> After commit f5cd8a929c82, such systems may fail
> pcie_init_service_irqs() and so exit with -ENODEV.
>
> Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnq=
dwb33xkcdwk@76vnrx45fsfd/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Hi Brian,

I am interested in this support as well for Live Update scenarios [1].
Allowing pcieport to probe avoids disabling bus mastering during boot
on preserved bridges (failed probe calls  pci_disable_device()). Bus
Mastering is eventually re-enabled when a downstream device calls
pci_enable_device(), but during the window that it is disabled
downstream devices cannot perform any memory transactions.

[1] https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@goo=
gle.com/
