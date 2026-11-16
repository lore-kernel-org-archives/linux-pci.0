Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842953;
	b=XiSNtJAAJU02J66UME885nLz2HaerktBNP1rqTtb7+n6CWkNMsM1vpw7g0ekCG8Z59dO
	 4R85Z14gqiSSnEkNH6c3W/ajhmpjobb4epKSpJKdq2Dp+nY9pwElhcH/UCrnLISF7ANSN
	 1bzexT9pT9+V/s3UrKiETs0cgA0WueEebMz5rqgwWP9qN3CwVeAf/xnq4esIC7pjWeVCf
	 rSF78kATn/tvByZbXW25AdBcmFto46nMxoxUP30H26x+J6ni9cTcDQzjb/xAMs9v+kOHG
	 SYXUciGxK+iSdiJs9LNozDO8wRj6r17thiW1zDQ5bO1d504sfX+qyPMRuCOZVyvB8Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7RVcy7n5tSjpgBaWfnfRw/WKmcUzznYWwN47iMlcxF4=;
	b=TNCSK/frxY6hlp/GMVZRZulwGAKGYxGeL3Vg9+NUy1UXj+tbeJcW8aqtoKmjbB8Y+99w
	 /QZnhlOjyj6tCGQKZ6TW/HFBJFst7IBKn/pFAxCtLuPH9nuJGI1IRi9nx8S9ZTUuCygYB
	 2fNs14m8PrqIMVTICAk/dXdh1+yoKXsEdN1x+b9EwRttxaUKygaGHU09ssCBTCJp5P63v
	 xmua8+SN5bJmLJ1YxUPWS2bpMvejmBMLtMwOCMfs4ZZIukW/UivB5Qn3jdZ82heAU9Hty
	 qYdW1h05JS8eDJCJEPxmS0j9bCBll2NYgWrdESpEwBYGrWmRSXmJR2vDzf0xhVBqniw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n/SoUugx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBDE606A33A
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n/SoUugx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3971F000C4;
	Mon, 16 Nov 2026 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842953;
	bh=7RVcy7n5tSjpgBaWfnfRw/WKmcUzznYWwN47iMlcxF4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n/SoUugxH/+/bxprE3oFdQsJURHskhlQJhpws7ZB8CevQYLg91FaaXGR70mf2HCxA
	 9umx8nPivoTo+KArgI1ptDXo0MuhsdFQpcbQNZIcL+nlbZrnHJcGBwNwh9yWCA+Omh
	 1clTIyFJPK/E91mXY51OFqAD5OXYvPWOZc5nQ/AhfnoQl0TGTA7jGV7aZq1+kKIhSZ
	 vXeUsMxmysvbqEzSeYZOMxfXq3n4MEhh+k5RmGNF5METC4Tbn/uk883S7u7BfD4980
	 wPeSms1gJMGRG0Rn/CgJsYxBMYiGSeUSynB9F9P/p3z6n5ZPT1OQIwiLrcq/OD48ly
	 b0IOal29sLrvA==
Message-ID: <sashiko-outbox-217275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] platform/x86: eeepc-laptop: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-9-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:29:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The eeepc-laptop driver scans single device and then attempts to assign
> its resource using pci_bus_assign_resources(). That function makes
> bridge window sizing disjoint from the assignment phase and is going to
> be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely no-op in this case
> as it looks like bridges are not involved here.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D8

