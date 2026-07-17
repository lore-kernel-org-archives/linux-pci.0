Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85093128D4;
	Fri, 17 Jul 2026 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274413; cv=none; b=C0U8uq8TB61OV+9Ji52ZtZsk1a0Lq8OfLnThGQPg6OC+tWNK3BEmIEqVbXOCE4ZmlVaRwee/JNCD1osEe1OZHZkp9Q5HoLWYnDOHHHjRWVLlJAJe19WFImY8kD6u7e5HW6wjEEUYduKdeG+wpU89fuVhLWZ4mSM7I/TfryWkkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274413; c=relaxed/simple;
	bh=0+Mp6fstxewhSvY0uuZ2mgXjbJnw+uAJL1PCOuhTjb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EhUK/4qwRGMPOpJ/ceEbmVV/FrlmS8VhWF6FIe/Y9vLfLAG96gZReSvqcbEMmNUPHrVaHLlWR1lfTzoe9rBE2d+v+Tt+QRWTohPdKL5HZHlCRFxZQ9XK5+U1FXZm+86McwNOUb4EimVZ7Vsc0D6NL8DU0uYw6sw/ootoAGrhYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS+jyh9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS+jyh9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775451F000E9;
	Fri, 17 Jul 2026 07:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784274409;
	bh=0+Mp6fstxewhSvY0uuZ2mgXjbJnw+uAJL1PCOuhTjb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IS+jyh9j0dyrDbCTJCC8DM2ZF5rEbdFtSsvZ5kT/NrQJgm08aLYkJlvxYnLD9J+5T
	 GoOMu5PkMt5wQB7Q07HRqNRdjMDyrs70cGViqkPdDYn9ns0GbE6sLWbF0nULv6bHAf
	 dqVuKPwvKI6vGGLJ2GzdcuCg6sk1fOOKPWhExxMy1jsNwfM/wc3g4fd7YEZhkYDDPs
	 2uuZq+L3tQUwjUFSMBFqqhFT3e6hWDOKCxUCm7au90H1nbMPAFqZOZ5VHEOFDoUAtZ
	 1Nof/e9D4whgUo9gR2ljhWFmy/IdzLAPOtAtAXThb2J9fyqEhCJqL+vxngJcdT5ztC
	 w9kqNdsZfBoLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260717074121.3214222-1-hongxing.zhu@oss.nxp.com>
References: <20260717074121.3214222-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:46:48 +0000
Message-Id: <20260717074649.775451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Some platforms like i.MX power off their PCIe RC controllers during
> system suspend, requiring full re-initialization on resume. These
> platforms need to enter L2 state to properly notify endpoints before
> power loss.
>=20
> According to PCIe base spec r7.0, sec 5.2, the system software should
> transition the device into D3Hot before broadcasting the PME_Turn_Off
> message to initiate L2 entry. However, some endpoint devices fail the
> D3cold capability check in pci_host_common_d3cold_possible(), which
> would normally prevent L2 entry.
>=20
> For platforms where the RC loses power during suspend, L2 entry is
> essential regardless of D3cold support, as the link will be lost anyway.
> Add a suspend_poweroff flag to force L2 entry in such cases, and enable
> it for i.MX PCIe controllers.
>=20
> Note: This violates the spec requirement that devices be in D3Hot before
> PME_Turn_Off, but is necessary for proper operation on platforms with RC
> power loss during suspend.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717074121.3214=
222-1-hongxing.zhu@oss.nxp.com?part=3D1

