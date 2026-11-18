Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000739;
	b=EWJnEkGeOFixh7fugK68ju59okLQ7g8e6AlunyGThQA+JXUVkbxBiSDIufK6iDZOzHLi
	 gPmjxm0lMMRccRtK/u2cSScF6DEi6ilWI9WSdqmlQ5aL8/zVP6Xm9i506bJuJc2cFtnRc
	 5FQkLmX4sVqAxj6F7dYyVnQ9Ip3CT4g1gKZqqr6USJBH+Zy6LG+AcbWz93zriOx7yLIFb
	 +z9k+tIIKGZL4J0wH7Ef2A30kYNURSMtBTZDiD0L6Dhvl0+k38kt+7kpQwpylBKtpKJo4
	 sOUja/GyT1wWTUDFVT74+/ZCQUZRaIX1yXjOZap8hiCh9znPk8qZ5lcWc49XpYPvNdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000739;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oOUWqCiDRNkVwRyDKKmzlOcVsiM1iLnCbTBfgxN4rQY=;
	b=XEKpJgpj8H1/PePioVdPfXEzpxPU8B8xs9jUDAC7Zh017Tv9FD8dyQ8HOrZiu1qK+IhJ
	 ZWB7qDdUZa3bBRfaja2P68vcwkwsSp3nwF4sNSVMWpeeH4AMxF4qeNU64lcNHmOOWVwpO
	 CwxZC6cLAakynk1XF4UY0V6NceMdgkQIx9KmU0v+uLizwf7fUo6kpDzr4dAQp9aew3Cpg
	 ASaGnQLNFjzg+kJe8YPlfny1XJU9e8oVRLeSXvuMzcpNRrjJBqAMAxRqcQm0jAG5SAAvQ
	 2kKjfj8Z6NiRHC7BrtcurOannZMVEX7T3QG3UM4fVauS7k8OdJQXHNi2kRT9Fj3iKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxXpj6S9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014C606A330
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxXpj6S9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4521F000C5;
	Wed, 18 Nov 2026 11:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795000738;
	bh=oOUWqCiDRNkVwRyDKKmzlOcVsiM1iLnCbTBfgxN4rQY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LxXpj6S9rctYxrHkwO7jfi2y/DUSxBfemDYx5gntcAjDt0iNYu7Key2h71II2Gz+a
	 PbrwAC4g2nE6wPmvHnEoieZ87xAdJgKMetrhfSMpbC7ffdROcmhFWKForHcHNz4EbK
	 c7JhAY5q3k0pkb8pFsS+qUr1b6see4xw7MaEpuOBS03DkrEOBYcsFSKjwb9ZAy/FZg
	 tK2bTApSjU9tvO2m9tPXaKBFL7xLGQh+3gLNogfRq+JIbo1aJpkBDm/DkJL6hzHRZb
	 rdXE3RnGQMYZovSkkkDBCNQt6NtK/OYyoixjjxvujL/a9cuWxaTs5/pVKY1H1u6Z/g
	 dLIhY1WdVXNTQ==
Message-ID: <sashiko-outbox-220815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] PCI/ERR: Avoid stale error status bits on
 recovery failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <2d0191cb7b92da82302f9d37b859e28ee6c9c85e.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
 <2d0191cb7b92da82302f9d37b859e28ee6c9c85e.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:18:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Yury Murashka <yurypm@arista.com>
>=20
> pcie_do_recovery() only clears the error status bits of an error-reporting
> device if recovery succeeds, but not if it fails.  (E.g. because reset
> failed, drivers are missing pci_error_handlers or those handlers failed.)
>=20
> One undesirable consequence is that the AER driver may subsequently
> identify a wrong device when searching for error-reporting devices in
> is_error_source(), due to stale bits on an unaffected device.
>=20
> Avoid by clearing error status bits on recovery failure.
>=20
> If recovery succeeds, Fatal Errors are generally cleared by a call to
> pci_restore_state() from drivers' ->slot_reset() callbacks.  If recovery
> fails, those callbacks may not have been invoked or they may not be
> implemented.  Hence clear Fatal Errors as well on recovery failure.
>=20
> Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=3D=
gwfYdcrMo-SQ@mail.gmail.com/
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> [lukas: drop cmdline param, rewrite commit msg, clear fatal errors]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794997749.gi=
t.lukas@wunner.de?part=3D4

