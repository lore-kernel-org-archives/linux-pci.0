Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F663803DC;
	Mon,  3 Aug 2026 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774958; cv=none; b=IPbijTRcnk3Icj4FIi2CTbws1eVXWMwMdpOY9o0zaHEL2ihwBQ6kDWWPI8hbCc5mqAez9/ZFgXmxTfH/8YZEv+RQ5KnjGPLw97SZcimxzbot2uF/e/ofuOJzWrHw6kcWERendtSdm7y2uB9opjWTh//C7ehqPJ6A/kWFSZ5dTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774958; c=relaxed/simple;
	bh=qV3sjAtAJDYHMCCEDv5fgRP7Sb7VlyMUOaxfU1aLFGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GE1VPb+z+dJlwZ8Fq9k2Wbp0ykSf+t+9ngownB6kjrGyPTq/DRCOWz3zu1lCAPPR3P/8EYX0xmi0xc2J6tHlhuMIMNxoZowodSeU+xt5Qw/InYxW8T7273D/l6u5UjbOQ3CamVf5cyzcAQcx8Qd3lUIE1DgrnupHHg+n/PuAJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5aViUc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5aViUc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110CB1F000E9;
	Mon,  3 Aug 2026 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785774957;
	bh=qV3sjAtAJDYHMCCEDv5fgRP7Sb7VlyMUOaxfU1aLFGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T5aViUc6iBiZA/SGXiwSEij4hmTGrkRcmMWZriT4P9qk2aBYxgcYaeTifZCmYt2Mr
	 K3RxbFX8u+Vc5SHngPfja0I3GDl48k3FqHDGe/4DnwhmH+8gIbgPyb3YgD48jro0aA
	 /Q2WC7z1tBERQzOn6scyvuse8F27jTh+F1DMeVcSN/4w8vY/1cotVMFmqNRtrC4GQP
	 c7cJyBLdDc0RUA94n2Fc25LBx+FSRBk9uloUAAtjq2VrFGwnUa31NnhXqgv+ZW7N92
	 Of1UqQuNi23L3w6z8rC2ez3beqawyTLKP5dWPuh50ytZ2+UAsSvyTuRcpxYv9EZJCc
	 7fVEFk6JJa0Tg==
Date: Mon, 3 Aug 2026 09:35:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "driver-core@lists.linux.dev" <driver-core@lists.linux.dev>, Alistair
 Francis <alistair.francis@wdc.com>, Lukas Wunner <lukas@wunner.de>, Donald
 Hunter <donald.hunter@gmail.com>, "aik@amd.com" <aik@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for
 SPDM
Message-ID: <20260803093556.0ef56084@kernel.org>
In-Reply-To: <SAWPR12MB9992679DEB9AFB41A21B116FDBB0D62@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
	<20260705220819.2472765-2-djbw@kernel.org>
	<20260721182046.16219426@kernel.org>
	<SAWPR12MB9992679DEB9AFB41A21B116FDBB0D62@SAWPR12MB999267.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Aug 2026 17:58:06 +0000 Ankit Agrawal wrote:
> > I don't like this, sorry. You need to come up with something outside
> > of netlink or more netlink-y. =20
>=20
> Hi Jakub, picking this up and continuing on with the Dan's work.
>=20
> In an earlier discussion [1], two options were mentioned.
>=20
> > Alright, so to make this more Netlink-y you can either:
> =C2=A0=C2=A0>=C2=A0 - delete the F_MULTI and replicate other attrs in eac=
h message and
> =C2=A0=C2=A0>=C2=A0=C2=A0=C2=A0 add an offset attr; this will make each m=
essage in the dump more
> =C2=A0=C2=A0>=C2=A0=C2=A0=C2=A0 standalone.
> =C2=A0=C2=A0>=C2=A0 - keep the F_MULTI but object_val has to be a multi-a=
ttr, and then
> =C2=A0=C2=A0>=C2=A0=C2=A0=C2=A0 we have to teach YNL to correctly append =
the attrs. =20
>=20
> So I'll update to the first option of standalone messages with an offset =
attribute.
> i.e. every dump message with a new offset for the chunk it carries and wi=
th
> reassembly left to the consumer. I suppose that aligns with your preferen=
ce?
>=20
> [1] https://lore.kernel.org/all/20260318170014.6650d2bf@kernel.org/

Yes, cleanly building the blob in netlink is going to be tough.
First option would be uncontroversial from Netlink PoV, AFAICT.
But also please spend a bit of time on trying to come up with
a better way of moving the blobs.
