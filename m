Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7E4D6C2D
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110636; cv=none; b=dAhiWDM/MytMppmZVtvTvhUqlpQoqbEv1irAy4xdsStLxMOh60wxpSzZnAbLVdTkbDOEX4zgaadrpn4xOgnAwsRGuHjJP1vcBToFA+EOrlqC9ymyecfka7/CWBTE7L6N/mjYF87Y/2hRO/Vr3gjanCzRQSmJBvlCapvGy0yFjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110636; c=relaxed/simple;
	bh=czDbGDZIxL77vjdsZgelI+7T1KvwPNdWHQKadkFWU6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vgh/GSSNxVcIpSagpIEzaUkKJW/xQAcEmhopbXDutB1UJrHnUS+RQr9t7juvI4r7KBK1D+Zs/8+gmVkF0wYGO8motpIGXr+BQec5TrpfnvXPnhbq4YiOYvuOpWrvP6BjkdRQYyvxteArQ46DtLtdkF7UsLDxfzG4NiUayeLNYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIfXGSqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIfXGSqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFC21F000FF;
	Tue, 22 Sep 2026 20:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790110625;
	bh=czDbGDZIxL77vjdsZgelI+7T1KvwPNdWHQKadkFWU6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hIfXGSqpgZUVq7y342x3RBJnFrZmDZJ3Ar1NJScJ8tBYfrRbkwg2LCNbOXGTL1wCS
	 kMoKeTzIHb3GuEN9e+kkY1xPktcmEM/U2ghbe3wZa3xLavUpUN6R8BfD9etRQVjBUQ
	 R4fLUcIC145UZJU2V1h0iSsEVf99CepBlrzUdvxx5VZNp8ZD/ErXvZmVDmGZ0CggCb
	 nAChAVJDUQpOzaM1EN31ITKQG6JuUxQVT4qhyyeUlRZQgFTdNpH/FkMqXyTAg4pEvJ
	 EaegoAWT8hIDiV1547osBl2binsB2zzphu66aMT2rcRwtbUrhNK/wJlcy1Mt3F+oDE
	 P1nqyTQf3EQeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/4] PCI: Assume control of portdrv-related features
 only when portdrv enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260922204548.3884906-2-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260922204548.3884906-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:57:04 +0000
Message-Id: <20260922205704.DCFC21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Native control of PME, AER, DPC, and PCIe hotplug depends on the portdrv,
> so default to native handling of them only when CONFIG_PCIEPORTBUS is
> enabled.
>=20
> Native control of LTR and SHPC hotplug does not depend on portdrv, so keep
> defaulting those to native regardless.
>=20
> [bhelgaas: commit log]
> Link: https://lore.kernel.org/r/fcbe8a624166a1101a755edfef44a185d32ff493.=
1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204548.3884=
906-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D1

