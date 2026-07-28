Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342F3B992C
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277199; cv=none; b=nwjETPJVWwhLvjW1LvC5dAVfWg67lp/18M7Mz+smwUb4w1WgLpZc0z5KoEB6EX9v9URv2ZUxha2IDb5vZK8R+DeFRNAEcWtn/buws0siBifDPFNnXP4ePeLtr00xcypK4xqITCH/Uhxs+jk/E4dV4srGjhgjYoTJj3hYmp0UlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277199; c=relaxed/simple;
	bh=+yB7A3+7vbNITP1zo2J33gUmQsjPrXeBNQvFFNmz2ng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gSMqPRdneNTGazEAHKP4WevDHs0vYta2TRYe7L/uYQ/t+gMuFIozypCdSTszRrM5JcWLux31khx2YPkwzppTunuKB7c+BHEUhFKr1K1AUFOSNw6c8UEnyiXGHelUw6mHgdDH3eBlaaeccitdLcr3OYTYEzCbFUBcnubMnyfXy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5Opqj+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5Opqj+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D37C1F000E9;
	Tue, 28 Jul 2026 22:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277198;
	bh=+yB7A3+7vbNITP1zo2J33gUmQsjPrXeBNQvFFNmz2ng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5Opqj+juaFuSUhzIzxyIBpQVexrO0DQGuTEHcpiS4M+cBhpDOA8cs6F+rzUHO9Rz
	 8gd9nmL1XJDzzZIOsut8V2TrbLPd0DVsf8+yLki/WA2OIieb3UtTV+G3L5DBqU3CWS
	 nwWW4OG7zufR7iA7Hbq+8QTwd4ryF0zfB6vTJNGY4mFKTqPIvMI1V5E6Nfu57uuU2c
	 lZ6Kxkvv1kqjC4obt3PpAtETa2UMi7InsCqzyRk0rttxKsmGOU4oJkCMQR+IzWZcfv
	 smfGFAry5ZOoR3YIa5njORcGtL/UALFs6GeqamTE40T5Wpq/FBNdeSYu6EEUv/vn1O
	 K3CuYN7MbDfsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-2-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:19:57 +0000
Message-Id: <20260728221958.5D37C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> it to participate in the preservation of PCI devices across Live Update.
> Essentially, this commit enables the PCI core to allocate a struct
> (struct pci_ser) and preserve it across a Live Update whenever at least
> one device is preserved.
>=20
> Preserving PCI devices across Live Update is built on top of the Live
> Update Orchestrator's (LUO) support for file preservation. Drivers are
> expected to expose a file to userspace to represent a single PCI device
> and support preservation of that file. This is intended primarily to
> support preservation of PCI devices bound to VFIO drivers.
>=20
> This commit enables drivers to register their liveupdate_file_handler
> with the PCI core so that the PCI core can do its own tracking and
> enforcement of which devices are preserved.
> [ ... ]
> assumed to return true. If KHO was not enabled then Live Update would
> not be enabled and these routines would never run.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D1

