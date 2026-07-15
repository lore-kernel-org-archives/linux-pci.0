Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6D436BFE
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129249; cv=none; b=U3XcXlLN1DHR8xBq2zmHGEdk0bydMumzYVpK4Zn7pkfmn6XtoVjwXUDGhFqUGYHRsKmgDmmhXzT/fwc3ttnR5/5lrm89MZx0a5PQ93h/oGBxayqtefK62gJtwjg5cM4CfI0ygANEpLTQZ2/nFOtC5XExbCwBj6ZU8ZR9duObt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129249; c=relaxed/simple;
	bh=TjjbHlQtj9ADoah3kZpCqt5oQ8kPlSofvQ0rvq6gnwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MQd+zk6WxxqEY/9NlKaCF8J2WK6VLKd8H8B+t27mD47jTBSCeOk/EFQqQ/IpHnjefk95BRjNPwXbgxsg3Np7wOSq3ZBDgX+I8M2rkgPeC9mNgy+iSXeCoZpV/Iyv0kBErd/6EffoY0enaTOAlj6b51VfB95ZLl+f+ru+UyXs/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIU55+M1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIU55+M1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA65C1F000E9;
	Wed, 15 Jul 2026 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784129247;
	bh=TjjbHlQtj9ADoah3kZpCqt5oQ8kPlSofvQ0rvq6gnwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIU55+M1v5zhB1Wlqyqtw7osAkcAApXv+VH5bFEuDoJZolkPB0oOhu0/jJAvTBF2j
	 wGAf3he+3ta4pPGGhNZgNtsrofflmZcyDKbW3IPlrtqu6z3AlutGsHjA3PvbEYBQD7
	 FPbt76GAia4//ItiAhwf0xbAD4SY9PLDSeonU5hwEv7Gye9rbF8zN4DKTvExhslx1O
	 vDKKAdpx9cLocq8meZTvMk0m4xrJnQdib7G5P2YvwVRNApCCao2uPfMoRSxw4uCQEN
	 kdxTjxyS6Y2A2zyY2k36g+SZFPRlXL+os6m67iBlKgOpBMGc2mqV1beXBAL8g5kYY8
	 HJVmpWdu+YYjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1961532.tdWV9SEqCh@rafael.j.wysocki>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
 <1961532.tdWV9SEqCh@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 15:27:27 +0000
Message-Id: <20260715152727.BA65C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Some acpi_get_pci_dev() callers already have a struct ACPI device for
> which they want to get the struct pci_dev pointer of the associated
> PCI device, so they don't need to look for one.
>=20
> For this reason, add acpi_dev_get_pci_dev() that will get a PCI device
> for a given ACPI one (if possible) and turn acpi_get_pci_dev() into
> a static inline helper passing the acpi_fetch_acpi_dev() return value
> directly to acpi_dev_get_pci_dev().
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5115219.31r3eYUQgx@=
rafael.j.wysocki?part=3D2

