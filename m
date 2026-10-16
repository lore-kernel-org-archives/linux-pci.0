Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461F175A6C
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136931; cv=none; b=B5zE5TwQQb5xCKVaUK2iT47C/HqhC7OJGGQ4XYpR0aKfSs1bQ4utuDaDg1RT0a8la4kP/UBge88Kg1436JYbtQ0JustNZ5zULwSlVboWzpnNRTyw6PhzRE3xkG3ezlPAKnxdKQTzo9HpMeF1ckKeEdcHkhhIlw+Qqhyvawnz5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136931; c=relaxed/simple;
	bh=N/poZujBhIQR85WRP7rlsBdiLB8vIEUefDjTwAaG+jw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=G1YQpqJVbMRvq16pzE+RydnhPjjSVFEVbJQzFOgih4fIAMSUsyeb90LMnZCTI/ICKUrZG9Y+je6DePaDa3Ut2WumJgJG5xW2zuCvyaHq4pA1nTcjK1tZsWM7OzUFEZGzN7Sm1MMg5YwfMx6pq76T8r3aG2GJWqkQNDTWMHSKZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVtdggOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVtdggOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0322B1F000C4;
	Fri, 16 Oct 2026 07:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792136930;
	bh=N/poZujBhIQR85WRP7rlsBdiLB8vIEUefDjTwAaG+jw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DVtdggOSDcWeeA4gVQWdGPteJjFBGxxb8VCD9R0lUCOZbDjuG6Pzl3dNgJQast6Vj
	 jIjAgAoqVR6LsPsCicL0/FKO+y9WmmBgFe91/M3vdlLEuOM9qDARAzdkPBOwwrRuRq
	 kmzxvIrVqbY4DcY8W8uEt1SdymyKqbDoBUfJUw2Jmlq983q5866dcB6ti0lbwVuyY7
	 yLp11bCUt2hSTJB2Fnf/O7z3M5i0SnILcA4jWqGqp/jLd+tA9IAQhsBDeIOGDjBmi4
	 elawjlPV+ac9da3j1FmeM2d6aA7TO0+wwu6u5ee1h1Rpf1hrbQWYIrqoYBusS3L93g
	 ItUPUdpTt/L/A==
Message-ID: <sashiko-outbox-173966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] PCI: dwc: Consolidate RAS-DES event counter
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261016074026.564302-6-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
 <20261016074026.564302-6-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:48:49 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Use the shared DesignWare RAS-DES event counter register offsets and
> field masks in the common debugfs code instead of carrying duplicate
> private definitions.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016074026.5643=
02-1-mmaddireddy@nvidia.com?part=3D5

