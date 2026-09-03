Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1EC332EC1;
	Thu,  3 Sep 2026 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422924; cv=none; b=n7AlaVFbfuSf6E57xMR6QU0O7kBJTuv7zI5bhkY9tzCbfH3U5t/oDugrd0tcLHJhI5qdyeaqMvDMxT925XkfZ4A16FLRr3EPluFMFGWAVO/wFssZZ9iARr1jAqpmpQocdYnOtzm2xe9vDt0FuBHAOHEJXIUOT6wD/bRQuwY2LyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422924; c=relaxed/simple;
	bh=quqTx99s9FqCOyMWOdkbDh/RbAlgh+3jNiNfIl1Y5KA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNs325PAjvTL7zfJbtpbVatUsarEWQA1tTtLhI26AOQFOy7FuxYhCqkhqeWwkc8vxZQ+5ND60zGmcBlQY87viuY6Wh8wJFySG9vyVpmkBFzdM3/bR4rjaU81aoFGLze3HV9kw0+Csk1du9PDIfudkY06tbluU/LCgOXG8fU8vnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avYQXat7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avYQXat7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A431F000E9;
	Thu,  3 Sep 2026 08:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422922;
	bh=quqTx99s9FqCOyMWOdkbDh/RbAlgh+3jNiNfIl1Y5KA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avYQXat77SJqcsU4iT4/idV79QdOiUg3fjYlSeCdVyykBnOpIxouzTIwsa5xHoYbO
	 QFs36ZmnEL9FvobrdqG93gzEf8UctFWn3uR8O5RaICSRkeg0spt7ViEiuz2juhbSzE
	 Nr+qEzGy1rlt17QEo662vCCDRHxJ3yktsVCvXl+SMtZzStcuaNb54moFWJNwXqht4d
	 odKnbjmYgQwei4R4Y2UnIGHsxoX0Pg33KWz3cd7V97zsRr41VbrrBBjxrlepLyzQSi
	 ePT4ehpWM6gikiTlJyOfRt66hvTCldRLXRfn/DWghVkU+6bdJkckkc0v1BFTEXIKe/
	 smuG8ZDi9mv+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] perf hisi-ptt: Add field-level parsing for
 header DW2/DW3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260903075241.1445338-7-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
 <20260903075241.1445338-7-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:08:42 +0000
Message-Id: <20260903080842.A5A431F000E9@smtp.kernel.org>
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
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075241.1445=
338-1-liusizhe5@huawei.com?part=3D6

