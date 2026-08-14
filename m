Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87633B6CC
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739486; cv=none; b=Tk2UaV10PD2DprWSFMy64L66bwRr7ZTn+ryqjBkC+Ng0HDRa18bolecQ47mvpNczPsqocktTELPUyuu8aZNvLWxLO2qVj5f39s8IyxI7bXlAE5HmolnAaNCbwSzb5DxlRVhpyJDs3pFrgLL+OCGsaeZSGbUTbW82BpUQHWP+fKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739486; c=relaxed/simple;
	bh=+mO++3viBLu+TxGp8SwYy0bTQWHU3IBV8bxjluQY1xU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rbW7TP8A8ZY9Ss6OIzGzPIEi2AYklUGXlZczLbx1KDf1UzeWl9f9Y36ojMb4cNHZTnbhG5fg4U7L3oRH40+8dVg8kEfPBZUnDMmUwNSENPmFBw088h3Yg/XyfQ14+IZz+4Wjidqgyaj33j6y8x4er2GCYof+PFr0oG3PdIzUcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCkMMUGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCkMMUGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BB61F000E9;
	Fri, 14 Aug 2026 20:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786739485;
	bh=4+mepKBshtmHJss7NDbFw32r56ePtIo6KgjhZ2lrxdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BCkMMUGvJa5n6mf6FWcNcatR2R/hjgc7ixMg9UMFHcbtZuBYtLJBRRC9KWWFUrDca
	 r5teKFITCvliQGJB5PFBzSsLz8yLEpVdITRmnd5pMSdcRl/NAiYK9bsD3Ad8E3W2Ih
	 VtnySpCi26rwZkV3N9e5rdurR2ZzCOMSugZ8rE3BJgZyudc5/aUbhEw84PshexLkRL
	 QynwEbqUNKb1dGjUjQlq3WqZZ7wASUdP/eDqSBEWJR7xzCHXIW/MQrzAnVdZfM9Vvx
	 3aI9SaX7soStun087zLj+spgaElY4tlO+NNERbvmckJfVHi538NyhMuWc6tCWZx55N
	 DxTaG2+WautBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 2/5] PCI: Move __pcie_update_link_speed() out of line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814201621.2281245-3-vidyas@nvidia.com>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
 <20260814201621.2281245-3-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:31:25 +0000
Message-Id: <20260814203125.93BB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> __pcie_update_link_speed() records the current speed and Flit Mode state
> of a bus and emits the link event trace point.  It is a static inline in
> drivers/pci/pci.h, but it has only two callers, pcie_update_link_speed()
> in drivers/pci/probe.c and pciehp_check_link_status(), and it is never on
> a hot path, so inlining buys nothing.
>=20
> A subsequent change makes it re-evaluate the Device 3 Control register of
> the bridge, which is more of the PCI core than belongs in a header.  Move
> the body to drivers/pci/probe.c and leave only a declaration behind.
>=20
> No functional change intended.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814201621.2281=
245-1-vidyas@nvidia.com?part=3D2

