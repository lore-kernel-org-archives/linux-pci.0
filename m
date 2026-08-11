Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A935A398
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492074; cv=none; b=RuNyaU6vlF9wA5uA57lwOPacl14SC1/Ixs/g2n067C/3x6R9VNWn6gTezJg8MIkZ4N3e0l5fKyBJI5H+t6n8F+MRHqh1k8HrKUZEATz9iaIhsXv1i5o7XsjGjEsnsuGOOIGtFUl0j2GMgfURTxrHe3+9E14t8+GZXi5tnXYR2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492074; c=relaxed/simple;
	bh=rmADhn4cIvMqkXSXu5PfIbRLE0m1ArKxuGM9JT5GmOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GtxKwfNkY+CIk+WK6f1/8tNwSlzGIDw5ceYeF2+fgSB/X8xqrkSdi9Qw4Jzz9UxSdi1B6JUY+nE0EV5ZaMhtKIBLQP8DEtNPkCe9GXF9Ob/7JEC2HUj5RMmEH3uq5IwFbCMsBZ4NdBuzJMbLChF2rUphV+hkis66IeZjtBruBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY/JKGyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY/JKGyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891241F000E9;
	Tue, 11 Aug 2026 23:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492072;
	bh=rmADhn4cIvMqkXSXu5PfIbRLE0m1ArKxuGM9JT5GmOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WY/JKGyucjuseDTtgEySVy+I/7qNoV716vlUUU0BLS2lYBwiQny7rIOSWVbP0JJ9t
	 o/Bi/AP0XRCSOzEurz+FaUN5CnFA7L462ytHAKPaJVvdGSHbTonWOq6kWaNf5gdhq6
	 2NXIEN0YiFnGO7eWJ6J0n+7SEo5pgoxJjD2jkhxxJNQFYJon35z3B2L2mBHEFWOiM8
	 DY2HKrsq4V1JuWnEsmZgJqf4oiGXm2f6y1ctmC4YVK1wrWtnu87xkDjGaeVrXTbSMv
	 wAZRPpZPkooi8vwXxzBCjM2uHMPtMrOw0t6GJBj1vOTaZ8ithjIrFCvU4Du9SZojvq
	 /P/ytBHIW2qTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] rust: pci: remove request_irq() and
 request_threaded_irq() from Device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260811233952.3000968-4-dakr@kernel.org>
References: <20260811233952.3000968-1-dakr@kernel.org>
 <20260811233952.3000968-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:47:52 +0000
Message-Id: <20260811234752.891241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Remove the thin wrappers on Device<Bound> that only forwarded to
> irq::Registration::new() and irq::ThreadedRegistration::new(). With
> IrqVector embedding a resolved IrqRequest, the conversion is infallible
> and drivers call irq::Registration::new(vector.into(), ...) directly.
>=20
> Unlike the platform equivalents, which combine a fallible IRQ lookup
> with handler registration, the PCI wrappers add no value beyond
> namespacing. They also introduce a redundant device reference.
> IrqVector already carries a device borrow through its embedded
> IrqRequest, yet the wrappers required a second, potentially unrelated,
> &self receiver.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811233952.3000=
968-1-dakr@kernel.org?part=3D3

