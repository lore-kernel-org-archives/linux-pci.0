Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794059218;
	b=2b85XGofN7TzwEC+2oH8E2jEM83lQ+/r8AoOIM+XVCr6IOf205kXfdTKesTjbbZWY08g
	 vPYP/8vAyzHUmzHI9Y9NNcp3lWCFRG2ywThufYBeNwqNv6UbxQB4WnYaKh/uW1ZLSS/I1
	 w+Fh3m5Q7/QpV8ak/JR6XA0TxS3fp7cyl8aaCVtdI30kYKeED2y9qUBbc9rQodMjiT80b
	 agqKSEOdgoneZI6qGqH6MpbBe4OjNV5jMPZ4mCzqDcZ2C2zQMckIWTgaaSxKyEctqRVHM
	 AlxJxRLEQgs2m/SLFfa53hhtk+8KpVCMaD+rRX/iMlIe/cHZRtjEeGZsquL2Qj1isWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794059218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c4n6WMEBe8WCFKaEg+YqPaCjXECQqngzidVsPj8WBg4=;
	b=GchVlPaVVDIz9JPUjQ8BJ5kt2VdueiGJIXJUIW5cdi3M5NhAMjY3B02iwPxfP4I9Hy6N
	 UyikY+hrBXGuUtUveahVIySVVgUL4mYMbC1D2PoB6QvfJqrJWXScCbsKc/tfGG0jkY/pb
	 0O+keACF4aAmQLcyvAMlpM+G6DCKXrv36v77QGvKl0aNUBH9KHhIW9VF5nCBln+DGqnHT
	 4aTU1Q46akuUe9LTnyfNLlTH5ZDM9Pb0N5cmKWTlOTWRhQdT6fo7jBx64TBJI/Dwr4ltz
	 80F9Jdq69uBLe90A4vp5iBz86hBMJYM2G04XfOmdRGamprLA+LhOPMyFLwKP2uqqWJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXvixqJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8B606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXvixqJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647E11F0089F;
	Sat,  7 Nov 2026 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794059217;
	bh=c4n6WMEBe8WCFKaEg+YqPaCjXECQqngzidVsPj8WBg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LXvixqJOQdG5WtDhfiH3Yqk+ciTViTkJxnD5fK81UcjvsX7r0ztYqdwzws7shLbCt
	 n4g3zPAshUekzKWBCg6wTSEU9uAuJv23r7RJgCjApMIIZC07cUhGmL77DOox4NjYG5
	 yZB7U/+JeQhyDZDkEp3fE/OFqimBsUFEvqyWvJTIXLhOjfxP1hku25yFkAzIKwqAlv
	 t4CrW6yppxLYwKRM1E2lnKQIN1wh2Z2i1ZFVWsYlBOtRlNcSXDfn6qZv0eFQhBGBGU
	 nAF9ibAy9HVHOkqYiO6vi7keVZE5ll+Czt6Fnnk5LnAClv+ZBTmn0I4B2BLBYIThow
	 2N0901JkAHzXA==
Message-ID: <sashiko-outbox-202933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/7] dmaengine: dw-edma: Avoid resetting an LL on
 stale stopped status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107133027.364237-3-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:46:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> CS can still report STOPPED briefly after a doorbell write, before the
> DMA engine starts consuming the published LL entries. Finishing
> termination relying solely on that value can reset the ring while a
> transfer is about to start, leaving hardware and software ring positions
> out of sync and stalling subsequent transfers.
>=20
> Require LLP to reach the published tail, on top of the standard criteria
> (ie. CS=3DSTOPPED and zero transfer size) before
> dw_edma_finish_termination(). Non-LL mode behavior is unchanged.
>=20
> Cc: stable@vger.kernel.org
> Fixes: db79c4e264ef ("dmaengine: dw-edma: Make DMA link list work as a ci=
rcular buffer")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107133027.3642=
37-1-den@valinux.co.jp?part=3D2

