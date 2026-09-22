Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F75519AA
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090039; cv=none; b=mASi7xdTuMb72J8XNBSm8n3sIyuIkw6tIIG4sXGX45ocMGgm1Cxj1VmFqAyG7XHjCcEGJZx50watWp743QOpbmiFixPPODtzDbpD+k4Dx8NwK5omoMKWn6WS0HdF3MyKNWES1EDhlnktWGPdPGbaTqNz0UqntyMi99uIZW8ZLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090039; c=relaxed/simple;
	bh=AosOAQ1jxwD+c8nunhD+takLrtBT+3QkhihyX7nZ+Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pmz23sF3iybt7xQAYeaJz60bcX8sAvaEnlk0Aaku9KaCoUx9vhdOQrqWiX+BGZEbecmPkPeiCAC0NAgWrhAI7mtgwg/oVJNNXYF130s9ASqQvNAlGdLWsVRq3Kq/gCb163iK8Xav9+sOqdUFFQ/f2R+fYeACvRbvaoI6tfxggkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z88i4UhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z88i4UhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79FB1F000FF;
	Tue, 22 Sep 2026 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090037;
	bh=AosOAQ1jxwD+c8nunhD+takLrtBT+3QkhihyX7nZ+Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z88i4UhKt876MHZJxlzX8W+lbj91i4/GTKU5bVIL7ZzraWVq5MvmaA1PjPt6kbsgt
	 kpDYab1DFpX0M/JJGlOdZ0ui91EKIAIXTuz2+id6jC7ErjmsM45SA2hh8lF49ShLd0
	 Tz1+qM4yVTNZwgwIrf1y1kodZozWAoGi4ynsb9reO9iA8YWWQEmbqQgLHU59/ZGO5J
	 uz50v2YdQ1UzRN56iY5WPvB+8+V6x+JGDF1xNaHHUmPG2Mz6U9TwR3mYp3RdLuJCTj
	 QzM4lSsJFQmilHrXBYy2+P9LhxNjKSOUpIjMA8yZ1iOABBslYNs5U4tJ30qql4WwJr
	 4X8X3Lay13Vlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/6] Documentation/kernel-parameters: Add
 multi-device config_acs example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB4393E6DC55320F9EB44A9092DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393E6DC55320F9EB44A9092DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:13:57 +0000
Message-Id: <20260922151357.B79FB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The config_acs parameter allows configuring ACS settings for multiple PCI
> devices by separating entries with semicolons. The current documentation
> only illustrates applying one configuration pattern to all devices, but
> does not show how to specify multiple devices with different ACS settings
> in a single parameter. Add an example demonstrating multi-device usage
> with distinct ACS configurations.
>=20
> Some bootloaders interpret ';' as a command separator, which can cause
> the parameter to be split as multiple commands. Document that the entire
> parameter may need to be quoted to avoid bootloader parsing issues. This
> avoids confusing bootloader errors such as "can't find command <BDF>"
> when passing multiple device entries.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB43935D2C01=
946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D2

