Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15633DEF7
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116098; cv=none; b=TWFyG9AbtYSHQTafW2fTgHZK+AgvWF++9bzwq5yEHb0RC3/65/7u9yKVcFgliKqgHA+Tc1QQTJ4VAxMp+59vezty4LIwnvXq2oTUCWL9Bu4vq20AUgyvDb/oAnvUxVqLMtkh00YRbSA937N4orTs4BzDHrsY/j4+lfEweUn4Rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116098; c=relaxed/simple;
	bh=SueEk+pdLn2UYpDYmCTLlZtZf4v4PMCnFUZgOCjZ0hQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bYL757lcsh+P4B1nVTgGMJLkvaqqOxGGFhr3dhZvEZSNPrx2W8syExc0DBBIJ4Rwd3rpY5yBhYQ+R8VDDpmu/SLKSEwdYlU8dAVZilPqpKXkTMd5VU/LyGlMiMq/Rdfu5sGoipUK5UKozbv+7G/YcKfWlzoXimI+V9aYEdu0xUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU3TFgOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU3TFgOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C661E1F00A3A;
	Fri,  7 Aug 2026 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116097;
	bh=HvfVx2px783ZK0zxIrZXbXck7O6Nyc6MDpDYDMfNcPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gU3TFgOrXlcPIeUMQxlEsp+IDdIX4DN+oysi9xzBL0LXAWPDbpZGxEI2eOH3GoWzG
	 yuVjphiINBt/9Hk75w/gSb0aNuFho1K4UMWGRzD5xivmmAVfMnO4j8DGfls7HJL9Cq
	 5y/GjOwk4jsID94fz1ZJP2KZC4zOJa/mMTZGfIxn8i2U6Gq+Tw+OO34c62lllnMevR
	 9gdcXlxa8I2l4jmEPmVaEU+Qq3ZT6ZAUam2q+OS1fpXXIXHaEGb9tEUh8+xhHuoxZU
	 KViux5NJg4n0Yd65gCmcEzYVFTz+vz6A4LHt2OiJsy95go3f0DIWgPY8KSREmVPMmN
	 VWmMwF5YsQtsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 06/14] i3c: master: Fix potential UAF in
 i3c_device_uevent()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260807145638.168865-7-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:21:35 +0000
Message-Id: <20260807152136.C661E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> i3c_device_uevent() dereferences i3cdev->desc without holding the bus
> normal-use lock.  Since the descriptor pointer can be replaced
> concurrently, including when a uevent is generated from sysfs, this can
> result in dereferencing a stale descriptor and lead to a use-after-free.
>=20
> Use i3c_device_get_info() instead, which protects access to the
> descriptor with the normal-use lock.
>=20
> Commit 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling
> i3c_device_get_info() to avoid deadlock") replaced the accessor with a
> direct descriptor dereference because i3c_device_get_info() would
> recursively acquire bus->lock during device registration.
>=20
> This change depends on "i3c: master: Fix recursive locking during device
> registration", which moves device registration out from under bus->lock
> and removes the possibility of that deadlock.  Without that change,
> restoring the i3c_device_get_info() call would reintroduce the deadlock.
>=20
> Fixes: 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling i3c_=
device_get_info() to avoid deadlock")
> Cc: stable@vger.kernel.org # requires "i3c: master: Fix recursive locking=
 during device registration"
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D6

