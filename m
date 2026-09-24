Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2C4B7176
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276171; cv=none; b=q6rksaiblZgx1q2FsDFfZ+hJ4b9ZH35LX8I2Gv1lOJjCRSJvV6QFgsKAuhdt6UW4l4q2YMN161tsqTTULtXbubZt0HAuMRxnNMr4ss68RZq6t/Lah0hcPQDQdRS6aNw0dCsuE184f/6N+ygazR2cS8pMeDjaV40bP0/awUDUIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276171; c=relaxed/simple;
	bh=vcKujPmG7OS5fQQpKrIOAGVBP7aOGe5CzcmbErMnoaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M/00ZeaTKp98TN0b0lmBFzRE+2ob/L4xsOHEPxVRmy9Wk+BofMQCcOHUh4MtYS6xpwvecz/q1ON9dpZ0OJv02dPO1tdKiLYxqC03+eoHdmBYvu8NlNnNJESIJzMvwiyvJArXnp6/eFdldbR3AH6YpBauZtolS81YHmCSa91z83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM66qyhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM66qyhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE5A1F000FF;
	Thu, 24 Sep 2026 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790276169;
	bh=vcKujPmG7OS5fQQpKrIOAGVBP7aOGe5CzcmbErMnoaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JM66qyhVnf0Kev06+Ad2TrvHm/Dp9uNwhMg/kovb+TCYV03FJsw6L8cENWsSLqpM8
	 +nb96AqfSW95EFL3OVwkD4Q7XnMMBB+ZDBsehfahAeGfPEp4HJ+MNmJ+iJnrLq4b9z
	 pEmPipC78WCjPQSeXRY2BM7oX5I0Gcazgj5uLvrckUsYnqVaYo6tAEaGsxwNToYr7/
	 d8lip1z5QqdsGwnhhUjcFQHGVCyx/HE9yYl2At2TUzdIR3b6DxxFsbRgw0u4KsJPWN
	 F6vL8Yrncmv52COKvDloAYRAo/BzrplNH9OvNYinzSRHoJBvhH8yyNpYK0SkKI5JhN
	 uM2dpaopgPBnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] PCI: Save reserved capability registers in a
 single pass
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-15-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-15-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:56:08 +0000
Message-Id: <20260924185609.4CE5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Every capability that the PCI core saves now reserves room for its
> registers during device setup, so the reservation bitmap already records
> exactly which configuration space DWORDs pci_save_state() has to read.
> Walk the bitmap once instead of dispatching to a save function per
> capability.
>=20
> Values in the store are kept in ascending offset order, the same order
> that for_each_set_bit() visits the bitmap, so the generic pass fills
> slots sequentially and never has to look one up.
>=20
> Delete pci_save_pcie_state(), pci_save_pcix_state(), pci_save_ltr_state(),
> pci_save_aer_state(), pci_save_ptm_state(), pci_save_tph_state(),
> pci_save_dpc_state() and pci_save_vc_state(), along with the PCI_VC_SAVE
> arm of the Virtual Channel walker and pci_save_cap_word(), which loses
> its last caller. Each of them existed only to rediscover offsets the
> [ ... ]
> was enabled. Restore keeps those guards, so the extra reads only make the
> store a more faithful snapshot.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D14

