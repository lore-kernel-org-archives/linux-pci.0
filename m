Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5143E451B
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000734; cv=none; b=D6bBx0vzzagyob0HewGATyYwsptBctDF0LHEdDzUB9EJwBFGHuSkduJtGrbqPWaziTdzKepoMcdssimhpweXUlG7c2NMr7SRerTG3on8fGm0pjP1pBB5dyZa+kr0yRmOE0/sasM7phDH2ZIuMAAJlYZEhB+YXbZuE9fK3FyB/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000734; c=relaxed/simple;
	bh=JRnsuKOdCtwTAT88DianCwDfSVNZUOFcbuHy0cerBYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UkZVJNQcMxvGHVEspwwiOMfXakkY6jlt22zE0W0uViKhxLxvAd0c3SGQkQhMdD5dt1YPHGCtUBOaRtzqB86QNDPxQcxiemXNDJPvfw30ocJKSm73vhnirzZrO/KrsJ+xMGNi2t2a9VSPl1QPf7l4F2MMNiy6p3JRTuWY+lUoRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDJi5ke1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDJi5ke1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7AF1F0089A;
	Mon, 21 Sep 2026 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000732;
	bh=JRnsuKOdCtwTAT88DianCwDfSVNZUOFcbuHy0cerBYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDJi5ke1fRMDMDHULZMIR+IiMVQmDYPQbOIruLQutqLpdOZH/M4mQe8zMhfh/EBFW
	 UmBufQ1cIQN44uQ4JWcCuCflcnVoGKav6OkxoNroEXX9mF2g1Gh17Dg9i8b2YaShzx
	 2qSM0gAgyigqACBS2TeI7qViHwkfmviJnxZLDhii3UkgP5l+NbpycrBYYkuMCCLDrF
	 DrwvsS2ySS63acJ+EsXYMTclZ8X/UWYc/EJdiB639OfCSTfVja69zeVEDt2rdCg9eH
	 JEKJez7VMU4vxlEMpWyHuF5AnNuILwHwUzTN3RmDEJDTmCu5GaSBFRqkRVsDSBy/uP
	 CsDmuze3saxjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/8] PCI: vmd: Add vmd_configure_membar() and
 vmd_configure_membar1_membar2()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921164316.3860312-4-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
 <20260921164316.3860312-4-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:25:32 +0000
Message-Id: <20260921142532.8F7AF1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the MEMBAR1 and MEMBAR2 registry initialization code to new helpers
> vmd_configure_membar() and vmd_configure_membar1_membar2().
> The refactor preserves MEMBAR address/offset/flags programming, but
> resource name construction is now generated in the helper ("VMD MEMBAR%d")
> instead of using two separate string literals.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164316.3860=
312-1-szymon.durawa@linux.intel.com?part=3D3

