Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7993448394
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778585; cv=none; b=FVwtUscBESk3lbU+vZ26Qu3D9IK5pdJK+WnY6yqBPMX6ia7t5ZpYgOfGw2GiFBs0LreVaFiqGXOUADBoDXelkAyordCxAb4o3kAAZEOqbjV9taQkPRHtkTmwdz6D/JHoHTIebw5XixV4pinjcWP3ZubAymd9W5j1E4N+gab9s1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778585; c=relaxed/simple;
	bh=KyYUcG5IdVDhrOPrJly5tKHX/olCAk+zxFrURISp3l4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aWKkiXSj4t5g6o6pSJnn+7w37OnUL68nFyxU7JLBmo5L2YNwyWoogdXf47DZ31yZGkzYY3V0kjPH5XBZ9xk+2FcIun5fzrQGKnXfMe6xc6TFN7bCnAt4H+YRQtmTzBKJylAVnHTQ4rQvoF/MIFfG9yxMptfwvxDrW5i+iay1BQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk6OW064; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk6OW064"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86FA1F00893;
	Wed, 30 Sep 2026 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778571;
	bh=QIBGxKN/4RVm6L8tj7cIAuaYABS9eRZrlN4JQZLp7sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nk6OW064BjjQwYwtmFJGcrl1q5ApurRNtgIaFbEjETs/o3Gi/swx/A3o3YkFtVU6U
	 fw9bUPvC5ahzZ6a7zyHlZpLc/pkdHTUR+4/NaG6rrPdd23kHhWtmyUyrwPFzzNF47q
	 1NqcYR3ufKCIcLIjdbaI7hX3OwR0U2u/yYqGtqgn/p/ai8Hz9Ue2rqOTzLDbqzfn2o
	 Xm5tB4jRkunCbNyucxxWynwttRFtPvBP5cLj8xcDyqk2CG3NrJ+1Nz3oyi9YOqv7TJ
	 vXf9vzBPx6i5rxmwB8DCSPjLJHn1d7SaYw2aMKfvCQojzFg2z2ppBi1o9I2HrVtk7H
	 yMDlwhfQG0RBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI/PM: Do not save the config space of an
 inaccessible device
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930141914.6678-3-fbeltranmillalen@gmail.com>
References: <20260930141914.6678-1-fbeltranmillalen@gmail.com>
 <20260930141914.6678-3-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:29:30 +0000
Message-Id: <20260930142930.D86FA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_save_state() reads the standard header into dev->saved_config_space
> and marks it valid without checking that the device answered.  If the
> device is not accessible, every read returns all ones, the previous
> snapshot is overwritten, and pci_restore_state() writes the all-ones
> values back once the device answers again.  On a bridge that sets every
> writable bit of the Bridge Control register, Secondary Bus Reset
> included, and sets the primary, secondary and subordinate bus numbers
> to 0xff, which cuts off everything below it.
>=20
> On a MacBookPro14,3 this happens to the upstream bridge of a
> Thunderbolt controller that drops off the bus while the system is
> suspending: after resume the bridge answers again, but with bus numbers
> ff/ff/ff and Secondary Bus Reset asserted, and the xHCI controllers
> behind it are removed.
>=20
> [ ... ]
> If the device is not accessible, return -EIO and leave state_saved as it
> was.
>=20
> Assisted-by: LLM
> Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gma=
il.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930141914.6678=
-1-fbeltranmillalen@gmail.com?part=3D2

