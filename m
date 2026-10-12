Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576F392C4B;
	Mon, 12 Oct 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815687; cv=none; b=MR4wc4I6Xjk2cUJ972uE/F3cflQG8zPHYDsXXHwpiKZzyBQ3GoHnosn5Tv/PbTS0cZom1sx3vSrCkgkCG1REc/uOnBnJOcrfinEfdMrOANkijwNEboubuUiMilqja+3pdadaoykqxt6CXjjYCILA7t63nuvWJxspE/zcn7puLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815687; c=relaxed/simple;
	bh=ntXzfAp0GcPV9p5YzKs+YaoJNZ6SEZdMyDW5uqW8nd8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jPfm+mUgANO2BnjLORWrYWbJ3CdO3HYpe43KJLuKyN2Bs4As5p4alZDCSuZG+L/9COWArVMy8mbEJSBIqOzlgzRYamnRul5O9EJXoQhWEOXFNDhkX2c4GjReqis0hiMp12xoMMZMRjhvPIZYhxzQ1w4dPrcLxuN7HlfxD4GBkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkHXXJou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkHXXJou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF241F0089B;
	Mon, 12 Oct 2026 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815685;
	bh=ntXzfAp0GcPV9p5YzKs+YaoJNZ6SEZdMyDW5uqW8nd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XkHXXJou7qYEuvSZf/HZbC6WpHq4Krluvl5rkikqqwykfCcHVxYW0CGNArMDaTv8t
	 JoIh9yampsi50Y4nNwN2RVwS67PP9dsbiOslsslHs4AcR0Bd3pnH1kyfBf2/x4qZQv
	 nbNYXizm8FKgs5Gh7l7n4l56O49Hh/KCryXODL5QiP5jqpgVNnGlq2+qNfwKycSepe
	 L15UZHOehwOo8MsmfRAyAx+1qhACDbyodpQF96GY/RC+ng5mTHKuCDCmDoiuMdkFav
	 M8V+XlJ7tqy+vodiSlMllZTaKH7QOlEHdXveniB7TWpCT04usPAtUraNAHNN8NeG1z
	 TV8+jLhiE8UrA==
Message-ID: <sashiko-outbox-168271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/10] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261012142826.159178-2-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:34:45 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Setting fwnode->dev is specific to fw_devlink.
>=20
> In order to avoid having a direct 'fwnode->dev =3D dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>=20
> Having this helper allows to hide the fwnode devlink related stuff
> behind the helper.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D1

