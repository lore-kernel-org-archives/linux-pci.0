Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FD519DF0
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089957; cv=none; b=SCIKb3182IKj9qx9T0s0jNDwWb9VvK3AM4WZQ9SlmbaL3dhOFXLxvK+4QipwgJAH4V6mhFtUXF2OyEvfUPs/74VrTMUr7DXrwDMBpN9/HueXFIh9lli1XiRdzKBdGm+EQfXjcl2VOla136hkio7iv/34Gz2N9DsKpducqewlh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089957; c=relaxed/simple;
	bh=rsBMqoMYBrzM/YiuXYi7kUlMv7Fe7hdua0Wqlm/7pRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BGvqn19nhYSqduaDQJ6Q5o9sCr9Qi0i8KF8y+XUcdnWF5fugqd/6B7IPw28KVT3JsyEg86MERQVCZtVHjHiVPO8JRm3lWYldeG6SNT4eRmafichiTqd4LoWlsdiSv6TYCXq5kBtnbNEhLqm5v1GKVqT14azEs2d3R/lJndDT8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx1rhxFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx1rhxFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B25D1F000FF;
	Tue, 22 Sep 2026 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089956;
	bh=rsBMqoMYBrzM/YiuXYi7kUlMv7Fe7hdua0Wqlm/7pRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jx1rhxFw0B5VDIG0Iyh2hnReEebMfiw0Q9WeO9KsgWPPMzGjvN/JKkIJonuE0Xktb
	 TTgK0OIx3vuik2lkbNxETC/2h0b2GBEo4Ts4twLHwyZu3QMPLvaNxJN28S6uk3E9MR
	 MswgHKWE3PiKha5rLRKF1lS7dMFG3Ncz3xn0H1W0EWGIwHq0kOy+E/5EeI9wX1AX6w
	 EOKY4HXKmn5O5ulpqwQvkQw9M9kt6jePlF3xhI6lbXqw1p3YXfPvgBHfkk6gyyqIfd
	 HWtFGguA3vhFqg9JkYLOhirvmOUCpqenh9xGbDHBjguBiSelsh+ZmrkGvC8rcsTBcB
	 QmAU86KvpxeSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/6] PCI: Validate ACS control bits against
 device-specific ACS capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB4393EB421B5947A5A25F4272DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393EB421B5947A5A25F4272DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:12:35 +0000
Message-Id: <20260922151236.4B25D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The ACS control validation used the kernel's full set of ACS control bits,
> which allowed users to request ACS features that the device does not
> support. Because hardware silently ignores these unsupported bits, users
> have no indication that their config_acs=3D request was partially
> ineffective.
>=20
> Validate the requested ACS control bits against dev->acs_capabilities so
> that only device-supported ACS controls are accepted. Mask the capability
> with PCI_ACS_BASIC_CTRL_MASK to select only the currently defined ACS
> control bits (0-6). Higher bits in the capability structure (e.g. the
> egress control vector size in bits 8-15) do not correspond to control bits
> in the ACS control register. Warn about any unsupported bits that are
> ignored.
>=20
> __pci_config_acs() is also called from disable_acs_redir_param(), which
> passes a hardcoded acs_mask (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC) that
> does not need validation. Gate the new check on !acs_mask so it only
> fires for the config_acs_param path, which always invokes
> __pci_config_acs() with acs_mask =3D=3D 0 and builds the actual mask from
> user input.
>=20
> Also move the check after the device is matched, since the ctrl bits apply
> only to the matched device.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB43935D2C01=
946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D1

