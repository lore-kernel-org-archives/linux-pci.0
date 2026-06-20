Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D8340A46
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945495; cv=none; b=A3O+M4HzpLncEO2TMp0hxwGc22n319zPaLx1dw+gfBGSwPIKJG37uIG6Y40CsxzDJyOrhIh6LPKbuCmZFwm0N4jh/KY9LGjG64aixgZ8cTI8CH6OYFFMNc8D2f8DUAHI2wVO7EEmdVglD/tXLZpAP8ctLlR9Gz0P6Kxd5RP7X1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945495; c=relaxed/simple;
	bh=ElI27C9tO0i8C5lQHDUG/4XqCGPwnd4oVxZ+N//rIUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kqzu397qURQsFIAv44gITUhC53lBxRVPrl/ufEQQiwZjwpmiwtz83jUj+jSGXmlf+BgPG9MKtFYt+cQ03y/lfdpijsxR+mxqDci1Pp5EdpVDZtKVOZ7aoUR9zcpIZRjU77RV86fVAM9DCNDbPqj9N0o7y0iQRodpfJZrRQw6ojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7GEq6j4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7GEq6j4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3590D1F000E9;
	Sat, 20 Jun 2026 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781945494;
	bh=ElI27C9tO0i8C5lQHDUG/4XqCGPwnd4oVxZ+N//rIUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7GEq6j4hsRF/k26Y+VzGL3JRkzi5adtTFvrBPr1TSvI7SpVjldYUCTD5jBgQOKlH
	 EsxbEQXFjeO9Xiokaqz39P5t7DT2S8YF3uIVJy5yw4Cp/hPPM9qBRc7bnOp4BZuxGl
	 bGtuHLAwF7r1jRqvNU4YqaoOed7tGSC4lNYdLUObsdO57xs0R2nKGoNgxOib55bNQ4
	 OWYWN4urTdA3D+OSYN05BjGcem5NDdjdZZcOonykZ+VTjd1BU4eC8wXGqv8egcp9h2
	 3/04mszd/1nowtsW0yUHHBczCL/9PCtrEYCyFJ4aptTpO/xomoLzrbgA8ZfhuYznKK
	 ij8WZlBs1g3Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] rust: completion: add complete()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-3-6fd6684f2c14@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 08:51:33 +0000
Message-Id: <20260620085134.3590D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The initial completion abstraction only added complete_all() and
> wait_for_completion(). complete_all() marks the completion permanently
> done, which makes a single Completion unsuitable for signalling the same
> event repeatedly: once complete_all() has run, every subsequent
> wait_for_completion() returns immediately without waiting.
>=20
> Add complete(), which wakes a single waiter and increments the internal
> counter by one. Paired one-to-one with wait_for_completion(), it allows
> the same completion to be reused across multiple cycles, e.g. to wait for
> consecutive DMA transfers to finish.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-b4-rust-pc=
i-edu-driver-v2-0-6fd6684f2c14@mailbox.org?part=3D3

