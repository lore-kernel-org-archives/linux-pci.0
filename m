Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40324A0F1B;
	Wed,  2 Sep 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357050; cv=none; b=uJYwRCaeebtr33BMp+nuX23kSD4nJVnHtl4AuwAmnLMpOGsJcxrchaQlTCNfOFH4MbTzKAg1LoaQnLGUyyjFLMMH7uDtxscFEtcnIdGwca8+4Pa9NBghM4XBj4civb/EqTCfykiAc+xK9i+ZhCjHufgleDv8LwvEDBd+/F58jx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357050; c=relaxed/simple;
	bh=SmI88JSvS04CYWz5Bel1P0O6ce2WQc4qhYuPpF5uvzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DlvbJVUMJRLa7eD1L7X/Wvwc3nuunHGIFW2oIVVvuR/H9/5nfVeRSwV0TUqn4VUxikIipcXNsz7Dwt56F3nPUqfNMlTSrCEwP75Legfu0OBGNBn9fDKVooFDTvy2qP/pi4vaKuigvjP6gTXIQjgNRmScKMM/9GVhy9Fe70C7wDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJy8RXVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJy8RXVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEA41F000E9;
	Wed,  2 Sep 2026 13:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357046;
	bh=ivkR0zbz0kXWQiZ82YKucl2B4DLKJ/uF+0TtJ+xby1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SJy8RXVUq4P+RNRBoH4dC8iBMB2NtUyYAk6UlcpsoJ3c4y/WKH2MTUjXxf0CoHMrt
	 GM4LqhyukQXqrQiNnETYO0Bxudd3qX6DXmXkZGTjAkQpjHqwKI9ZfpET/McD+Fw5Kl
	 2dQzbeTPqJFFte62NxLrAA4HQkd1qFeZoKDiXFSUyYb/VT2mY/ECXTezFQlNsDRUEo
	 EZJFpBVMtefuxfkZMR6hHV6RTzcimRKais+D/YbgbiPgHyDnzqYngzJ2DbVNldsvFC
	 YXRd18vScQMo0gHGD4m4SIA9jUoMO/94TrICNXyXVzbzj1W96MJNLYmhorIsuOJmzs
	 v1p6KmUc06jrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 7/9] cxl: Add port and dport identifiers to CXL AER
 trace events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902133933.2992457-8-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:50:46 +0000
Message-Id: <20260902135046.6FEA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Dan Williams <djbw@kernel.org>
>=20
> Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_* trace even=
ts
> instead of a plain struct device * derived at the caller. The trace event
> helpers then derive the right strings for Endpoints, Switch Ports, Root
> Ports, and RCH Downstream Ports consistently across the CPER and native A=
ER
> paths.
>=20
> The unified cxl_aer_* events keep "memdev" as the legacy field (Endpoint
> events populate it with the memdev name; non-Endpoint events emit
> memdev=3D"") and add new "port" and "dport" string fields populated for a=
ll
> CXL device classes. Updated userspace can key off "port" and "dport"
> without a parallel set of events.
>=20
> Remove the separate cxl_port_aer_uncorrectable_error and
> [ ... ]
>    serial=3D0: status: 'Memory Data ECC Error'
>=20
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D7

