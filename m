Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7B40C5AE;
	Tue, 30 Jun 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823213; cv=none; b=d8poj96187ogpL7KAgfUNi4uj+ZgfXYaCho86LZY5DYSQwvE4jSCx8JHKkugaLehLRTmFR2WBZk2fbH3g0XzJ16S3y7shFwxZ5k8bnewZlMQnS99gGdplcW+ZGmEw520cX0gNyB43KlwpdgyWaFnuLcAMNKZ4etdIIfsMNRArQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823213; c=relaxed/simple;
	bh=uKaCbDGpWr5UKHnGgrDO87OukPxEyAP0AwZqhmrej+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kVEzTX2lWS9Keu1wo97UNLqqZk4PK143VqlGzFBky2UjDkRC0OH3Oz8QCh6sz2MoRyRIIunTB7mdQlzP3pgZ6oRddEcyyyDDlZJPNpitmBXfSZlYeuUpzcjMPzJyEfRWZX/E0jJSbzBoROEdM2qWcnVYz+2LLTm4liRn0AyGPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUdiIiPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUdiIiPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF841F00A3A;
	Tue, 30 Jun 2026 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823212;
	bh=uKaCbDGpWr5UKHnGgrDO87OukPxEyAP0AwZqhmrej+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUdiIiPupylxAEryQUqh/oTtmWH41ATcBpPUPly+7VRm1yDoidgmy6mktoTVglH7q
	 lCaqvSzRBoETfutMr6ueHJ7jDW6YIawqEXun7ma9Gs47539PZPgrB9nlnQCL9WPRrP
	 7DKxNmmQoEfqNvOPn4jaj21G7szJdYZXETnd823u3TsjBjRWw/XiDt2WL3V++87/g6
	 woFbxDL5+Z573X6aCkmU802d9b6iEyt5TziDkYdH37Our0bYxe7oc49DYXs49t+4XF
	 mtkiTIWDHSaI9XyK2ok6vi4fnst59UuVcEHXCI3sYGVQUpG46gcuq2ElOkUdK67Zgv
	 Esjd3JfQtW7PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] rust: usb: use `Option<&IdInfo>` for device ID
 info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, robh@kernel.org
In-Reply-To: <20260629-id_info-v2-4-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-4-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:11 +0000
Message-Id: <20260630124011.CBF841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> It is possible that ID without driver_data will be passed to the driver,
> e.g. `new_id` is used to dynamically create a new ID without data.
> Therefore, the driver must be able to handle the case where `driver_data`
> is 0. Thus, update the `probe` functions to get `Option`.
>=20
> The current code cannot tell if the info does not exist or is the first
> entry; however this will be achievable once the code is updated to use a
> `&'static IdInfo` pointer instead of indices.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D4

