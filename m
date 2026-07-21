Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C00395243
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616242; cv=none; b=C2NKuqvb1S1ad529zUGhUXGcxiENNyiJkAg77LB/boRhq+qK5obswT7KXtYmrWq0+iIEahNWDzKzw0CK4dMFTkPzryZjtI7n/w+EC4j4JoZjnB/PmftcAKicNWFbYywM7kfTVdoMaoLCFQhy13wwVrF1Fq0lwyVeZ00mUuSP/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616242; c=relaxed/simple;
	bh=jp9d2FKuqqgF+NCwaSGjLRjErbPtdOUg1RCwAHF2Nug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GASGxs8KkyQq9ityUvS9djEGSsblZxOhftaP8INlFmLe15j/2J4SAkYkqPXWFEl8vEzaz1zPQAdy+4Dze6cur744QJHw2z7Jp5kxDjb/VgeZxkpe2gpCcg9a9WfVBNlyrA0EdKCqs8jpNusW5uSKCmX4ccrvamxNAt6LIhNUyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUJc8pl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUJc8pl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904D81F000E9;
	Tue, 21 Jul 2026 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784616240;
	bh=jp9d2FKuqqgF+NCwaSGjLRjErbPtdOUg1RCwAHF2Nug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUJc8pl0Qg5Ca6j3sUzliZu7NgltjHjQPFwADbx2SaOfR7Sp/TC6TImY6uv6oqT5t
	 IdjcRH036Z50FHc+9j24LQvFQekKVuNnBq/zrm+grBROhZKnrmxgKWwrb4EpGNCj9s
	 MdZpxNhyOY7lnAAQ19bmBVq9mYQqSvky3SpDAba81EYbyRcQJK1TgEu/cG5Eq69JnB
	 Qsw0nWWTMxagUdZTZbRnUyL6HVlutDpC94uiUqVLgJsSqUoOJX2AhHsXoJg1hAord/
	 25JdG7r40F5aeMv2ug/1XmW9kOCWKV6oWUrnAaYG+ESPcl6o0d/PlmU4jS0UqRLGFQ
	 09v0Onji6+fng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] treewide: Add a flag to detect the Apple T2 chip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721063412.11588-2-atharvatiwarilinuxdev@gmail.com>
References: <20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com>
 <20260721063412.11588-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 06:44:00 +0000
Message-Id: <20260721064400.904D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a flag to detect Apple T2 chips on Intel Macs.
> Cache the result to avoid repeated checks. That will
> be used in upcoming patches.
>=20
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721063412.1158=
8-1-atharvatiwarilinuxdev@gmail.com?part=3D1

