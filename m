Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967242D759
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212111; cv=none; b=XvjkWSPupbE/qQdREJyEvXxLY3cshB8jB8XnIisccBzdh07IXkuusUd8OS6pekFChHN+8Ld6hKywczkat/1nFqQSAosCHWcgGco2XfngHidqgOyVSXVzERVkatu8DV/KKF1Bfby4jRZvwhlcNs9xdlMsGMJ0nPk6vQ2VUjg/miI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212111; c=relaxed/simple;
	bh=zgDD4DuCCan5bGwzJdVxxQvXlnwodwa7pmeyQceckgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZnU4e8HJ0nRcGhttX9BJ5rkR80KqhSvaip/NjqWyVJJQZ3BEXmBNwSNZD8ZjNMIfnKBg+fZ0Uv0NnTfwcl3RAbVCNidD+BwNoO791LrC2RCb8CVVQjCCYzu3OhypMSSm/jlmEjG50ztK3KANxhBRRa21KcuJ1kyEjMZjyVv4clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM3xV4lU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM3xV4lU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD791F00A3D;
	Thu, 16 Jul 2026 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784212110;
	bh=zgDD4DuCCan5bGwzJdVxxQvXlnwodwa7pmeyQceckgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bM3xV4lUN9aul+t2i0qoBmt77SpBMi8n7d/htqb6WF4mwTy5UW3bApGfC+422LZyz
	 ZPmYlVONZVs8kTiZu8TaLrpVFk2OPoiApinS/r15KBbaMDmR7zhKBjOAWI7pv8gZ8l
	 T1sXGwo9SKWkBdMKwpmTkB2Aql7W98jssljh6i0bApR05Ed99KxzmE4lCrOktRYhS/
	 R1zvpZJehGeJ1ahHfVPSzIAQs0gsMNFVg4/qy6RtTR0xoivKroKy6b6ccWSBQ/Jorx
	 CSiNoS/OudGKnK2K5N5Xl3J6An1TQsDwOD/82vsUBGTRKhaRwlhUJqWqmoDMcZvFPH
	 FyBeL6UMrEl5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] ACPI: video: Use acpi_dev_get_pci_dev() instead
 of acpi_get_pci_dev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2047771.PYKUYFuaPT@rafael.j.wysocki>
References: <12935400.O9o76ZdvQC@rafael.j.wysocki>
 <2047771.PYKUYFuaPT@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 14:28:28 +0000
Message-Id: <20260716142830.0DD791F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> In acpi_video_bus_check() and find_video(), simply replace
> acpi_get_pci_dev() with acpi_dev_get_pci_dev() that can be used
> in both places because the ACPI device needed to do the lookup is
> available.
>=20
> In acpi_video_dev_register_backlight(), instead of doing a parent ACPI
> handle lookup based on the handle of an ACPI device that is already
> available, pass that ACPI device to acpi_dev_parent() which is much
> more straightforward and pass the return value of the latter directly
> to acpi_dev_get_pci_dev() to get the PCI device associated with it.
> That allows local variable acpi_parent to be eliminated.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/12935400.O9o76ZdvQC=
@rafael.j.wysocki?part=3D4

