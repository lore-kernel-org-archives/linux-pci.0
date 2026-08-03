Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F3427FA9;
	Mon,  3 Aug 2026 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780632; cv=none; b=d6wo4TT7+SyI1NzRvbLVNQgkqksFrYyMO3zQ95PueJtwWyPodn3aUZWmaylk0HaPYagm6qiedKTsVnXVH81Qucg1fZu7W8+1qzroKJHFGc2gL4P49IKBzgSGl17Xz0YYtBw95qy6P20SBhVJ8nf8ZwZ2V/ba+NnuDgAKfhbtDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780632; c=relaxed/simple;
	bh=p8LoTM42asO8CmeqD+QbCoWmXTrykvxW9S3VybHRqiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pV4vQzUKpKx/g7aAivUk5jg5/D6vA+CGjwUCqfi5xbjFgtj582i05JSXf3Zx4+HwUJ2BR7vUkbojYt7XO0o8+Fxkp20Pz7qyZKmwdo5yNu24iQEjYf5ZUMMf/ghW2MJua+fLiz02xVVjBnFvgr9WhDXUXajmupB/tbKMK7qCCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxzKZrje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxzKZrje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF6B1F000E9;
	Mon,  3 Aug 2026 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780631;
	bh=p8LoTM42asO8CmeqD+QbCoWmXTrykvxW9S3VybHRqiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SxzKZrjecLI90e5krcb4ECy3JSngx44fn6vlS0H5Jwe3/CwFSaJ2sIYJY2LimZuXv
	 7P5vKwKABJvKhDxPa0+Xl0+pEZRhHyy6HWrkAab7mzA9mi5vxRfIlvESGjpWX04zgp
	 dsFelHrooPmCFb6QHQ/daVRFAMkpK7t/hAj0QiC3OILzkka6oqL1j4x/LVML42d09v
	 rTyBnYyCrXv5RbOD8jf8zdOccjbyhrlK+zWFmRXyeuO97BbxVjlEg7V4jW+77otPLo
	 6ePsoAx8xph95XEQdYR76B9pQ5PgeQAPCG/AczFwxl6IqR6Klmr8OjWfVE6+hGV7Pn
	 kPu8Gu25WSuzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] NTB: Add atomic MW translation group operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260803180439.1963864-2-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:10:30 +0000
Message-Id: <20260803181030.EFF6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A PCI function has only a few BARs, but an NTB device may need more
> logical MWs, for example to give queues separate windows. Splitting a
> large or resizable BAR avoids spending one BAR per MW.
>=20
> BAR subrange mappings for that would consume one inbound mapping region
> per logical MW. Those regions can be scarce on some PCIe controller
> integrations, limiting the number of MWs.
>=20
> Introduce translation groups whose members use contiguous local
> backing, so one inbound mapping can cover the whole group. Add a group
> query and atomic group set/clear operations. Singleton groups keep using
> the existing per-MW callbacks.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D1

