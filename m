Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194B2931C5
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056682; cv=none; b=f783M8OPKhlbSAPK2b0P5SoWf+mAi534dqB+qVu+Lj0PeUB9mCdYy7WrvTXShGpAQ11st6XDnVQN93JAV3b6lJZ5Ok2KFzVvdwf0XvwuGEXLY12APsySJxjtHrQaboBh1y4I7eO+/9Ex8XbWVOXr8EE7QaqSBCr9hxN4s2xCgPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056682; c=relaxed/simple;
	bh=pD4cMsb0nU61iToMV0Cf76kxS7ETzWOCRQkxIrFQ8GA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fI+JKeTEgqd2CSwYSSm60BYbsjdk9CXaZRjN/ujnXY6+UOtdmMeDhAOwZss+DitGFPZuWU9QdFex2Wyyd1EyRP0rC0Cc/zdI0RYvXavbkLY1rRq46Dl/Qo/PHK92uzcNexMPnUgUvqNEp+jTupCXNbcjGLayG/fYxIDvMuKy6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGvrk8Rr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGvrk8Rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B216B1F000E9;
	Tue, 14 Jul 2026 19:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056680;
	bh=pD4cMsb0nU61iToMV0Cf76kxS7ETzWOCRQkxIrFQ8GA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGvrk8RrJYCqyIXPTt8UDB2DXC1MAEaplfDcCby+tvoDsh6WXQUwBpg3rqs02yDZf
	 8S/UXuZI1KYYRkCn4hESe8IMtfwtBHPprHbDyxFRX4pBqg/PKdqznltvI80W+uu2HR
	 xk5kP5nCF95CfeJYL/yITUQXXTSMXiMXv1kPNn9NoqNOJKEdMwBgux1tOsxIjZInxa
	 dQfXhctFSYnt9aCH7kw8cf3OzLXmUKT2fVVFTUiosioYzWsF9Lo+1iNNK4Au/ZRUkJ
	 OCiHT3qpVvELPYUyixM3KeNt4eEeClt3k6HBPDl0WfIgIG7mvCnVaxZUOkZpO75LmO
	 2sv3omhMbl6gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] ACPI: scan: Convert to use
 acpi_dev_is_video_device() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714185915.865396-3-andriy.shevchenko@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
 <20260714185915.865396-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:18:00 +0000
Message-Id: <20260714191800.B216B1F000E9@smtp.kernel.org>
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
96-1-andriy.shevchenko@linux.intel.com?part=3D2

