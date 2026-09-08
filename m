Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F41440A24
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908620; cv=none; b=AUvbg3zwp4uZQ2ekxF2dF0vCM7hN/FUI1oGkLDc/bcx8Ef5kujEzZ2Wgh/DsrtQanovPvbPFodViuzBC+2Y+IUqJjoBDH7q7Ek54+znTexIhroM8NNVo8s1y/kkW0zRzdXmgJxm2F5PuiXT9OoiCYR2h7OrEUdOOnHpkeH4rr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908620; c=relaxed/simple;
	bh=8dNXxg6QWDs94S89qscFUVRA62qWFCvWEhrJuYqboII=;
	h=From:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=Z03DhaNBwRQqx6/zaTL5bvc/FHkhdyUzoc+Wdh8CU9/l/Vaw4ZsWC0nsJKMgkv4PmlKdidW27cAW7sXBlsdkbdV1T/QwskOUXaaISFkuIvkkTbCEA2byDvfJIE1TrYxxFEi9ouvVManGZ6b0UWEqooTdf85AQG47iiCV+nmJAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=Tp8/DpZr; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="Tp8/DpZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-type:content-transfer-encoding:cc:content-type:date:from:subject:to;
	s=s1; t=1788908617;
	bh=UvAuWdRNhxBj0zIQCudhRLv5rmtQK2pKzB9otIfWB+I=;
	b=Tp8/DpZrouDPj5p5W9hL6qnFC0t2gNV7V25Q/uWh5dsMHXp0BFTdIUm6z5//m4OWsycN
	wvmVA2WxjpYTd5wJu0koV8NidGH6xamxqxA6tf3kZa7ei+l2Wy9Y6RYIttJMaBM29Ff9Jq
	o9odSYAN4dtblVynT718T6vYx7xoPaH1s8mpmICadIHV7GQDEx9CZeCL9Rtmj3BuBS/W9T
	TDvPZrJWAstqiTmEw38Pi8jVa30AoDvPYgb5nNKtB+4Q6+5XWFOzOWTqq1JETxbXbiUsaX
	gDV+4dweWMWXIe/KdGChU0K+xs/qQPdnlonnkDya9Vk3PH1GGPfANFL+tBR8h79A==
Received: by recvd-75688db57b-dswf8 with SMTP id recvd-75688db57b-dswf8-1-6AA09449-12D
	2026-09-08 23:03:37.621995259 +0000 UTC m=+697365.363574854
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-102 (SG)
	with ESMTP
	id 8chTIw_2TIOU_JxuVrOLcw
	Tue, 08 Sep 2026 23:03:37.406 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v4] PCI: Fix BAR resize for devices on a root bus
Date: Tue, 08 Sep 2026 23:03:37 +0000 (UTC)
Message-ID: <20260908230335.62766-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8866d915-56d1-312b-ae68-b65021abd914@linux.intel.com>
References: <8866d915-56d1-312b-ae68-b65021abd914@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeSz1FDEY+=2Fil?=
 =?us-ascii?Q?XfP63B3wHcxN57FkNN2flTO16G2tHBREDp1ByV9?=
 =?us-ascii?Q?6wkjKG3MiIiHMwHVO7E4PGFvnjAFPVfRfnhFrHO?=
 =?us-ascii?Q?4cZC7t8WKDo=2Fx5onjg0mMOJWyBbVfBznfHERTU6?=
 =?us-ascii?Q?Opjuq0V40LG3YNZofM+pkZ6zUxoP1aZC0n=2F2aaF?= =?us-ascii?Q?JOXJ?=
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com, bjorn.helgaas@gmail.com, helgaas@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org, jon@solid-run.com,
	jon.nettleton@gmail.com, jacob.martin@canonical.com, stable@vger.kernel.org,
	kwilczynski@kernel.org, regressions@leemhuis.info, lizf@honeycomb.io
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

On Ilpo Järvinen wrote:
> Maybe this is what has to be done here, but I wonder if this could
> use pci_bus_assign_resources()?

Good suggestion, and it brings the else condition of this code into
alignment with your design goal that the core bookkeeping code should
be used as much as possible. Implemented in v5 (note to reviewers, I
am clearing reviewed-by as this is semantically different):

  https://patch.msgid.link/20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io

