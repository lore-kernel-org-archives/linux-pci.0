Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA44A4412;
	Fri, 11 Sep 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145840; cv=none; b=bgnE8N7+Ua+G7r+y9jtxAFeeqISod9rR54IXwuX9VQL3YhaVTQHn6QRmSW4kdDtOfzqk0DIsnckirWENMlb4+038YM01PMCflBQDppyGU+VugJKwe0BQ9TUKjhHqqcKzPSRPH8A33HzYGpjlsaSZ88ybKaA7SsahJC4BsXdb/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145840; c=relaxed/simple;
	bh=EWDyuXxQbLnhXQWOiYco/63wvJPfWEY+l0OrqiWhHYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5GLrq+LK6gvUUV09vsZqlDGsI+843zFWbc8KIobOPqPm7QB/8TjVM/U94KW0tMdav4LO02uZWIT413CrEy5Xa6fzGUr6EUSLtvnWZfdR8cezdO+2gjPj4K0SBfCa1T/8NoIIoW3KQrU9SENWVHkeG8G6o65Dg4IGOtZGQFGuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOU/o5Vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOU/o5Vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2775E1F00898;
	Fri, 11 Sep 2026 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145828;
	bh=EWDyuXxQbLnhXQWOiYco/63wvJPfWEY+l0OrqiWhHYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOU/o5VmXpYgvJPPw2Ll6a1ityv3bAqgTdwncyRtToltcoIDfomAIcx17QqoEcosu
	 aObS14gc5xx9hePOwxlzeOFeOtfsOqqcH83k27MzIRSI3dkNT+zyFY5r2316wQvNzX
	 EAkEd0leKD7Hycfv3+rnCd6OMLVvClWODx7J9a/FBugwk2juigBkY81BZ9LotZ8L0O
	 TOt/5m0/3m8wos8yGfGqhLCS9yBBapeLcIIyHw6OzjIQY6gn8frrQWPDQIMYfkfwwQ
	 UF+bAz+JHxKzWo4GUVTXMMUwX5Xft8dj9qIKColdDJXj9h1U3qmsrs4wR2xk+s3k6/
	 AOKvuxvA8OJrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/AER: Map a raw AER Capability image field by
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260911164705.841407-1-dave.jiang@intel.com>
References: <20260911164705.841407-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:57:07 +0000
Message-Id: <20260911165708.2775E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> struct aer_capability_regs is not the hardware layout: the embedded
> struct pcie_tlp_log spans 60 bytes where the Header Log it stands in for
> is 16, so a flat copy misplaces everything behind it.
>=20
> extlog_print_pcie(), ghes_handle_aer() and cxl_rch_get_aer_info() work
> around that by stopping at the Header Log, dropping everything past
> offset 44. Flit mode is never decoded either: the Flit bit and Logged
> TLP Size sit at offset 0x18, unread, so the Flit DWORDs at 0x38 are lost
> and the log prints as non-Flit.
>=20
> Add aer_cap_regs_unpack() to map the registers individually, taking the
> TLP Log layout from the Flit bit as pcie_read_tlp_log() does. Clamp the
> logged length: Logged TLP Size is 5 bits wide, so an untrusted value
> reaches 31 where dw[] holds 14 and pcie_print_tlp_log() walks
> header_len unbounded.
> [ ... ]
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260904172337.1409775-1-dave.jian=
g@intel.com?part=3D5
> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hDv11cPuztPZsaDd7uwD_49Kzn=
Jy=3DtzuRO+dZc=3DCnAEQ@mail.gmail.com/
> Assisted-by: LLM
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911164705.8414=
07-1-dave.jiang@intel.com?part=3D1

