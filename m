Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979450;
	b=H4K/2Gs9WotqWXjH2iSLAqTGKGHA6n7l/UdJ/fLx5uJxBc3NcQYidNV/VS7b4UaX6Jk4
	 VPlSriHUqVxmHvbVuw6TW+UnLlw6QGlPEh01ERpv5JTM9Ri0cNT0swL2iEzdGHefJY6Lp
	 VtOpD3r97N0RmWkCFbR9YAHvwQomFX0j80TaQKkLtN4dUCZOlLJIVYERr4cigutULtGJY
	 JGskhKM3GheGOxJJvwKH8iq3tuZszuYxJianzWuk0N2JDqAHGNyElufPqgTEaUdF0DBEU
	 qFV5/PS4aN7VJxuXREOzyFF1xvxPzjv5QQJD8jybsfKCEI3tXsUiqADJQdA03OZxMbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979450;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jMAMkC54G6l4AM5JWRPdbFHCaxfms9aX6TlpRuNJCEE=;
	b=B6TBuqcIMZKr71GSiiTCRZVUI8zhzYGkVKgYMdbs8i1/j48SjkUOaGlvhVIrv+fL7/5D
	 /sUp1B8NLJ81uNs0x1Lj0wFd7xyfzB66Eodaa6Cgi1RaO/poBUHYlmV6Tto77JjsYUlIA
	 fxBWh9Qdyw3tOTMRWQOfB9/M1TS02SAB2Wv03ufpQtf1D+mW5I2tyHdg3WbwH/VD6DXPI
	 hCg/ABHZZyd8jMzC/ms8SXRgHksP3YKbrQhHGJrI5qjrRaMGkaNzyrwfw6CKIbEWaKTEc
	 6dl5NrpX96SKPj6SKfBrFALXPi0Oz8jbzSGH5T2dnFKJTC6KIdF8ug6eIQEQ6TBOOBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6JpbLqw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F515606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6JpbLqw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996521F008A2;
	Fri,  6 Nov 2026 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979449;
	bh=jMAMkC54G6l4AM5JWRPdbFHCaxfms9aX6TlpRuNJCEE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N6JpbLqw5VXj+T9FlSWrGr4YO0lT9o0US1YijWLVdMWQgLroBJBKjWJkwVhx09jzV
	 vpiQcbsBcz6YjZ3QZF+QzAkxUpw1canWZd8kuI2JWLEE561jMyUSkhZvNPO1b0OqGr
	 9bVW6361ZlLN1S5rncI2KM6L6R+yXt+xpmnbCpjHOoU4JHSLOT86kseNdHthXHmCJB
	 W3sbz+k0GjWRcqiNr89OmODNasDpQ1wCAbAAP26UOPGWBhS01LD1HVfP3THHKcGlcf
	 zKWpkYcfEq2ZKOyFlw430ybcyhQfCKLSaGQPbY03iumKZ6SIZPo1x2xWygAzNEiDJ+
	 RD0/A8IYeXcuQ==
Message-ID: <sashiko-outbox-201705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/14] PCI: Add debug printing to window sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-15-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-15-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:37:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: inverted range printed for zero-sized window in
  __pbus_size_mem()
--

commit 75a33ac81964888053244c6e6481c6c66d89219a
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Add debug printing to window sizing

This commit adds a pci_dbg() print in __pbus_size_mem() to log the
calculated bridge window size, alignment, non-aligning resource counts,
gap, and partial blocks.

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 86c9557bc2fb4..22da18347488c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c

[ ... ]

> @@ -1379,7 +1379,28 @@ static resource_size_t __pbus_size_mem(struct pci_=
bus *bus,
>  	*head_align =3D calculate_head_align(aligns, max_order);
>  	*head_align =3D max(*head_align, win_align);
> =20
> -	return ALIGN(max(winsize + gap, min_size), win_align);
> +	final_winsize =3D ALIGN(max(winsize + gap, min_size), win_align);
> +
> +	if (bus->self) {
> +		int idx =3D pci_resource_num(bus->self, b_res);
> +		const char *r_name =3D pci_resource_name(bus->self, idx);
> +		struct resource print_res =3D *b_res; /* b_res update is delayed */
> +
> +		resource_set_range(&print_res, *head_align, final_winsize);
> +		if (final_winsize) {
> +			print_res.flags &=3D ~(IORESOURCE_UNSET |
> +					     IORESOURCE_DISABLED);
> +		} else {
> +			print_res.flags |=3D IORESOURCE_DISABLED;
> +		}

[Severity: Low]
Should the else branch also set IORESOURCE_UNSET on print_res when
final_winsize is 0?

When final_winsize is 0, resource_set_range() sets print_res.start to
*head_align and print_res.end to *head_align - 1.  If b_res does not
already have IORESOURCE_UNSET set (for example when initialized by
pci_bridge_check_ranges() during hotplug or !preserve_config probing),
%pR formats print_res as an inverted range such as
[mem 0x00100000-0x000fffff disabled] instead of
[mem size 0x00000000 disabled].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D14
