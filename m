Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842436;
	b=F0wOuBsvU2sRHgGrRLiuXcwcXNB7zDuUeIDqUDMbakVdIwhi3TvNOyRx22me2+I3+JBJ
	 T/BtQ1ja08gnKnSZhjOZo05B8+Mpf2gzeEXryQIHrZ9AFppzFasxC3lF50uLqAqGEEcUo
	 /FC8ZWS0+vqzAjr1npy3Eh7PXpkhLjm0Ea7kZGcDzB5t+f20CamdEY7nRW/h240+LEoLp
	 IY0OQpTgQ0ztLRIkFAR3j4asKm6K1Uxt8AnfYIs2pRaNs4OYUac0l8NepAnQiHScbK+2A
	 svarVFtheuvbm/TO6ydngwzar7S7lMnTD6mjkiEeS6YUUsq/0TenbRNycgaG6j369Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842436;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=erUEfR+prdgpUXc0KGebiHm+dEWQ+JCdbail3LwjsA4=;
	b=yJjZJTNHDX+1GvBMiEKydumejwPVxUUGwdWGzCVQGqdEZx3JB0nXAREQXEliP9mQ3R3Q
	 B+vrVVnkmT85RtGvF7shn2SjlUR2Ag1CYh/CYTJ2GgxWH/CMLOE1qG3hKhe4saMG5LfEr
	 S0qqps4wTv4h8sIHgiVY9+zLCG/xyy2Z/0+5QYhqwaNi0VPVTRSPQBdHxeLagp9WvQv0O
	 H/0k/1K2H+ckgNycFIlD7P6tC1EVy9Aq1Jt3uIQmXLDMinnTYig7KQDrPh2GEqE6XRjc5
	 T8XTuoRrGVMZbeoUxVNgie27zv+J0dSKp9Eif8R/EzsVKzV+L4wN1tvzCUU1C0YNNdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeFeB0fi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91458606A31C;
	Mon, 16 Nov 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeFeB0fi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75AE1F000C4;
	Mon, 16 Nov 2026 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842436;
	bh=erUEfR+prdgpUXc0KGebiHm+dEWQ+JCdbail3LwjsA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aeFeB0fih0PWJ4M0kg85SbIstZtw8ISeXDTYsXR7jtFzWmyklc582qyAArPfTIaIV
	 NejTK7O2TQH6CLucH8Eo942jU4in6SWrTodhhlR28+oZtCFiqYVk6Whz2nIJH86+pI
	 yfjP0DgABY9du8KN3/me1eZ+5+M32oP/3YcsE+toPZywXaUDhHaZBurUdSQJPSxleY
	 HYJud1LnrLNCCl42EECFUJSNmqmpQ9+/aO+I5qQ0xlvdL9cFpMrysY4N6aHAIRn7Kk
	 jEkCQIMe6ADRVpixsODrbWvccxForGjCeSCzI5xOKJO6dHNVkcJqM75WNeCW7yaPSN
	 +vQpj3eaZD3Cw==
Message-ID: <sashiko-outbox-217259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/12] treewide: convert rdmsrq() from a macro to an
 inline function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, linux-perf-users@vger.kernel.org, virtualization@lists.linux.dev, linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261116150208.1572254-12-jgross@suse.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-12-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:20:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
>=20
> Convert rdmsrq() to an inline function returning the MSR value.
>=20
> The users have been converted using the following semantic patch:
>=20
>   // Options: --include-headers
>=20
>   virtual patch
>   virtual report
>=20
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val =3D rdmsrq(msr)
>   )
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116150208.1572=
254-1-jgross@suse.com?part=3D11

