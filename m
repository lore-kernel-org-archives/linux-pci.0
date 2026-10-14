Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D824825BF
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963194; cv=none; b=mDYiYYwdyQ8GD2I8Xshys0uQCwEOrfSF4VVFiNxwkiMoPHY5JaaOqdIsG4YdcFarNj8S8mDOucZm2wGoCj/oUnHGEashsNbSRKWqFk/3yX/Vj9XlEAr+VC7zeZVOzeAr6ey65S+PFScX29cM1e7W77xGnd1bwfrYUMOLpyXcd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963194; c=relaxed/simple;
	bh=040BANy4rogNdwqDhGaS1g1B0L8v3O7CHa/QDB/51FQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Kg1jqAvxhyBEZjhEyYvIUbKCohYKM1qZIS5NbaiFL2/+ISJMplfAL9i0Ljac/9Oq/W/RJORfIP06AwUa64rGnIvt6Ee8X6Pr9fNv29mDZD/GcNHfWl6LnGklUMS4qEaubbQmsDuxnDzbCOfSKnCpDENNleK1kdAYUunfeVltgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3ocbTpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3ocbTpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C9A1F000FF;
	Wed, 14 Oct 2026 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791963190;
	bh=040BANy4rogNdwqDhGaS1g1B0L8v3O7CHa/QDB/51FQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j3ocbTppqLpth/AeLK0cuSchl9hmjqFwuzwfCibGqnl+CVNvB0Tmsgxk4YOXke434
	 jlfROzqwInKI17iiQtc1gqCRnNwWkw0AH6z1Px+PRP24XNzwQH0we5pJDkYyIxCwHp
	 tQxxmA8jRT+0cK8Q1i1hhJmDiqjNHef+vi5Q3fAKnTOAwKAXPa3IZ7PCrpExid9S8+
	 NaGynVRk2LGoVE1LuPz3C/w2UEZYEUK9w188UkkmddP3TmdiGUewhZIM9tBjyq6A8U
	 9rPJbcvPhLjdOJmaia1TzGW6w98uQ5Fv5w8LAT818f5iUje3+LljvHF69ZqLB1q4Lk
	 01VSGqiI6n4xg==
Message-ID: <sashiko-outbox-170947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Sort Register Field Macros
 by Bit Position
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261014072907.581539-2-devverma@amd.com>
References: <20261014072907.581539-1-devverma@amd.com>
 <20261014072907.581539-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 07:33:09 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Sort register field macros by bit position to improve readability.
> No functional change.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014072907.5815=
39-1-devverma@amd.com?part=3D1

