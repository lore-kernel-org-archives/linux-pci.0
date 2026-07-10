Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6603BFE47
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719251; cv=none; b=I3cNFjzT1sldTwFw1HhNScgVc4NqD+j0l8aB/j2iOdq/ULpH7Uz3aUQHxl0WfYIdwlIrMH9B+ORJY7blI16JIFiZ3NzkFUT398fFjEn6LaWuovjw08kfD96/2VjATDf2DnK+5bL2XFFlPUDVwTvXsNgoEjUiFm5kYRf3axCwsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719251; c=relaxed/simple;
	bh=Stjshtz/HKXf3rxvi3aQNlDcC6dJwvrPUfzaxzE6VXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XFhu+wqrfk/30Qn656BxOIqKltNLtllXrXvUXh1CqV7dxwYXLsLQkyjoj1HdG+ckATWkUjQCP1k6Cy1hYoICEqhnKH7UuuwS2DNg8RlNJi0Pl3uZANGJFvVugxYDV3ZN9pRYTFrF8flwm8b3CH5wslVGBJ3CMJd6K7w93MOgMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0pkXIAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0pkXIAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082F91F000E9;
	Fri, 10 Jul 2026 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719250;
	bh=Stjshtz/HKXf3rxvi3aQNlDcC6dJwvrPUfzaxzE6VXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0pkXIAtiv0/2FZvO/vrOvRCTIpcyuwiDUImVcEJxWg8Qs1/v2IZWxMOSxms+Axv6
	 EiZmw24CP7EksCpwlpo6Hn4yHjtwz0G9YF2V43SJQgWw0hrGgrwGZhPqnX0R+lq31v
	 MbX2ciRU9vIY66xX1LgReRdxtIxII+Gjlsj8/q6mNOjGVBFBkwEsZzvgPcVtOdqOTB
	 B9jwPNYcTqrY+avmJIdsbW5yU56EHSXNr8J/BLjkB3uve5glETLespdTbOEYq6azLv
	 r4W6oTqeHbQtKCfZZXQXd7nNDu65V0GX5G21aDtNPT5B4rqMNd0FBXCp4Ljggkz7i7
	 hSkSClnz4Lj5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/12] PCI: Refactor matching logic for
 pci_dev_acs_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-8-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:34:09 +0000
Message-Id: <20260710213410.082F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the loop and device matching into its own routine. This eliminates some
> duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
>=20
> No functional change intended.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D7

