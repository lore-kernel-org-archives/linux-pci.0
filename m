Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556710;
	b=NYL2EZYBGhPO0B3SGtyRSvzerJpXnAh5dSyHF7YY1UOzLdXeySEyF1F5j+Cb4vaTmyU4
	 pF715uquAytGteV1ekaaVv3oKM6OjWKrnYeoQtZfqIXO39ASEVoPP8Dw/Grb1j4u0JsBH
	 NElXUOHhFbF0198LaDeLavnFhhkt9loJyvvbtgX1/5KWD5rcbsTEnCj8/IWioxblCMH4X
	 W+wrWW1nz7gn602pe/gzT72h7iltsNaYVGyPUrez+BE/LlLzHaetQfSgwQW3xJ1xYJYQq
	 3PORf+qgoscm+mQqWokUSJnxhYJxhWXdrfUMBfO8fpAz0T/ZkAJrjMPJm4CXMGS8tVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AOVbjgH7nB9BN0G9Nq8g6UjrZLxRzxBbJER7oJOs1Wk=;
	b=vejsK4J5ylRoIIGdEtVrH3OQrFOI5mV1BzPbjOp38VMWLc9RP7cOBcEaw8jSRzwrIPMo
	 t2FJ4HEYotOK7vlbc6VJrD8BOvA8WTF2w/PI5ShuKV64wGC/VQUapdUW3faKjSpsyZD25
	 zWgTqCgCoM7yWDDeSyA46Tupp8eLaqsRAY49tSkb0aTf1VcVhIUoFNdJhy5ArrsamVs1f
	 onZT2xU62hzmZv16XkAPtECJGdeg74nyiPCyr1PcvBfAtJCq4ztUhbW1zxwmavtNbF1Qe
	 trVYJvwItkuYQ3IQBYFSRqb7zXYBJxBGJBVB412jk1s8VPwnI3cUVTBjlSJt+jqlMcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egfd+05x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E8606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egfd+05x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BB41F000C9;
	Wed, 21 Oct 2026 04:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792556709;
	bh=AOVbjgH7nB9BN0G9Nq8g6UjrZLxRzxBbJER7oJOs1Wk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egfd+05xDX3E5aoQmIxYZQO0Yp/S8ha4CZf4KbFALnlmvK9aQe29HzUiL23/a6SL6
	 n9GAmCrxbIhjfzKMviREqahcUTdGrQ6Sw6c4QDMyp5vFCFXcpAFSAmNiUe23J065ua
	 mw/SeGuPCcZl4RsMifgbQQyZKjH6kwuSUMB8TdWN9WB1Yn50EJ0ZWt7uSSqFDfIxDW
	 ADN7aWNQC0IpNiZjtGrnnAeCyusZaRTpAuFWziiV/J7wnEWUZN1HkiDITupo2Kn5t1
	 VQD1rSZjMz47TmFtRQTwmMdptX3hEICUCXrJ3im/T1Zgikj2m4qyduFMdjKMNT0c6D
	 eYRVvDuOA25sg==
Message-ID: <sashiko-outbox-179777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] PCI: endpoint: pci-epf-vntb: Move
 epf_ntb_is_bar_used() up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021042229.2280937-4-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:25:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move epf_ntb_is_bar_used() up so later BAR selection code can call it
> without a forward declaration. No functional change.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D3

