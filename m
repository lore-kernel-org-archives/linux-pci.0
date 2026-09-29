Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE322D662F;
	Tue, 29 Sep 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704345; cv=none; b=jPif/aRV5lZ3MwxsUuR6MzPjzWgPUdZsA8mmLteeI3a8Ih+c8POwNwjSl3JTXQl2jgzCJWYOvHSJrccyXAypZmefRLeziDhLaJM7UJiPbYPLXVzX8LqtKCZykNpnK7wCdE0RxC024GiioonQo1g8fAAQqA09NXBtXT6yEfJVJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704345; c=relaxed/simple;
	bh=jUdmQ7cXcG7gmDJBK/gy/2oCt4DJ9zyFUO90g738snI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=upWK1oS/7VKgvaSIQfsPPsag9cR8MZ0wDb0oS8yw4NrfN54nmRoQgD7IdgnDf/yCSJ5H4EMtAx7LOfhyyz9zYsOOh0If65KQwm9AGlUxbfk22RGrY+NtwN6XrfECkcXC5KOe166L2oABC4Z8PsJprRTmlbkl6uEUg66ddUKqjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBrDhm0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBrDhm0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA251F000FF;
	Tue, 29 Sep 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704344;
	bh=jUdmQ7cXcG7gmDJBK/gy/2oCt4DJ9zyFUO90g738snI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QBrDhm0FbGauENZzVflopasGfxSkpItLQBuxlBuQPY6EI9OryQ4SLecUcBBlkrBr6
	 iD2yG9M6Dg9qx7hgtMY2I0oZaP5Ym3fHi4O4ndx7rsV7AQ7jH69iIM3hllkYwhHX5Y
	 63yCGALHUBoSgmwjBWV4CfCQRPwhDW1H8UEPG89f4JPyH6MsNFywI30/9jdTkBLxun
	 sHlrGYBMvXqKJdirYT24OUkBvzUoGDs62Ga0MpTNACXjmB7K7EAuQDlhBqigCzC8+w
	 nbqrSXukImbI1PtLs6ibKFr6/Otz8kCcQeUENXpjL8r3JJoYBib3UkFTOEigVYk2dw
	 kgKx8I1LQXTCQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/16] vfio/pci: Gate config space access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-3-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-3-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:52:23 +0000
Message-Id: <20260929175224.1EA251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Protect config callbacks with the access gate. Keep user copies outside
> SRCU because userfaultfd can stall them indefinitely.
>=20
> Run D0 transitions after releasing SRCU to avoid waiting for pci_bus_sem
> while AER waits for readers to drain. Record blocked D0 requests for
> replay in resume(). Return -EIO for blocked D1/D2/D3 requests, which are
> not queued for replay. Preserve existing handling of hardware power-state
> errors outside recovery.
>=20
> Add a power_up output parameter to writefn so the PM callback can request
> a D0 transition after the caller releases access_srcu.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D2

