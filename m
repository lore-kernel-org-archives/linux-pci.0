Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7C22DFA4;
	Fri,  3 Jul 2026 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044949; cv=none; b=sDqiaOc6jXc5BaPzHquWbaqb9bOhyo4MyWldGqCKtvMngRin4jl/2POqLCycv0LII0d2yrfEnL5dMtyND2Sli6GRqLJWYOFyRg9OEKSyNdKmwSyEn11UMRMh1ti8iTb/7QUD2X5rPor4FkPDt8LBybFg9CV3UQkqfQVartYP7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044949; c=relaxed/simple;
	bh=ws8lFGi60JAffyHHWGQsYBGvF3eKXTMWx2I1W/nRC1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KV8kuDkBMsJkB7v7G/4ulzXjzvxcsIVco6F0mK5tB9ebReBhZodaneP5+q+2E/rKHaCgDKMypc/bKFWExl/cQnGEqrLJIlYQkVLinmv96xBdE7CLaaye0sxSzSF5ulxy8LBZy8G5pHAfFjTDTHqXxs8ddpZEoaJ/a17obe5wA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmFwvdYN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmFwvdYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29ED1F00A3A;
	Fri,  3 Jul 2026 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783044948;
	bh=ws8lFGi60JAffyHHWGQsYBGvF3eKXTMWx2I1W/nRC1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dmFwvdYN/CTRJrMBpvQRsG16+y2wqwMjBMbbQePWBHaCxo2czyeXf19AebUc5D110
	 JSW2xKoTSMacaqnT9S+4nS7CEsh7W7U+jn6t8oDgzA1ZRisSmXQ5UZHzfl2Gp5r6h+
	 iy+549yf0Re2TQQtbKpK+g1pP7S8qcrd0HQWEo9+mNB9BrVRn3ho1+Wtl9QF/sjeRj
	 ErHqumSBHsqrxv+f9CFM47oqOZDGoBxO/oxta8n5GL2aSlwqzUdsC1o9NnpAyLfAF6
	 Yh0TDi5E7CjnIvlSu5vJY+E/SYPnToBA4kxcGcJ5O1Te03v39bORuFQN4jsBdCQxZl
	 cWA4rXI0IEkzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] PCI: spacemit-k1: Add multiple PHY handles
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260703020003.485436-3-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-3-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 02:15:47 +0000
Message-Id: <20260703021547.B29ED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controller on Spacemit K3 may use multiple PHYs at the
> same time. The feature is not support by the current driver.
> So extend the PHY definition to support multiple PHY handles.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703020003.4854=
36-1-inochiama@gmail.com?part=3D2

