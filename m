Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B853B8D76;
	Tue,  6 Oct 2026 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276725; cv=none; b=YnF5GbGPcXjnMXWx27CgJqAZU1EOg9fXo42IG98mlLe/nKj0W8c6Vb7sOsWiG4MdWDmQnKZCufUWAqMMOEKKUJnrQY47jL4V1W2K0VYikiDL5paF620UdpU9Q+M1kOVGLier4z9cMQa91WosGnNgR4CVysOCDEmGNwpdmFzY8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276725; c=relaxed/simple;
	bh=nstWVcTqV0H6SWThC4a0vh7uEOhkQuu7qD26fSlOK4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oNaZMMVwtAsWDzqSsjV3nzMZVb4KaTW8TBp18cdV+Zd3xFL11e4iWm3kScpw5CsXXjo9m3hdSc4oHgS2iv0YkDh8cjpZBjDoWv5AqLjrVSdN7mfvkVv8MyfsVR8WvcMVVXNPvWEX0KyIeqRyH7KoPc1aXY9bqon3hDx/NZHmnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAm2YogG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAm2YogG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E421F000FF;
	Tue,  6 Oct 2026 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276724;
	bh=nstWVcTqV0H6SWThC4a0vh7uEOhkQuu7qD26fSlOK4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nAm2YogG5xVaiu18lOPBxM7eXyeGr2yXVgjrhkIYE9JOwdlDP/Lkg+yHTBy7z6rtj
	 kqEZYXN1V9c8lCU0AVwWG7d5aW/NlgnLPIogyyT9OgwS+0WaQYSGiMinSsQplYuZDb
	 zDWkAXcnZVvDU5nozNf6faswDllOVkM4nl8JzH1abaCO8DyvzEfDcPtew2i+oAFrbj
	 v4ul9nK/BwBEhe3BwbmP6vR6CNM5vFXHoU1bfmZoSKnHYPoOQi5p651hEjEEL2jCH2
	 d3l0O1DOum+IOub2H7E7z+e9+ZoqnbgMSzS6La5uDVR9zSbe/F6J52vVfAYvMwP8SK
	 O8KK7FxjSLBYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/18] dt-bindings: PCI: rcar-gen4: Add optional
 "aer" interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261006084638.3821710-5-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:52:03 +0000
Message-Id: <20261006085203.C7E421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
>=20
> Keep the fifth interrupt optional so existing device trees remain
> valid. Extend the example accordingly.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D4

