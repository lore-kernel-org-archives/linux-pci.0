Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684240A929;
	Thu, 27 Aug 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839763; cv=none; b=p/WCkQySzr8NDFdp6pPOgLPRdkyzennEeE5yXQaJLiQnQsIKtb3b+gi2kWR8VTVkI3rleRs37cVtggWudoUioJl8LVj8we+SLIGZ6FSe7J2wJJL/kuwgRQTPrbNj4/1LXmRiiUxEpDIXbNFub+ABBDXPbXgT9Ijqe2EWZfgAZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839763; c=relaxed/simple;
	bh=CtQDv0WCmE715RueSgyyPup5L+4GHidexGCcLBk748U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lpok45WSKl2gSbFwX5LNWOleY5fEkq+kJ/I9U13ZJ9qfn5+BAgRyZAvacE9J+kKR+/JXJOgnIYPPqdBIQhSTfRgvbJazLPSJufzs3PnXG7F7TlHZeF+mIj5cOdnP966kDEkFVLUoHF145bg5eJJkRkFXOym9W3bPz33WE7Q+Oe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY0l1/Cc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY0l1/Cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275811F000E9;
	Thu, 27 Aug 2026 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787839758;
	bh=CtQDv0WCmE715RueSgyyPup5L+4GHidexGCcLBk748U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LY0l1/CcTdYIrTLgzH6ESkiu+4sb59iawmnfl9UUE9Ew9b2bomkVGvC1u7IDJTBK6
	 oR/9aIDDqBN2nw14Cb68B6VABPla7fUxe1LWLKortO63MIvFxcWfKVLSm38EqIl8LG
	 r1CMOl7l6qJBHpC56DQXQjA/aaVuvtuLg8o2lldNRbCbloNFPar8rCbXglRfmjSIZm
	 G++wmKElxzimuLdRmmzu/B7zKpCkpY+/FW3ocx11UhICNIHP6ZbBWrwt4QbUrlVrGS
	 xs2wBOa7hQY6mKswQGh8pr+maOCjgww1FyStTO1AI30iCIxzHc2xmVpls2W1LRl4WH
	 Vkv7FKiLnsu2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] perf hisi-ptt: Extract the raw data printing
 part
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260827140442.2031128-4-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-4-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:09:17 +0000
Message-Id: <20260827140918.275811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Extract the raw data printing part of the TLP header into
> hisi_ptt_print_raw_record() for reuse by subsequent patches that
> add field-level parsing of individual DW headers.
>=20
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140442.2031=
128-1-liusizhe5@huawei.com?part=3D3

