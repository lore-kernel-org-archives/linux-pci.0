Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CB2FE057
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789356451; cv=none; b=k8q09GHhQhwp3LJEHe25r2Zn+1WBEdOBTKGgWBPLwqglYd40AZNrbJcNLBfvvDLeH3KnA4jWucdRoXHIzjdNASLx6FUqipmIKQpH1Ub0oKGxd0jr6MtfDOKmeSgCZ3f+oW4eD/xUUuFYyT5qf/MwFdG78eSXcfn+3I0n11PqNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789356451; c=relaxed/simple;
	bh=nxONu3SQ3llh20t+evfbKfbPN39pqBPDEPWjRuLg2gU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bEPkyZriAklE/5P0q4P5DUvBMeskQVGAD/XHzRJy81g5ADXcqN7uf5T6/AV0oeCYV808TUe4M4MPSepZGpD16+VjeWJZsKEN2CFRKYexQDuCttWEAOe57LrArldzhiZw9/O5Hazp/Lxn2b6fIHsIrwNMpIN6RfC8Ucl0WgJeTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZe0EWRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZe0EWRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870621F000FF;
	Mon, 14 Sep 2026 03:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789356449;
	bh=nxONu3SQ3llh20t+evfbKfbPN39pqBPDEPWjRuLg2gU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZe0EWRjy4Ay/OUSsaJKjTfVauLzeejbhV9xHSiY/YnTXedIDJLWaHMHTrNpkoTYR
	 jiSNvoKFWIaddbAwaLHBoEeHpzDGU3o3wRh1iccj+lu5/hhQFejTTohIzf7HIrZ9uo
	 eVpbHFUvatel+p8X6MxELgTkw7cZ9QFKJnAMsKrME5lCYPpZJNXWwMOOKA/0n2loP2
	 F/QZMFrOYJN9IEeXJCaMTe3gRE4HOOnvPv0i8zNw1ntpccZJtPOubkNMFrKcSd5sRg
	 eaZtDULEZWwiQVASZWvTBHB0PTN3EkdAwSNYNQ+LXxw3IQxdMliPSWWKXBbtMzvafJ
	 MB5AZGSICezOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rcar-gen4: Update how to obtain platform firmware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260914032520.99699-1-marek.vasut+renesas@mailbox.org>
References: <20260914032520.99699-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 03:27:29 +0000
Message-Id: <20260914032729.870621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
> specific firmware downloading. The firmware is now available via
> linux-firmware.git repository, update the documentation about how
> to obtain the firmware and drop the conversion script.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914032520.9969=
9-1-marek.vasut+renesas@mailbox.org?part=3D1

