Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0192326D51;
	Thu,  4 Jun 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586679; cv=none; b=Xi04CzmiJZfOWFH2T6/7OAFf8tMv0RO0vt/MKqgbTNG7aNVltxEMCu99Zcot5Gq2OnrvlsEBSOpoBNSedg0xdaTD8XkPZHJZunvxC8yg3ML++e5iEbA6HtWmrRCQx2A3VjihLDM7o3/eDwgVc/IlsOm9b24rCnyJSuMYm3G0x0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586679; c=relaxed/simple;
	bh=OtYIwdUAxpHZS8KVVlVBNnrK1jqSWiAD8wBFniKvarQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c/6RDQK6PUMawpT1VpVkUIwDciJwP469JRuwJrnw5Y7YZ5t/ZgwwwKskEaIIJF5FXN8PVKtmz9a87HWJTAqcJG4gUKVQHOOXAoD7FrbDYNk8iGvgInBxhYpeNKmnm00tw+QD/p4BU2xvi1COlwg8kK9is08TfkvYeQZZhMx0V20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfID/TIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfID/TIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510441F00893;
	Thu,  4 Jun 2026 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780586678;
	bh=sRfVqMgXjbJL90GRnsXXEwjSzBU8nPLOQuIHfMhk9ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfID/TIW3ClI9it8qjUOadZccJbKLtfnegyvKRpbCrrSTm07yo6J6d44NIZDejJed
	 WJlhWi0ya+TwCUStkSMknIjPQs1esAFYOU1jLBGyI6JYM5MhSK+/8+4Xy0e9cFmcJg
	 R6RCKZIRH0hgo0bSBFMXve8eOYCPrkWytSxPn1TRYEwQf7iPbXREk1WcFCWZssXK/7
	 XgG5nW7RYI3ffSpvOM4feRQqFrj3iSxaYUnkSLm8wDY3G04ILWuYQvWoqkoxoPIiRH
	 74JbTZrS9wWVLHiUvy5HNeSYrISvKvQMAkDpEoTDEujXRAHtBJZl/M2xr4KpdvUwto
	 uU4jJgshHp4dw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 07/12] PCI: Convert xen-pciback and pci-driver to
 pci_is_sriov_* helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dimitri Daskalakis" <dimitri.daskalakis1@gmail.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604150153.3619662-8-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-8-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:24:37 +0000
Message-Id: <20260604152438.510441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete implementation: missed conversion of dev->is_virtfn i=
n vpci.c.

Pre-existing issues:
- [High] Concurrent driver unbind can cause a use-after-free of `pcistub_de=
vice` in `pci_stub_notifier`.
--

commit 88d02306e6f1bfe4b75d5df018b4e5de4f2ff35a
Author: Dimitri Daskalakis <daskald@meta.com>

PCI: Convert xen-pciback and pci-driver to pci_is_sriov_* helpers

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>

[Severity: Medium]
The commit message explicitly states its scope is to convert xen-pciback and
pci-driver to the new pci_is_sriov_* helpers. Did we miss converting
dev->is_virtfn in drivers/xen/xen-pciback/vpci.c?

For example, in __xen_pcibk_add_pci_dev() there are still direct accesses:

drivers/xen/xen-pciback/vpci.c:__xen_pcibk_add_pci_dev() {
    ...
	if (!dev->is_virtfn || func) {
    ...
			if (t->dev->is_virtfn && !PCI_FUNC(t->dev->devfn))
    ...
}

Leaving these direct accesses unconverted means they will fail to distingui=
sh
between SRIOV and SIOV VFs when the helpers are updated to check dev->is_sr=
iov
in later patches.

> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback=
/pci_stub.c
> index 79a2b5dfd6941..fd5a13f79fcf4 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -1695,7 +1695,7 @@ static int pci_stub_notifier(struct notifier_block =
*nb,
>  	if (action !=3D BUS_NOTIFY_UNBIND_DRIVER)
>  		return NOTIFY_DONE;
> =20
> -	if (!pdev->is_physfn)
> +	if (!pci_is_sriov_physfn(pdev))
>  		return NOTIFY_DONE;
> =20
>  	for (;;) {

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk here if a
concurrent unbind occurs?

find_vfs() searches the pcistub_devices list and returns a pcistub_device
pointer without taking a reference count via pcistub_device_get():

drivers/xen/xen-pciback/pci_stub.c:pci_stub_notifier() {
    ...
	for (;;) {
		struct pcistub_device *psdev =3D find_vfs(pdev);
		if (!psdev)
			break;
		device_release_driver(&psdev->dev->dev);
	}
    ...
}

If a concurrent thread unbinds the VF (e.g., via sysfs unbind),
pcistub_remove() executing under the VF's device lock will remove the device
from the list and drop the final reference using pcistub_device_put(), free=
ing
psdev before the notifier has a chance to execute.

The notifier thread would then dereference the freed psdev memory when
evaluating &psdev->dev->dev in device_release_driver().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150153.3619=
662-1-dimitri.daskalakis1@gmail.com?part=3D7
