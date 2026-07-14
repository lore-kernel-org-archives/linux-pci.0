Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD58477E2E
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056274; cv=none; b=W04DQ9PJyt/qHyGvQ0Vh2Ey+x6pNU1PhHiqbsr8xPNSAP50yo2RSHmJArU+iExJg8Z+0lpl30aDYvOxmBzGi+LJPUshaR2kyxm+dLGyARa0Vt2ZY2cKjNY2ydXLPJYSlHiBdYc6BZ/ZfUQ44HZzHWL3OwqhnCrWD5XS8LKNlq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056274; c=relaxed/simple;
	bh=EVhsxws7IhXnDlG1j7BN4bNbxpTeyMNHvIxipdyjIgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z+JiQU2YJMkvGmQ/CH0B4bZeQyVdH2DCJjULHqBcebxLttkv17vXd3jR8NBNZ30sCcaVGoiyR2do09eIVO4KWSdN9Su+e2AaLoYmmqUxFn0TVNhWe0EAMePi9f+yw7omH+rQXO/efpvUbc3ugpClCzwXRwFHFQPLLz17O7HZGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVbAzrWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVbAzrWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A96C1F000E9;
	Tue, 14 Jul 2026 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056271;
	bh=EVhsxws7IhXnDlG1j7BN4bNbxpTeyMNHvIxipdyjIgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KVbAzrWyOx/5TZTIkZLTzutN1/Nhu4Ay1dwT1MnRW0o7npdgzD3XIoANY58aTc5yz
	 aR8gsOrl8W/7XvYBhVU14NlIGN4d2bDnJmDfN9PcVFtvWBeZBu4yEvYJROZJeaphgp
	 PTc9Xp0JiFkgg5at8XmhMAqFAG+KmS55uDkUUtrlPzBoK5f32L5vlNxLmDMOmxUD4S
	 hT7tDxv7iEtpB9u1Z0BCdRBjZ6w4l5+QJXEa0K/3AJpDuZE1jt2ZaEbeVN250EKA1A
	 4i8GjQm9SIL6tkDlPqDTwzBlDIfN0A5IEUUmfRGLK2qhFoClnpMn6Hp8IMRdB+qjpK
	 oWws+DwMPEIpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] PCI/portdrv: Group PCI Exp Cap services into a
 single mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714183950.1620016-2-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
 <20260714183950.1620016-2-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:11:10 +0000
Message-Id: <20260714191111.3A96C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PME, hotplug, and bandwidth notification are all services of the PCI
> Express Capability and share a single MSI/MSI-X interrupt vector. The
> set of these services is open-coded as a bitmask in more than one place,
> which is repetitive and easy to get out of sync as services are added.
>=20
> Define a single PCIE_PORT_SERVICE_EXPCAP mask and use it in place of the
> open-coded expressions. No functional change intended.
>=20
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714183950.1620=
016-1-yazen.ghannam@amd.com?part=3D1

