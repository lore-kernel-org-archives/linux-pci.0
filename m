Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C543F095
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148490; cv=none; b=c5iaK1p6FJ5w7jk9nEhnM1lLVbtHPPW2V9kz12Htfhr4EkZBEWGiTOx2K88EhWdqlqMx/yen81YQbs3AODTbKtS81ygWjEMGuJwwQND3Hb+8qhMZXGjmXpNTzKRk84iPGprMjgRxLoeWrSvO5FjBFTIZhuaLsVPngmLjEr0eSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148490; c=relaxed/simple;
	bh=ZHn38ir42I5MXzsHXanNHCraHghRXxjGGaQwyVrUGrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uj1BZgHvVcLzm6So4ZdI5eifmTRZ5hxx6luRVdNQtWFusqjJv/sLiJKNsc5CFSck0m7VqM7X3qmjjesyMRYjQUJUQBN4q+lvYLWKhl1C+CGz8dPYK+qjLY+uIlMUw5KgBhc+se79DhOhD0F6LNseDCMQPIaH6ftNMYKPk21tnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrBHrMZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrBHrMZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ADA1F00893;
	Wed, 23 Sep 2026 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148489;
	bh=ZHn38ir42I5MXzsHXanNHCraHghRXxjGGaQwyVrUGrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrBHrMZEbvmeLMo+9OUZj8QEiiV4wHjqi2oxdfuvx4FSYjJ9fhhjuBoFDAnroNi2C
	 6KYqKsed9vad+iMeTQCjlqXCufFSaU9K3PO4mQL2u0U+uW0Kc4GcRCfh9/uQtIqdOP
	 XPgzM9b37LxRVFW/CydByqzBBqMeMLfCrxiYb0+RvUORtKtzh0n90AIQXYlNE/Jxn0
	 QybtF4+BmvH9D+SD5BJwloSiEF4Jiko0VhyEpA7gkV3aDCElTTUASidAvuTNlKb0xl
	 Rhw3FH9yxEtw2BZfdhD4Y8WcZd0AfDSB1AZTcf+c2huxlE6puv27Yo3sqN9DQySU34
	 VATZcDDF/x/fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Drop unused shift macros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923071706.1134320-4-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
 <20260923071706.1134320-4-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:28:08 +0000
Message-Id: <20260923072808.D4ADA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Tegra no longer uses the DesignWare field shift macros after
> converting the call sites to FIELD_PREP() and FIELD_MODIFY().
>=20
> Remove the unused shift macros and the old narrow event-selector mask.
> Add the complete event-selector field with the standard mask name, and
> keep a temporary alias so existing users keep building until they are
> converted.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923071706.1134=
320-1-mmaddireddy@nvidia.com?part=3D3

