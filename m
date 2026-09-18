Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE5346A15
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720297; cv=none; b=pTGbBs2G0vOSOD0MSTxoEDvfyVvHeDGL0tKDuLA0sGrFRS82Ir4OR3GOW4WvL9q3FGhZZ7lg2Ay/TeU7o2SIDnt0vfGuOjGy5bNTtsVZBxIYye54OmacmY7ITZFLmU63YjZadPYZ+ZH/FBUQY7pU1TtqqM4r1sJQ3XzFkLNVJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720297; c=relaxed/simple;
	bh=zHEsCKRn0eq/NE7jYEJyxmXJN4LM8gNgGQGIUP1sUZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LmSf6cYAHaVwSY4bpxg7efY0H6LAYpuS8hdQ5E8bIY6FCHfOsuxKGoqgoAyGmxSyj9aIylMF12dPOTtRcjwHI4MNzRQoU71p6tKtWMLG6g/gPKMiB8kVm7gCMtPchZ/IyrA30S4kBCBVX0nE1kfKIYOVFPsFRqwTmLCyGev8SGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2MI3mj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2MI3mj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFB91F000FF;
	Fri, 18 Sep 2026 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720295;
	bh=nmfA876KIeJn6k4+XI4Wdb4g9TOBU7LsoedbgtJ9UpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a2MI3mj4tvnMTKai0++tOrKgH3AxTE/q9KOWSGxfUFAg9cM35XKdGwCvlLu+HEV2G
	 Rd4lsu51ot5Z8dpvprRPmSe9ItZ8Nd1zKUiNYfBqEZ/6SPR43CPMUwkx1xJ6JiTj9R
	 e34zoseBtSv2zJz7shk6hRIaRck93WOqVknxNS9tx6JF2gt9A+1JkiTUIRb1Dy58JG
	 jRXWISd8FWx10qHo7/13xn0HGqU8RrC8g5Qpq2KbPMHKCOmMT6YOWjrdFUcThMoQvZ
	 JF71jZIUDIjLbMIV/XE4bJZAmk7v36qgoDcPnxwVgwxQrlpjyNuqLjRrX9SbB6HSJA
	 rKyVlxRS/zqqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Alibaba T-HEAD Yitian 710 to whitelist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Tang" <feng.tang@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918082412.15967-1-feng.tang@linux.alibaba.com>
References: <20260918082412.15967-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:31:35 +0000
Message-Id: <20260918083135.8FFB91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Alibaba T-HEAD Yitian 710 surports PCI peer-to-peer transactions. Add it
> to the P2P whitelist.
>=20
> 2 NVME cards with CMB (Command  Memory Buffer) have run p2pmem-test [1]
> fine, under same root complex and different root complexes.
>=20
> [1]. https://github.com/sbates130272/p2pmem-test
>=20
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918082412.1596=
7-1-feng.tang@linux.alibaba.com?part=3D1

