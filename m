Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057E54B1CA;
	Tue,  8 Sep 2026 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876633; cv=none; b=oMqm9Fnt1rqdsoCCg5OtYIaYWU6g4ILCu+A4pC9EdNoyPfcCy3FqjqnDa79nfpLyrmdPOXZA1lvgdC05L7NurD7/oWMLO7kFhtb2n5aEPZu5vxMJ9P0J43FsiuPG+k1FLJM4fLQhX9dzbdXeLFp+l+BmIPGG4ghvOvSqESfnrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876633; c=relaxed/simple;
	bh=k/To3FeEZyHzgAfww/tuRSVePhnz/nrKOliGgTi1OUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kIQ4skA7pVb76P2mMxdDsZTyTOOdhqU8g7uwLnuFJbLuPTQJ6LsG1kLVct0I5yM4/D/Gpo14JicXSmZ3kk0tfIyo50BKaeztMyvNUyKvjvaMr4BRVpGCzX0383RyLoOecqBAYSwKlkyIKJcOWukuHdj6Nqe58p/n6DSZknQJ1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EDF1F00A3A;
	Tue,  8 Sep 2026 14:10:25 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/8] perf hisi-ptt: Extract the raw data printing
 part
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260908140509.2485649-4-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <20260908140509.2485649-4-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:10:25 +0000
Message-Id: <20260908141025.93EDF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Extract the raw data printing part of the TLP header into
> hisi_ptt_print_raw_record() for reuse by subsequent patches that
> add field-level parsing of individual DW headers.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908140509.2485=
649-1-liusizhe5@huawei.com?part=3D3

