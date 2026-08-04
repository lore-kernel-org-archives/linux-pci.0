Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D442393DC7
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854461; cv=none; b=T8rJkDy466qXwj25e9T11gy4OxwgHkTcLbmYrlGN+GGe5+btgK8fyiYz46Vw3KWMmLRiTDiScJ/2Yp1RPx31OytdYKBomXl9rVBK+lTs4/4wDI+f7Ry/Eb7snj3wivtPDrs4Z922yQamgu6Src57r0GJkcnaBEo/uSkuB78fbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854461; c=relaxed/simple;
	bh=lz697MiEZejSdiaZFCI3xzVFWQtMSBeoXw2TNQ2kOqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rbsPN98ldVEIiJXUiK5XteRsPly6zjB8VxPCQHw+2W35oGzi6bpg4tzIr0UouDPIXh8WMoMYywUxfBe4jN/5Ur/ZV/jsXh1uK2uv7nxIGewKmNnuWyvPTSQVedqoZWo/LBM0HQQPdVKk7sSZCMhtgT+LuC/PzcnRcz9NTMeaSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrbJM0hd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrbJM0hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474C71F000E9;
	Tue,  4 Aug 2026 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785854459;
	bh=lz697MiEZejSdiaZFCI3xzVFWQtMSBeoXw2TNQ2kOqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RrbJM0hdYT9FMNrXwVid1N72nfxHkqKOYFW+x9vaE2qFMMd5MMfq0YtWrLBYcOswH
	 lJPB30QeOs0iaU359R+Drpi/GOygrbp4hxhRDv3nQ4fNlPTqE5pQ9JotRnJsCP5J66
	 wTujUZJhoJ4nU9XaofXAvNcluk0U2BOR2aOvWQmsRIN1PiAqaHGdqyOmcxSTFpkg7c
	 TA0Gquq+gJAuLWN6qAv+UJGE5xcWFrB906afdR97ROvu1c+3AXTljblazDG3bnp2Ad
	 j3bYoIpWB9FE6bgbEVOEZ/IETa8FQ0XX1XG3djfR+bHoEGrZ4+5OH917p9pcvh4ntO
	 eIIWjYaYH4p8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260804133810.184905-14-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-14-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:40:58 +0000
Message-Id: <20260804144059.474C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The MIPI I3C HCI driver needs to identify the underlying system device
> used for DMA mapping and PM operations. The logic for determining that
> device is currently embedded in the DMA implementation.
>=20
> Factor this code out into i3c_hci_sysdev() so it can be shared by other
> parts of the driver and keep the device-selection logic in one place.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D13

