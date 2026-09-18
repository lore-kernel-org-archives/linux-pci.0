Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7742C15A0
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743846; cv=none; b=UbAZEvY28hjK9g1BrJez/xT9zug67m2BlCi7pWX+12bttKg6XHntIDL9FPrkczb9AMc37tusN56lcr1Jwf6iec3YOHy6nCiu4mmebS/tcY8Yy6nEke3tluJOin/1hYvcMcKe05rnO3aWaIlT7IHf8JN7uORwTeVtNJ25uCHCm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743846; c=relaxed/simple;
	bh=D/QA9CyKgQ8OTq+lcna24ny+mN6mBKSH7m81OF1TnfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HuR7w3OXbw1wCl0S1MBHhhaZDUqn2FtxGTXIbcUjzeIaiE+VwlGZ3YEV+Bh7N+pB9//pi/O0Is7EylT+C5//TnzMLMO7+sGhWuZExG8KFFZeYKdfAKq8Ewg5qRS0RzeoPBcMv2Ry4EnJKhWbQremlV1aKVKbloCTrHJ+190HI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovDKePFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovDKePFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775821F000FF;
	Fri, 18 Sep 2026 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743844;
	bh=D/QA9CyKgQ8OTq+lcna24ny+mN6mBKSH7m81OF1TnfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ovDKePFx/UILk7WUOlSQnrEnrwO7ggEDYFCF7N4J3NoCfLWbkqIOh/pOhzFMshegM
	 sMe/l86hdyw4/n7cTl2MUp1jGMp/KHPX1HtoQ9im/xvDRGVk89M06DSdZj7Ic3J296
	 Igb+UUBOlBxqXq4PlA6XXwDnUJnjWv5y3fP95EkB9/V91VerOsXJDOfV4MvkNp/QIk
	 ImgWwwYwFVy/fQ5/76biuhrQAioMvLQFFif7ujF7jHX8OXX7b6GFxflwM2NFGqXGWU
	 +vDV2R0Ixg/jYQfTuwgrzgtxul9/BarqF5BU1qsJeLNu+18gZNM5v38STfv7+7Mq/t
	 kYqTabTAkWMBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] PCI/portdrv: Group PCI Exp Cap services into a
 single mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-7-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-7-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:04:04 +0000
Message-Id: <20260918150404.775821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PME, hotplug, and bandwidth notification are all services of the PCI
> Express Capability and share a single MSI/MSI-X interrupt vector. The
> set of these services is open-coded as a bitmask in more than one place.
> That is repetitive and easy to get out of sync as services are added.
>=20
> Define a single PCIE_PORT_SERVICES_EXPCAP mask beside the service bits
> it groups, and use it in place of the open-coded expressions. Assign the
> shared vector by iterating the mask rather than naming each service
> again, so adding one is a single edit.
>=20
> Iterating narrows which irqs[] entries get written. The open-coded
> version filled the slot of every service in the group as soon as one of
> them was in the mask. Those extra entries were never read, since
> pcie_init_service_irqs() presets the array to -1 and
> pcie_port_device_register() only reads the slot of a service it found.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D6

