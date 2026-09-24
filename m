Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E81D18A6D4;
	Thu, 24 Sep 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262497; cv=none; b=O+ign5tblTkxV/gJ1rilMSYix5i6K00yu5BbDB7dYkNmH4LY71s4t6cCUbqnDems7U7HcRMccZ0SUmbwXi0C55N7MVN+zM4qeOHqY4jGvSihYq49wjiDNW3pIwVXutHjURv7yiKnyX2BJCeiZRBmiXrIChGWDd47GAXWwLbTLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262497; c=relaxed/simple;
	bh=SYOMIRu9GXqLoX5rwMEmja6bQ4yVdqAP8/0TxvyrX0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1BjvZp1/UIYjRgZK58+nb6d979usr/tB4vleTW9v6GDRXBh6q022gugDzkPTxMmy7chGY2un2sjO6YG762cZ1TphhiN1Rcp0JSyHOHB/6l02M8bz1n+YZ5Cq5l23x7A/N9d+Kl3xQExCPHNKJSi3NFw+OgQcUBWV7TSTinv5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHrh5Q7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHrh5Q7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10C21F000FF;
	Thu, 24 Sep 2026 15:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262489;
	bh=SYOMIRu9GXqLoX5rwMEmja6bQ4yVdqAP8/0TxvyrX0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHrh5Q7iUn6zhYUab+QKwjmWvbAl3s3Qp6kPNo4ogV/Gd6g5+Fq0se2Lx/s0D2ZGG
	 DmgZTcJlOFnc3E94vt369kw+Gqtpw5+ydG7c47iS9Puu33QM6dfAX5GAGg1V3aG+TL
	 ELPxsTtlRFNLeugbL7hKBbK1ph76xuppg4JNz4Z8+uz6sB1D87813FTJANNDBCibKB
	 8eCnIzazFQZOa2Gmp9pn8c/GqiACGBnyGr64pn2bkDL1S/U9XbcdY3OksyG2QoK3HP
	 E9IrqO8oPA4JTxCSZko9NxvqgyJmtXmS0Ys4zXMrHf+mMtJmyqEUxfBdFcuaqIWTZ3
	 wz2ypzZ5Db3mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260924150222.1179235-3-elder@riscstar.com>
References: <20260924150222.1179235-1-elder@riscstar.com>
 <20260924150222.1179235-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:08:07 +0000
Message-Id: <20260924150808.C10C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The reg_num argument passed to of_pci_set_address() is always zero,
> so get rid of it.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924150222.1179=
235-1-elder@riscstar.com?part=3D2

