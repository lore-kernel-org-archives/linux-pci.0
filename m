Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED744A701
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186433; cv=none; b=g5Ylf3qRjBqqn1Pn5POuoM8e/787PLw9Kccv7Ih52yI0NucEQmwAmJXXi1UNl8M9IlkNvTay6vaIWmJkYwVyfJkj+p9WtsmQc9npUvezW2HFhFGE1Cf4AAdzppy4UtSPwYF8IaTq9PCjmIlNUYJiqpF31Ky3p+kOx6tJCv4JR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186433; c=relaxed/simple;
	bh=WE9aKScAKM5gsD4IlxqooQmorim2UiApk1LUKYLlefo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cw3/hX43l4zW5s8iaBqJG1oChxtrscxapfxRbKKCocVemA4FDTN2bL9FYBzhgOTdrz4CYjzkqcME9L+GVfDzkhnxq+iwDqJGPSXvrJSdR2BBgN0sfss327E0MajS5T4PsZVj8fqUsm6D69XFGtXHEpMVbQH1zxzqb7FQZAmeObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCFFVmWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCFFVmWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD28E1F00A3D;
	Mon, 31 Aug 2026 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186431;
	bh=ULM5u0oxixCq4pXtl+P+bSek3clWEEN/HMgUCGUG2TQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LCFFVmWzVmQBr7DLC17yk4qpxNgE4MeNehEJ+9cW2sPU7febgUWdFQnLXSxufiVjH
	 AwDjN6lOa4iLqoJpc8aM17X+HZDPK2dWkYRiP+Bq72TQKEA9S2JLjvXiqQaq2IZ1Bp
	 Ht+ElG1p2hnC4S+xtFyYd8Nt0qKmMz8wQajAye28+K2MZltoF3IjtjqJSm9stUOYM8
	 lE8YzTZtpk8ngFBJmTGwTXKOl4Lqw95cLI7ubgJgFbrai97l+L2dWKdn/quP9aRC4J
	 eFc/CkkDjENTgNxEw6AiQtwxcZvomiFG3z4ubU27q83rMLd61U8pXdaorv2/vPdbnf
	 hPoKlIelVkdhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] PCI/proc: Fix race between
 pci_proc_init() and pci_bus_add_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-115-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-115-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:27:11 +0000
Message-Id: <20260831142711.BD28E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
>=20
> [ Upstream commit 8857f6578b001bcf5f53c8c6a3936647f05291a8 ]
>=20
> pci_proc_attach_device() creates procfs entries for PCI devices and is
> called from pci_bus_add_device().  It lazily creates the per-bus procfs
> directory (bus->procdir) via proc_mkdir() on first use, and returns early
> if proc_initialized is not yet set.
>=20
> On x86 with ACPI, PCI enumeration occurs at subsys_initcall, before
> pci_proc_init() sets proc_initialized at device_initcall.  The
> for_each_pci_dev() loop in pci_proc_init() then creates procfs entries for
> these already-enumerated devices, but runs without holding
> pci_rescan_remove_lock.
>=20
> [ ... ]
> Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-2-heshuan@=
bytedance.com/
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20260611150543.511422-1-kwilczynski@kerne=
l.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-115-sashal@kernel.org?part=3D1

