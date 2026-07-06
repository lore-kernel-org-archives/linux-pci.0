Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E542087C
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341997; cv=none; b=Vji9sei/Bj9aWnHM+dGFE/n3F4wCdh+gYBelHwoQ+9EPrX5znlzRBynlJOFHbSBXFXZlZGeGdfoX7lBxGGdb+auA4IrVUrc+ZUvFbxc4nroNO4bUhZfrhsphx8MCQudPEdE87V0xlrURlIO096EXGYkyOZH/XOAapJmYE8iN/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341997; c=relaxed/simple;
	bh=5QehpwABrv6KeyjJr4+cwAaw0I3u9LxCy51LeJfaPwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eM97Y64qzsCOoxCppHgnsUNeQ0d7JdErDi93WUGeARTBjLhrFNdgCWerP5Sdx7i+FZl7/7igawX4N+MJvRHCxkZQW8AIfvOePs3OkW/sKUHUkP0HWjF2UvaVA/6MdYcJE8xFUDOOi+zOCVkM+qKLD2MxVTwJgM+RFrTEvKE6qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1GI+Qk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1GI+Qk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20811F000E9;
	Mon,  6 Jul 2026 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341993;
	bh=5QehpwABrv6KeyjJr4+cwAaw0I3u9LxCy51LeJfaPwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n1GI+Qk3aA7+3uoaHZ8oFKqPKkGSg7CGZD637IghQ6UFL/eoO0WbCODYF5p69PO16
	 j5NjFOomIdO/OEDWjU5GFVYqnqKyB6dPZhdzKh+UWvg3Jh7GD2kN8D9a6mGA8VB14Y
	 AYcUD8vmKK3LqyyQ4Q7zF72gsTvpkZx/1m1kZqzM667O9PCyju0l+wvG0aJV5EgS/e
	 lRxdycjVuJd/krXYbsO4e6WW2gRgGYEEpPhADoweAnIIxd3uEd00yYENffMphfqWdU
	 1aTBhb8cx3B/dlUyaM+JAKVKUM4JlsBJtsZg+aY1cjI75UbSdf/Z1+I1Jytp3c9UDM
	 5FvMb7UXJSRjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: acpiphp_ibm: Do not use uninitialized
 device_class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <8730724.T7Z3S40VBb@rafael.j.wysocki>
References: <8730724.T7Z3S40VBb@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:46:32 +0000
Message-Id: <20260706124632.C20811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Passing an uninitialized pnp.device_class string to
> acpi_bus_generate_netlink_event() is effectively equivalent
> to passing an empty string literal to it.
>=20
> Accordingly, make the driver do the latter instead of doing the
> former.
>=20
> No intentional functional impact.
>=20
> This will facilitate the removal of device_class from struct
> acpi_device_pnp in the future.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8730724.T7Z3S40VBb@=
rafael.j.wysocki?part=3D1

