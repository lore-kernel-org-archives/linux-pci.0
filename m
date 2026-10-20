Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515153;
	b=e9F2eq8Gd4y9MH1yv75ynKkhFZIuUi3JnEo/uJLBH9I0bpM9WqHXZocfU2sQiP3zGFnw
	 Mx7T4VC46KsKtltVVfNKJUK9iO0Uwrtc5ni+D0dJW6PqT4kVEJ8O+VYJxPOdRnwl6dw3U
	 CeU9Ei2WxhhRWW0e4pw0uYbbcl0/lA/k3Wf5fIBfTVo0QaHeR1kmb1arlAldiUiRb/ex7
	 gaicdhEMu3osZLHzeOfHv5fO7Jff4ZJaELI3w1wdvadpUnQwtcQCIpAA5FGqsy86G2Blc
	 Opk3jpVyUswfgAuk/KB4vu9QI30JWDkN+t7iiC4xRfKctpCq/U4mVELXmKjZvZ+JUNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515153;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Rt0zUPmsZBDr4u6HGmjEAGMqawHcJkNqKKDZ6PeFX9Q=;
	b=lzYbb7yiiOSN85hPDWKcSktij2ESJ27OB7ECROzXb7pw8XyouqiVtcgEJxhmb87PLQ5a
	 TKqAd2Ui7wYQk+DOHdAHUpisjeayhgDvhlL+QR1QwAnL9s/B9q7UiTnLyK61OmGDH+wyn
	 ldiiQIOMaPWbchjQ2ZSXzclSqkUaurkSq+sxCCDd0MkCwC/NHfiCm7HDs4Mej5KiNcTEy
	 6OxNyVWavlhIZgutO0yeTj6t8mTZJFS1RpDwVXuTEJKgptna5AYySkU7o4AQOwcrXIuSF
	 WDALRds+CgHh2m5hLP0ZkpwJSeZ91TheUv7UFyH7Mg+jb2LhJBHL7VL/y10h+RFdciQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0860A2629
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EC71F000C9;
	Tue, 20 Oct 2026 16:52:31 +0000 (UTC)
Message-ID: <sashiko-outbox-179382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] PCI: Link a virtual function to its physical
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>, "Bjorn Helgaas" <bhelgaas@google.com>
In-Reply-To: <20261020164435.80499-8-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-8-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:52:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> With a PCI virtual function having the same bus for its parent
> as the physical function it is associated with, there is no
> explicit dependency between the two in the device tree. With
> async shutdown, this can result in the PF being shutdown before the
> VF has an opportunity to shutdown.
>=20
> Link the VF as a consumer of the PF to note its dependency and
> ensure clean shutdown ordering.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D7

