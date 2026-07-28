Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A253E639E
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277141; cv=none; b=qaqBSIEf3BLojqaFnuwKT7j3G4hGccRhHx+mYjv2/6EdUEuZTFnqbOKA7dWyVfKMOafJ433DFJZlrAnMMnlLtrwSwjnmGSy3lFCgTjnAJkAwE+pM/X/pIq9zqBT9o6+tREA1J5fqKX+/Zd+gc2m0CSDYEMVvnUJqFbP/Kk6shHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277141; c=relaxed/simple;
	bh=SLXNdpEuyPaaWFDM7AODQGcOCnlEKtNRiIVh0YX5614=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZvcmijMwnGVQ3bhc9tGDYm5hSqPWtwwCD0X62S9P/qyznGd+xp5e12YVe+DFm96qyodtX2JZ3c+D+Hl1EQUJZF/HKLxFqzdyFI4AgTpJQ6+7HnxM7vToKWJxrEzpq5ypis0TdffuJkaNee5rn7T41sOTMLTAScOuG45GEACViAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzS6UbCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzS6UbCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9828A1F000E9;
	Tue, 28 Jul 2026 22:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277139;
	bh=WYQyAc6XgvIa9tX9L97pX0iUFXNg0j3ewK1eI6mbV00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nzS6UbCn3t07U0YtzasJoMtjkf5jOO72zRURSpvfEn7EjyvycgXE9Wv9vrICv0h9i
	 kJh+KYCGbWRyd2zpcoafck7Eje4+vIZZLSRSZDV4fP3D/XqU48L/U7Bu7W+blXf2ZF
	 odF4QJ4GuJrhNpR/qMC1UmlfqG+8WujXjIJIx96AcgW8MiycFvVMJlQC55cLO9aYIG
	 l4osbFzj35LuuTcLEq7wOOvxirwXyQPDBclzWZS/+aUQbkBxYRtXSasIWNppbJxDkW
	 6opaxNLXjAg+Pg+10Z9tZBmrFLhcsHTYZW75AXUEhg+qAb2B4hDsYzOmD1pvREFu1r
	 eKXUKy2Zu6+ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-12-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:18:59 +0000
Message-Id: <20260728221859.9828A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
>=20
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
>=20
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D11

