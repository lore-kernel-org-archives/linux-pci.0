Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444833;
	b=ESAxPqxaARXLemMZRuwWKUr9avFVhusT+Ef4UDXbamtp2oeaM7khQxURdIgaYRzNtaGV
	 eYEzCIUkxZVR0qRPPDDjR7E/rn9/t2+LaFypUeqqFGcDSiRtsrgg2pr0TsxPVoNvmcsa2
	 WvxSa+7BWxg5/hLkCGC/WkqwvjoozII+xiXv1nlLbtK6h7Jh1YLu636PmJKiWgnYkznNL
	 2rVPjsYgaAgwWyKkG1sjOtJmwxjlPQuNyED0xhen9z7oiuqvbezVCfl8OkGMzF2EagFhg
	 Y6m7/RqeqgrQkgBNVOCiY5unIaDBOsZ4DNXCA8Myg/da2ctCvHwpkNX51d+Vb4qrnhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444833;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yKK3xp4e2htivC+R/xoCUyIZYMrNYl3B0gCGA2xTohA=;
	b=RhOsrYyqNG2B2o7HGv4vgNR2iw2uyNIwZi+l3QQCqnETUViTbMwoVUTFGUNDTWPQIyPG
	 vqag1kcQSKKyQnurS8vleRFq/pi0WVfFiUz2GoIxQ4sHFyPoglN63pmg7jZcGZSR5pbml
	 eldoRno37CR7JzM6dk9OgxXmptwCnYXytMPj+l+P9avCacK3ThJr6/Vo6jO4dlxfV7Pbn
	 QIZHxC9rFgQkfHaOBr9HHt0kufr1q4uJTIS+rmI0ZT+buG3Ph5MHmP5XMYDmCBttPc6Q+
	 FM36uHWlAfn446hGa7f7aKp4Rsu8MIQTo7SONXqN5XP0e3o+g5wcsMUM5itrr8cbHsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxLOQReG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522D606A321;
	Thu, 12 Nov 2026 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxLOQReG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4621F00A05;
	Thu, 12 Nov 2026 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444833;
	bh=yKK3xp4e2htivC+R/xoCUyIZYMrNYl3B0gCGA2xTohA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UxLOQReGuyEB6c1hIYkFhtrx9wT4oGSI9Lg548gDqXbG4BRsgE1k3xol2qxC9h7T2
	 TuCpBu/EJl6Gg8tMhgzW+X/oLgGuQqz4Jt3fPGbZVqk9a3gstHTggYu5xysyOi8B17
	 R+0aRYYE2Acsd+BYrnPL8dPwr6MmnjMJTLB17qkm02hnLZ1xz8US7iqwonVWHDvfSq
	 RkiNX1XKiGEo5NaCPodJC1vYbsMdfcTHbxBBwyc4QWVBjG7PJOsfKM9U3twW8d27rW
	 YlNBfykQW4m+61x1YZOhaZvVIzTbjTkwZ6mquELjZmMpjv3Fl9w10KFyMDb+U7uRdP
	 rZJNqxnIr0wFg==
Message-ID: <sashiko-outbox-209999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] PCI/P2PDMA: Move CONFIG_X86 #ifdef out of
 cpu_supports_p2pdma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: virtualization@lists.linux.dev, linux-pci@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261111234439.4098-3-pavel.e.popov@intel.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-3-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:53:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> cpu_supports_p2pdma() has an #ifdef CONFIG_X86 block inside the
> function body. Put the whole function under #ifdef CONFIG_X86 instead,
> with a stub returning false for !CONFIG_X86.
>=20
> No functional change.
>=20
> Suggested-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234439.4098=
-1-pavel.e.popov@intel.com?part=3D2

