Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C74EE84E
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455589; cv=none; b=UiTqjRaMuMMNTmziuuefCcx0AT+QB7zud/5XL3EHPdAhzB5x2aeHtxcX/1UHK9ldcIssZZ4hAjUiWRv/hXQR9ix7Dw0Qutw36/0Ogxmz0SvHTa1eppZjxSQrXIaii8OLEYk1sNoiu4ZWBmeEJbRfrPhbHZ6cs8tvzh8Fvqy0L7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455589; c=relaxed/simple;
	bh=InSioqu0JL6ddabv4mmZ+hFbNc2zoZSkd5nUbPprdQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SuzXu0e5qnLhxhKNheD2ZZpAkVPDNAyqMd6+pOOjONmIUhebN5eO0cvYI3FHXdloHjmnXE7KZv9EnLfqU7fX8K+GXDKVFRmpr87WliXKu18/S69Yel0bZmc/S4qH7wR8E88CLcnlHr7TlGoD1qAatQSR5b+FNTcPsI3x/UCaOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqL7gWV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqL7gWV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE131F000E9;
	Thu,  3 Sep 2026 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455588;
	bh=InSioqu0JL6ddabv4mmZ+hFbNc2zoZSkd5nUbPprdQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqL7gWV4+zJUh7G59+2xpGGZsw+onBQW5K4NfYuuMtDQk0sbgg/2UN+foqwjw6/nY
	 /PuVExM9Lj721oH+uYxrthBeoyJ27curV05UsgU69jVbyt5H5aqF3HkQwNSXdpqcNX
	 1OjgyQ4bJCLS58S2ZPufF4LD4jlPp8MVNYB1UtgLiEMDKEqQMmiY3SB5k/FhtEtyVm
	 bmG+JDlvEsWG88lt9P0q+6rZbxg92ei1dv0V01r8AIWoioVezSTSKkyo1OaPF72Q34
	 XD7zdRynHpJofHWpn0JAVJdiDGAOaORrQaFd1wPMXSYFfhGADYmAKHA8mTVOAigYgH
	 ePsEGK7j9j6Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] ACPI: scan: Combine two conditionals in
 acpi_bus_attach()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <8746939.T7Z3S40VBb@rafael.j.wysocki>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
 <8746939.T7Z3S40VBb@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 17:13:07 +0000
Message-Id: <20260903171308.3EE131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> There are two conditionals in acpi_bus_attach() that can be combined,
> which slightly reduces the overhead and makes the code a bit easier
> to follow, so do that.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6044499.DvuYhMxLoT@=
rafael.j.wysocki?part=3D4

