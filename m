Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE4598C09;
	Tue,  8 Sep 2026 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895055; cv=none; b=jzg3OmXuKVNMQdV7XdS+NyS5KpaGjvLKhqfHfV1LfBW4X7cA2tMxcAU5sJa1+UZHl4VmsrSNIBs19rmi8perogXh1JWPCc9J8INtugkVSe1XKo/NYvHDOfFE/KvFriOp2cIDN98kj+5oeg7Mgv8N/d1bfnx6m/tuivX6a2U/UpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895055; c=relaxed/simple;
	bh=9QkntcPPUEwY/jW/GjtPbqLai0VmW6YmWvMHnF6n4Ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dAEcNCNemz/3M0tyO8WwxJxO+fe7LfWfkNsnX2UEgprDZEvWOG6RrN+Tei79FousQgUsV8MkXFzUscji/R8vLFRIOUUnFy9CHwWvQUV7icnTYF2T9jRVSAsBWxd4eOLwomt/nHv21d3PcP/5uneWhCagXHARdH8F6I5b8QU6TBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O33Tkxty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O33Tkxty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A981F00A3A;
	Tue,  8 Sep 2026 19:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895054;
	bh=9QkntcPPUEwY/jW/GjtPbqLai0VmW6YmWvMHnF6n4Ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O33Tkxty9su/6V4Mv6eCK6lia+nVVc5oygA4da/ajscoKGQzoAs+6z5Hf3D9v94D2
	 IAX6rFJziXGCgpYMxg3g7eyN8DYxB2CuJEHgLd6Yc/eh4mwb5hMhPmdlxRrkYK+6E9
	 6H3tmT8k4ilOVWT4sdVdsc+OqeO4nGWrVDaYb0kxqpa9LVEwWdfKKEpzKyrRwITeV/
	 mmA4YPBXVVnxszY8taoXnerWa2BdYB9/xKN3KapW4wsaQS5m1ulrO+PG0m5/31EALs
	 A/3fA7f1rA143q0cjq4ihs8bM6bcnmNczYoOPggnEfB3KXFjG34F6tEdZXP0FSB3iA
	 srO0UHQWN+MJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] x86/PCI: Disable enhanced atomics on some AMD
 PCIe ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260908190600.226485-2-mario.limonciello@amd.com>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
 <20260908190600.226485-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 19:17:33 +0000
Message-Id: <20260908191733.C4A981F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> There have been multiple reports of data corruption that can occur
> with 64-bit DMA when the IOMMU is enabled. This occurs due to some
> BIOSes enabling enhanced atomic operations on PCIe ports.
>=20
> When enhanced atomic operations are enabled on PCIe ports for some
> models, data corruption occurs when the 32-bit IOVA space is exhausted.
> The problem is reported on storage devices, but can affect any device
> that uses 64 bit DMA.
>=20
> Disable enhanced atomics using SMN for NBIO 7.7 and 7.11 based models.
>=20
> Cc: david.laight.linux@gmail.com
> Cc: John Smith <imjohnsmith4000@gmail.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: Roland Waltersson <roland.waltersson@netinsight.net>
> Reported-by: Mikael Etienne <mikael1022bzh@gmail.com>
> Closes: https://lore.kernel.org/all/178789300872.392066.15963676631650361=
573@gmail.com/
> Reported-by: Arthur Husband <artmoty@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty=
@gmail.com/
> Reported-by: Alvin Lim <alvinwylim@gmail.com>
> Closes: https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinw=
ylim@gmail.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908190600.2264=
85-1-mario.limonciello@amd.com?part=3D1

