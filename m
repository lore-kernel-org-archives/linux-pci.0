Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515777;
	b=UqKYvLM1hqopBIsgeqeDKMjrRRRfBtBql+aFbPxcqwmtAiDNbMNZt6lJSSfAyIheqiId
	 5bomZSaq8fCk5qM/64sQfQPiJHdHd3nHo7nhuwPFSBvQJNgDvEHOZtj48suRyf7MTZ/dO
	 1w3NlszN2Y/HWzYNVrbppnENiVNyF2TyhroZ6myhe95w7pEWZlI9sYIrgJyywF7X7lS6v
	 Gs13sUO7daxMav9P20u98vXk0CBQ49g2sEcZG/+dzUhX2RhGtBz7DeTI2XmG2ou+o+CtX
	 ZUQsFeOGer0N7XnJAYKEGZqFVTJp1oM1Jrfd4rgU0z9l27p3IcpPgZTp0jLxLOC2oww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515777;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OxKbMULqyL6GdMaTQ306wA89n00B0e2k4XDUS0QG62o=;
	b=zCxR8dgY3MoJEaYf5IzkdgDqMcXS5nQZHehTRkDCbXMhIlz5QbZ73i7pGDXpv/bpzKCb
	 YGHMjUnd9nzCIUNSdl18yhGqyI2LihVOiybtQPCfw0G/LAlCXUBsb3+x5YbrCizXlhTzM
	 ltemgE4yTWSGxsF95MgWLOAib/ZVl9d7w/DEVNO7VsRi/RU0sQ5oLSouFraqRsNkV6LvY
	 lak4vyNIZ7WwHvnUBUEZqb4bBtQ1/iNLY0ConwbRYyjVp2sEZldHPB/2ZqnWaWgVwGEG9
	 GB8BXxCI4A8OVqh7wVCNiyGIQsc59tQV/lBf3iFwAAVIscQ2W4Z0vC0gGvnuisa2upg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60964606A31A
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 17:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B24B1F000C9;
	Tue, 20 Oct 2026 17:02:56 +0000 (UTC)
Message-ID: <sashiko-outbox-179395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] driver core: do not always lock parent in shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>
In-Reply-To: <20261020164435.80499-6-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-6-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:02:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Don't lock a parent device unless it is needed in device_shutdown. This
> is in preparation for making device shutdown asynchronous, when it will
> be needed to allow children of a common parent to shut down
> simultaneously.
>=20
> And only acquire a reference to the parent device if the parent is to be
> locked.
>=20
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D5

