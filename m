Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249335E940
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289632; cv=none; b=qKsZ3OAVkpv5RxPhP5ldMdlkLGaEp2AqV6vIHv7DDoOIb7fVHOOggFS98aJe0K8PUkylM4fcaBpZEc703D9hSQiiRfXwMpuc8WOLywW1lnCHcFRiUOhp7pvaeKqnnB7Rv5RsL7EbZG5bZxWJilYnWmcAz3upYfd1unUMAqFcH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289632; c=relaxed/simple;
	bh=1BXeHXwRJjmKKC1MTa+Td5al9i2hSrnUpoxnnOgB7IA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pMbdxDwn00NsXu2f1jVbUGE1QiywgaL/nx3MPReEfZuTe+Bg7RqDVv/WI0svcd0RRZOezpspC56tF8mcII4GRAo4MgWL6hbSBnNFF5pYpscFCjO1AglOrKHTIxrZthXbmWcOsSGD0C2nLCTaUpOXpIgar2ZxdDobkgD173LB2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWNFrmGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWNFrmGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713291F000E9;
	Sun,  5 Jul 2026 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289631;
	bh=f8Y8GvPLOPPmfbU3oaO98oROTjORWHA6bIaBunHTk1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWNFrmGmSGD27e/hOZ/RECJiJh8WJ1NwylESqtVL0rt4rF213ExSMYuMtPV5S6W4h
	 7a8dsKLe6yAihGT4ezSgVWbT2JPwlXGH+aUDppFuFAWjtAHkz82AHVbu5V55ClBVlV
	 ECodvtqHmKepNAAct4N6Oyrhmutd1YRk7IQ9TY5ibsbJAYifKn2gHq2TK6Hqnrh7jC
	 Qi6DZDdwAdAPKo5KEuwwrqENZ0BtmXk474xKYXdX1cSBbmckXccYliVg30CiSeZD77
	 NXa59pFpXQO3lIXSSvDMHbkeDchGaM4etH6JpNq7NzkiojZYez+9K0RR4bjfRDs1hR
	 34LixUffadhhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for
 SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-2-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-2-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:13:50 +0000
Message-Id: <20260705221351.713291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `bloblen` property in `genetlink-legacy.yaml` is missing its `t=
ype: string` specification, rendering the schema validation incomplete.
--

commit cab827e2cbb54e443717f126a29803e1306e23f6
Author: Dan Williams <djbw@kernel.org>

netlink: specs: Introduce multi-message blobs for SPDM

This commit introduces a netlink blob property to teach YNL that an attribu=
te
may span multiple messages. It modifies the netlink schemas to allow YNL to
infer this structure and interrogate the total blob length to preallocate
buffers.

Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]

> diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/=
netlink/genetlink-legacy.yaml
> index f9c44747729ae..fff9d7b76dbc9 100644
> --- a/Documentation/netlink/genetlink-legacy.yaml
> +++ b/Documentation/netlink/genetlink-legacy.yaml

[ ... ]

> @@ -239,6 +239,12 @@ properties:
>                  enum: [ little-endian, big-endian ]
>                multi-attr:
>                  type: boolean
> +              bloblen:
> +                description: |
> +                  Marks this attribute as a variable-length blob that ma=
y be split across
> +                  multiple messages. The value names a separate scalar a=
ttribute that carries
> +                  the total blob length, and which is sent ahead of the =
blob data so a consumer
> +                  can preallocate the full payload.

[Severity: Low]
Is this missing a type definition?

Unlike the additions in genetlink.yaml and netlink-raw.yaml, this property
does not specify that the type is a string. Without a specified type, the
schema validation defaults to allowing any data type for bloblen in legacy
families, which could bypass intended type validation.

>                nested-attributes:
>                  description: Name of the space (sub-space) used inside t=
he attribute.
>                  type: string

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D1
