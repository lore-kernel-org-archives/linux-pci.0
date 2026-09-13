Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B5346E5E
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334433; cv=none; b=Snp3gnwQ8xH6rcjZIH6sX3WJ7Fa2p/eFHqEuxW3r0FvqPz4sHu178gyEii0+Frl181wYyCmpPvTogr8mZMAi6iU+pvCdNWTjRqrt4BhE3I4VLipSTZ3LD4JvsOwCABAobD5OpTk+FRIcfwr/YpRoB4FFS5PJ2McMT+KPpabQ260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334433; c=relaxed/simple;
	bh=iBQzK20fmbIVdRX7rlr6+UcueR7pfGNkPckKPcSxc2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eMMyoJEVtD3Sc2Hw+7R7f7WbhPPEvwNARnICkUSId8Vc1Kq22zjvxZ4mdzunfwaWEc+4wsk2G/dH//WqRbLCbywnWD+CpWSbDQNHV+0+qYVC+jVT7NULSgzld4N5X6jwzfJWMD1fp2G7tps6LBkz8uunu8qWPG378Ei7cjv7vJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om/6wwUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om/6wwUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D81F000FF;
	Sun, 13 Sep 2026 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789334431;
	bh=iBQzK20fmbIVdRX7rlr6+UcueR7pfGNkPckKPcSxc2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=om/6wwUZtxxZq0RJDRLYxcZ5ahL0LTkQOUEHwKvWMhZyQeebhag0TkUtfTrA5vZ2Y
	 0EJuglrCR/Q+mqA73lj/6t/QkImGSG76bzjb0RzRBtBBzh0zNVFGCK0zdDKzM5jxG+
	 kB7MXratdDxO/+zlfuS5s/v7OeU7QtFtBQCmjbE5wXYiBZhXVuPtAHyCwH4y9hT0bn
	 H9g8bff5DBCuoiEm4wbxIXMsfpmPTwpgLW7k1CBgN2iOfrDuya0NvkuXpxQ5Z7cRp9
	 udaAsU86wbH1fOGrWx73eoAoOA7GQP3yrJ5jdzovMP9yW120sb1ie9Sm2rg3OB9TMG
	 DB5blMqT1rwaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless v3 1/4] wifi: iwlwifi: pcie: cancel the ME
 recheck work on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <856bd0ddb7f3391aec28e6af710edb077204076c.1789333511.git.navonjohnlukose@gmail.com>
References: <cover.1789333511.git.navonjohnlukose@gmail.com>
 <856bd0ddb7f3391aec28e6af710edb077204076c.1789333511.git.navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:20:31 +0000
Message-Id: <20260913212031.764D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> iwl_pcie_check_me_status() schedules me_recheck_wk a second later. If
> iwl_drv_start() then fails, the probe error path frees the trans without
> cancelling it and the callback runs on freed memory.
> iwl_pcie_gen1_2_remove() already cancels it; do the same here.
>=20
> Sashiko's review of v2 1/3 pointed this out.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 41fff83fe6cd ("wifi: iwlwifi: pcie: check for WiAMT/CSME presence")
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789333511.gi=
t.navonjohnlukose@gmail.com?part=3D1

