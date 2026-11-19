Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116576;
	b=SZBjRoyvwYGqb/a8rTEOjARyVL7LmSYsFh5laNtWQbkcUs8jWX5LszgTdXjzHBOPqnpT
	 gA6xX0WYciwsF4/37SG0XhUD9wwm/+KsGIrS3D8l/XumQ7R/U9vO9lp71vfmT8N4PqqGB
	 NnXKIa6A4KzClwGza/ofjRN7vIK+t7bN05ezK+tEdAzvycpPkUGoLXaqfKz+qPKKbniJk
	 DEQz4A1Tat83hgYnRF/yNJ2K36y+7+C30l1hdQbp4VfAH87LbJ0b3vSbl3bmRY7IqICpu
	 mHJXO4DZ35Tq1FOtqErYymdf+qImPs0ELNqZ9JDvR1VdkosnNAJoIv8XBWiVn0S5jIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116576;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q9pH2yUaRsSO70OjFRhmlE1KUpQraI5rZkyd3pJGhek=;
	b=oYzPfryjrDVeTuHDZvSHWSNGmUdO1GwrvD372ytVkCQoEXV8NBQDP2vXpkg2xFimn0DC
	 buu5Y/8qE1NI7EyyJnfrv5dtoA6GRHtchcnpQNfxcj1y1OZNQHOVzJEdCieLZ95sw5kox
	 rBAslMacSOP03TNMnrMYlU/KFG7ouOK9mgjJTwndFFL8S3TaPQU+riFcpWzx/WbWnImYx
	 zwUYWwDGxbw4oBG7squ+XZ+Kzf3uNFbR4Xrdqim86FJhIf07/BY/lZxji2ew5sTDukCRb
	 /pKRb3cUC82EW2O9y07ma/fjle3q9OFaE3GE0ZA1STspu+dEksscWn1NEvDOspTzRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRf0GthB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D704606A330;
	Thu, 19 Nov 2026 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRf0GthB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811871F000C6;
	Thu, 19 Nov 2026 19:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116575;
	bh=q9pH2yUaRsSO70OjFRhmlE1KUpQraI5rZkyd3pJGhek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TRf0GthBTxmA8LZjQqS5/hfBSUA+THClfbc7m9DbWVFCY4S7mqiHnmCT7JnyepBiw
	 3AOThoWjKXmv0yE4n/bWos8yJ/rJGWxLZ+qVo/1eDT0mYUh4tg2+QitgwDBsfy4HHU
	 9ZbIUiWfLpKxHyIkaYFmdBl9d7sduu9e8EQ/TrJFvRv00aZlJGbaBTASa8BRNis/OC
	 AKNyU5pFGitsIsF9gTnhCR7PV6QT5g8oROfG3hPNI0ul6k5vkvnLoMMDhTgNEMDbYm
	 AWvyL1Bvs5vAulHvt0N0blTSGJs5FG2V0WrG12+UEe5SrzhwrgiIIJAt+PEHcN4qeh
	 VV/6HWhPW3spg==
Message-ID: <sashiko-outbox-223902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/31] Input: gameport - use the compatibility driver
 attachment API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-16-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-16-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:35 +0000
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
> Manual gameport binding calls the driver's connect callback without the
> device lock, allowing it to race with generic sysfs probing. Normal
> probing would run CONFIG_DEBUG_TEST_DRIVER_REMOVE under gameport_mutex;
> a disconnect callback that unregisters a child port would then deadlock
> trying to acquire the same mutex.
>=20
> Use device_driver_attach_unrestricted() to centralize binding and failure
> cleanup without the debug removal cycle. Take the device lock with
> device_trylock() to serialize attachment with generic probing. Return
> -EBUSY on contention because waiting while holding gameport_mutex could
> deadlock with probe cleanup that needs it.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D16

