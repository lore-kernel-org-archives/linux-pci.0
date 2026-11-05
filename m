Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871204;
	b=Kj2z9Xwo0y+IhDTHV6Bc+NXUMNS5qcuFtV4p0LThhbBatVCZP+BqzCAQPA/Kvcovttip
	 de/GXQrwNdeLgyDL7x0Ud9cCbvrKgsVswPBZaz1XZDwT4xHPSsAvfllvBmPcIZAFuBMEE
	 iig+ugW3eACbQde8RkBoryqzzbAeRJthSnYzQblEuMLe8ih9qvrCRE+eccbAWDS39C01v
	 lPi+HiAIdaMIRADBBx1LKfGqsnSHC5TQNMjVeAq1BaX5misltXZRz0CU72jcxPUvMmlNy
	 BpSl5ARj9BUuMpzSbzulJkR9x0u4ma7Dxc7wnTCF2h7eHoW4ZIhYs6APozYwxCkHkPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D/zH5UB0EEkDhiXGSSzotZdJtQe0jxMtapSI3nN0exg=;
	b=T0ndyrPACLCJ0y0kyUT6C9pLSNV7WtQxQEA8sbUqsIqhZecciKNkLNpUWXqQgxsOfJLK
	 k5IMXpJbDF6eszzSHTY1ybOF5GsnEw97hBBOtfcPzZDX4Y/xFTWBlUm2l++PAaaE/Zfop
	 mKkAw2MouPAZMQ+k5qn8OsC4gS8/MendRdxtehRkGKyHivTgErKq7t+zOfl4JYXckUQtW
	 bIE0oBFVhd6wy8yam5vtNNnx7dq6iNAgWZGM9gvoAQUWS0l0lavF8o5rEiWEA3j9kl4W5
	 BRS0kA6Pwp+MLc+U2+GGDIa5Eze+AmZXABEh0XXIbEpEY4feINNsWlVmIVazzRHpRuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oplphWGl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1CA606A328
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oplphWGl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8263E1F000C1;
	Thu,  5 Nov 2026 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871203;
	bh=D/zH5UB0EEkDhiXGSSzotZdJtQe0jxMtapSI3nN0exg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oplphWGlIETi0qdSEYWtVjToXlupxBWyqHoaJpQvcBR8+ksbONi572tEAB1gxpa6V
	 SxVOH9me2j2EfnsMdUOwiTGjSgIcqTLS7C95c/1aldynY1oHTHeqgyJQcJviwg8r+h
	 0dzLPBnJ+PmrV6Rs82Qe+5sk1BLbQL2DW9tVyEGu2sgRSlVpYXBAOkwo3xZLffNZls
	 8PTwqCpHGc6kHYLlpOb56ZHl8sgLLNahvz15rkNW9BOM0UPtc9Z1BKbE/LETNeDDZC
	 NMEv9T/eIyO41QZx8q/Di7IiXjBk1oRkPh89AXP5+m1KiE9KS8NNewe/wAOA6voSH/
	 HS7kaVUwM8SSQ==
Message-ID: <sashiko-outbox-198767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: octep: size the interrupt name buffer for the full
 format range
Reply-To: sashiko-reviews@lists.linux.dev
To: xujiahao <xujiahao@cmss.chinamobile.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105092705.3099201-1-xujiahao@cmss.chinamobile.com>
References: <20261105092705.3099201-1-xujiahao@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 09:33:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> octep_hp_request_irq() formats the interrupt name with "octep_hp_%d"
> into a 16-byte array.  The prefix is 9 bytes and a full-range %d
> argument can add up to 11 more, so the worst case needs 21 bytes
> including the terminator and 0-day reports:
>=20
>   drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive output
>   may be truncated writing between 1 and 10 bytes into a region of size 7
>   [-Wformat-truncation=3D]
>   note: 'snprintf' output between 11 and 20 bytes into a destination of
>   size 16
>=20
> The values passed today are OCTEP_HP_INTR_ENA and OCTEP_HP_INTR_DIS, so
> no truncation actually happens, but the buffer carries no margin over
> the format's worst case.  Give it the room so the warning stops coming
> back from builds that cannot narrow the argument.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507261457.SXXHOjUk-lkp@i=
ntel.com/
> Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105092705.3099=
201-1-xujiahao@cmss.chinamobile.com?part=3D1

