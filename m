Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515286;
	b=OwEz7yWb4uxmBjo37rWpYnle03bFndDbNhlgpcw29B9aipNF9LYxibUFdKjTyr4r88pE
	 hGlrDbBT2iceoYJXb128D1zTKWPmvfJH/DtDlKloPxHeRiX3wIaI0PNNu32s9ikvEufHv
	 WDtcgDaH7+GBnnd6JoOAJqYbm4UM/5eW6Hx2VR3WQV88G6I4kMW2BIBOnI9pbNM12jiDQ
	 0ldRd05hF6yJqJtRTzys+I30XnSKpMX92JGn8+13ViSs4zke2lCHKEUtXcnb7//wsWe7/
	 sez51mfSAcRzFD2JDRmneKBW9o/7dWWf6NxhfLl9BHZrOs6up23xaIEjkj8K6XWrHJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515286;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rUsaUhwHeiQf3xBbIOzTemfd4ixtkr1Kys8NIsISdFY=;
	b=u42K89bDlV6zOyatGdMC/oHqjeij/DT/vWhLFkLQ85Ee68HjkgU4PIl66w9JlOdR+frU
	 gJlqKEILlZNF0Xjy2Pva6XJHlhMDSQRXX9wdufjeZ6mgo+xYdByLV6MOVtVU/ULMNUmTY
	 PxRhNnEAORe7MqRdjPQDq+0X6iRrNqyKn5VLkKd34u3+jUKpVSWQrzUl2Cnlt20w43vrs
	 vsl0GqujRA+woN63MVollq+1l+qH8T6n26dUaqiRZYa5DT64DvW6kKbUxanVebuLP1bSo
	 wILXVRlYSgPArEOH834x1/1YfmLRUvUouCwSLc6IiksrlU5pQOmx8hwfEliSUZzZK1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D8606A322
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1C91F000C9;
	Tue, 20 Oct 2026 16:54:44 +0000 (UTC)
Message-ID: <sashiko-outbox-179385@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] PCI: Enable async shutdown support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>
In-Reply-To: <20261020164435.80499-9-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-9-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:54:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Like its async suspend support, allow PCI device shutdown to be performed
> asynchronously to reduce shutdown time.
>=20
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D8

