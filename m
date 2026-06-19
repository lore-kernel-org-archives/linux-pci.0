Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADD3C0625;
	Fri, 19 Jun 2026 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888712; cv=none; b=qO7hnUwnqNhveJEBClK763g6CQPZN8ED3kI1u2NFeVtS0+hM9TnEgNNMFHzFwHQErkabnk28gTlX+m/Lgp0TwNElkUTlQwd8NfPieYTZDBdbXOmEqsjLtU3LsDzxNKXycaKs8n6QyJtUXhU3g6reHcBLmHpgtKIlKknxUOgymaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888712; c=relaxed/simple;
	bh=UdxH6owbpvjotP1H0Mzg0H02heg2damNE4ssLdIzPYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iuehUOamAsWSJrxJFHSGJQuVOwg6kHdD0sSjQNnH+TRD6pjKVXvM7eH2jjPn/p4wBOj6196wUcFhTuTbJ5yjwFQnir7DV5N6T8Yapeyw6xSjbJmrmgsWGT6xAEJY90OVZf6bYWSVaznC8dbKqACoUJv7jzny8cmLpNmPIWVPe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQJsfrA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQJsfrA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610711F00A3A;
	Fri, 19 Jun 2026 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888710;
	bh=UdxH6owbpvjotP1H0Mzg0H02heg2damNE4ssLdIzPYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQJsfrA0QkT9xzcvNy+RPiLvTE8LXeUZEH+57exIl5eMZCuquaqxjukzO5Lp15foo
	 A3Ewaefymv+/KGC5Ot5+DRgsWih6Ujv0/JVVopNyVNK2vIO/tc3ykG7qaCe/6clkgb
	 SUbP48HuSaTV3nbfsezOLGkDXjNf1RKUhTobg1H5OArs65s0a+5sUIeqYAzXtgexjg
	 4h8KyHdZMNxyv7XotI4PCN8qNLHCv9WA8PrlatiKkvgiGZqALl6kG+KW7FIOIRZgOs
	 gLy7ptVsKs8d2zNxRUo31Umh+vuOiut9nViLsG93pUbvLae2bLPLmANuO2zNHQhJL3
	 vUBa90We4dWsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] rust: driver: remove `$module_table_name` from
 `module_device_table`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: conor+dt@kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, robh@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, devicetree@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260618-id_info-v1-6-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-6-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:10 +0000
Message-Id: <20260619170510.610711F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Wrap the generated code in a `const _: ()` block to avoid symbol conflict.
> This removes the need of creating a new identifier.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D6

