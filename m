Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BD141B8D6
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058463; cv=none; b=oHdz+qj06V0gxDhyMo+fdyvuFM0TgtpKIWzpiHrnK++2K4gQezYxLWWwDms4nlXkBhL4Y6sbL3dCIhCmMtz94pBiP7icmCIHMmBofb86AKE00nAxPR4v4caFfcgpfQNAphfxIRutez+ZnjxHw/KdCD00CxRCY6ItSUo0KUVsg9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058463; c=relaxed/simple;
	bh=HhUQ6H43J6+jaZTnnyqzXeFvQvPjTxOBeDMMFNdU87g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kt2fYY0yxL7BAg5GJTjvFGapAHgBg+wvR3QW9F0vg1/OqM96O9wYAhYQW4W0EyZgdOQaCPerNS8NoPB3kRa+40LmEBcZGPMgpkb5in4R+nSIZoSYl84k/TKYS1PKEIAJJcadRM/pJF0+mPyQH91RjKscQYGyLT1IE+KT/pwe5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jljUeRo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jljUeRo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDB91F000E9;
	Tue, 14 Jul 2026 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784058462;
	bh=HhUQ6H43J6+jaZTnnyqzXeFvQvPjTxOBeDMMFNdU87g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jljUeRo6YfkCyHCLIUrib7ftgOi/l5xmbtI8qztHRzfnOY8tbCSduI4j/Pb8pcvud
	 cQCHZcO/G40sTXO7NAZwVnM5MqgRIqot5Si/4ZwF/3I92goxlDcbesHc3rB/mEIKoF
	 kYo8L0drOgKucRAgvLlTf9SVPQfPM/0ry9f7TQdIC7902cmbxqlCuDdpTB7Lqj7TMc
	 Pj/Tdu+zMda04skQIvyzEIiG+R6l7YFLBd9Ob8e9Pl2jhRUslUULIV+GT6MgXrIt6+
	 Ci5vok9AjA+FWwYIjhb30R/78qR1nk5p16O5KV+6uIRyZkQmzwcouICbVayEwgd0pf
	 W24FYgKItokRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] platform/x86: thinkpad_acpi: Convert to use
 acpi_dev_is_video_device() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714185915.865396-7-andriy.shevchenko@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
 <20260714185915.865396-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:47:41 +0000
Message-Id: <20260714194741.BEDB91F000E9@smtp.kernel.org>
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
96-1-andriy.shevchenko@linux.intel.com?part=3D6

