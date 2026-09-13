Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B63F9F56
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334516; cv=none; b=uqh5+tDZ+SNKdMjfsIsj5Y6evd29MuvS6D8V35xIaOAEzXYKZhb72rdxSUQJaLucvwLY1i4a1zFNeXFHxB9o1hufW49E+k9cr7DO/8y3OdrJrredZKQLg/w8klQFvTYHs84lQcz4D2R9Svj2JFg6i/vuShIT5RjDQuj/2KFJD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334516; c=relaxed/simple;
	bh=zpIjVglcXIM6Q9MDGhZHzLc+yNKhDdrC2hkvWWew/Jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C3+ioxPN+9g/EcWmJq4if6kYmJmqRSocLdvSJmWNZ52SExpumpqGTgLwySEmvUpp1h4oIFZOHNK5mG6NAYgQ6r3eYxDBSR/UzxcLYtPePQ20fhzZK4Nqki8+gmWik+3y87RfnJP0z4tKbXauY42v53fsMEUQYzc/1Ots0GrO75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+g/ohyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+g/ohyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EA41F000FF;
	Sun, 13 Sep 2026 21:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789334512;
	bh=zpIjVglcXIM6Q9MDGhZHzLc+yNKhDdrC2hkvWWew/Jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+g/ohyI4/qe2sJqK+qdcaRRqtx8vzOodZ23nYwcHpI25O9zv00Qrw2lF+SMmkLuQ
	 /R8w0SjPUDz19cMP4j8pMwgi4JoOa1q4cVw3HjIG02E9jC8m7JvzO8IZLCbydjU2uM
	 1KqR10BVK3WAic6cFzejUtVLekhWf8KLysONnf/+SbJcwf2GIWvBZxlN7oy2Qt6WAg
	 gfEyFszNN+stGtmvEVirXxKtJAgmoAs/mfGf9cUlKZrklumx+NnYB5vtAmi8Oa+nS1
	 wlgPSfZBdVcxAu5OuilV+hW4k4NApDScDa20FrLaqC+WEjWd/VFX3w1l2SiPX7/zRa
	 Vq03mjZ6MJPsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH wireless v3 4/4] wifi: iwlwifi: pcie: recover a device
 that lost power in D3cold
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navon John Lukose" <navonjohnlukose@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <87d0a74f482d9dbd6fc529eee86ebfa2c3025cf5.1789333511.git.navonjohnlukose@gmail.com>
References: <cover.1789333511.git.navonjohnlukose@gmail.com>
 <87d0a74f482d9dbd6fc529eee86ebfa2c3025cf5.1789333511.git.navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:21:51 +0000
Message-Id: <20260913212152.44EA41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On some boards D3cold cuts a discrete module's power rail and the device
> never comes back. The link does not train and config space reads all ones
> until reboot.
>=20
> The product reset the driver already implements recovers it, but the vend=
or
> DSM that selects the product reset mode reads the device's PCI ID out of
> config space first, so it can only be armed while the device still answer=
s.
> iwl_trans_pcie_removal_wk(), the only place that arms it, is too late.
>=20
> Arm it in .suspend and disarm in .resume. If the disarm fails and
> CSR_HW_REV reads all ones, run the product reset. Skip integrated CNVi,
> whose DSM takes an AML path I cannot test. The DSM failure log drops to
> debug, since .suspend would otherwise hit it on every suspend on boards
> without the DSM.
>=20
> Cc: stable+noautosel@kernel.org # new suspend/resume behaviour, one machi=
ne
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221695
> Link: https://lore.kernel.org/all/20260722021321.68902-1-nika@nikableh.mo=
e/
> Link: https://lore.kernel.org/all/20260829093922.37103-1-navonjohnlukose@=
gmail.com/
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789333511.gi=
t.navonjohnlukose@gmail.com?part=3D4

