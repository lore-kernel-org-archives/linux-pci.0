Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5D37A83A;
	Thu, 27 Aug 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839820; cv=none; b=YSl23isWhfzBtvApm5lAPh6ALq4Xc1dZkHIomry24hYDt/d15Bxi3UFVY1r3m3hY+m8IxjoevDpDMmKxCIAKbrVvDkf20AmeK4EmYFWuLFMmmvxkWcJd2uho4lsAIO4VdN51AAngAxEiBBlIiSFPjTaOmYuh8pzAp5wFfrQWOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839820; c=relaxed/simple;
	bh=JePPU1bY3WikBvOkPpEE18keX35nVeveVQk9PIAjWDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ShcKg1ZgkHH55S0yGv7QI7PSvmd1T5MT6Cig+l9LHdUaaZa6P0D7er11wUKeUDYGpROr8A4czILcPUpVyAPmXLV7uXj7vb+DDDZWk/B9UXFmoMRCMaDl/E6KPzJun39cVinmzXUxXaQ13f8FM1Nrks28Xi8Nt0vxg3/1xL1+z5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8u8cgBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8u8cgBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC261F000E9;
	Thu, 27 Aug 2026 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787839819;
	bh=JePPU1bY3WikBvOkPpEE18keX35nVeveVQk9PIAjWDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8u8cgBa3osx7Jm0tONeRIK7hTqp5WjdLrMMorRzGsuBai1lNssZSdl8wEIUkCX3m
	 nL2FBQ3DROKO9Ppvfyk+IVCQAX/RHOeAaT/U3yC7iFkUxO5IfKIpmlcq+WjXfR9mRi
	 3UKm/5Iz9VdlOzRt46h1G69ANhBK0EpsQ14u1tMS1WBfokbWVnnvZbs7x3dWhGJuzt
	 5Mth7OizpXtfHoauYdkSE6C43+FZrG5QXh1AIyDBZRUfgGr6M0XI4uOTwNin0WMXeQ
	 CFHl/EwdWtlYhnVs+h8/UUKheYGRYmkcvnqO+vO2cVw7QogbV2sO5/w8de7vFw+Tyz
	 GjCBGu8qdypwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] perf hisi-ptt: Complete the field names for 4DW
 and 8DW packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260827140442.2031128-3-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-3-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:10:19 +0000
Message-Id: <20260827141019.6DC261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the missing HISI_PTT_4DW_HEAD0 entry to the 4DW field name table
> and add the HISI_PTT_8DW_CHK_AND_RSV0/HISI_PTT_8DW_RSV1 entries to
> the 8DW field name table so that all DW indices have corresponding
> names.
>=20
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140442.2031=
128-1-liusizhe5@huawei.com?part=3D2

