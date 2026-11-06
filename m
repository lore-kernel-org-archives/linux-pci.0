Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965429;
	b=QaqnpwWdwslWzn+9/rYMiVktzmAo9wAG3Wb4LPhy26BgYr+tBe6eEfYT6NMY3nJr2QmM
	 Q0XNIAV5GeQnlXwbqD9Kat70UntTzlMS8xJU26J1nZhl/aGf0MVTFXbjOG3juP/S19q0b
	 /2223jxZ7xqZvVNubK5e/VdIcKPIBZYZ8RPdH3zNh+dR1wDNA1CTdINt2wO010eD7/zah
	 J+z853tys1unhRl27+EXZlXgUfoAu2q9AbpK0wUqqbWxzO8KNRnowdjJWPhDnZwuO18Dw
	 /4pC9FO02eMNOPX5NUP+NU0PNMED5h9F+idtb342G3v6ceGOQq/OqmfUvet9LszAwhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4r1rOSHvbjTs/HhWgDS+n4U9KkZvlYfSVlnR8750Ag4=;
	b=vESf4PxfAYMhhhWXUt4NC/FvIWxhNfR+R/d/Cq4Y9NZ43ktOx++EtXpszD5WerodGJo1
	 OVAJTqpA1mJRaRIR2RQHMXA0VyBpi5tGh+SKS6iUqCP7BHFMhDRMwaMXkJpdNX1tXylhv
	 O7ELk6USR8jiDpa7N4/F1lovguJWLP1kwxZkxUulTgqbd7GL30MZRlKkJc2Z3CeEEYUjQ
	 iD7nLS+05836wiplqote99fxDpj+5NQZMKLuof6CWogKRfnMq7cAd2dcaYbl7QNd665p2
	 BeF0c1qs0bhon4Icfmfj5Yn/rc1vV4gs0NUmXEGtyzx8hnupDnIPgHVCh3u0mTSIiyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMDg5Lt8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE36083612;
	Fri,  6 Nov 2026 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMDg5Lt8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C7F1F0089F;
	Fri,  6 Nov 2026 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965429;
	bh=4r1rOSHvbjTs/HhWgDS+n4U9KkZvlYfSVlnR8750Ag4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LMDg5Lt8s7vcahfeqbmODICFaUBeSNXtlIeCh3/vGu5Mp+FcBcyk266CxyRJS/SUn
	 tDyPpKfrI/iOODk5O4nkrgK78Q1Y8hDOUDKdwOXcu/2KjRNp9398nw79gt741KViJD
	 EqWArLzjmHSiqEonV9eE+lN+Wqtl8Ly/ya5EeTXqwBfAGeh/KhPZyypTFO8i2lLBAT
	 A8Nq1/UYufScWVxVLQTjyG9HgemjAiTB0xQ24Afv8y13daOomM5yxkJqECDi5eEuCg
	 9VUf5PEgZcxglcibC3LTsRzUEayrU+kYfpiP+hpRpMax8+ksNLcSM72qwtV7IIdxMP
	 JGGK+HdMNiszg==
Message-ID: <sashiko-outbox-201349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/17] driver core: Document trust admission and initrd
 authorization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-16-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-16-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Policy agents and bus drivers need a shared definition of authorization,
> commitment and active trust across boot and device lifetime.
>=20
> Document the admission state machine and disabled-to-authorized initrd
> sequence, including built-in probes and pending work. Explain DMA domain
> preparation, binding restrictions, device replacement and current userspa=
ce
> integration requirements. Distinguish attestation and containment from the
> permission to bind a functional driver.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D16

