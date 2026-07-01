Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A53EFD09;
	Wed,  1 Jul 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904260; cv=none; b=sgJM+c4tESFRS4Z2oZQP/Y/4RGNpmSh6jAN3PGufBONT3y3YiyMHncO1qu/dPFP0MJQjZWMwd9g8hI4C/io/72/jIC46iC3ntghIoBP6iSOcdNrZBYW2uVwewHHcJO9T7MMOlImZV8TC6cSio1POz/Ie9JClStZFbkuh+jbLsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904260; c=relaxed/simple;
	bh=VNQiKyq4HgcqP/QWG4QLn7djfhmUAouDeO/uc5ZopT8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=apNM00qwpFz2RqQWm70ljo13NLvniToolStKyvTuP9Hmq+4q053YSUwzXpJx40+2x2mw2bB1FQaPO4Q1m1k/W9X1p5egJd6PIwdooFkRthjl0Be03oPqpQNjC3nUofGmcn0ypD4xRUUQtM2s6M8okyqVbxrcXEvAJdl5Muz+vSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8QJfYJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8QJfYJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA9A1F00ADF;
	Wed,  1 Jul 2026 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904258;
	bh=VNQiKyq4HgcqP/QWG4QLn7djfhmUAouDeO/uc5ZopT8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=O8QJfYJEJsU5wAFNDvnBkGMu/Gh+igh3b4BvDJaSGrzB+ptVsmnFrlZipXIEP7N5g
	 3103CaNtEMO+eJSWI5ATD9v8cv5HXXG/tVWbvcxN5jjNsp1dC4QMoGIC6urtV89sKR
	 dQGMZ+iJd/YG+lGgnnvWl56i+kh/l/V+02OOpoFub4Mk/s4Q8V2Nm7kJVh1d1pyOjq
	 h8Ic5B9/c+AwH5WRWrpnCjPzxnxy6G/39gHCQ8q6OOTMH5vhQ6aW7ebGIVJxScF6L0
	 ZyqmVRuZrJ20ND8M7IuHSfUyh+w6GQkqaZSsI7ZJW6H/xUre4lDfcfC33WtfrVY1Rh
	 uDJkFHGw96b8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 2/7] arm: dts: imx6sx-sdb: Add power supply property
 to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260701105234.198987-3-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
 <20260701105234.198987-3-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:10:57 +0000
Message-Id: <20260701111058.2BA9A1F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Add the power supply property to the Root Port child node to support the
> new PCI pwrctrl framework.
>=20
> Legacy power supply property is retained for backward compatibility with
> existing kernels. New device trees should specify power supply at the
> Root Port level to utilize the pwrctrl framework.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701105234.1989=
87-1-sherry.sun@oss.nxp.com?part=3D2

