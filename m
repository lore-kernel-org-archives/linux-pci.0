Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9124457CC
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854761; cv=none; b=cVLyOmVC3zu5LSxIVr0XE94GsR0p4kInjzrCkWX5xBP0dUPffbf6lwTEo3ysG3PcZ6sjlWTEmUEfKiM32ocGdtw8eoUbL+58ser+3AT7yarehRhgACb0I4Eo8IQ4jau+5QYcbOvDL6TddYz824AirVoAQ/2yOLD8p12hjnEH5nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854761; c=relaxed/simple;
	bh=v8cUFKLEq0DR9kmNaa4fV2LIaZLzUKvb7eluk0TnYVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rMXgyz2CdWxRdbuRa/hu7okNpyQ0Kx3p/ztObxguJwRrEd1Iwis1AkRcA/seMslAALEadtZnN5DByxdQ0EhbfL4LL79i9Mr6Bes0wLIoSzam+vYwIx3rxKd+8XYLpgqmalw7gSQ1LN4nH49wFrchtMqWDjWTZlLXkgAPP6ncGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHrzU7BW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHrzU7BW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF7C1F000E9;
	Tue,  4 Aug 2026 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785854760;
	bh=v8cUFKLEq0DR9kmNaa4fV2LIaZLzUKvb7eluk0TnYVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHrzU7BWc3GsvpTCDnKEip7RPg+V9ojbj6BW3JUazWB+K9Pe6hbr3c7RwYRismyGd
	 AQomZhNaZrQzifACn0bec0ihQ1AAnvpCIz2Gu3xqlZKRXxCFcAzbCzDTqyJkAZcSQZ
	 ZYt4CznBuonS6ilU3ySuHEeKJlgF85aIoTt9QeiSpWnW5+RVkaGN9pkaJDjgwoPmW9
	 XUB5z91aWHqMc7/75sfrVkhzM6eaU66TGpZz6ILs95PhliqxDKNxaAyzqKSzX11Pe2
	 8n9Lqh3xwno+d3FWkpRVSmdbCHPHnFTQto2Edn0LzMym4LPnEqAaOwxxZaHe97UPV1
	 +Fv3vrGTfla9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260804133810.184905-15-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-15-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:45:59 +0000
Message-Id: <20260804144600.0EF7C1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D14

