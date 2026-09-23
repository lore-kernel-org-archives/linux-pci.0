Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D347F3D8;
	Wed, 23 Sep 2026 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195294; cv=none; b=rsl/sNPG/F7Ls3PyzV5FySBTdJKZd44h0jl3Ge/K0REAEQdzW9NecE9SH0BzUN1t6GM0qgVHmfarBzZALQgZSPbVV/i3iBg58llF28/R8cwmMPPOYHl56x3w2+a8RkmxGcAvUWiBpILCCqTnn2CQbve9zYlQaiKBJBA1Uz9lC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195294; c=relaxed/simple;
	bh=WZUHcusRH18G704uN9SmmZDrseh2JrG+koTSGrPca3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=co8dOZdfecAC51PtzJCCj4B77yN98SwheLOmonXnf73XSOhvlqjQ3YGx86b3myLeIiU9BWQSJZ0sfwp+GFxmNItru5eVhze3AAoWp3M/kZbmCDT6pJkFThHMCBR1ZUb19wKN8I4SJrxI79abkZWoV+o2bPfS95J6cim/AqERTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYPhm5Zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYPhm5Zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5C21F000FF;
	Wed, 23 Sep 2026 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195288;
	bh=WZUHcusRH18G704uN9SmmZDrseh2JrG+koTSGrPca3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYPhm5ZrR9VNLoU9o6qqBPV4M60U28iTWtU3avFvJB+4yrxbyxeSHR5PeNs0iviwI
	 N074rtPMzP43uvSiiluPQKwj1svqR6ChjG51Qy2XmX957HFtpgsBaenQfSryB0sT/6
	 kKuCupHo3Nnwv56wdgwUDtfCzcE43pYg8sp+dPv22aiGI+h8nHb7TTGHto7tbpzlrK
	 C3G+9ZirHcY2TdclMi5+OD5QtXIP1b4Q8nN5d1AqsW/BEnq7opcj7zaP/4Mwg+wESS
	 4d+mdITocNJSipbAhQX2TdJW9Aw44Uc7fzyJkcw9BKzZ7QhJx4MyHD5jCxXid3s16S
	 0HzkP7RCHXgFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/17] iommu/arm-smmu-v3: Quarantine ATS after an ATC
 invalidation timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <94c7039fc6dcb15b86f79bb72d00e3c4eb11b4f8.1790188511.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <94c7039fc6dcb15b86f79bb72d00e3c4eb11b4f8.1790188511.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:28:07 +0000
Message-Id: <20260923202807.EC5C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An ATC invalidation timeout is reported on the trailing CMD_SYNC, thereby
> identifying the failed batch but not the CMD_ATC_INV or responsible maste=
r.
>=20
> cmds->cmds is sorted by SID, so when an ATS batch returns -EIO, retry one
> invalidation for each unique SID to find the unresponsive master. A batch
> with only one unique SID needs no retry. This is the common case, since it
> is uncommon for an ATS-capable PCI device to have multiple Stream IDs.
>=20
> For each identified master, clear STE.EATS on all of its SIDs and mark its
> ATS invalidation entries in every attached domain as INV_TYPE_ATS_BROKEN,
> thereby blocking further ATS requests and preventing repeated ATC timeout=
s.
>=20
> The marking must span every domain because a master may be attached at its
> RID and at multiple PASIDs. Marking only the timed-out invs would leave i=
ts
> other invs issuing CMD_ATC_INV commands that continue to time out.
> [ ... ]
> non-responding ATC_INV completes in error once the device's PCIe Completi=
on
> Timeout expires.
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D17

