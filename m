Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4C2F84F
	for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122368; cv=none; b=IqPs1ET3bOHUtwC0dJCaz8T3263TCHUBmiSWvt2F4c3C/17gugCIoWsretKoClxxZWpHvCApwmy+ZXxukruYmdBR/vVSZc2rSrMSvC2FMb1bQiIqn64IPUcgH7kYB5NAvoIRK0vMHoxNBAgn8NK/V6ftjSrONv8ZBn6yvGk0W/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122368; c=relaxed/simple;
	bh=CSS6KiKx62+wsoyW6DWceEvnSDU+OEqs3/j3+sN4SdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZwtqsfhvNN0dzECxESUZNJa2UP5IPqfUixurpsAhazfVDjXhE6aGk3VUaBAie/aMeMQqb1hXn7jWtqCqW0Mzhg/H/WqGxgasWqK2JjriDAquoGELmrTCsu6jaG0+ygQFhqE1WQbHBQnnHEPTpkRwo+/POsnPXjy05PGN2ES0YVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdW2bZFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdW2bZFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C261F000E9;
	Sun, 30 Aug 2026 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788122367;
	bh=pzwW1ee92bQ1fH2P6AWRk3u9IlVBL+z8lC5PaQgZLgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JdW2bZFh3KZu1g2RLmvKWqWlp1a4nFFaMPBXAQmEKx9qcBcfzQVx9u4Mmp89m+Y82
	 pbvMnNWFabF6ltUc+tVdbfu9Bc3Cgi0AJqifNs9b1fsDF9/ASwlsxbSzsOa/DxClLA
	 5UJuz2TdlVh4uWP9X2KAyrF8yJb5aAc2SCxWPmSxbiMoPu0iYu+Oe8aqjSt3v1pfCe
	 POxYx9EmTTGcK4c8dL2Kdolwixn5R0akiM7skKvcTYSFN1LUljri1ShKvQ3qjrpO1/
	 RrOVRKNhnFMbE+TEaHeC19t+76UHALEIPt2LiKuDTZkGJ3SlmOIc+YvyGG3vnY8ZKh
	 yc1HHKM2JLCgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/AER: Fix struct pci_dev reference leak in
 aer_process_err_devices()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com>
References: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 20:39:26 +0000
Message-Id: <20260830203926.F2C261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `dev->driver` in `pci_aer_handle_error` can lea=
d to use-after-free if the driver is concurrently unbound.
--

commit 9885b6e8d159d70ef8c2c474b114ae69fb1805af
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()

This commit fixes a reference leak on struct pci_dev that occurs when a dev=
ice
without the AER extended capability is added as an error source. It does th=
is
by decoupling device reference release from handle_error_source() and calli=
ng
pci_dev_put() unconditionally in aer_process_err_devices().

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a548..2401b3a18f07d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1197,7 +1197,6 @@ static void handle_error_source(struct pci_dev *dev=
, struct aer_err_info *info)
>  {
>  	cxl_rch_handle_error(dev, info);
>  	pci_aer_handle_error(dev, info);

[Severity: High]
This isn't a bug introduced by this patch, but does pci_aer_handle_error()
safely access dev->driver?

Looking at pci_aer_handle_error() in drivers/pci/pcie/aer.c, when handling
correctable errors, it reads dev->driver into a local pointer without
holding the device lock:

static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *=
info)
{
	...
	if (info->severity =3D=3D AER_CORRECTABLE) {
		...
		if (pcie_aer_is_native(dev)) {
			struct pci_driver *pdrv =3D dev->driver;

			if (pdrv && pdrv->err_handler &&
			    pdrv->err_handler->cor_error_detected)
				pdrv->err_handler->cor_error_detected(dev);
			...
		}
	}
	...
}

Since pci_aer_handle_error() executes in a threaded IRQ context (via
aer_process_err_devices()), could a concurrent sysfs driver unbind or module
unload clear dev->driver and free the driver module immediately after the
pointer is read?

This contrasts with pcie_do_recovery() and cxl_rch_handle_error_iter(), whi=
ch
appear to correctly hold the device lock (device_lock(&dev->dev)) before
accessing dev->driver.

> -	pci_dev_put(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-fix-aer-re=
fcount-leak-v1-1-64e1013add12@google.com?part=3D1
