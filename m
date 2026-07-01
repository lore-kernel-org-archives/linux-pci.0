Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E9270545
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937355; cv=none; b=PhTPK5G6ziuOSNaCPwmu/AaWbEG2/+uYZ3Fheb92LVTzKxJaaz3uXpLEkLu2i2i0A1gRDrSqxjgIQfAt3EFtUZSY/tMBwzH9SdFAbIxrlQFWCj84pnSPE7cHE8hfXIUC6Lg36bjBxzqemwTlQTikznncOswddQSI2Q9LXuRqP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937355; c=relaxed/simple;
	bh=Wdl/CpmR/VMFZ48C7FB8X3PfOeQaYePruNXxJzV8XRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h7zKDxJx5vJsg+1GO0Bl9+SzvfuXHYSKwQ8e3cC7vjEmbi/6TBkQk9qnPsXpUnb1+G6r8dTB6BTv4osZ8BQP0mHbJsEaztWBihkuRnWWArxRjeu+gtx6EUgG3FpH1osJwKbrEgxPITctF9yTsCQ6qULjDOuXkiDXB9CuqCZ9Z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/hhP9Zf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/hhP9Zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C6D1F000E9;
	Wed,  1 Jul 2026 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937354;
	bh=Wdl/CpmR/VMFZ48C7FB8X3PfOeQaYePruNXxJzV8XRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T/hhP9ZfQ3Fm3C7DMZ3uwfZL8UB6A1ShKYRjWBXY/uSB5xaSYsqUt8FfvxFU/on/u
	 v6kdXEzsDx/MbFubMHInT5O2DgIHFrAVA2WVK3m2ov3UE/ocdEO7nW2SPnwln5XLZi
	 CuG0WpFfUOikr8ikUfgiic+c3l433XLP+9RAmz9zLEguA3zRZFPHYQuuOqnXwQjpYK
	 QO/whsGtwEuFvUjJm8n14+gjQvL4bzADvFVq0sgmd5jAacf4lhCH2EQWXwlYAT/cDC
	 7OA1AM4a0sWdOpUkTCwnxW4TejLeP/mlwjmGE0UfUj8KmHZWU0dHZNQ9XpLA1k8xWx
	 lmjq5uiOFx2uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC RESEND 7/7] i3c: mipi-i3c-hci: Advertise IBI wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org
In-Reply-To: <20260701201533.220818-8-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-8-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:22:33 +0000
Message-Id: <20260701202234.10C6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Set master->ibi_wakeup during probe when the associated system device
> advertises wakeup capability, allowing the I3C core to mark IBI-capable
> I3C devices as wakeup capable.
>=20
> Tweak the comment for i3c_hci_sysdev() to mention the new usage.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701201533.2208=
18-1-adrian.hunter@intel.com?part=3D7

