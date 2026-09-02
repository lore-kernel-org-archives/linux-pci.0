Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422133998;
	Wed,  2 Sep 2026 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390523; cv=none; b=ac+uweje1t/eVxY9o4dyn1Kspt15ADw57r8gS8fj8gb9eQ5lYjHaZgGJ+5Ud+LYyJYO42htyAcHtzKP50qsupw9v7wy1AEiomHPx5Hx3gz+VF80Z+1EkRKcIx3admIkV+lXufrR/Cs9HzN06llpwsoz62euEjwq9etLstcBT+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390523; c=relaxed/simple;
	bh=IQMFKkLd/MFtL9pxUr1+UIMMzD+FgDoyZopjX4LbJ5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHrP8PWkyt7/jm9kN+s/JcpfU2DY+IYeTRWAZF6SxEfWrJPQWovn4zVPPoVT/dKMbqxymUvFV1yZZwfYJHS1/bmQ/CNWg4cjr2Nl/kxNQMFAYRz0RDrdobLlafZBI+0Yw3vPnicGz50UjC2P0AapepzVPDcyH0Az+7pSNtv46eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkSTysFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkSTysFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C734D1F000E9;
	Wed,  2 Sep 2026 23:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788390521;
	bh=IQMFKkLd/MFtL9pxUr1+UIMMzD+FgDoyZopjX4LbJ5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TkSTysFszBbT6B0fNmR0E5NCNzZPL4goW3+Izl689bJVSaK9aai28H4aBN/ko1T3U
	 ueoZIaqnUzsf+Zewzujq74EWsIgU3ps5WDVCwnNV6wQJsC68iWQlSGOBIImqPjlAa4
	 SRe1er+ET1mRAkfMTQ7ISHrX3nxIjcgUXhY70/L5ej8ECvcY21RiOJGsZEHPTzB8Il
	 7+1XHf00rSZyH6MPPnQOuXaE4ku9lQr58quq5nyW81zF+n+buJCL3rnLtI8eYWh2W0
	 vl7eXxWeP42jasJ29lLlXWPI1B5uw98jGd8Z9cUtwPM1MQ0oJSpjpZnjGEOPlkSGk3
	 JLJILSl/YtK1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 2/4] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260903-rust_leds-v24-2-8d9e4c04db69@posteo.de>
References: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
 <20260903-rust_leds-v24-2-8d9e4c04db69@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:08:40 +0000
Message-Id: <20260902230840.C734D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message description starts with a lowercase letter, whic=
h violates the LED subsystem capitalization guidelines.
--

commit 549c02b13bc8cc96fcda86b2df1afa6c3c034eac
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add Mode trait

This commit adds the led::Mode trait to allow for other types of led class
devices in led::LedOps.

> rust: leds: add Mode trait

[Severity: Low]
This isn't a bug, but the commit message description starts with a lowercase
letter. The LED subsystem guidelines request capitalizing the description
after the subsystem prefix.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-rust_leds-=
v24-0-8d9e4c04db69@posteo.de?part=3D2
