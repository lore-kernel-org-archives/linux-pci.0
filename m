Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59029B78B;
	Thu, 27 Aug 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839841; cv=none; b=lfQ3H+Kx4i2wQ4NW5nXjlX7HK784IZ2Z7fFARjvVZRWRhBFs6Qj3u24y5fBOxejLcwpc80Ovk5O6S4U8F5CDTdADzGPTRUVkHT4S9cZdCliHCKY6y1scu7edHtx4CWfqtlf6shtQsclv5dp8AgzwRyVydjk23kkWPhb2LAkrDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839841; c=relaxed/simple;
	bh=s0k28fN2cb4CHug/wmipNZR8CdCOVtKlSIGkITV5KAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c3nAI4JoK/G8rgKZfT74Y2QHKHfMHXSgjrsn85b/KcCYsNsHGssW64w2yfvj1BqXP4TpoPZF7a5Ekz/xa2geIGerGq+HG2NfBYvsg4YQK2mvR97rdBYneYMJTKjPWJmGaDoOllz4nQ0jgNCUJz0rBx+XxanGNBPYbPeGoMx/N3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0yyBZwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0yyBZwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D771F000E9;
	Thu, 27 Aug 2026 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787839840;
	bh=s0k28fN2cb4CHug/wmipNZR8CdCOVtKlSIGkITV5KAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C0yyBZwEhwIf6Ljn4xDSjpNV73XnXI5S0wlzrHhh6TY5d5L+ujJLiW1C7uWDLPJu2
	 9w1vzvBbh44g5X2CC2lCWy3zojiI66eVBxzU7KnEYssG3Uqr1NRAnuxb1CMK9Urt4q
	 tPWTOjjA40BdZ6tMo5De/910pz5RRR//e0qzfJtIXwrSnWp01Sib+KGXqWFEzH7PGh
	 Al/Qiws4CBfbgrBpxh6f4sc5XeV7IJjgr71mWCowcuGqJr1fm5uy1e9dyWQ8++GG7z
	 lOq81HicQHSueJBN0UBr5AaCpbmkMYh+GlF8yXNg0IrPh//7+V/0N++wD1YUpSgFBM
	 2XOehB1S4+gAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] perf hisi-ptt: Add field-level parsing for
 header DW2/DW3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260827140442.2031128-7-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-7-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:10:39 +0000
Message-Id: <20260827141040.25D771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add field-level parsing of Header DW2 and DW3 of the TLP, separating
> the layout for CFG TLPs and CPL TLPs. The message type parsed in the
> previous patch is used to select the correct field layout.
>=20
> DW2 fields are common to MWr/Msg/MsgD/FetchAdd/Swap/CAS/IORd/IOWr
> TLPs, parsed with FIELD_GET() against HISI_PTT_HEAD2_* masks.
>=20
> DW3 fields have two layouts:
> - CfgRd0/CfgWr0/CfgRd1/CfgWr1 use HISI_PTT_HEAD3_CFG_* masks
> - Cpl/CplD/CplLk/CplDlk use HISI_PTT_HEAD3_CPL_* masks
>=20
> HiSilicon PCIe trace device hardware is responsible for packet collection,
> parsing, extraction and fills the corresponding fields with the required
> positions. The packet decoder software will perform the parsing and
> printing of fields filled by hardware.
>=20
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140442.2031=
128-1-liusizhe5@huawei.com?part=3D6

