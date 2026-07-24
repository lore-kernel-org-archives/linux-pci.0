Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768943242AB
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910082; cv=none; b=ANL+BgPAWh2Miet20JqTVfNfveIvnHc5U4hvxI1dr98BTWYEIHpltI/TgHuDkJLBeGQNILoG3NHrRwHnVCtUeZvMe22/n8KP1LloBexo43s9SGis5ksNe3r8UuDfh8enBfrfdJDz+DxMQJ55fkM06l3cJWZbm+ZAnWsDnSvhBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910082; c=relaxed/simple;
	bh=Wg+VgjNVkjRuTqwYQcBM871teKvXuEsDBZIpY8zdkmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j5HWBLyN/ZDsAjfhtWIu+Jfw0Oj/rDz5frNCJXCrLNbp5O3i1Jeey9f0mKpCTaTDzkkD8daVVBphGTulprkR2/Sx2HsiWAwcUG12dYJr8B0SfdEEDC94BmbYqgitv9bzxq5NNSnVMokzn/r6fjsgAb75PhBbtB188Hi5AVd8VAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlxI+/Li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlxI+/Li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5B21F000E9;
	Fri, 24 Jul 2026 16:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784910079;
	bh=dkJeUrBxsyYDndtIaPnz3ci3rg8LET9UYhw49Qi1xHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FlxI+/LijbdB6/JLCeLRP2HJqZYGaO/TqI5zAOQvb3kpOhgIkrb9q1NRONoVY2SBX
	 JQMZs9wB1WW91lR4RCb/iAlxNhSpWkgs9p5z9q9cn2veCzw6Y0/ZYXSAmKSWCaJT6p
	 D1rhJXtESgVsWT32X9SE7059CBABw5DpqajEc7azDpmKC2OiM1RV3qqzZXB9Xlv70E
	 rCzQVhFhVXOf4hHm5xItQWBENSGkSD7qJb9F9T2lz25s869H3zCOba8TC4tqVMohf7
	 lUq47q9sQDoF68URehVTvUPMLw7BUeZiziUBUae65IIl1Xbub1On65tgHSRIvZyoBG
	 6KEoTvcKhfZpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] PCI/AER: Emit TLP Log only for unmasked errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2e712b96ba5bfc729d78bfc23f7fb7d285aa3d6d.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <2e712b96ba5bfc729d78bfc23f7fb7d285aa3d6d.1784905909.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:21:18 +0000
Message-Id: <20260724162118.DE5B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Per PCIe r7.0 sec 6.2.5, the prefix and header of an offending TLP is only
> recorded for unmasked Uncorrectable Errors.  Yet when the AER driver
> determines whether a prefix and header has been logged, it does not take
> the Uncorrectable Error Mask Register into account.  Fix it.
>=20
> Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriv=
er")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784905909.gi=
t.lukas@wunner.de?part=3D4

