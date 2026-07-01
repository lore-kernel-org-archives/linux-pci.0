Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054A3947AC
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892007; cv=none; b=Ju8HJTH5w34hwi2eYQU2425Yqg2Kz6pSGgeeOfCfeujVSnp61+LVV/WMdEV/M0gKXsRjyYXNdb300lH0YV3fei8S+meFMMr1miK8ayx1P92Igd8ZB6fs879WJ5YVeYcodyeDeywgvV7yCrOP+YmzVoJdVTW9Fqur2+/GJ8Zc28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892007; c=relaxed/simple;
	bh=Awet9F4HH2AITZYakDHiABjE1fxaOWSfPkIo4OgcTZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hnEK4EKipMPKSHxTwytIMkQx0ocj51vhUeH6EpqwFpHqTTzJBQtc+ZPtVauZJQQMhtWUyuz8n+oSpiCvgT4H11ENw1AfAYwte4ZvNT+mYvDrTBbMbXwVeFPi14tWMF9z1Zog64+xApA5sdvS9UZXv5DxbQ3JU8yVc61fVYgxV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPeKw+gw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPeKw+gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0222B1F000E9;
	Wed,  1 Jul 2026 07:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782892006;
	bh=Awet9F4HH2AITZYakDHiABjE1fxaOWSfPkIo4OgcTZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPeKw+gwUndml0eflqy3EvSZa1UZ5gNzq87Ta7vQUC0pMRyIm5gja3wmdlfsLmS+Q
	 2XgG5FymJHDHbc3ZXwQEwXcgaeKceLyPnfoqeB26K4LYE3gqc7wN9UI3Tqn5zFiA35
	 atSM4ePz0+OrISy5J1/OD5h4jzLTK8ISIXP1cCv0df61KYrFCyAXZDdxWGyEcxnTgD
	 Y4lYcZAZTef1O9SLeaBQVt5B7mJJ8vlXGCvbT5nOGBTm/SpUdLfA9btApqZhe3ETk6
	 bT86g60BNszwAXm2qGOuLPg0HzmHiJNamZKQXjnA2zD2LyI+4suVt459tPucEuoOcH
	 bbaBMNDrQC8gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] PCI: cadence: Add HPA architecture flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260701073513.1101559-2-18255117159@163.com>
References: <20260701073513.1101559-1-18255117159@163.com>
 <20260701073513.1101559-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:46:45 +0000
Message-Id: <20260701074646.0222B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a boolean flag 'is_hpa' to the cdns_pcie structure to indicate
> that the controller is part of a Heterogeneous Processor Architecture
> (HPA) system. This flag will be used by subsequent patches to handle
> HPA-specific register layouts and behaviors.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701073513.1101=
559-1-18255117159@163.com?part=3D1

