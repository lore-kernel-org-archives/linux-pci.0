Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F541DE0C
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277194; cv=none; b=KNrdn74kCUvkm+U+9LvL8rS1gVK0mQe1KpFsJ1WP2OUpynz5iUNJ4aNk07QO/XWVWqRzWeccO1RIbfIPkKver6/Q45gSZCSQJS5Dqa4+gU34qtav089/dSATFLZcgvcneV7vT2/b/C4mbxlKqo9FUDfvWnnd+8Y7IyNwPw+28FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277194; c=relaxed/simple;
	bh=efOlloiqOSRHfuRbJ/yOvxHhx0zBMUDvoYHHpLqzTNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lrS8i/9h6+jzkcI9+w9EVXc/7R/nPMCvWIQuDHI3Wi8rxPrvpEPidIIeQ9rFjr+OWPsnMtpxwsyNyv2sSPa+nkaAYpNww8+a/WeoLhqNeXo/GPY+eSypr5ebMYyrl7zi6Lnm5NyJ5h7PnIRMC6ESFNh6uWAne4Kw+kns3LpsEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe9EACG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe9EACG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9281F000E9;
	Tue, 28 Jul 2026 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277192;
	bh=efOlloiqOSRHfuRbJ/yOvxHhx0zBMUDvoYHHpLqzTNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fe9EACG4MoDYMnzajcvvrYbXLngzhLyoY38MdV2evAjnUS9FKJE1nUhulL1FUJ/pX
	 7L3pYC/RoYUYp5RMghsu51pcpCpfQ+4IM3ORwJupk6jJz+l8Zr88UFaDvIWy+abSOb
	 g/tMD6OpGM81Y5rDBpfmI/UYnoUO16Kz60tPatTS266Xx8GCcgxOKqroXSL8BTnluP
	 uHxt7hyHvYs5FBdNW85sZSiJyvMxH7oPuCdRfoLmvtmyUbmVRwcns5ryzqRpB91IwQ
	 PJqfoKwxGtVYOqxafSxCUr7Rgsk8sxHInrdQCNvFDxoWuMlV83i/6bvzPGCEcVboeH
	 RT+BG3GbRi6BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/12] PCI: liveupdate: Preserve bus numbers during
 Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-6-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:19:52 +0000
Message-Id: <20260728221952.6F9281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling and
> flushing any memory transactions first.
>=20
> To keep bus numbers constant, always preserve the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices were preserved. Note that the
> kernel preserves bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.
>=20
> If a bridge is scanned with a broken topology or has no bus numbers set
> during a Live Update, refuse to assign it new bus numbers and refuse to
> enumerate devices below it until the Live Update is finished. This is a
> safety measure to prevent topology conflicts.
>=20
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since preserving bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D5

