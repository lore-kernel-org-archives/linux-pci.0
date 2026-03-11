Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60B3B636C;
	Wed, 11 Mar 2026 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216307; cv=none; b=XAMUGR/N0FC8ayQ5w9GsN6yASylpgl/IAgFpyd4oIrQYLkckago2r3QKa9Z7rrSURhh+u/tZOr6DGMXJLkVWBh3pA5NoWQOrvmhqNMuHVTzeCHQeJqei7JKzQA8BClp0wMdEi9m73SLo4AkNo21F0qpPJETcouun7eX1iEYB3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216307; c=relaxed/simple;
	bh=oZX4ayMIufI52STs6KSNM/xHpH99DGI6l1fwhjaFlpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEykZCNFBGAKz6pJ6r7VURR6q7l/NtkMs4lavwDgpdddWz6m2fcTAk4Vlee8tj9St9UGZz+UEY6VRYhImZmoAvkVUpKDtPZXs29I70TpRSeDBgEGEdxMxaoemawKyzr++sIUz9DjLhXM9o0eOgoPkLEUABQBOcZ4aJl9MT+Oh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7116020202BA;
	Wed, 11 Mar 2026 08:56:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 54BFA61F83; Wed, 11 Mar 2026 08:56:19 +0100 (CET)
Date: Wed, 11 Mar 2026 08:56:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
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
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <abEgI2Q52C-p6cs1@wunner.de>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>

On Wed, Mar 11, 2026 at 10:54:59AM +0530, Manivannan Sadhasivam wrote:
> But isn't the underlying issue is with phylib calling request_module()
> while the driver core performs async probing?

I'd say the underlying issue is the call to async_synchronize_full()
in do_init_module().  That's very coarse-grained.  Maybe it can be
replaced with async_synchronize_full_domain() or async_synchronize_cookie()
to perform a more targeted wait?

Thanks,

Lukas
