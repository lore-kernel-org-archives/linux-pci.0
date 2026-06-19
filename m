Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071E2F8E98
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859838; cv=none; b=YdPVumZYUSQ/NH+W7YRyqc6LcFGPby4dj0x5Ke7qbYqmeFZcVkVkU99tnAsaO7F550StQQXVyZAnvgwMxcywyg2rynMpaHUub1bFWukl5cJ+bNkV+IN6jAJO2Hkb9L+jNmlv9xfokvO4Jmirs2TWhFhWh04GxsigjV+/+etdXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859838; c=relaxed/simple;
	bh=+9oESzxUENwJRh18m88ezSz1pb3z1v+EYoSz20ZzfTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dnaC7Xfw06jKG3nK0kVVjyPi2Oaxflgr66covtbUjIk6PfjNNhmxrnpCEBCALf4erbH0/8XvnwlSZp4hIcJYPOpB8LA2CQXUvBRIYexjirVhraP6oRMNbDu7CvYcJ4OuYT2thu+AgNVssmjwZCE+bMt++32OZpyZpXF5oxHidBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9x4TEV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9x4TEV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5451F000E9;
	Fri, 19 Jun 2026 09:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859837;
	bh=+9oESzxUENwJRh18m88ezSz1pb3z1v+EYoSz20ZzfTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9x4TEV//XGt5SguDuQl5gWgiOWenGIx7vR4sZQGOzdAg1/TmLNh2Q8KbRvMGqfV5
	 KkWFyTOXYJcr2ZeSCp241WYCl6EaT7lHsU0FToLRt6lv61pILGL6ZbiJXuxuhCj5PO
	 5ibNM0MZYxgB1yynM8Yh08wX7cWB8QJOGhVx0GnOzUcOrXOj+2p9+g41lNP7a9FHM/
	 KswqeJDxmG7x4XiHfonrk5nbgYwRFtkTFJyzc0kXxH0+xt6NYiUMd8q9okXqjfHToL
	 lBLXQ38IkszyXgp/E/dZG11MDLIuswo/gt1gYcHz0wXll+Iq1EDW4V8LuYrK8ul6vG
	 mxQP4jx7C4DNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/25] PCI/sysfs: Warn about BAR resize failure in
 __resource_resize_store()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-9-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-9-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:03:56 +0000
Message-Id: <20260619090357.0E5451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a pci_warn() to __resource_resize_store(), so that BAR resize
> failures are visible to the user, which can help troubleshoot any
> potential resource resize issues.
>=20
> While at it, rename the resource_resize_is_visible() to
> resource_resize_attr_is_visible() along with the corresponding
> group variable to align with the naming convention used by the
> resource attribute groups.
>=20
> Also, change the order of pci_dev_groups[] such that the resize
> group is now located alongside the other resource groups.
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D8

