Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03F4A340E
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000749; cv=none; b=FCru6TqH49lVdzt59ZeK5FSJm7sw2qqJ0qPVOYUojKEFd42MX/Ou9vCp2vjIXEMx//v9rrbRXGNoRUVIUlKIes8/r/ipUaMroWYsb6MZnMz8Uk5zlE/A3HPR+ixwbJ3bg1BCPb160qhTkpx9AbFWXhCl/2TR1s9FBf6sEHLxa/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000749; c=relaxed/simple;
	bh=NdvEQrJGm0g4LCvRHXdJ2+TB5dPFRt8IWJGF5FeKVpI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=frTEM3WIU2COYz0lzGVLmHZoqtJr7xkZrfAVqgVELKcsdZ3LP60DwXeUOogUUd1qve1irFlAR993GK3ehTLL/qG23eR9R8BgE+NdLmrEO2rllZNB3+fHEBhck++kLdvMoD48k0Q1RUfQxpX9xCrLi1q1CFWBeskrJenE1ugu6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAmOcvCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAmOcvCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D1C1F000FF;
	Mon, 21 Sep 2026 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000748;
	bh=NdvEQrJGm0g4LCvRHXdJ2+TB5dPFRt8IWJGF5FeKVpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FAmOcvCDMZRTIOgCxRh7eRblpJr3p82oyvh5WLtK7GFGE5bhdJBflokkrLplwvROs
	 04C+CPCaETbLyF0Q2SngNt2N1cbTy0eTAhVO6A8KiT0Q1rfAOYGGZkNW9L2fj2RQlV
	 qC/5ODvpQHlW12JQeXElW8AkCQBdvchScYUSZqudn31gfj7vx9gp08aUpmKiYq5+Hp
	 GCvd5K34CEyGdZYRh/dxuQBTeZxu0osfTxNcV/JS/MJZECyOdGlRfHIqcejDfG51QG
	 HFbSPCORH3ggIBfzPYFmdx46P7z+inldeG1i40cwrdIjHARyj9b7wFimqoousXnxhC
	 uNqgL7z34+GAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/8] PCI: vmd: Add vmd_bus_enumeration() helper
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921164316.3860312-2-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
 <20260921164316.3860312-2-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:25:47 +0000
Message-Id: <20260921142548.30D1C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the vmd bus enumeration code to a new helper vmd_bus_enumeration().
> No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164316.3860=
312-1-szymon.durawa@linux.intel.com?part=3D1

