Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9983A6B67
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259533; cv=none; b=RfDBK3E7jd3hIkWNaaBnHzeIeSMBpp0hqSN05pP+eQCN8oRhmoyFKp+D2UvhZIZWYc6pX5k0qZfUpleNw3MbKEhn0h+HAWDs3mX9Oxrmkwu77ouDoCRObfo7gBPc3mxYH6bZh6LK46fSSGM65+EzDIiEhcfx+u2IoL2AaPOX1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259533; c=relaxed/simple;
	bh=hwj31KkaGnYqjcX7tCCojMjr3Q8V465LkK7EBYOaXv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PnA+T+tocTxIHYIHxxZux3jiX/DvhfYFJtRNbarrtoQG+ZyB0NJ0Y92NCv4ym2rjx0X0+laehP3E4PdR3qBaIwzqMy6Qj3ac3NVMUOksn4b9RI06qQaSkeHEjN3srW2dmT62aE2x3AXbUS/g+VFt5ZiNyNJdONKk+9dYUGkSo8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+38a0E4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+38a0E4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88481F000E9;
	Tue, 28 Jul 2026 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259532;
	bh=hwj31KkaGnYqjcX7tCCojMjr3Q8V465LkK7EBYOaXv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+38a0E4DpoogOknQOzu4npqKuV9QdEnSzSCvvnDfQoBLIj7NocPUpFCohIWomFYo
	 7XTL0dU1+lvWQNZr8jouqW5CFCY3Xrfo4DxAmALweUtZ+7P6jETwAf8PDU5mnbCAfg
	 L/snhFPy93t4IZB6y+LKHslM9Pie06F5Xwl4k+XlOkOX3+4f5/UX3NDkivgNYB/qXT
	 B2a9k7gDBl+FXRTN+ridYSglrDKlGiew9PmFovmYNOPVf9L7VbR3NeIEdB06Z2BauG
	 qnckJhF+W+UKcTjEDBKChrWoBL4PZOhu3snH5+1GLJgMQXxmb4c3TSjIZvICzGr3MK
	 xT8zX2ZYw9/rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 8/8] i3c: mipi-i3c-hci: Advertise IBI wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260728155308.142713-9-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-9-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:25:31 +0000
Message-Id: <20260728172531.B88481F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728155308.1427=
13-1-adrian.hunter@intel.com?part=3D8

