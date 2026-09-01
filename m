Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A23488748
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281943; cv=none; b=YnV4RmnpSvcdpYUD1qMt5Op6ro/fJEqcdVck0yenXIZEDxx+IWcYxMme6gpHKEn7AtBXdfkvRToAdUqiOI/pyLzSGdNh+zVTdSggwu9Qe3TpxlaS9p/sDjsRCdL/dhms47E1NqqMmCXy2QIDRvEVeQ4Xb3ZgErvI3v7Bq63pJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281943; c=relaxed/simple;
	bh=ELvpO9TGO0jav2xemTL9Ytysgav0jAindTAbKa6pSDU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b+4adDLQBYXFgOmkiFXyKhlnBGLx82EMOvpdhTnLwdMu5nD251Pw8Jnpk8o8z1kkaRYYADZVwiX2O1zhQn+6ZGH8K/HsYsY/WxrsEvfnU5rNbE9C8ETpX978Gj40WNmT4yN4l24yabpjlXrKwb0f7vP/4GCQ/YWIimVolKoyoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkS6KzAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkS6KzAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49291F00A3A;
	Tue,  1 Sep 2026 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281941;
	bh=ELvpO9TGO0jav2xemTL9Ytysgav0jAindTAbKa6pSDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkS6KzAYhoSZWCyzJpS53NwM9kmU5k8YRkK/GoFuILGT6npcU989gUJimBDtNCHQh
	 +S0kkmuGZtqBhN6wiWoNHl2fLHs5L5mB8uJd4udIRL1S4yjULHh+qL0rFU3Pxk6dzC
	 cE2g+zjG40+JeRVrV32snEk5dOqLBBxIHitFgWSx1yDVLcz4absHbioRCbFZfoa2pZ
	 3eCNnCYLEYlWu5Lfm7Ev1q5/iE1U2sGIK5aRfY6PfY06aT0Tvbu31H59W6ayQNQi0E
	 FU2yRzGq7p7yCSe8JRP2A/zF6aDuPiFqn25zUhG8VSoHzK0ySlfG/YEur/CXEJYNSF
	 KJ/qTNWCkjfWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-12-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-12-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:59:00 +0000
Message-Id: <20260901165900.C49291F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` and
> update PFALCON and PFALCON2 registers to be fixed register on them and not
> relative registers on `NovaRegisters`.
>=20
> Update `Falcon` struct to store projected views when constructing and
> access with `self.pfalcon` and `self.pfalcon2`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D12

