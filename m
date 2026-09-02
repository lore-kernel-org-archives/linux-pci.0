Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858737A85A;
	Wed,  2 Sep 2026 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334815; cv=none; b=kXEtihF05tpEjfp9dqDdcmDvkIO6DeE1j018M6sbkdIts86+7ag6YJcQVmfGq8avzab6SBuGx24jDu4Ix/QJ7MdbF77N7BGQhe5KlreZUQvORjFQBNmEWvSmjN70Bhr79yakWSFOp42gd+DK5DjjMfR574oBLgbihYENWv+WOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334815; c=relaxed/simple;
	bh=Us6ifbP+3wiEsiTdzDlmDnaRMzTN7KMAc0lwlsmlBBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BlB/pHG5IcwJskDPlyx6/tZ0AwnJVjyeB8FK/jaei/28sjR6l5UTPfX2aSSsw34oJHauK1YVR1gjgZFwE8qhD17gzsG7Ycp+cD4pMpjC1rOgoBhyEQZNNfjw6mFUNgLXIi/jYnRIi+tDb964eHqzzpJ/Hjw5aNjzyGTvaz9g/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfIUQml3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfIUQml3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B957A1F000E9;
	Wed,  2 Sep 2026 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334813;
	bh=Us6ifbP+3wiEsiTdzDlmDnaRMzTN7KMAc0lwlsmlBBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YfIUQml3Y8U7HvzNb1KXk73vo/7EafdFTMC3ZjNIdOVlXvJ0y58o7dShf3EQsN7+L
	 REuCJwIrfiy1nc4H0eZ+am5sde4lRlDAWZyK0fWjZ09eS07JBTJfHoMfRYO00ZA62r
	 Yw8UhObIlcnUxOS19ihQVdua6rx3iOOX+9+jlnAOfLFMrFf16vmiEvP22GrFZBGCQE
	 nOZ4/qiKZlTkVZSTayqhH9oc6FkO3Hh5eA2BcBxIRX3JyeItnTOMcdsXFbkJfhob2a
	 zNyHy0KvDDyLpyYPIcT/T8DsZ8S7Px5cnimlHxvldFnTDfzenoYVNukfBCeH91Ycq9
	 9S8nvnlJz/DmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/12] Documentation/ABI: Document CXL Reset PCI
 reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902072804.665639-12-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:40:12 +0000
Message-Id: <20260902074012.B957A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
> CXL Reset is device scoped, requires affected memory to be idle,
> invalidates CPU caches, restores cached HDM decoder state, and does not
> request Memory Clear.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D11

