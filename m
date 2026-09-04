Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A4376A0C;
	Fri,  4 Sep 2026 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564396; cv=none; b=d+VaUZmfDUfVHTjCD4BGqSIuSRAgeC+/3KLMVpyYbGaaHqoyDtVJlqr8I8fkpFQI04gn7nzU155vr27Df8m5qdfhaZyJXIDMOOKDXAKvvkSdgDD2BK2uYrgABFDNfEmJR+0CxeiHKzS6eKBtSI9wZMKDFM/yX9/8qRl9WtFj4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564396; c=relaxed/simple;
	bh=9eErm+ReOeF03siVFaUi+88V7doSwCwwsi41jCI4YyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OtQFwN5Mk/ztKwZsVd9oPFu997lsK/ix01e7iXv/4t2ii78hpASV3F/4y7RiKk/vwzPbmhlhbHAOx+lTBxRJnYw/wmo4I2/SB9K8j8QjDGWbD00jA3L3rG4r0kGedUb5BQuJEL8TiClm0SuFpEIl1pkF/iKlNpPMMLXbj0u4mnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMxms+fv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMxms+fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84541F00A3D;
	Fri,  4 Sep 2026 23:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788564395;
	bh=fUjunHcUNZmew8ZRXLjlDrDvH+SvisDb2NR3YNXUjPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMxms+fv+tO2sEOMXfwC5FtZsO2IAwfHVDxkGIAT4UfHBECTW4K+zz37rY1GrVRvC
	 kUIcrJk7f/s66NNOKkTM0gCa9KcrXPhWbfiSxjbh2yR7MGLDk9h3d4ZQuCIziJBgBJ
	 SqDIBkckn82OIjdIlr35zOaqgrvrVmicttbmAtGmP3TC3LTvv/DOfUC9szFgpwyS8J
	 Ru6m5DWPILPO2niPpr/dKpKDSU/06PegemnEfSP9t7UmOTsNINySlO0514/o9kJ6Oz
	 lUijtFfiyMTJDRe0kwq9S2wCfSDKxCUG08Zu8wol6IOaW3z21MlODT7hwBuzRTkbH+
	 GnJvGPz2gze6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Kconfig: purge twenty-nine legacy ghost options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-pci@vger.kernel.org, media-ci@linuxtv.org, linux-input@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260904231240.87106-1-breno3011alves@gmail.com>
References: <20260904231240.87106-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 23:26:34 +0000
Message-Id: <20260904232634.D84541F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing USB_CONFIGFS_F_TCM prevents building the TCM target fabri=
c function for ConfigFS gadgets.
--

commit a0c8218d80f352a73463cc7e47871658dffb0211
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

Kconfig: purge twenty-nine legacy ghost options

This commit removes several Kconfig options that were deemed unused, obsole=
te,
or replaced by other options. Among the removed options is
USB_CONFIGFS_F_TCM.

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 76521555e3c14..f05eb1bb7b6c0 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -492,20 +492,6 @@ config USB_CONFIGFS_F_PRINTER
>  	  For more information, see Documentation/usb/gadget_printer.rst
>  	  which includes sample code for accessing the device file.
> =20
> -config USB_CONFIGFS_F_TCM
> -	bool "USB Gadget Target Fabric"
> -	depends on TARGET_CORE
> -	depends on USB_CONFIGFS
> -	select USB_LIBCOMPOSITE
> -	select USB_F_TCM
> -	help
> -	  This fabric is a USB gadget component. Two USB protocols are
> -	  supported that is BBB or BOT (Bulk Only Transport) and UAS
> -	  (USB Attached SCSI). BOT is advertised on alternative
> -	  interface 0 (primary) and UAS is on alternative interface 1.
> -	  Both protocols can work on USB2.0 and USB3.0.
> -	  UAS utilizes the USB 3.0 feature called streams support.
> -

[Severity: High]
Does removing this option prevent building the TCM target fabric function f=
or
ConfigFS gadgets?

The commit message states "the real fabric always built via USB_F_TCM", but
USB_F_TCM is defined in drivers/usb/gadget/Kconfig as:

config USB_F_TCM
	tristate

Since it has no prompt string, it cannot be selected by the user manually.
With USB_CONFIGFS_F_TCM removed, the only remaining configuration path that
selects USB_F_TCM is USB_GADGET_TARGET in drivers/usb/gadget/legacy/Kconfig.

If a user configures a kernel to use USB gadgets via ConfigFS and disables
legacy gadgets, it appears they can no longer enable the TCM target fabric.
Will this silently drop TCM gadget support for ConfigFS users?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904231240.8710=
6-1-breno3011alves@gmail.com?part=3D1
