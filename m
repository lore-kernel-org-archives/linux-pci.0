Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843362;
	b=30DuVaNfsxBkv7EnbBncM5AH/eCGXwAFxDevizQ37xT7dY5irRplbavAI5Ks9SWXlwnP
	 VW1k+iTWu+nreAoQb8XxpqCqG124CjrhPjJi2BohC10C1tdQzNVWWNfm/gvRXeSz0kyL4
	 v6VU1leRi7UKCOErstL8f/u3vyabupR4cAt306Kvv3XZwqzBzKniDnh6Qrcst+Q3XMgT9
	 lF4ZvRk0awc6Z4fti3tX8i8GDzQuN4edtRVcrN3ZJ3YP322SnZ8pU2jYPn32rvXs+uaa6
	 MB/XfPswaAnaHtTXBY3ko/TNCRwM8BM2GCQ4IhTD96E+fNk+ELpR60lz2rqw/8R879w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bVCo77IoHOKCQJ8nc9Xbd8n9hyj3pTyezT9sgdKidAM=;
	b=vxggDjuLazLPJN5g8IoKErAgxO7VJyAZJhiNrsTLZh4cQHZe9cPtLcOfyCJRFCBwQWyg
	 pRdkSV/c3AbwWEmQDL0b5WfZ9TY9xkWANLMF/VuJFTSaKUpnR/jMqi9JDjhup6nXgB4lg
	 JM660e8I9yAX4c1K1+oe4RAOiozn/wItdf+B2cD9ofCbEUyxb/cd8L7QmZjEdPuc3qtRM
	 cxxZs+6M5xl39sXHWxASZP0mKeJHFheKdApy6nnjQaYl9OtjEJi8j5I89nK7ycPmIpgUd
	 YV50yj1kEA4woH34Dj0OdBRa42qTXHB9Mr3rJ2ReVFcbkdGBPr9pKNWb/0AYrMd5MZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDQ2AeoF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1E606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDQ2AeoF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B16E1F000C5;
	Mon, 16 Nov 2026 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843361;
	bh=bVCo77IoHOKCQJ8nc9Xbd8n9hyj3pTyezT9sgdKidAM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dDQ2AeoF2mahj00GtGa17ZC7wQ4ozeooRtylsLvJb9ovcGq7woMrLXR01lZhtFnFA
	 cQLFrffeQfJcKkU9ghEbg/du9eo6fx6wmXEkQUXlGi5fNt2b2lQ9Z/c9yk42/Quxnd
	 2+HqyN7w5zaHIcg8PZrUzyiIEt9QOG105RAPjkvTZxd+aeN6E568n8fdhx6xYQj0PO
	 Xqqurylv0JO6M3BEJ71tj7ErA1SH/ddSTyivcwnZU3BhXhYqvmfVIQCAnNSi0lByL6
	 4ztS9vYQmGGJSaHf7XdYJTks6F8V3OWp0sh5enqwG/hyQZ+ckTTNsCwjCiA0UBvCaw
	 nLFZmZ75HtMvA==
Message-ID: <sashiko-outbox-217298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] PCI: Hold pci_bus_sem across sizing and
 assignment entrypoints
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-5-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:36:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Bridge window sizing and resource assignment algorithm walks
> bus->devices and insert resources of the found devices into the resource
> tree in many places. In addition, its internal datastructures hold
> references to devices and resource it encountered while walking.
>=20
> Most entrypoints to the algorithm do not hold pci_bus_sem, and
> pci_assign_unassigned_bus_resources() drops it before the assignment
> phase.
>=20
> pci_rescan_remove_lock is not held by all callers and cannot be taken
> by callers running under device_lock().
>=20
> Protect the walks by holding pci_bus_sem for read across the entire
> sizing and assignment operation right at the entrypoints.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D4

