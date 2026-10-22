Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657572;
	b=DUW8z0cYV/rREpyNOpuHbHSFZEimb/KV0qECQPfdu44cvf8oQZHkdNtzaEx4eZrJ0ser
	 +K5KzTRSStWsIoBrrcWisJhNKAR/nuwQt0ozuXzeevxg1OBrTomJ1IekeDdlK4RsaAtyK
	 ag+a289XP6G64Of7GF38SLS6erNup/1wHBwaCDTfQZX+Drpk3Nd42HkIfdL8Coo0fybZ1
	 WiwfSXmhPfXUMQ1q3rutammAzJAjQ7wn5Al+fxo/kzfGhmiHKGLf4HIkk09O85J7c1qBA
	 03GzOgF+zykyX1auYbiHkE4VBhJcD/pU9LQJjteH/3fnAqIkgA5HzkJEkL6prZ/3ntg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657572;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D/JTWo7bl4W2/jv2C+XW2Sn0rsOBIU8HZPzD54uDdCY=;
	b=atD1E6MY3YWvWBVPwFnt4a8khxC7Y/BtxhS+nVqkcso4U+fZyajNiaQTolWaraBN/YIe
	 LAKv7EYp8nq6sf6jtqYaoH4WfG1Z87inf65kXVtOkbpRjg84TKLiy/HzI5usXhPjEBjDd
	 QODv9KN/sgH3ZVy0bXYUcBJ0n9DElcyuLDW7rsOMN93rkyPLzL4eYel2+aIl9YRDgcitj
	 q+1ED0ErNhOqh/wzph/gy+jLDxl8tAXGjNug00jk6yjT0/mx/1snp4WahJ11rePB6cIcZ
	 yqhJ4GV4/h2XB2Q0FzkWx5AbdTj85mCOXUk+deq/FKgnZ9Oe0F4oH2jE3ezlGTiWgsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY13Osa2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12C606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY13Osa2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E00F1F01573;
	Thu, 22 Oct 2026 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657571;
	bh=D/JTWo7bl4W2/jv2C+XW2Sn0rsOBIU8HZPzD54uDdCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XY13Osa2/83Hy6nFvR+CdMDrBD/i8VzilYiCaFtnyN7WuKrgI5RorjT9jYoHHtBRV
	 5yZrJg4j3OaMhWW4LFhoE0uXmeNLLNoaMJgI25EGOUtOXziwtLW3vQ6pr0Ii3D05YP
	 UVlkxVJ2Q+Fta9aud1COrUhc8TSxI8v1gMjZ4L3AZyE9YqTMsgjsk6J8DFXidAhdyh
	 m8PNOSMYbj8OL/7wN8IHpruTUZx4Zk1uM7SDz4jJNxJO9e2nq4edPdm+9F49pL7TDO
	 pu/V7Bs4b3JnZ1jUT0wnfcRlcYhPpCzlo4vDH6zPOQyX/5mTQAfGXfgWemyWL+KwHO
	 pzxiCbLdgUFvw==
Message-ID: <sashiko-outbox-181164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/10] PCI: endpoint: Add pci-epf-ntb.h for the
 shared NTB control layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022082230.3164834-5-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:26:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, pci-epf-ntb.c and pci-epf-vntb.c each define struct
> epf_ntb_ctrl, and ntb_hw_epf.c mirrors the same layout with hard-coded
> register offsets.
>=20
> Move the shared struct and macros to include/linux/pci-epf-ntb.h. The
> vNTB "reserved" field takes the pci-epf-ntb.c name mw1_offset, which is
> what ntb_hw_epf.c reads at that offset.
>=20
> No functional changes.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D4

