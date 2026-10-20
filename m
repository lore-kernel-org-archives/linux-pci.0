Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518010;
	b=FRH0uu4xCcbm3ck9/A7N7UuuRCa5chVVUcZIiRC3b7hOJF0NndtDdxMVk2hELNgJKiXC
	 VnVYRdG5feJ6Ud9cXUnT4Ij51chiXw/CRTpdFnS3U+3kzEHHHD7kSJ1xwp3/m9c6y6uxG
	 T3I4k62+0ii8gx2+E+gng4uos6nytxDgPGpiqX8zY1hVtORdRWXL0g8lQjquS45Xrf3Rz
	 AKOTo+EnNnde3ALFd7blR30mneKrjmafVsrJA7JCd06G8BZPnowE6MybgXAichoVIzNMD
	 qsLpHZHS5KJNWgC3PvVn7KQzT4HC0MJri2V+hp+772jxG7i2CNl5CchUp7miMqpB+SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518010;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=02BH1I7gEbYX6MeWGeBwW48mmKK9Ol6GjV34jbqpBZ8=;
	b=ct8Vyr7h06MQeBq/2yDePj8lzDRjU4chH+YrcXXb8QaKay7DuY3sH7k1RHHyv1Lia8uL
	 tIvtUPl1IHI835MUDxPa4QMUvP9yEfW6Ce/ifygb3smxG/axmBKf5XOJB+ZD+UEOP+Jf3
	 8hgTo5eVk8Xal5NCN6DlrIm7ngmcJzp8/UNsObzC77DmvYKD3MSjczXaHcd2E1T6dwR4k
	 WfeXf3SUcchUKoDVIPqTOpJzPxkwsyEnA7a0c2nhUOgy+Xf8XcJOskgCdqnKwoSamflLD
	 1cXXlChiemFbTncKLASbtZdr/pbRQ2rwO7jRgJaPWYfv61UhwfcEtgKvJ/ieZx8EeTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30877606A324;
	Tue, 20 Oct 2026 17:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CADC1F000C9;
	Tue, 20 Oct 2026 17:40:09 +0000 (UTC)
Message-ID: <sashiko-outbox-179429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] PCI/P2PDMA: Move CONFIG_X86 #ifdef out of
 cpu_supports_p2pdma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: virtualization@lists.linux.dev, linux-pci@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261020173736.81755-2-pavel.e.popov@intel.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
 <20261020173736.81755-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:39:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> cpu_supports_p2pdma() has an #ifdef CONFIG_X86 block inside the
> function body. Put the whole function under #ifdef CONFIG_X86 instead,
> with a stub returning false for !CONFIG_X86.
>=20
> No functional change.
>=20
> Suggested-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020173736.8175=
5-1-pavel.e.popov@intel.com?part=3D1

