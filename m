Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A19331A4C
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736772; cv=none; b=KD8t6FbK4pfWEKXw9n6mCxY3CA+2ifj+SdZYZnOVz2v424aEI3QRz+DaYnKDgYaEs7XUQD5J92eTbDxn2PFZXOOTIs3+uww5ZuCRMoPwg6eUu+mKs6mHPSLN5ktnYxzZgjKiKdLSPgxJaxG8vNKc7FT1YT32HzZV/NGlaJIpgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736772; c=relaxed/simple;
	bh=AEVwFXbKCGw98vtyOXn6N8YZqJTY/o7vCFBJsxFZeFQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rB2On2381U1SP5AmrXABtJfSbofnCoS9MAmnEgHAvs6m/GBZphfG7VsAcuTflJhhD6xijmK7fe0JQfKhQ27iktIPik1J0Hk1538FKCchjjWt5YO9T3p5cLRyBXbIYtb6GVk1sL4lxWwlkbc2ExBfdPZyNZqqjgqIjq4X9d0nUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJeKNr6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJeKNr6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8101F0089B;
	Sun, 11 Oct 2026 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791736771;
	bh=OBysh6YaVpdpNTgmyYBs+pLEVASqN4pL/OaefqwneaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJeKNr6yujC9ouAsUNDia7NsGjJd3oQ3oGrY0sCbctHpX9fPlSezg7bCSX/btwGR6
	 b7I102j5GJrTOIeejCj5+GobF6PgqCEWDdHkNNJK0fGZY+gEoI8Rc+gS+fczEao/ea
	 x21C5fFa6mZZ57RXuq50tMF1PcpQo21/XduKfhLq3c7Jux21MpDvHJxyRZxhIlSkAm
	 1Rwuj7bnouL41c++RgahazUi+XFQ+1sv1flEDRkdEC81mK0+m5oxHoCk1YoH8tQl+u
	 a+zTmBSczfYqGzZyZ7f2okEb3HbfA/E0vYlZbRy5G1wnRwIqm3UvVlRjOFLzrcCnt8
	 h7WQHWUgum7Yw==
Message-ID: <sashiko-outbox-167315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Ignore Immediate Readiness on Samsung 990
 PRO NVMe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gruhlke" <gruhlke@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261011163249.18479-2-gruhlke@mailbox.org>
References: <20261011163249.18479-1-gruhlke@mailbox.org>
 <20261011163249.18479-2-gruhlke@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 16:39:30 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Samsung 990 PRO [144d:a80c] advertises Immediate Readiness, so
> pcie_flr() doesn't wait after FLR, but the drive returns ~0 for up to
> 7 ms.  Since commit 10baa9b4df40 ("PCI: Drop unnecessary retries when
> restoring BARs"), the config restore after FLR is lost, which breaks
> VFIO passthrough of the drive.  Firmware 8B2QJXD7 responds right after
> FLR, but older firmware such as 1B2QJXD7 doesn't, and the firmware
> version isn't visible here.
>=20
> Ignore Immediate Readiness on this device, so pcie_flr() waits.
>=20
> Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
> Link: https://bbs.archlinux.org/viewtopic.php?id=3D314833
> Link: https://lore.kernel.org/r/20261010160529.27974-1-gruhlke@mailbox.org
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011163249.1847=
9-1-gruhlke@mailbox.org?part=3D1

