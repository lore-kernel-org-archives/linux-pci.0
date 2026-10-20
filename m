Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514896;
	b=V6GAYClyIzk0s+iT30YlVql9jwRyMtpVVpweowiUzkgbwFv8H8Qpjx9dapJLJJECVk1D
	 LzLt8B35nx2f0om6Xn3So8Tgt2AlYS9BE69dvX/6WeDEtk1Pqb8U5dDXJ0LBxJT1mcv26
	 GAkEM/qI9x9i3FpRFVpmHQYmiyOq6j/b6GtG1RL+n/RtWxDIulnFn/MuocLA/LTV/GOKr
	 eS758Lb1QHiqgZUGjB0nWOCIeuwLhTdzhtf2Sdl3ocRiMazTNNHL4ZVICPai0R10faBRY
	 K7l4oGoTbFjy3eci9Um3qzQo5vtxwjizHdN7gBVU2vQSG2vBF3v7/G11Alr5qTX/jmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514896;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z1SzUBquWHQZ3C1Z4lcH1uTSKaB93rIIgbHYk7esgOk=;
	b=jVD5qUI5wkjzDJ3hIX2qANl9ChbJmBh4nBRrUw/B+iQJqL8QXXs/zbZvr7QbGvD+ZzYl
	 Nt3WH4F5HMsCE+MRsC80me6LSOzIKKz6Ug+tJZBaT213LrEmNvav/H8KwnR0mOfz2qKvE
	 qgAlRc8L1jOtWNRDWrOH4seWnnKKzjBDClKbDUOfLf0EFmVZ+ZFqwe4nm5Nauol61ZevY
	 F/ts0PB0WAGdOA8FvNqrU+kvWbcd7eKbtEMO41j6qGlLtFXTfdhRIYVVQiZLrdiUWAucc
	 6xGqkyMGvoqWFO3DKKRNo0SAO2wGzTh88Ey9RpKdTziNm2e99RedZpDqdIwB3AeE80g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18209606A31C
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538EB1F000D3;
	Tue, 20 Oct 2026 16:48:15 +0000 (UTC)
Message-ID: <sashiko-outbox-179376@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] driver core: separate function to shutdown one
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>
In-Reply-To: <20261020164435.80499-5-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-5-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:47:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Make a separate function for the part of device_shutdown() that does the
> shutown for a single device.  This is in preparation for making device
> shutdown asynchronous.
>=20
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D4

