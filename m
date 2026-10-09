Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD43AF677;
	Fri,  9 Oct 2026 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550507; cv=none; b=IRVrg4ankoUGtjNSPSbBgA/hVCJNQRZScf8BytqavNaclzgaGc3vZn6+eFajl9m/uf/FGjzrypPTWfy3VLv2Lr1tjpDr22D9TM5WlbNtNaVSWeVrB8E60rBa2vhkLrv3EqlD8bt+g4jDgJbWiGScN4RKOagEcajdDWmDE8RkUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550507; c=relaxed/simple;
	bh=Z7cvi8fjtqA78XDezmYY6l6hf2+ZFtcQM0sHyf5qCLY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QVfYWWEJhTzdgR2uAFCpa3gds5xx0HUG5xzh7ZU7lOycrQdjZA1MqGmwwM4DqDLqZI3sZxAQ6wZt7lx0jaCTcrQbe+2kmCPP1lH8ryaAhFdaAqaj4HYfPSblmnltd9cVgNCyWfpenC7ORTYjNUl4HDRM16BjDAnQz6baTW7ofY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td7PhT3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td7PhT3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500191F000FF;
	Fri,  9 Oct 2026 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791550506;
	bh=Z7cvi8fjtqA78XDezmYY6l6hf2+ZFtcQM0sHyf5qCLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Td7PhT3J0zChLgXPIGSmNJ2+4/as/uLp4IUosSQKr9A8hQXYyiQ787EuJuuZVJ2QM
	 xWBgUXu3rQKyBUYq66nUthRxRb+EPO0HSL2rhCvTKkCQPAgTtHGDYIkhEJaD11cfOt
	 SlQnJi+TBXtmTtXEBDzKy4P8d+ztIwAzRMAaNlyBPqTHg2UXo/O4YNmJcVuyJVDScG
	 VmJt7YPHG76yNmYyKOxtN1T9I1lPBbplVtRCIVf+6zd3MfyCRMoKZon79VEXCzTkIz
	 gAPGaSIt3KIwbLW1VrxKwsVf/UOT/X1h83fruATfVv2f5H8AsHxxYeZeUZgwFNn352
	 kiC17ex+mcEnQ==
Message-ID: <sashiko-outbox-165571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] usb: xhci-pci: Add TUSB73x0 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio Estevam" <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261009125154.266435-1-festevam@gmail.com>
References: <20261009125154.266435-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:55:05 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Instead of hard-coding the TUSB73X0 PCI ID, USB_CTRL register address
> and the PWRON_POLARITY, introduce definitions for them to make the code
> easier to read.
>=20
> No functional change.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009125154.2664=
35-1-festevam@gmail.com?part=3D1

