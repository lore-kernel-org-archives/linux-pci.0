Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956035;
	b=B4QenMkIQ9C9pkGvWBrkU0RvQnC6YvuCi9kuqo+Hpd3w2nIjvGbHGuL7WjjfyKDsTxWU
	 Nc4dYvzJBn7z/9qcrTga3z6orma1X+Byr+MFfIah4VPUp9RH3e8PqRRqT5Yg2m3nnfvBK
	 ML9OSbQp6xEVSgJ4siy6EQD6DtRKrVLzYYZ+17JFtgEd0fIgvy/gyfNuWePEZlwa39w7O
	 CrFyOH/FF31DbNCjVrHmtHF6yH+4D+wIjxUa8v9joG4X0YxNRrMuU3r2uVh8h1PNQ/tYe
	 mi30jpSrL/67nYPmCkHjoFyKNw5Fx3qjj5gjrQRv3DhHJ9NKXLhrull2hdnMQ2vjZpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wbw5ghqXd7nKhOZhCvQCEnMbcWx45eQbr7GNAd4ylEE=;
	b=ncu7S8Aqoc8qhT9/A8ai7C4hCxGZO4Ap9rnh4kxcgpiLsnBzCW/PtuMoZBJR96jLVxbz
	 bnRlVZEMH5d7DYJz+V3n9M7Cxf2xaywsxw4umBC4GXRjFrksTAia1iejZXWjxgXWg7w+E
	 bKZjMBI2x+TeiX0wiA5LzBzrY8NGh215X3i1nEQ2TX7ockWvx3aDtWgTCrFnckoxx7VDZ
	 3geAS5raKgz7z48fpsA9ygAU27MaIzaKbQo2NojAb6fi7hf1hdhM/L6PRHBrDuuytguAQ
	 pC7pUQyrGmxxEj1q4R6OEMJIx9V4X1EhneHYvF2FWJaDGHUyTcQB+FTLEmT19Z1JGtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYTt9yOE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645A606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYTt9yOE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C817C1F0089F;
	Fri,  6 Nov 2026 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956035;
	bh=Wbw5ghqXd7nKhOZhCvQCEnMbcWx45eQbr7GNAd4ylEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYTt9yOE8sy1IjDbPYd5JPIhi7G6XWHEHnB+aCy76e3cx/l10Qk1UWQyVecxG/+EX
	 m12vY5mm0hgyG8PCWEV47NSvLK5p3Zh9be3wwg1aQQtENkaChKLWmPw9piX7B99igE
	 /dLSigUU1PftJCekEN62fXjVk15ImD0EXYyLIAAC3HKh9kgfKxlt2RvvmmAFMyExbO
	 xWePlIO5FUAdI6viBrGLnUvWCmJvI5FlnpwEPLKg4P6hSO1HU0sBR6ySBj4vGI8TtZ
	 xLZo57GF1hz7wFLnAucNHkcapgSwnLYbNHL8R8sHm7ciXO2xd66maQh2ROtELb/lBv
	 5BDlg9M5Gn9ug==
Message-ID: <sashiko-outbox-201100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Enable L1SS support when supports_clkreq
 is true
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106090342.2601665-1-hongxing.zhu@oss.nxp.com>
References: <20261106090342.2601665-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:07:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Add support L1SS support for the i.MX6 PCIe controller when the
> `supports_clkreq` flag is set.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106090342.2601=
665-1-hongxing.zhu@oss.nxp.com?part=3D1

