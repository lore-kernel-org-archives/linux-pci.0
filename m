Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A4320393;
	Wed,  9 Sep 2026 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941584; cv=none; b=opSB6ByW6wlHeFUTsZxTUMyb8IehNcryGYAZozUTKz5OTsbRO7QaZ8EjACO006njCDgTBqnHacz0vemwUOzJKRJp8fwpvDWErZu4OHFEuqUQXzXUiOMCUjFAgGkdSjwe7PkiYaxkwVlApzCvj+13JEVX8EuHxxZgnji6qNx5VXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941584; c=relaxed/simple;
	bh=8TxQiF63MoqvZVi67XkJtZIfLLwq4xkjg6TAB0Sl9ng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FWDZa16jF2EU5V/udX71H1QD6deTZry77w2a71KxnPWb/2aPOu/hhPIoRbmZCQhFbm9ylfzVYtH95+8vMqAskWhjHhR+k/o7xNw2rf6oTqI0jxmezLzhss2KkmXk6Nc6HctKv/42Iv/B7VMRmBUTfwsdMMlPf+Utx7wxQaTczT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7caqjno; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7caqjno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9701F00A3A;
	Wed,  9 Sep 2026 08:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941583;
	bh=8TxQiF63MoqvZVi67XkJtZIfLLwq4xkjg6TAB0Sl9ng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J7caqjnoXISJlDB04CWtVtGhKOlRuR0dNbG+w1uAZZywe9atObn5EFLOghL2HYEJG
	 7JlIvsKHuAuJtC+uVZ+GEdmV1pzBlAz1P8wFcP/Ass8Xl6gDEU9xPAw7vZpu+sVgT3
	 p61wSZEVQ6tu1B6lzM7/lXd8tIwgpd5aZb/uHHaAZ4x2ovLuomi1c4IQ2bySJgSYCF
	 f1e6Yhdex6BJtnLTBqRLhVHaqfhQ1/lTN0luzlEJp/zyU2bRwEd21tSe7fdb7efI5b
	 j0wV60oHdN5WkVkOcxbuvmlbUAmWlgfXems6WgEIteeEDnxGV1E1gwyKqANXTJsiS+
	 ywe2Jrp4ZxQ5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/10] PCI: of: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909080114.591938-7-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:13:02 +0000
Message-Id: <20260909081302.DF9701F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D6

