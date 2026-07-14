Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B92931CD
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056894; cv=none; b=XWamNXbaa0P8Q8qspPQ++ubuVdtqg3hIrOsD7WmcSbxNHjoqf/7scPu5vhIZN0r0Xf4Po2Cb8Vyy9TTezz+EDU/Z1W+Rd+uEkhlIMBKA8TsBvUjB18H4Dm59hXR82th5KFzFgAN4cLuQA9GqLj3gyXmyzn+KPhMwdN6DlnmD03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056894; c=relaxed/simple;
	bh=z6SqYQS/Muu6tRSeGc205/UnTfSJRpZyKBvi1vgonDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DTOqNgKhTZIqIuSdYNpSMUqcExjZWJHVwnnDf117ZOsz8JPjaibUyJ/k2ea6cE8aB+I5RoNWe2dLrBS5gqv4RYwTLyW8F5ay34P4DkzMqBcz1fJg7mjYBf8cRjym8BB1p2lyF9/FJced1sNKvbWGE94918d5bVPbOt4oQVQrVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjk/7TUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjk/7TUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237021F000E9;
	Tue, 14 Jul 2026 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056893;
	bh=z6SqYQS/Muu6tRSeGc205/UnTfSJRpZyKBvi1vgonDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjk/7TUE50zRy/Tbhz2q8L3yh/XS7wpCQPx7abZxY4cJ014GByOrbdxHcqxWaz7t6
	 BV8DT40cEFOy2AWZugczdc4LuCcSgYjO5XutOE81u+8CyZ8WaQZFXKHFIRDXQcGKKG
	 HDklkDWDNksvE8cxl7IVZSZpNZsIGSvTtYnrVf1wBSCWDUTuxLni4J5aYWZTmmzF4G
	 LTXaEct4E+cVElwws4u/8DG/iO9y9YAEJ8eeijgizv4vLHdCBvGbu3AywdqSqKILJh
	 IcRrPy7+9TLUyaQKkIAXit8wEUo+AKJZGddhRwylnb+d6s/JDQ6BcAq46GOAVjN/BM
	 9Vn5qCY1mHiGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] ACPI: video: Convert to use
 acpi_dev_is_video_device() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714185915.865396-4-andriy.shevchenko@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
 <20260714185915.865396-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:21:32 +0000
Message-Id: <20260714192133.237021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace open coded variant of acpi_dev_is_video_device() helper.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714185915.8653=
96-1-andriy.shevchenko@linux.intel.com?part=3D3

