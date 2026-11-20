Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183238;
	b=rIZv9bY/XCeMY0tzN2Q3LPzEJROiO/OF3TRxKYdBl+/o2ybFjT0D1UohcUjYKxObL0gN
	 29aBhhX1x2ipRE1nhWJ2dmr/t02hTDbJ2TcNmXyjdYmIgyUylVBhVpoduMPeBexZrWs8D
	 vE+LHQT4HFMbFzYTUXSXD9ssEbRbx2oCfG4x34hRnOCzWYYhLRXCKb8luRRkscN4kvemn
	 4ExEIO4GjK5n/Z3joFEuRu1wRxOStm8Hx3PgbVOOEX7mCC5ZtC0mLL60h/aL15HzZc/jT
	 AFNDO4pfro5u0Xih3NITNpO2x3HSTtnRrihwMdHn1Cvy7VE2LqKeZCsWdoHP8xNnrKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183238;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NJGKNrZy9YjF1JOL5gYe9tILiY9Na1ifTZ7L7aWe7qk=;
	b=FYJ56XglXBfgSoozzeL+L5ZvuJsezt3h4sNQuFKP1bFdt/7Qeomn+UDek+dQY/0bSfkF
	 SiubAT6jvCxdoY5V5sgLrcR3+8hjtBLZ9NNQ/by+A8cRgP52GPIk4RqXsyA7uYfHyoC4Y
	 +hoMycCXTvvhK1fyPgylcc3qYK90/TkLi43dHxIpWfyFID0Hb/TdNQyOiuX+BOGEBdVcy
	 LZrYnDkF3qkbivSK/daTjBXW5lYFjfSAvfT70qVz8Fa90ty+hUChMnuqru+ioU6RR5YIe
	 lBnWUY12PUCqZ1qIA5ZRCQGyxTdkhKBTPt2WBO5jouEUK1Gs/MOCGzCjtgqn9IVN5kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/1zBi/M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4F606A325
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/1zBi/M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1070C1F000C0;
	Fri, 20 Nov 2026 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795183238;
	bh=NJGKNrZy9YjF1JOL5gYe9tILiY9Na1ifTZ7L7aWe7qk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=E/1zBi/M3rT/LrZG41UH7I2umMLUpg/A1fTZf+06vC4MOhXq3XWXLlyF4gKHYGndi
	 v059wLeLdwqe7HS937VAeHjoK/anuPUBOauH7Myt4/J5k5ggwffkcCZWPwbDmWWEwP
	 CEwin+SmWpz0m5wMG234nbUny3qL3aG8RH9F3Ae6cZX4i9Dpxylp9nI2ypuxkgtcKl
	 HGhIxHftcSWaoPJDsoYgjybfYKJ5e8BugvZK1MxMat3cIu7U7+eAw2ZXi99Yck4irg
	 msP3LQMwtrA/nZL4HCh0zP5fBuQWbrbz/ZNAObyI+A0X5pjd6HGYGQeDizYMeaIh+n
	 vEgTap31yXS1w==
Message-ID: <sashiko-outbox-225312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/16] PCI: Serialize bridge window sizing and
 resource assignment
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:00:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Bridge window sizing and resource assignment are started from multiple
> entrypoints: rescan and hotplug under pci_rescan_remove_lock, and BAR
> resize from sysfs or driver probe under device_lock() only. The
> entrypoints hold pci_bus_sem only for read, so nothing prevents two
> sizing and assignment passes from running concurrently on the same
> bridge windows and BARs. E.g., a rescan may assign a BAR that a
> concurrent BAR resize has released, or restore a resource the resize has
> already assigned.
>=20
> Looping BAR resize through sysfs against a rescan of the parent bus on a
> system with a BMG GPU triggers the add_list sanity check. The rescan
> sizes the Downstream Port's prefetchable window while the resize assigns
> it, and the sizing values overwrite the assigned window. The resize then
> programs these values into the Downstream Port, outside the root bus
> resources and overlapping System RAM [mem 0x100000000-0x4075ffffff]. The
> [ ... ]
>      pci 10000:01:00.0: Failed to resize BAR 0: -22
>=20
> Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D7

