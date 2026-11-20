Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182978;
	b=vSZyG8yljzzpIE5R+q/R6pQESCPaW8x0t5JNpg7wgv8SI1zu/D8K89KBPZLJVEGDf6q1
	 7QmYE08Q++o6LdUqMYP3hQfECV2sXgnN/v1Rwowqz+Cx3aun+Er/C6Q/oATwxdJXTtQx7
	 L6LGMZFkrtKus1oGZTnStygTRx88U7fR5XErwiwUBtEBz6Ex9pf7s90CFh3eBrjnj7Kr/
	 ifg9JvmUnzURnt3h5pH2dDQ3rEymw0MnQ68bz+PQ4g/Bi2p5NSvlnfefeRufH4Dt1tf/H
	 R9wRxPuqAlOrObxwvmM6CJCvOhcWPikJ80xf1HBGlbGJN8kuLtwSr9vtIAGir4mXHTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ay8SdXaNZi1BhDG2igpsCOunTOYfP1K/BZ4o4/DM7R0=;
	b=tefcaw0pEfHtQib5Gt29CHp+wC5vPZVqyO7h8I5TEXccT8o3nwyxRQ/Q/UsExTa6YtKO
	 bKnb7abhnq7E0LHTv0Tyj+V3gKEWvhTqVspwSX40Zd6eW5MVDdfQW4cOwcwty4AYCpApM
	 agQm7Az1MeMQvGpjynKQyTEJuRQT0LsxovAZ/L/YHeh61qOzeGXwEW5Q9JpriVqC5U/N4
	 EvWg5hdcnRfy3shZ9KwhbLMqN1GrOqVdA0Ae5n4TO8t9dRy+moqZVwjvcTKSKbYYhLYyF
	 FowoIlfJxSLB3NwAoXlxKJBpc47J2TirEgJFLvq3DL+mmJlGxtFqttnKzMDa4uIF/HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR2j+U6q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06362606B9A2
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR2j+U6q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC381F00AD4;
	Fri, 20 Nov 2026 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182977;
	bh=ay8SdXaNZi1BhDG2igpsCOunTOYfP1K/BZ4o4/DM7R0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WR2j+U6qE9ZECttWUE3FA/LdPAqQYjc7g+aJAnbhlOQHnS76jbPP9CKBfzbX086Zl
	 LT1AWoaSv8TYytc4tjiTTh1b3DxbXW516uOqjQW+98U/4D1h6Piscjm66QK9Hszh3h
	 A7b3F/dnqmMNvZTQnZRnG+y31zmKqGkiDK7gCq6QX6UW4Kjkkad7Hu+wzK/943V6XR
	 nTiZIlAocbBGlND2+AfaUPiCxB611NT9x2H39dNmUpo07UePL4nUh/x4EXYqCbcpCl
	 7W1zyBEwgxobfHNv5fSUgh8TNGE5x/6F7qrZIXuxi2Y2k/61upKzTKDW+P7kwG3pay
	 PpzS+BegHmUUw==
Message-ID: <sashiko-outbox-225303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/16] EDAC/i82875p: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-10-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:56:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The i82875p_edac driver scans a single device and then attempts to
> assign its resources using pci_bus_assign_resources(). That function
> makes bridge window sizing disjoint from the assignment phase and is
> going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely a no-op in this
> case as it looks like bridges are not involved here.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D9

