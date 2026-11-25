Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582202;
	b=p4jvEKCOJNcoSmvWncm/epBEnfT+FKDkY4SQ3oSI0u8DwR0TaVZeJmz158LvEbVC/763
	 3pW56V7pQCSIPyEO8QsysBRiOb3ctOb8aGf5M6IfC3+f/3EftF6tQeb07i1ClXeSsA719
	 q0mK1P93lzjvki1kHz0Ueu+NSHG/gyF6BViwcPzs8QSxfgpArXL/ZJDgmKST2xAHoT8DG
	 jR+cYwMeDsV3VRumfmQMEzTRy/ar//imgl1vVug3eOy4UyLFwCxxvky7MfA98k3K3z5hR
	 SDJC5gadpsBoF/sPg4HIqI5Mw7RU0DTsZqiGnTdmbzXf28icv4AiOy6PJXZybVZwXhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582202;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yU7EOQaldJSRJvVfQ3Ok/L2rmZwO9zQnLjzR2KlyVqw=;
	b=GWdxvembezSPCyX5X/rVfnwoJn0YM/tTlezmUBRgck634lrzwEP8rPpE6SxgoGxxH3gw
	 Z56+YZTqEpNZOqexyY2RZogksLlf1ACwWpZl5rfwVPh0tzttIDShHkxqOE6rTfHSHsVGZ
	 qhsoJ15vcyrCT11H+Aaaw+aYDei0dWt/WgLqkXd15Y2E6IeNQPE7e1qOT4XMmMWMbCAKl
	 jBsTkGVALtsQwpPdsLeVwUsR942QuLLEXsISTXxPlELFxX4+FPuSdt6EoeGx7AiPRiqLg
	 5gegCY8lYJsBmMYtxYiERY6BArUpEfzSsOYTGyO/mAHsrzko4iTtWWk4Q7lME6r2B0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuVUTAIm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FA606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuVUTAIm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C2C1F000D8;
	Wed, 25 Nov 2026 04:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795582202;
	bh=yU7EOQaldJSRJvVfQ3Ok/L2rmZwO9zQnLjzR2KlyVqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IuVUTAImOHpLtyuIFvlLpw1f3MlqteenL6db/NYALimag8IRJ6+1p59CXSbAlgFNK
	 KCFJ2zJEtknAsTnAq1aKF/NyhhnBXTMh1EtJHlkdQAhnh7bancSakQc+W0PgZKDCoo
	 NHPyuVIzem3lvMb6lOXm5h/AyDiy/h2TUdiF3Fa+nPCyYurbUJqviM2CHHuSYR+1nN
	 OddFwzTLxS7rqwdoKULQhDa/sH0bYWN+ky273GBsbHrTqSCRD0388hYSzY+A9QhWMK
	 AvfgmwGqFd5qsrdpoD1BOdKSbSmgrQetIdAbwPnitM8gbhrKL3EG9epB5mnb4y0qWA
	 xBRb0hHUdcakw==
Message-ID: <sashiko-outbox-232597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 0/8] phy: core: Add phy bulk helpers support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125043639.249525-1-inochiama@gmail.com>
References: <20261125043639.249525-1-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:50:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 8-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125043639.2495=
25-1-inochiama@gmail.com
