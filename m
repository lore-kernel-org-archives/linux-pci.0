Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725453;
	b=w/RQsgPAnFdJyESVexzJxzYfappZf6CobDnhyZkKGr3GFMuqY3+1tgfiqkaIN5W6xW5J
	 7EJDs7xg+GhIB1giJrPpzoKCK4421xydyN4P46wUUJBevsT7CrEIls3FvojpnkjEgCOMR
	 9ar+wMv2lcp8iuU5IZ/7nMkJ4cPvs7XHNQ3llMEHl95B9xhHXVGaj+ATYinL99yCO2FPs
	 ez3kQdq5E/WP7KAg2ncoB3IR19LhXslaoxM3PtOCLvq3mFgTMKXqwrBbo/+hQrYjKN9jo
	 bzBsho+jg+fjK0uKC7e24RItd/yOAiucuXkTibX6PLhuHCZ6rj7MhLv02BYou+23/Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G0Jj71pPEItT6iHIQASIvJnu2aBimqH8wtBodeMK+Pc=;
	b=C4UemByQHxJgCGveFNQrtw7fTk1w0wGtShbZo2XRd3XqIwL3WOl9iy+I427lw3bF/xRN
	 SjYwDYEHE34Mv61U0d3kEc5PPhKYK+IZyfuf9eHexnFNSZMpg/Dkj9B3FeRj63aukZzN2
	 raFw2EI4H/sQckedQ5hH56fUT0Xc2jMU+qvpL8lwWXKNuCBlj8G5YAZCX6xqFtwfXqTbU
	 bpzYS8wz8YLxpNoGtfCAaE0PpiBC7fqtj5zOP/gIj7KNYtdAkiQSTzNZJAkxA1Hbpoh+T
	 syIECObsU07LHI2N39JBCPV0ucjFURaEIafLpnjUBXPIGNDZBrdQu4kJstShtuCTDlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYWuJkjP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0238606D83B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYWuJkjP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5591F00A02;
	Tue,  3 Nov 2026 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725452;
	bh=G0Jj71pPEItT6iHIQASIvJnu2aBimqH8wtBodeMK+Pc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BYWuJkjPP0m3Tmhih2wNhHBKogl5/219nN4VEQFLUi3QNboiX2IwigR2X9SJVJz+g
	 klhBLAAi7Z/b2g7JR9Ks041Vwn4tN70drZ2vNN7wXiRmKr7cK9of55cnDa7V7bz4Kd
	 7UXljEkeIehlIW19ZoWqqRqhKcsJg+nDfelxJHNjsUw63vLj/fGHqDTLlTpaR97+lj
	 im0JME3RLaY5O+trb9zQlQ/zGmRjfNGXvuvpiJU8AwgsxahgkT0TF5DAmE8obT1OUf
	 cXlw7SOx2bKhX326wE/0mMPcmxnBOeKI0jAllje+0tai4xG7VemANCILxjkhWCPZac
	 NSAp28VUQa2Ag==
Message-ID: <sashiko-outbox-195771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dmaengine: switchtec-dma: Add Gen6 secure device
 IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261103170033.471034-2-logang@deltatee.com>
References: <20261103170033.471034-1-logang@deltatee.com>
 <20261103170033.471034-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 17:04:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the device IDs for the Gen6 PFXs and PSXs secure switches
> (48XG6 and 64XG6) so switchtec-dma binds to their DMA functions.
>=20
> Based-on-a-patch-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103170033.4710=
34-1-logang@deltatee.com?part=3D1

