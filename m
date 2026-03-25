Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18C13635C;
	Wed, 25 Mar 2026 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420610; cv=none; b=BBqopwqDyYwjOhnAiOgn8krxPOY1DU85wNjLXiMBCtFYAvAZ2+26KkM7JmQdb1YdZzLkRwOKvCwuBnAg1xxB1cKXL9LopIQFVaiOgspqcBB6V6r6vwSbyKAC517/6S4xh47/1PNMjCoCYIt+XmAxYpt704h1b0chOg9pGdllH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420610; c=relaxed/simple;
	bh=yR8vbOL+OgIKnrJPYbc3VTIiKUaBBS7srWl0b1K6Az0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8a+u2iRNLKqboqo9K6XGN3+Z33BNciS5innhJ2onpqUgAIpYQTf+1Ps4VXDPrs3s3nbN4IdtcoE5t8X6qrV+1q5hIKgLwJu0qRnRogVOmXOlaX+w9yUIgg/qff6xaqhlb6pwSDXhFPlZRvmXIMEczDU8t/4i6uH58v4QLXwEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 043DB3AF;
	Wed, 25 Mar 2026 07:36:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CB4F36033925; Wed, 25 Mar 2026 07:36:45 +0100 (CET)
Date: Wed, 25 Mar 2026 07:36:45 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>,
	Grimmauld <grimmauld@grimmauld.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <acOCfYR3ii8RoKLz@wunner.de>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <DGZJBMG2Y738.2MU5LXVGEDD47@kernel.org>
 <acNYJ2dyPaEzabYL@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acNYJ2dyPaEzabYL@google.com>

On Tue, Mar 24, 2026 at 08:44:22PM -0700, Dmitry Torokhov wrote:
> I think the bigger question is why PCI does something different from
> every other bus? Why doesn't it rely on driver core to bind devices to
> driver?

This was introduced in 2013 with commit 4f535093cf8f ("PCI: Put pci_dev
in device tree as early as possible").  Corresponding patch submission:

https://lore.kernel.org/all/1358803252-20639-12-git-send-email-yinghai@kernel.org/

The rationale in the commit message for performing device registration
earlier is that devices would otherwise not be found by for_each_pci_dev().
I don't know why that was a problem at the time.  The patch is the last
one in the series, so there's no other patch succeeding and thus
depending on it, which could provide a clue why this was necessary.

Needless to say, changing the behavior now risks regressions.

The author of the patch is apparently no longer around.  Last activity
on the mailing list was in October 2017.  Access to kernel.org infra
persists though, so maybe he's still reachable:

https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/plain/keys/A7C92F7A39BD11DA.asc

I'm not defending the patch, merely trying to explain the history
as far as it is possible.

Thanks,

Lukas
