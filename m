Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0B3DDAE6
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342412; cv=none; b=mKP/K2Vovv5brSfiKis4Ehlk8vqZHfVZhS+kB1EU0obIDga3JKFAMLg45YrBMpooxXo0Eg72wgiYfJT2VzQr/6JzFGq7DyY9RFwv/7c3UMf+Tjeq6vhc5RlhrH+8DkbY6z3UtfSRx7crr/sglKbOIHZ77AFJ+vzxr3cioVK1VLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342412; c=relaxed/simple;
	bh=kqPfdoQL3aLX9bpfzPt+4+mrGjAKeGVe23iF4eebkyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G1gHxqZKqpNgQTYzUKSmG4HCI8G93f3WhyyLJtyNKh03dOAvqtmr7BQRw53DjCaeKBzI1oOX90HF1eCuHKr7xKhbjM3ESW6hy975E2ulAVYsrue5jDJfOQBbdC2l9/PuZEUk7UJlDlQGGNHsbAsAwdYng9yTzQM++tGGMhiOhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPt/TvY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPt/TvY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB52B1F00A3A;
	Mon,  6 Jul 2026 12:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342411;
	bh=kqPfdoQL3aLX9bpfzPt+4+mrGjAKeGVe23iF4eebkyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VPt/TvY5ghEDqeNBgOkvGfAZtXn3Tk7RPEk5bRb90BichhFn1o4L+xnT/819mQNJq
	 zgwuNY5rAGMb3Td3A2NaEf/9kV1iD8F1e3a18DIlbSGDy3Qbc9QS/Ox3rWLpp48TXu
	 YbmztEAIRdj7YRgFmYtNUkqbloaE12lPQ5Rjq5fVVhX7TuSn3KdjwXbo5uac8G9XfI
	 i0kJIBkhrP2gEOmwHFH4mKsoF+l2G4HJCI797GQsMaGF3hvcD01aDmz5X6pFVEN/MW
	 2ibLHceOYdwQqxhHiliGgYJFi0GPsNhpYp41uAKzi8vNj7KCy2OopX1iq/J00LjsV/
	 wfM9ai1CAjvnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/20] rust: io: implement `Io` on reference types
 instead
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260706-io_projection-v6-4-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-4-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:53:29 +0000
Message-Id: <20260706125330.BB52B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
> going to change with I/O projections, as then `Io` needs to work both for
> owned objects and views of them. Views are themselves reference-like
> (however they obviously cannot be references, because they belong to a
> different address space).
>=20
> To facilitate the change, change `Io` to be implemented on reference types
> for the owned I/O objects, and make methods take `self` instead of `&self=
`.
> When I/O views are implemented, we can then naturally implement `Io` for
> these objects.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D4

