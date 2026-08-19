Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440B2C2360
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143735; cv=none; b=oVEqOlYtor5tKfbvoby9u9Ktp9Q9rulUS0bzivDMY7oGP+gda4rhhay0Ej+q64J+5QUG5YkCSjXEznMNzuEe3EHaYYKHqhGllDLH8hGPtV0oug0iLoU9NUJs8Viom1aLJ62Wj4Vzdx8ZOls5u6+7EA1Ht2/O0K7w0fOMUyIiBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143735; c=relaxed/simple;
	bh=/LL9IA9XlMeRSdnL9aUcC0tj6Ov0Ffe/SCaUA2lbT2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEEFqYRLmu+ROfCBUteAdxm0A2X2OGgB3cWO+0g7YX4acbXZZ+FebuUZGVBlp+ySuQ/PgDPYgkES8Cc8VDQkZaFOLn84VmC54DgUbFIc1OL8dRLp2iXfRsFHjCxNoCsPUZjxAfh06U0EEw4Qg/JyA5ofcyq7g4uw5kz9mpJPyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyTM5IhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyTM5IhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155B61F00A3A;
	Wed, 19 Aug 2026 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787143734;
	bh=/LL9IA9XlMeRSdnL9aUcC0tj6Ov0Ffe/SCaUA2lbT2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FyTM5IhM0IXVfln1WIoOEBCwhC9BUQXgOPthbXHJHpB19Ssp5mS3jQVXQJkv0aWrt
	 Ufka7vrwUEiJgjzHuB13quoqJVy7Mp1WfPfe9sgCXxvVZu5ABrbrsngmob5gC5QWh4
	 O5m3SOlD5hJIdgHXiAbzBEkJRyWviJMlCka3Zbeupe1xrLkdf3NhAbBDe5R9rq8xsi
	 KNtct8qH9kUVDCLUAW6nje/QT3OqQhaGu5GtoBlZT1Pvblxh1vit0EBjkVhaACNLC4
	 wMuS0BE7c6wacqM9uEmtYvO6+1M9b+6XP4s2m/3/wql9z9YdPXvYAVAjUoaHCWAaUU
	 65S/p8xoOUgDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/7] genirq: Add GSIM infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luigi Rizzo" <lrizzo@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819124341.4185621-3-lrizzo@google.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <20260819124341.4185621-3-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 12:48:53 +0000
Message-Id: <20260819124854.155B61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce the Kconfig option CONFIG_IRQ_SW_MODERATION and GSIM fields in
> struct irq_desc to support Global Software Interrupt Moderation (GSIM).
>=20
> Note: This commit only introduces the configuration option and basic
> data structures. The core moderation logic, procfs interface, and
> integration into the interrupt flow are implemented in subsequent
> commits. Enabling this option at this stage is a build-safe no-op.
>=20
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819124341.4185=
621-1-lrizzo@google.com?part=3D2

