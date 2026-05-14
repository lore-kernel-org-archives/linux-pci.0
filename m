Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72933A63EC
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784238; cv=none; b=ayBO8x6HGaAN3YAj6ljbZUC3KonT8YzcbLLSMPkUz23BbpBEx1eHd7Yj68R3hsoPBkDsOhzUpecKUUXmJUab2nhuJwbTr4xHzHzfgdjjz5VN6X/r+2pAExUMEeXjjCLR0fTUtbifSh8dY4fe4V80rrPENsp+Qtzr8SNDb1RwBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784238; c=relaxed/simple;
	bh=Ovy5cnxWQUO/04WDhPYmYdWad622ch9wuo6qADaQjts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FTPSQ7vFDACqa91Nk8YMtesyofqz+CLCXscSFXGhNEC63/9s3S6FV+1sOZN4uRNtG7P3UIXHSq+PyYtHaNfItB6Ys7cf+WFaPEQbWyWvTJUmqlf2IWoMDPjBCTYaV5K5gzQ+L4ni+ADem39YnxVHKI6ddgTbRocGUHT7bi6nRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU2Fk1Wj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU2Fk1Wj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FB1C2BCB7;
	Thu, 14 May 2026 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778784238;
	bh=Ovy5cnxWQUO/04WDhPYmYdWad622ch9wuo6qADaQjts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MU2Fk1WjYB7LCblkRzgEt4E1rCozcuwAZk1KXbMcjYEHY5VuHtdTz4Q/SWeVU0CRe
	 E3FQllqwk4F1cyJggNeCaQBjTxlxk+ugjtUCs6JfRLLooomEAyCUn6qDdPipZlulUN
	 E8JgJL/wtgbw+WrWFpeXpRdolYDs0ZVSRbSPw0g/ZKHENUdyd8iVun+vNy2/pw4Cz6
	 tkMw7Eb0pCplXsVfa8Z9JxwJlhbA4wDbWYeIv/+tBwNA4+PUWGnraVXKqjN/5DGB1W
	 liWqwS1AJ3CwEn1yldwOwmBO9A4HOHAB99jth1leRGDEdL+sdeMpSFA/E3746pXz6k
	 XEsBtqj1aFtGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: Constify slot attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514-sysfs-const-pci-hotplug-v1-2-3b0b6c6f7481@weissschuh.net>
References: <20260514-sysfs-const-pci-hotplug-v1-2-3b0b6c6f7481@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 18:43:57 +0000
Message-Id: <20260514184357.B7FB1C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete constification: missed `zpci_slot_attr_uid` in `arch/s39=
0/pci/pci_sysfs.c`.
--

commit 81d437e9bb503bcf5cbb6fdfb3f55cfe7eaf8cde
Author: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

PCI: Constify slot attributes
   =20
The attribute struct are never modified, mark them as const.

> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 6d5cd37bfb1e7..7929bb87b1959 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c

[ ... ]

> @@ -93,14 +93,14 @@ static void pci_slot_release(struct kobject *kobj)
>  	kfree(slot);
>  }
> =20
> -static struct pci_slot_attribute pci_slot_attr_address =3D
> +static const struct pci_slot_attribute pci_slot_attr_address =3D
>  	__ATTR(address, S_IRUGO, address_read_file, NULL);
> -static struct pci_slot_attribute pci_slot_attr_max_speed =3D
> +static const struct pci_slot_attribute pci_slot_attr_max_speed =3D
>  	__ATTR(max_bus_speed, S_IRUGO, max_speed_read_file, NULL);
> -static struct pci_slot_attribute pci_slot_attr_cur_speed =3D
> +static const struct pci_slot_attribute pci_slot_attr_cur_speed =3D
>  	__ATTR(cur_bus_speed, S_IRUGO, cur_speed_read_file, NULL);

Since this constifies the core PCI slot attributes, should the s390
architecture-specific attributes also be marked as const?

Looking at arch/s390/pci/pci_sysfs.c, it defines a struct pci_slot_attribute
and an attribute array that appear to be missed in this patch:

arch/s390/pci/pci_sysfs.c:
static struct pci_slot_attribute zpci_slot_attr_uid =3D
	__ATTR(uid, 0444, zpci_uid_slot_show, NULL);

static struct attribute *zpci_slot_attrs[] =3D {
	&zpci_slot_attr_uid.attr,
	NULL,
};

Could these be updated to const as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-sysfs-cons=
t-pci-hotplug-v1-0-3b0b6c6f7481@weissschuh.net?part=3D2
