Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2336A02F;
	Tue, 14 Jul 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026857; cv=none; b=XRNK1rJ82mRG5UUtHXnwSF6wjNTO3zVm+Zjm3JnqMhobVhtuV8U5LYe5Dqqt5FNW4h4+xqKdIFwwHd7cEpt/RphOE8CkggOQ4KXumwDWEhCQhQEaZ3jZbY2xJqibmHHshw624M+4oBQ8HvlY0FOTpebeHQkDG7A/HqGu4G2cSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026857; c=relaxed/simple;
	bh=0qhDchg6rQk91lgeLzwHrDfd8BAxgZg11LSKCFxThzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mg99bSqUk66Sign089BOz75F8N90zOGgSgc1DjPzMoqzXz6zZ/CcghnYHu4cYen7w3q6vBbeRQSus7kqU6syvH37CFf2dMMXcfqaSiYXA8fvDR5yldZMScqAtylEJnqP5h+H2UyzC0iuNT5bbIso2Gvxp22QiGq0cUYv3GQuZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWgHD2oL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWgHD2oL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D598A1F00A3A;
	Tue, 14 Jul 2026 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026856;
	bh=0qhDchg6rQk91lgeLzwHrDfd8BAxgZg11LSKCFxThzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TWgHD2oL8VeaK346zkTlo5sv/Xy6eBVE+sCbKJkoIEskbro+5DwAuSKoDotmTYUql
	 d3TDo2iLYw8Xv1bsLvr7fHnaC8pDvD2BuyR7lzLq1hFNPH/qBViZFinC7+6TME+gv/
	 YEVroiMX4RsH1aSdxqV2+2z29+ZMBx4YiqjityZ5DBsXdVQIL8x7bFliiRO0xeewi1
	 LQGM1NOv1ZCzHAxHMW7RXX000KuqCvWBR6ekQ/8OGtKQttbNthm5gReGlP1CoVLBNk
	 RzqOBlOy5tH/lEnpgRRv7kaVyHKyEfADga+lNZSl84fYcGFEmqfUjjvSCnN4/c/zet
	 7d4KzenY1qOyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 05/16] PCI/TPH: Fix tph_enabled concurrent update
 race by bitfield packing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714104325.54444-6-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:00:55 +0000
Message-Id: <20260714110055.D598A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Split tph_enabled from shared pci_dev bitfield into spare bit of tph_cap's
> u16: tph_cap is immutable post-enumeration (15 bits for offset), remaining
> 1 bit stores tph_enabled. Removes cross-bitfield concurrent write hazards
> highlighted by Sashiko after VFIO TPH exposure. No functional changes.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D5

