Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D08433BD6;
	Thu, 16 Jul 2026 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224960; cv=none; b=Ui66iINtH5TB5gI5dQIYtxJ1JrjXLf0M8ttvr95rvxp+athvXMuUFb37LxGyN+3aOgohk+kf0NZBGtOagZ6b/RXT8lsYM4O63yKFMUxBS0NjhqBw9QzhTjChVvtE1SXbCM8F8cRMRmoGniKimQzm/3/NoO8YuFhkXVPKwfpEM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224960; c=relaxed/simple;
	bh=l28oX+EmSOxcWZ8IUL9u2cLltmd0WZ4fxPSWe+tBcHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m8Ig8rNrVUUZxAgDIjFvRUErPzVg3csH8vpMsLAH69QDZJw99dv442LDBLLaRPrSxcfbXueaStNGQakmDHcWdF9LXwrFKTsHNIoFag4F7rIcJVX2UJnh6P7VoYWehghqQAs2XiD4L7vXdUwJWh8HmfaYQ+gazci6a4nre40QCvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXw+tEeD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXw+tEeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7CE1F000E9;
	Thu, 16 Jul 2026 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784224959;
	bh=l28oX+EmSOxcWZ8IUL9u2cLltmd0WZ4fxPSWe+tBcHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iXw+tEeD6onf9enFILhgGk8eq6Y2Jc3dvum6RLQlZzN5KuC20Z+bVOwbhZZNdnUas
	 ov7dbTLVj9QyPPJvl+6gFPB8oTF1S/33w3JsPCEVqLI4/LcfsPkrfPJ+8QGlmdSM6v
	 HisYFHFvg4lsVJfTvaY9Ld9cyEg7+T55pxMfEwDuaBXHCQ+fK7HVprfn6wgSkL5wDE
	 knb4V6C14iRrNhCFmXsTC7tLNEPqiKdUYqNiT5UwJnQRfao/EN6F4mg50xLk2ZENaC
	 /JkiLj8A2yZh5ukxayATgkD6KlGLPucqM2vwPK9w5azq69Hah645xEQeum8K7gYks6
	 EpLFFi+ItVKqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 2/3] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, lee@kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260716-rust_leds-v23-2-e91f5b608b56@posteo.de>
References: <20260716-rust_leds-v23-0-e91f5b608b56@posteo.de>
 <20260716-rust_leds-v23-2-e91f5b608b56@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:02:38 +0000
Message-Id: <20260716180238.AF7CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message description is not capitalized.
--

--- Patch [2]: [PATCH v23 2/3] rust: leds: add Mode trait ---
commit 82637721450ea77b83de47ea809b8962d9011425
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add Mode trait

This commit introduces the led::Mode trait to allow different types of LED
class devices to be used within led::LedOps.

> rust: leds: add Mode trait

[Severity: Low]
This isn't a bug, but the commit message description is not capitalized.
According to the LED subsystem guidelines, the description following the
subsystem prefix must always be capitalized. Could the subject be updated=20
to "rust: leds: Add Mode trait" to match standard naming conventions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-rust_leds-=
v23-0-e91f5b608b56@posteo.de?part=3D2
