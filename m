Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB4649BD86
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766625; cv=none; b=he7MveqBIx+QqXSe49y3m0JknSzckzTU0T5eTzcLhR2B4tFXTU2xVc0ytNLY7tge2ZVq3SplHK7dWY6lyBAUdEzSKUHCVJXpvTmiDKliymAEi1b1PwcWnkGyyzPna+eU2I6PNBI946V4hoE+zrkLu4qaAONXytfYXLR+gySE7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766625; c=relaxed/simple;
	bh=Yy6yGKCWkAKGV30/NZIl1ogIJLl3e+dBLsiir2xIvvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lo8bpzu3KNIHkuo5UziE1TiPs9sINNFoiLzksFXIBCK072GfBloncQ9PLVh3GAQrdQSWVMQArP1Y/JYwRQ3KMjekK1KrVmVYBQKSIf5YSQx3Sjs/jPqS1uWS6qccQmaRguq96BQtSctS2R3kJkYmlMhpgSq+KlNlt7DAKZKV2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ+cj0/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ+cj0/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98451F00898;
	Fri, 18 Sep 2026 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766624;
	bh=TOos3aa3a6YOIi5sQZ09PPFKLq34w2BQtd4oArpGkNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJ+cj0/7PPCZWBJcU2hRymZYX5FAtwukoxzoMuSkTemNxsUbxZOvnZyolVI3mct5i
	 5z24D2uys0RNoHDUz9sucZmdatameLPUT4tYDB4pWJwG4pdAyK4hUYZ0z86pbNbWrF
	 o+S4OHIsafJwk2e+AlpJqDkcv8cpg9k+34af9AluASVw6Zbr5hL9HQ/200bcTP15Ei
	 XjO61f361EPOgWzltO0ntu9nK+aazwuI2TBRTZNNwmYJSdaNoSBsorJ/3oHjxPPUYB
	 Odky9RJPia9leGYQqpls+7c4DM1YJ3+7PhOPBjQt0hw/BbDv9RSyj6BP5Nxc+XD1Eq
	 vCW4nWxepg6UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: pciehp: Add PLX quirk for missing Command
 Completed events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918211926.1480-1-yurypm@arista.com>
References: <20260918211926.1480-1-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:23:43 +0000
Message-Id: <20260918212343.D98451F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> All PLX PEX 8600- and 8700-series data books say the Command Completed bit
> is set only after the Hot Plug Controller completes a command that changes
> the Attention Indicator Control, Power Indicator Control, Power Controller
> Control, or Electromechanical Interlock Control fields.  It is not set
> after writes that only change the Presence Detect Changed Enable or Comma=
nd
> Completed Interrupt Enable bits.
>=20
> Consequently, pciehp waits for Command Completed after changing these
> notification Enable bits and logs a timeout.
>=20
> This behavior exactly matches the conditions described when
> quirk_cmd_compl() was first added: both controllers report completion only
> when the same four Control fields change and fail to report completion for
> notification Enable-only writes.
>=20
> Add only the PLX PEX 8600- and 8700-series switches on which this fix was
> tested to quirk_cmd_compl().  This makes pciehp mark Enable-only writes
> complete immediately while continuing to wait for commands that change
> Control fields.
>=20
> Signed-off-by: Yury Murashka <yurypm@arista.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211926.1480=
-1-yurypm@arista.com?part=3D1

