Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682779;
	b=LE/repAnLSHR7Lw/ua/DtGKNByZGQHceP6ni8oeuMJ3SS75pktVZWQxoO1TMamFFYech
	 DZusRP2HbnZ+U72uBYFw6nB8Xke3Qz3zuClAmS6y7vrvoi2aqVnogYqz/BPl3/1QjrxXi
	 aTPpHZY0zF7lLEeLpH+nCKyZ7FIkriPL3iGv/sTmcwa2nHmFtRk6qz2kWQ5pAda2Ui4LT
	 b32PvI/oSbcsc5oDKjUx0oejQrcPJkLjjK92BKBASaq6lUkWEmET6lLdv/c3RGNANW0OV
	 ad4rxGgrPUgwE6I5o75aH93rdy8WGcdAkeqh1evqsGWexqIR53iAGor9enrPRevM53w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Rk57VYTFxT03jZ1TU9JTKNXgFQgGwNWI0mcFNI4uHA=;
	b=C5WrMPdp1IrRqfG7y3RE7oHeBbG7vbmdCzMKIpp/Ym4ZnsNy7y1nrhWD5dviEwmJlTua
	 m/eT53gApwYfOuq0pt9B3UDLQedY8Ea+HnS3UuuyyazzQdWEFjpi1b8RfGCpf1VrqoUmH
	 M060IO8eghhBP9JGqFfuTV25Kc5Ehi1/zB2mBXjnGNswFEEaGCbL5/dVLSSqEIoZ3bi89
	 RreHVKZ4xOqfkWVjx55KO8h8r78r6Ew6RNsXov1Kmnd/r1AqId36FkxWpVJX4psm8uPni
	 ccwbqtEGTt6IWeUjRdlhnekQyA2/oPYuOv9SPsPGCltR9V5S7BMTG4LH7nYaISX+c4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKA3U7yH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63170606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKA3U7yH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D791F01828;
	Thu, 22 Oct 2026 15:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682779;
	bh=6Rk57VYTFxT03jZ1TU9JTKNXgFQgGwNWI0mcFNI4uHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKA3U7yHNsTFIx6kxEcLs5OVD6ebzdFWhoFXr7DmBsKSb2QUd3vo/GIteWTSYsEQ/
	 w3+ARt1X0Uh/Zu5ldqjZNAd590d4rnr3/kyJ+l8jCow2ffWkBAS9SqI2SAeOOkLdpS
	 IdhEfuMtoz0jCg/aZAvoditD9cY5Bz6pKOISnHK67YOLFtYCIjeoEHHLaD5Az2i1xp
	 7zX6+DLoI5BJ+em8rg2MqNGiiMBFV7zhaTpk9BgWZsl7AO9hYrMK/h30etinAiZAVh
	 4/AF/FY7X10Q16ItM5b5o6+9v6qCIsp+JkQ79yx5VXQg7cyj6j7fLd8Ww2Q+l9IQXs
	 R4FG2BKvcTc/A==
Message-ID: <sashiko-outbox-181696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in
 the preserve ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, joro@8bytes.org, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, "David
 Matlack" <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: sagis@google.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, skhawaja@google.com
In-Reply-To: <20261021152527.375070-3-tarunsahu@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-3-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:26:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently luo_preserve_file() iterates over luo_file_handler_list and
> picks the first registered handler whose .can_preserve() callback
> returns true. When a subsystem introduces a new, backwards-incompatible
> file handler alongside an existing one for the same file type, userspace
> has no way to choose which handler preserves a file descriptor, nor can
> the kernel keep the existing rollback-safe handler as the default while
> allowing callers to opt into the new handler.
>=20
> Append char handler[LIVEUPDATE_HNDL_NAME_LENGTH] to struct
> liveupdate_session_preserve_fd immediately after token, keeping
> IOCTL_OP min_size at offsetofend(..., token) so callers passing the
> original 16-byte structure continue to work:
> - When handler is empty (all-zero, or zero-filled when userspace
>   passes the 16-byte structure), luo_preserve_file() selects the first
>   registered handler whose .can_preserve() callback accepts the fd.
> - When handler is non-empty, it must be null-terminated within
>   LIVEUPDATE_HNDL_NAME_LENGTH bytes (returning -EINVAL otherwise);
>   luo_preserve_file() looks up the registered handler with that exact
>   name (returning -ENOENT if unknown) and verifies that its
>   .can_preserve() callback accepts the fd (returning -EINVAL if not).
>=20
> The retrieve ioctl is unchanged because the handler is identified by the
> name stored in the serialized payload from the source kernel.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021152527.3750=
70-1-tarunsahu@google.com?part=3D2

