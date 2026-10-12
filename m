Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115033C07A;
	Mon, 12 Oct 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815547; cv=none; b=hhs16F/2Of1glwlAQ2u624IcE6F7IANsKoDRiId5alNjui643IpTwSB18VJtcb8szVVj7hZKckLDXmFw7rrxD4tpbfND397zJV34fC1/byZ0Fl6hb9abLoHhiFJZm3aRm6qR+P2GYqo0Kqr25EijNRj/2gyASwXu18RDgePE4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815547; c=relaxed/simple;
	bh=cGOF66SfhAj748TjikF6x0Q8wPXbwtW9KNFkhpIhZVw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lSbC7jGWFDrdZhDUSfgrYyxt8gPym7jk/jUFlSP67G3kzCPDJ0F0efkG4bVIJraZ9q0cZG/NBT+MJBbLHhKqC6X/AxuMwduzzCf40M/CMqogAjPdZ0wSTPzfJhi2KBL6V1e63nSLkgCHhaCkoXC0NJAx6z0MWtRKf1ECM0DB6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1oKdcbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1oKdcbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F98F1F0089B;
	Mon, 12 Oct 2026 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815546;
	bh=cGOF66SfhAj748TjikF6x0Q8wPXbwtW9KNFkhpIhZVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1oKdcbxfscLx89QCDjEv5YUDgGCgMr6j/BPlbVSSJCu/1+mcuFMTFBiDUa3NWiwo
	 GbhQsI0Q0/jFSqVPcYpH4ktdqDQzkSt/KETSKKcWWA+xhifD2sQgtLDh5KtWCXqmfT
	 aQCS9xgp8xORJVj4DklYi+ioXPU3Cdbuue0a0D427xPfPZFXYBcv4KDv9uCIf13io3
	 oFZ47MyPEoILy1cqxWcKWETyOgOgsJ8f/nk+Ls1ITK4scP2m5XRzQ/9ONnydmPkLcM
	 twptxvLSFgoliXXZvGlHZgxh1E+n5twRTdQzmAjlJOBonDJZLo7pnlTHhp3OYnDO3b
	 Txd+yb31/6OvA==
Message-ID: <sashiko-outbox-168266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/10] pinctrl: cs42l43: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261012142826.159178-4-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:32:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D3

