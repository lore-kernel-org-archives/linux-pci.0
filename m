Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577036;
	b=ZZT2SzhbGy5d3OTFJHiDareNgNMgCkd52HhOYMfhF424ICqo6nKy2BTTPyIcfBAWyaT+
	 lXzECVQ69L5kxQtZ4aU0cyq3cTpgQ34aj66Va/Ob7DpBw1sEYSmKqeAMimopmYcGxGCMQ
	 0Xb+nqvugM9bWo4PrpOQTUHUclgtmQxxAQtvtBORV1GZGaZq4LePoyu59GkiIFXPyXT+M
	 arqNXP4DDAxpldmDyE63WuRhMJUdnsnVGaJ4m1XgK8wjORKdKSSYLSHyZiaCoJVULCSfX
	 bFDf42emMD5tjmvuIIvZ6+zKdWqBByYfki3AUCfAZ6p3O7X++I0MyHyTIWch3MyL6fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Q/LG8aQc6TKge/XGyDI21kxARirEeJK6QURYi7TY2I=;
	b=Bmvs7BHKxJ3L1VUCpR41riJkRThKxtSGwAGjuHhcd9QJxGLdIlIUdDuYXzjNf07Vg1fX
	 w1XNDbgaMH7TJtNk1nx5qW5sO2Ib/pQJnOeLIkku41gKr5JzxT/mT3tg/Uj9f1reDgHqx
	 dRY+b0kgk4CCrM7q3TXtgnkmrnxtg3UTppPIlCIQUu8Y4oJHwO8iH1bPF+pqAeOFW9JCd
	 9StakqULb2lXrWwQ8Ri6G6vxwMjiVaSHB0EeWD0NNyV0rhU08GF8cabYeqrYxvM25Axb4
	 L8mc3vLQWP4fBoSZW1C+nzVPo0qbWqEMeAceXOdjw6kmm5Y54eTUWjSevjINOIoaCIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP5NIZYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFB606A323
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oP5NIZYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720381F000C4;
	Fri, 13 Nov 2026 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577035;
	bh=+Q/LG8aQc6TKge/XGyDI21kxARirEeJK6QURYi7TY2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oP5NIZYdlDWBtscCCIHgAXupa2XUh+YP6kfGCFcatdKs7L4moMjkFwM6gdnUmZt9S
	 m8qo8DmIyF3rI0HAGNZDxzSYkOdHzWQyyNETf0tLCPJXWMPXI+XAn7AMwmR6WM2vCB
	 sza6paCaGNCG0Gzo2MCI4EU2peCbpWt7dCGRymb29xrnD0eSGJiNSiYlEISS2rVWHp
	 EQGjfHyU31j/qWxUUCUdUiORstjSk0LJiBI6OeJCgy3NtvgBu0Kxv91d2u/h5wIvAH
	 APENiw2BkzO0Vz689CzjEgPJaLKrxW5ekRarUqQG/CXs5OlkqrYJ3Q7BMhT8eDTuio
	 u9KQiFKzt0teg==
Message-ID: <sashiko-outbox-212902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/10] PCI: endpoint: Add pci-epf-ntb.h for the
 shared NTB control layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-5-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:37:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, pci-epf-ntb.c and pci-epf-vntb.c each define struct
> epf_ntb_ctrl, and ntb_hw_epf.c mirrors the same layout with hard-coded
> register offsets.
>=20
> Move the shared struct and macros to include/linux/pci-epf-ntb.h. The
> vNTB "reserved" field takes the pci-epf-ntb.c name mw1_offset, which is
> what ntb_hw_epf.c reads at that offset.
>=20
> No functional changes.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D4

