Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0B2D97BA
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256409; cv=none; b=YLKuI4WOD8B8wqKwwk89+YUcIuAg1fESzZpYeaWAtpnKdlKjG9dlqBEfUVqvW7EKBrgH1N9WOOcwwxYrhUUpN7xyFcexZ72MVZTVcEepp9Nsb/InK3jieJ2ECu18UkUEh6XwGQggnf1RuoCQtPuFADkyAP6X/ReCOInjYmEMKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256409; c=relaxed/simple;
	bh=YCSK7nulFNTRGounBVcKOHtr2x1AlTlaFwEs4XpaCDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dgEG7gn5SwkD+uPZwC0wk92dIWHJl0p46OR9l8b882uwfyBc9Gj/ZVKZY7amWnrXHBHiz+oVh4yat94/eoYiEDCSLhGXSFyVjPg2rxm0nxIVmzWRdiVoBWOgsHf8o29Xs5ZDXM8zQy1Op9XN3t3fVjb0ygjxslYQd+i64MPSilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnUVtc1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnUVtc1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200BB1F000E9;
	Thu, 20 Aug 2026 20:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787256408;
	bh=YCSK7nulFNTRGounBVcKOHtr2x1AlTlaFwEs4XpaCDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XnUVtc1QdVQRuLXJnKFXCvvZyAm6xX+10Wf6Kui0jbJZ8VUsg+tyE1fA8GHMS66tD
	 dMG3+xXqWBsz0ReDeIJOKeJhJ2a9A8CoJEQlFOnPO3DEnY60Qb+uDhjYfQAPru/1oW
	 xrCNMST8UmxvHYoH9wzNd4IBaRrRcDPLMWvZ90qdiP2UUw8pKWjtMm9/QqM4IoysOL
	 gDdKyzNdft+Rpj/uTrcPZvkaG5sXpz7Xi3d9N9DfnDVRPfiOKre/jxD3u5tTmOK5c6
	 thoTbx1Ap0vFuCWtg2qLIZcTNjMPBCF1ZM+We7+N1E0xpN2o20FQm865BHzG5Fyhsy
	 CbVzU9ShCRZ7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/sysfs: document the link speed and width
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ferran Duarri" <ferran.duarri@me.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260820200359.283335-1-ferran.duarri@me.com>
References: <20260820184228.166566-1-ferran.duarri@me.com>
 <20260820200359.283335-1-ferran.duarri@me.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 20:06:47 +0000
Message-Id: <20260820200648.200BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> max_link_speed, max_link_width, current_link_speed and current_link_width
> have been exported under /sys/bus/pci/devices/.../ since 2018, by
> commit 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_s=
peed/width, etc"),
> and none of the four appear anywhere in Documentation/ABI.
>=20
> The gap matters most for current_link_speed. current_link_speed_show()
> performs a fresh PCI_EXP_LNKSTA read on every open, so the value reflects
> the link state at that instant. Modern GPUs retrain their link continuous=
ly
> as part of idle power management, which means a single read can legitimat=
ely
> return any speed the link supports, not the speed the link will use under
> load.
>=20
> Observed on an RTX 5070 in a PCIe 4.0 x16 slot, same boot, no configurati=
on
> change between the two reads: 5.0 GT/s while idle, 16.0 GT/s under load.
> Comparing current_link_speed against max_link_speed at idle is therefore =
not
> [ ... ]
> end's capability rather than the link's.
>=20
> No functional change.
>=20
> Signed-off-by: Ferran Duarri <ferran.duarri@me.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820200359.2833=
35-1-ferran.duarri@me.com?part=3D1

