Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451C2D3ED1
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199473; cv=none; b=H7MtWxARFK/kYiuNLOKn36v6G5wYWhhl1t2W2AbXheLHdeJ7f/zC6KVTMcLiZmqKdHzw76fbdYZO+IGHikS4vxR6BwzoGOxUhPwZA0hnmGYqAeW+F8TcPpCJMU76j8V7HHp+ZRrPgyGLrw9dqo5+jczMNlDG76xIqniPjIrPIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199473; c=relaxed/simple;
	bh=2loNpQ+nvyQD04275Wmd+3D3pNZ42j5gmIGYocEWf4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/fFe5fLFoyJvXs7qJY63oR0/cD7fd+LampwijcjexZOq63gUYSkxE7PAF11X018Rkzw1JMRLyzW6Gi/+zfPlIn4WLz9tZmMlXEqcKoZ20Oy8y5DJOJ7X3uERO+/f+Yc9bZd4dvjRUHHQ/+1vbospuLjlhU6Ez93rIRi4RAv79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm0UEsAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm0UEsAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DD21F00893;
	Thu, 11 Jun 2026 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199471;
	bh=2loNpQ+nvyQD04275Wmd+3D3pNZ42j5gmIGYocEWf4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gm0UEsAKL80MOzG/VlQLwRjtK/3DyA51Z5vUkd6yZHT0aBF6PZT6Q1Q+FembV/NzN
	 po6E+kXQtje2NoMgewwIrTsapC6CYecw+bB6fpkT8kq552sSgCFIKBReFB7CgnLayU
	 4isucdfQYGkDT3S4mwv603Mo8TvSjgIgVp4YMXz9JpBdaid6zh+1MTF0Ghkp42OL5x
	 bUnFSsoSjWs+DPfbOXcjBKO8w8ecXJz13fvpOLheSL0zwV0b2Xe3Kqvb4Z7wutezs3
	 oH8N8c7hsWWbQljPiTeMuByepRbBJ5G6eWT2dQLCdiJG9zHZ60xCZ+hSuFs8tqx1IJ
	 yazm/lNhlJmLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/20] rust: pci: io: make `ConfigSpace` a view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260611-io_projection-v4-8-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-8-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:37:50 +0000
Message-Id: <20260611173751.62DD21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In order to support I/O projection, we are splitting I/O types into two
> categories: owned objects and views. Owned objects have a specific type
> that is related to setting up and tearing down, while views can have their
> type changed with I/O projection.
>=20
> Things like `IoMem` or `Bar` are owned objects, which requires setting up
> mapping and cleaning up on drop. On the other side, `ConfigSpace` is real=
ly
> just a view, as the resource is associated with the `pci::Device`.
>=20
> Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
> view. This means that `ConfigSpace` object now represents a subregion and
> therefore encodes offset (as address of pointers) and size (as metadata of
> pointers) itself. The full region case is still supported with offset 0 a=
nd
> size of `cfg_size`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D8

