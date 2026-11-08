Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131122;
	b=IGBSHJFstU2H/cwH2LFkzJpMhL2g+h+OKbqQxdTqe1iKRBuKLWHGbynx+7qh9NuG0JGw
	 t7Up/hiOM1AwBd3ySmo7pfFFeYT7VwcgWAPM9p1kWF6IOLn4DLxu+34DBLuuygKR1lTnV
	 6sWqrB73i53wfK7qdJHs7sK/MEnNuWn/JVM9ntzuN4woRUe1Q+uDuh6u3av/tC342+oOD
	 Ttv1LfWWFNYqQx1Lt/n2Laa4nMz8FiDgMyfjrb7hKRucvVPnHE1fHjeJNHx8xbyTT7Aby
	 2+vPGKaoMWVQneKnIaStXNq+UsQaCaL7sJeGLm3iv9QQ9HBcL0eWoYtq37baAx76pZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131122;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xJsV3eZtA4sfFHjIB01AX6LmMvbYOZmpHD0qy2HGVs4=;
	b=SDbAHZ8Zt2TUzJnVc4RWpHX+zoph0p4vmhE16gIk6od9jLc4GqsWrrPYmrG6B3m+0Klx
	 Gw4Jasa9an2b9sHiz8bTaFn7TQE98B2Db/u/XgdK9EMQj/SPBfIrdiIv8/A2rFAB+gr3D
	 KZX4+D25in5cXEDucwacIWb86FEEc74cwBT2RU2iWuWu73O9fSjMsOI4xCYgLxyKD8fvD
	 bo/J8Pc1JjB4T7cL/WC6wmis1kKcZXXD6kc3iJiXx/lpqDEw6YfwhSnZc8pF6qQNbavDo
	 I9sex3gmwDxfnAdtUVgLF9D+ApPQQq7lDEjFKtKYjJJjAw5VCrEouQKS/gkVjnZbWxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f21dUrL6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E949606A323
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f21dUrL6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADEF1F0089F;
	Sun,  8 Nov 2026 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794131121;
	bh=xJsV3eZtA4sfFHjIB01AX6LmMvbYOZmpHD0qy2HGVs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f21dUrL6l6NB0psg0QqcCt9MXEd5HymaNqp/lPmtgoncUwoKuk3sn2vG85s0S/C6e
	 HTCxpvaY2RWwTvBqY95yZ30eZYtdin3Gew86IhXA2dZqF4WlHulNiVW/YkfJlEbJiM
	 42QvkkHRQlsPYciageBC74oGrxDalSYSj51G0hQS3m6I+1fXOlzfeLpy0TjkPbeu7h
	 g9LIzpTlRxt0R+eaXPBtIkcnQ4DWlE3tGS7JonKU0ast2Nvllji5+L/E7bmNvGNKgA
	 X1HIii33gcqLz6KafsUOGuB6WfEV1g0Mr25EHICzoXsRrmU2MD8TM/jpsqBcTb82hK
	 QEfJqMYSc66jw==
Message-ID: <sashiko-outbox-203666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] PCI: mediatek: Use pcie_get_link_speed()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108094034.679945-5-18255117159@163.com>
References: <20261108094034.679945-1-18255117159@163.com>
 <20261108094034.679945-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 09:45:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> MediaTek was added after pcie_get_link_speed() was introduced and still
> indexes pcie_link_speed[] directly.  Convert it to the helper so it does
> not depend on the array being exported and cannot go out of bounds on
> invalid speed values.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108094034.6799=
45-1-18255117159@163.com?part=3D4

