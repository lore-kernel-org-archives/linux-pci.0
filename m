Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554A266581;
	Mon, 27 Apr 2026 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319183; cv=none; b=q0bU35qr1UM9E2vAbQK9aeJLmpYdv2uRSkL+wH0xQMbXohP25ztPQQVgmtCrfd8FIvgZx2hDbW3E/d4Rw0NouCnifDcMWY6qmQ6fwNqMd1N5tLadK63nR3LnfcIe0f8d18o/0zHNXmoVJjozevWnyKOUo7QnsXF5S6rhwY6s4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319183; c=relaxed/simple;
	bh=v1R/95ouEPrTFF8ffv/0xVsBHMFb9M3cHebK5elKK9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FkhqHKYt0A9Z+hhfKQUKqwlm2efKFHdhvKQGRlWp6VYwhcy1RSAcz7gozrUuXakB20QtxRvQBGtuhHzcI4Sel2PbPZmAZOQOOYG8aASe/eZEM31B1glRe+4ht5eMwZKHY7AaW0mJCfIU+GKyxarrW0eM3njA/nqgt9WDWCdxY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZniO/DM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZniO/DM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9830AC19425;
	Mon, 27 Apr 2026 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319183;
	bh=v1R/95ouEPrTFF8ffv/0xVsBHMFb9M3cHebK5elKK9k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=lZniO/DMfgD5G8+6N29cnq/nmt98m6TdZx5H4DNmzggok+EqMMyiR5jevfYwXiLMw
	 JEYBUJdLYNj+2G4PbSqz94oB5O6Rf3wL4gCiPJGB85zZE2cmWsI5fTNNfkcRaH+y91
	 +8N1/7Vt3GswpN8lfVDduLaimw6wPGg87n5uyWWuXgyBf41qMowS+e4iPARzjNnouW
	 s/yOIKI+cFhk5CuNNMMbkbSZxiK4c1yiwtJxNj4IaupHCwAm0Jd8yzPzb1fmXPiiSb
	 kFV+kgC7Ck+VTdKbqWLLcyh6Lef7mrClD46HmOEZsZglI32nwVyNORPIEIUvOSM5fG
	 L4VXvn+sc98Uw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 21:46:20 +0200
Message-Id: <DI472FJ8UOG4.1JGTQK7W1RAX@kernel.org>
Subject: Re: [PATCH] PCI: Init driver override spinlock in new_id_store()
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Gui-Dong Han"
 <hanguidong02@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Alex Williamson" <alex@shazbot.org>, "open
 list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, <dmatlack@google.com>
To: "Samiullah Khawaja" <skhawaja@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427193139.2109938-1-skhawaja@google.com>
In-Reply-To: <20260427193139.2109938-1-skhawaja@google.com>

On Mon Apr 27, 2026 at 9:31 PM CEST, Samiullah Khawaja wrote:
> Fixes: cb3d1049f4ea ("driver core: generalize driver_override in struct d=
evice")

I don't think anything is wrong with this commit, and it seems unrelated.

> Fixes: 10a4206a2401 ("PCI: use generic driver_override infrastructure")

I'm also not sure that this one contains the root cause, despite revealing =
the
actual issue, more below.

> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/pci/pci-driver.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d10ece0889f0..5f453213b8c5 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -215,6 +215,11 @@ static ssize_t new_id_store(struct device_driver *dr=
iver, const char *buf,
>  		pdev->subsystem_device =3D subdevice;
>  		pdev->class =3D class;
> =20
> +		/*
> +		 * Initialize the embedded struct device driver_override lock to
> +		 * avoid the lockdep errors.
> +		 */
> +		spin_lock_init(&pdev->dev.driver_override.lock);

Can't we just call device_initialize() and set pdev->dev.release to a new
function that just calls kfree()?

This way nothing of that kind can ever happen again; it is hard to predict =
that
a device is used without ever being initialized.

>  		if (pci_match_device(pdrv, pdev))
>  			retval =3D -EEXIST;
> =20
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> --=20
> 2.54.0.545.g6539524ca2-goog
