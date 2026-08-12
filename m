Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99547A882;
	Wed, 12 Aug 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555671; cv=none; b=hR0XHGzDbSRSh4axvnVRBx1ulSmwarIl+lJEjDrlRQQ30iLlHnVsl0sIl1qtWy8IbyS25mexYMzXXqrIduQcxhqrvnXbRNG3h8NwfI7x+017ilgGNv1SegRzsqp4uQh8KGfUmEX6DO5ZNEX4AwVyenfsGnNNGN/pP5nJrvcIHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555671; c=relaxed/simple;
	bh=nmiAVgIyU1kqqCUOuYp5LG0z4Eqj5Uz8kE8AYKwsNI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PSHz4BK17usMC+Kfdv6dDRrhG45hHGB8OIQfp8HVj769jdMsOrtEdzQ4bmx08cIc3uMiMiZLWsr5512nsse/0yC2yu1/rdwtweqSZAPdBTC51G7LtxS2oquGueRBq0J/cDGB1uBijdTG0JWl0HctXj1goxf3quCBYAnWkTYozxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZi0pHHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZi0pHHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C521F000E9;
	Wed, 12 Aug 2026 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555669;
	bh=VRShP+bshfUGncOphLYhm/msiteyhOKfG+GMC0zZFZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZi0pHHrFS/b1PHQIa3nLZJ9ENHvmGowHaCkegCRfhemkUD8j3qFfQcWUMrJQJqgm
	 +Xo4mDlrCHr3qVxmEAhYjuxwypmLvNHVf4bgd3ZaRpq3yiMVcOAhKUt8eq6LztBg67
	 x2y8E4Yx/+oWJike6N2JNuUnk9m+Xr/dW7tlCGQqTSPlxSUoYX+IG+ipcbc5m3xBiv
	 Yc/WBI0x96dr4LCfiqUFKcFDRJevCdhQhECfOTsjJ9JTkEz5ONivsQttBHtuEnzTUV
	 VXd69mC6R5wwE4+ZWHC+O3PZA+gOPmC39nDsPE2ePeARF5FuZjaGDsMVGXrC3ZOGVv
	 KHp3QsI5+wSOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] PCI: of: don't zero flags in
 of_pci_get_addr_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260812172247.276554-3-elder@riscstar.com>
References: <20260812172247.276554-1-elder@riscstar.com>
 <20260812172247.276554-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:27:49 +0000
Message-Id: <20260812172749.90C521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The flags variable whose address is passed to of_pci_get_addr_flags()
> is zeroed before assigning a value to it.  Skip the zeroing and just
> assign it instead.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812172247.2765=
54-1-elder@riscstar.com?part=3D2

