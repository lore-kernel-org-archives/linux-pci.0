Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF13B14C7
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719225; cv=none; b=GnNoNBrsWFOWLW00h3GIHbW5Sbu+d+Gd80mt9H8HrOvsMgxvMXry9wfE2+yAUwSDlqXQciGUx46PZ12HzQBErY6lAcfwfl7h9kLhQYX2T3x9C1krpz+HNpFh0Xi6ow3XAtOJ9yjwz1G1jzgEijYOF9OirSJ599V3Vsy12WYaZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719225; c=relaxed/simple;
	bh=6LmSquj9M4q9qtc8osyoepfWn56LV8tBQn+0BYG6wFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lsEPnFGUz113ZW/ZUf8JL9Y21SdqTHECJqKg6moz2vBceE3J0lnMnYJ6xVpCcehJVAsFYgFg+8W7JK0sZDFLULWM6tb9ISXuBzShYkz/SWOD4Uz5S3IoDbExkbl0H3rbRNHGcNccIxhlbqZtZt/xO74t89xQ4fGGhiheKwkPB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwOOJYsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwOOJYsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A596C1F000E9;
	Fri, 10 Jul 2026 21:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719223;
	bh=6LmSquj9M4q9qtc8osyoepfWn56LV8tBQn+0BYG6wFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DwOOJYsMSTybOP7XsS7Fsa4095qkOExXRbvQxKLrguqKDz0YbXePuqujBsB2dh3uD
	 uQSaLmiIdJUrPHHeAS+h3EAbAHkLCfypH3EU+gqxIGruo7y1i1UZ/DOClw+poW6iSr
	 TUQULF+hTsDBB1wAKFFiNud/T6ZiUjIk/dSwg8bPhe8H/snVu6yBtpjvdHlF+BRB8S
	 pOtsrlwAgtshAaTuVeQFu0ucnKIGHVQSFBsPPyMZFLdlhdExw8ed0ul22IymP1/HBH
	 WicmwRIHKcjhlULmbfcr1xLpTZqVaxsT5oXBidZTcVCTRro9El5/gp6KBZZqu5bayf
	 uFY8saXRHW5Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/12] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-7-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:33:43 +0000
Message-Id: <20260710213343.A596C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
>=20
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
>=20
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D6

