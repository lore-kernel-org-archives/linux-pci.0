Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D7D38239C
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991239; cv=none; b=LT+6Y6Kn1Hdj3m7Q7Z5wWVy9ONpvhXzt4ssm3H2z7Y4vPnVBTE+1SJIsAzSmg7pTOR2UYdGqGVvkL0XBErGRc4fWBJs2kEAMjnhydKSNJYNwgsamBMBm3OMVp94A8rHDy3zO+XDNLLxrQXuDmAGXq5JcoCf7a5rilcOSTNb9tes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991239; c=relaxed/simple;
	bh=U+OVOs9uVOjP87NzsJrht8HdhXL1l3jD4g0atijGy3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AvHwDPYT8ZSlTqHmWh2Ef3pEJBRmjLtG6VZ0fIeHRgXLfxCJhiVKd7XsKzbQg2GmDFffbE56PB66xyRJNKzsfkTg3ZJp9Au8/adpnrdHI76fhNkI5p2L1TgjZ8j3q/jYH1u1Et1mb4HUI0IIa3MrVbjDwm0qjLLKNG7V/6Mr46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5N9Qha8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5N9Qha8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FF61F00893;
	Sat,  3 Oct 2026 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991237;
	bh=F/sxAzsOnaXfmB4YVHAEjqpx+SBz3Gr2h5jpDTe6hkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5N9Qha8NFt7RN0TP8UKHEivgoeDG99/2IDalLJZWI2OowPRD5QqxCZwUrbZtdbAv
	 w7BLJuAF/BFAlfZ5rdNrGhuh9LrWUFD77swtCBd8XOAFpV5ySSim5srTBF7Igs8vUo
	 BY5raK8U98i+R1DlJuJQT0DLGhyWEZyuT8COBHe0o2yaabSETzvC64Dbd9gQnYoYtw
	 6ffStX32YibYeLLN3jlqmOsVRJAKwT+UfuX0yvFaxdXsTKyY6gwdgtKD8eRuwb5Tu0
	 KRjzgdDQo36J9K98ZeXKkvlZUJj6Kod8PXk8FzzZ7HpmOyl9gmZLtoD8IZlREVZzrO
	 mUuR4ac/zdQjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/4] PCI/ACPI: Tidy _OSC control bit checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002211828.1293177-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261002211828.1293177-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:57 +0000
Message-Id: <20261003013357.A7FF61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add OSC_OWNER() helper to prettify checking the _OSC control bits to learn
> whether the platform has granted us control of PCI features.  No function=
al
> change intended.
>=20
> [bhelgaas: split to separate patch, commit log]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002211828.1293=
177-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D2

