Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334E538D7A;
	Tue, 29 Sep 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704196; cv=none; b=eLMqjYd3okln/bt4mJleaduLdO8D6ETvEbMslmXGDpFEQmyiz7VnNBU2le9BG1MTs+aL4EYWU9OYtchy06fRBI4YzJRVn+PLSGbFsX/Fcb8V9HoAPan9OmJoDGGx7Vj/oknekiKgRSDjWtrx6VfZTzA4V0nbZGlIjd56riK+2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704196; c=relaxed/simple;
	bh=XjLQsSYWlTGUl63+dvVEjuRbt0lKeRobGHijGhEskyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ugZF7f5wvs0AsluSAGBP6zaChj0Fo/1JlK2XMJDO3bKO8aaJRDoN2VbmsL9otQhfNVNpsaPtOW/MrpDD8TEJVBKM8Yl+wEkiDhEQsPf7CuOFtQ41nUMjPB//1UdXhvDiwqfgq/RqEapCMAT1pcLpVPX8+M/5+x/CfCXNP9BqSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsY9MA32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsY9MA32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E751F000FF;
	Tue, 29 Sep 2026 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704195;
	bh=XjLQsSYWlTGUl63+dvVEjuRbt0lKeRobGHijGhEskyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsY9MA32RxOiWgfU2iRkIa2JEYVb6hhgb8vlZewp/AgdgdAF134bU9eXP5CG5uB5o
	 DqjteSVoqunGjn2zZswN5eeTNTRlWRrb2ny2GUm0MwtDQSMODDP7yH7k0lrVnbQqKx
	 QazBMRZgTBNJAfJyKSTAjJNQ8bo/oUpMq2c+evn6WBB+NFmQhwbdqeEdgUeQq3xEk1
	 GKu7201wi7Brfy7HQMu1YvTxwh5g9tmHRYBUWFylw5hH8imXOHkJjSfCHtFNpTC9M2
	 N8f2pE0JinW4c32exldGL9/QKgW1QDssZ72vnz2+ocI3cYXj54qqrYCxfLq1es0a8o
	 FTFjo91xQC0rQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 16/16] vfio/pci: Enable host PCI error recovery
 for vfio-pci
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-17-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-17-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:49:54 +0000
Message-Id: <20260929174955.33E751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Enable recovery support for generic vfio-pci. Userspace opts in through
> VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. Open rejects an active host
> recovery even without opt-in. Leave variant drivers disabled until their
> access paths are covered.
>=20
> Exclude CXL memory devices and s390: Restricted CXL Host (RCH) and s390
> mediated recovery can omit completion callbacks. On s390, permanent-failu=
re
> notification also blocks config access, so draining SRCU can deadlock
> with config readers.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D16

