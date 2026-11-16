Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812429;
	b=3DK56dp9F5GzBBAYpIwFTAUZxO/+84h4M3uLrQ6K6Je/l4OYpmQhEe0tmFSZmPzwfYW7
	 REbBI7V5zqHrYS+QHS94sgeUvQraR0aZEFP9BgckqcV2Luly6CDLyjXInvFbHeLSWuLiC
	 BURHLnBMjnzLCVVIoEbSXkFIx8AV2pDZfaz72ED/O5sFmDu2IfzYHNNhNVWhyS8KJ8mZB
	 4Pr3x/Wsmq/2VVYZGd3tVrykgsrD0XY+BWOIyinDG2RSl7/fTmC6uK/OsyZQjsFcvybT4
	 H1XOFqQwCv1MRG+KwBhk5qUdYjbhqwGYboHeOXKw8J/tJE/Pu/avzlU0BWCTQI3wPBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jTHI0ENNpFzpX1KhMZDKBSkHuhl+Sg0VZWEWolK1eH0=;
	b=InosrKBavkdFrhGZWH7rK8fvQ3gzGUcL6VTG+ubnWg91o/4NMHSPsXiDZCr8cte1ZOiK
	 hEfijj8FdLLf4XfpVdSMvu/+JnIm4i7cMlwdhSe0yoKXhRyQA3n3RZB1LnzuSLrSIWGEV
	 yb135WCqfcEAJO9PusRbYc4KrLiJGc7ng0soQGFTQjR10zdOAB/jIsehENA0RKO9DK6Ms
	 dWcBAFcNmgGeUzKwq9Blqdee87njle71TIsM1C/Dh7brziKB0tUkqYX4JkC6uhM4M9dRW
	 Q0jN1PXpb3+hZH98rK8REfweoBvvsiEkJDRMnfIG3h8pU0kF9xjf3B4dDmMcA+nDo1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIdVpNWe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F1606A32A
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIdVpNWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778CA1F000C4;
	Mon, 16 Nov 2026 07:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812428;
	bh=jTHI0ENNpFzpX1KhMZDKBSkHuhl+Sg0VZWEWolK1eH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gIdVpNWewnhrW9K3ntKvHfiGg5nsKti8WIJ9pWobct2xc7kT6Azhy5rnQ7MgviVI5
	 FCfmF8Yof7ipQoYHD6YKgRnURKLQVMG/wC9ZLiNuDSfTYffU0+3wVvLgCCkH6Nsn7w
	 3HwEwby3vECI+0SlzNdoSk/K3H/ZBDxehwx4PPm3H/JuAT2dL0oAAbrGNlAs8w4DDV
	 MVtlqFH0VpDIWLwXvKMyBZWOYmyk0bLCK9icWJgP7OZv+rN8JsPNVeHhOiBL/fYH/H
	 vgEldJJe+eLxV2DiUVLPS3naLjFm92PCC1WKrVF5msJZVaVo4hnEZsEBxBTjcghF90
	 sXbQYmp4DqkoQ==
Message-ID: <sashiko-outbox-216358@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] cxl/pci: Guard decoder accesses after reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116065229.38194-3-icheng@nvidia.com>
References: <20261116065229.38194-1-icheng@nvidia.com>
 <20261116065229.38194-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:00:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCI core calls the driver's reset_done() callback even when a reset
> fails and the device has not recovered. cxl_reset_done() then reads the
> HDM decoder registers to check whether decoder state was lost. Reading
> device MMIO while the device is inaccessible can trigger another error.
>=20
> Skip the decoder check if the PCI Command read fails, returns all ones,
> or Memory Space Enable is clear.
>=20
> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in los=
s of previously committed HDM decoders")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116065229.3819=
4-1-icheng@nvidia.com?part=3D2

