Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC973F20EC
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805023; cv=none; b=sbGHPRK7ZpZb/kHjn5srJM6ZvstXhQ1H1yiHTyN7+6vwOjrjEViifabIYf6KqDZ+3WOqMwkLUeRErE/SOxVTQ9qrcIXv1OljOd+HPdYZGS1qe6VA/6uzzfdHoWB5zf/IUK0eXDWsopcPBhMI5HVug6IcEuvwcmf9H+pOPY6myt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805023; c=relaxed/simple;
	bh=lrnKxcHIctX5G4ebFdhp2aUBeL+7DAWmpXpEo5fMolQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a16oK93AIjmrDjCiceY5QizGUSsKmdFbAT1Bm3qi4XL+VPXtZmftamutQBRfoDjdaPOs8HeKR2aB9D2BZtWulvxh2/EQCaidISbOWpAPDb09U7//u+cdT3wJL6DoNnfc8+Q65y1vM6AN9pczGKKeF6JHelHKkKKG8PoYLGebSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbjpGDUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbjpGDUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D03C1F000FF;
	Wed, 30 Sep 2026 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805022;
	bh=7FDxIvJTKY7MQGiepAA9idwrVWFZXUP39WJvWQs3rxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EbjpGDULWJUzHp13riYI7+GgJRzAPdS7VZ3vqGFgPz8AL6JHCT0IHLr7WNF4+vqnp
	 qso+2+a4YZ4yGNrbNWE+3P9g1GfJIn5bj78ke4a9zEabQblKpR9SVNVJJTyH5PIHZs
	 bjK0UHOza2vYLUpwtI4HiXM3VSaiqJWuZtlgECAAHfoQO6Rpdv8BiYRmLUDlcVIqR/
	 pwQiMgRkw6C8FpcZnibKPHprQJvr83v11Yqq5j9q84+GqbXg7KoOUkm/A51jjeQXHV
	 EeRqpSuSZe7s0p1Y5RKYuAt7TIgFCQm9BBrwRattR4ZVy6MjTzbcj07Fo9rUiAZh8U
	 mVzPsgLAKLhYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] PCI: Align hibernate poweroff flow with suspend
 flow for bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930213923.566846-3-superm1@kernel.org>
References: <20260930213923.566846-1-superm1@kernel.org>
 <20260930213923.566846-3-superm1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:50:21 +0000
Message-Id: <20260930215022.5D03C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During S3 suspend, pci_pm_suspend_noirq() puts PCIe bridges with
> downstream devices into a low-power state (D3hot or D3cold) when the
> platform allows it.  The hibernate poweroff_noirq path never did this:
> it only called pci_prepare_to_sleep() for devices with no subordinate,
> so bridges with active children were left in D0.
>=20
> On many designs the platform firmware leaves bridges alone when the
> system enters S4. This prevents being able to meet various energy
> certification criteria for different parts of the world, particularly
> in designs with a dGPU.
>=20
> Align the hibernate flow with suspend by making pci_pm_poweroff_noirq()
> use pci_pm_suspend_noirq_common() instead of the open-coded
> pci_prepare_to_sleep() call.  This reuses exactly the logic the S3
> suspend path uses, including the skip_bus_pm handling that keeps a
> [ ... ]
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Denis Benato <benato.denis96@gmail.com>
> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930213923.5668=
46-1-superm1@kernel.org?part=3D2

