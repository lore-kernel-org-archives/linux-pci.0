Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127907;
	b=ACAv9s3a/s4xpIA+Vzdo3eoegX8BnQniUCPzCEiJnd/R0BlKK2uM5ByUSb5e3Rwb737f
	 jOtDrSeOjqiUCMOJW9Mp2eGStgJHtz6lg31+Y4Sbf2puTVQsseepr3kA/5hBU4ebvJMMH
	 qW5jFyBVRwlVVN/d0YoDwZ12PcZtwngAwVo5mMBVM1ey65YIF/rCoDmJNMQHcJQ6DeLyZ
	 h1rg0C4uhqKbAbqIpdsOpFOHvqJo+RvJbp96JFfBBUez6Td7eZJdiGnhQtrS54Di+cF5t
	 gR4YYyVpXoom+sv94wWEoonrDBEFhbLouZZ6agf+1zJKvRDoAl8ScklOtrSqxDl6a9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DHYqZQ7qnyHlDOThqVZwT5h7I/K159982q3EtNlVEdc=;
	b=xT6ZcWpWF1fmQk9I8L/a1IAh7LPpl58LVzrvRwbUsiunzOrhhI6TNTkB6ytkRbJBdHf5
	 Vy9f/PPexjsqzmG6UtQahrYIijmrPEyZEw/2Qy2Wnv0dYmXT40VNvdJky/upUY4w0G8Cx
	 dyaYusT+dbu3/O5N/+l+SWoQAwdr8sdcwyXy8d4uX/6DkK6nkA1zlLhJXyGWtbk7lVqz0
	 lIa+2WO/c9iIt1oU1lXITdoo9l0wwJss/GHVjZ2m7JiXu4JD89gzy0ldo54bvIIUj6FAb
	 Ox4hI+3eIOMvA7jM8X9Peeb+FEOHE0g5RGQp8WP91fftN9HJtCtG/Xj+rKi7J9EeApQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4tFVOlY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F1606A335
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4tFVOlY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FFA1F000CA;
	Thu, 19 Nov 2026 22:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127907;
	bh=DHYqZQ7qnyHlDOThqVZwT5h7I/K159982q3EtNlVEdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4tFVOlYqeJmQwBRuSrBH0kYyOkjyaazIwaH449t9MzpRXiNpBAe57kv73+1mmTL6
	 yVn6P+zExGqxtSajzmU5JeRc2dQJvUnqNzH2egTk3n2OQyswD5nsnpS49mqTo7pCll
	 jMC9w0NO3eCCZu4WwaOdlOxt0UXU9VAcqoD94yV2yeiP1txiN0qUpQpZkgXY800HPF
	 7IfTaCaBCApTKgxFW8/wihBDTeIxi+Xal3v4Xy20YO9opNCgj4huIppb5mIUGpqUsY
	 kJ6B+g3FaMP++tTiMpZ7f+R3wOvxBcR3exZ7QEHB99rUkHxnxQfL0/XRw35vBLCnUP
	 2W3d2VK92Gq1Q==
Message-ID: <sashiko-outbox-224139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/13] PCI: liveupdate: Document driver binding
 responsibilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-5-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D4

