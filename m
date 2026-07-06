Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBB374E62
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333704; cv=none; b=WEyVlWZanp57akRPN5vq8wPxcOSuFcyiyYjldccSuBt9r/FcfESLZCXpVfVjPYnfK5jtpJgXJTR7vT7zTPFLgWcf3ogwlEs9ple2Xel4nW0IRCZazYbAxY7yZ7o3bK0pZhoC0ARXwnAkqfQC+gZIpQV25q90BtfCfyEO8Yb3xAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333704; c=relaxed/simple;
	bh=z1ELzB+sdvuje19ORyJflT7d4PyaYLAWHiX0xYmnGaY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cs4v1aey26Ud5nipVElyqcto5qG6JbIVYQk0qu2TzS0UROW/bhxQFAOnQiBN/7ncFwUwYlDh6urDUT0B31awefWycL6ia1mfhuIhk/pjdlH1/CRL+knaC+LFRYmLanZFDY4I3UlItLAR+e2wXT6N4virLUDVEUCeRyjG8Dz6Thc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnoI5Zfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnoI5Zfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B907E1F00A3A
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333703;
	bh=z1ELzB+sdvuje19ORyJflT7d4PyaYLAWHiX0xYmnGaY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NnoI5Zfi6E22zz7JpQh6vCypD+MwL5jU2JPXGzSOQ9FwYMgE3w6ounwPv8+Cjqj1f
	 si0EoITzSl8ySravdtsVpMUR3gTNB9ltkk8wwdux4KH7pPxc04Nm7fMOEZgK4Cr0Xn
	 biykq4qR7151D6gnfrvZ1BHcVn7VOXGAQ0EcNcKh1bkBYQN3dgeB4V8rl9ekuB0p+R
	 0j8e2VU5LMe4GSuyO4tq55Yi7IA0UE2+mLxjetb/LGT7exHCBLCttlShLGkro46Toi
	 /jreRs178AUnMd2VHZDrbi59ZJ43eOoVzeAqj5oCmW24ZFe7BxI1LLUUV64BESRJiP
	 DCW5JNjacNr5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Documentation: PCI: Update header defining struct
 pci_device_id
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
In-Reply-To: <a01d1cca33187c8b2715227d3db7146465513ced.1783332821.git.u.kleine-koenig@baylibre.com>
References: <a01d1cca33187c8b2715227d3db7146465513ced.1783332821.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:28:23 +0000
Message-Id: <20260706102823.B907E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The defintion of struct pci_device_id was moved from
> <linux/mod_devicetable.h> to a PCI specific header. Follow the movement
> to get the struct's documenation back.
>=20
> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers=
")
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a01d1cca33187c8b271=
5227d3db7146465513ced.1783332821.git.u.kleine-koenig@baylibre.com?part=3D1

