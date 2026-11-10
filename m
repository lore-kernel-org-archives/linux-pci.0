Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306848;
	b=uZr2uv5FDQX1i9XJXyQIrwm8IQHFObcKJb/y/0PDS8FodeXXbyya9oJ0m7Hb3iVg2566
	 J+G56XPvdBwbvLetJJfPxvQgMs88m2rlWpDZSOQ4nxXG9dNPuyGaTAeLpxDlO43xT5SOG
	 uPWMFIeltOO+8f/wo6jPNdUuFE4bBJ/M9qvFdvXx7Q2PEEftxR6YbEV5h64W25nW4S5ZH
	 Ax2qWl0KL8oiyJRb7lwfFYjHbJDZkPxWIUocvNosH+3AvxsmOrHFlceY5hZqHGcy/UWea
	 1TdfARvt3xtxjP7hTEXBK7R7HvcaTloF88wpat3ju50exuEMTXnQ+5Lm/ViTw0/b5Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306848;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BDVHJjgxJtB0Z/B1mCS5I7G7TbCELKDyuTGiy+fw8dk=;
	b=18IpDRiEw2GGxQcnWVzXwWP2fHE/5stgoLBKlBJnnIYEJYOPAGyGIHVKvCNvaA2z2xxl
	 RnzNkt5U7ADmr/aLxyDd1CG4fXVfcXpFWI3j4RpH2btdte2Wo3We8Nuj0pauIjH6kQ8CN
	 8y4A6z+rAkFAGHoWzC6mBreSdIzLnHsWDh1R2jOmEtedia6zqofX820JJNz7v72dq4bCp
	 f35ri+pgKC33C5k/Xzi/EThZoP3NL62PIkyRR5Z8cLSLNIbw4WwxDvJA9+s/3sFJ4S7Ke
	 m3vENzsER7BKQW5h5K2B0hxh415y0n2kbw7z+xLZMxmlqN5WfGQ9fIZx1bB1pdX1NRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D388606A321;
	Tue, 10 Nov 2026 10:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D388606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id B2938276D;
	Tue, 10 Nov 2026 11:33:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9D07D6138C94; Tue, 10 Nov 2026 11:33:59 +0100 (CET)
Date: Tue, 10 Nov 2026 11:33:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Cole Leavitt <cole@unwrap.rs>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <westeri@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Don't resume the software CM if the
 host controller is gone
Message-ID: <avLzF-e6lTqrQM-7@wunner.de>
References: <20261018163750.130470-1-cole@unwrap.rs>
 <20261018163910.132231-1-cole@unwrap.rs>
 <20261018163910.132231-2-cole@unwrap.rs>
 <20261019042920.GX176164@black.igk.intel.com>
 <20261108051829.152803-1-cole@unwrap.rs>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108051829.152803-1-cole@unwrap.rs>

On Sun, Nov 08, 2026 at 12:18:29AM -0500, Cole Leavitt wrote:
> For 1/2: the trigger on this machine is gone with the new BIOS, but the
> ordering problem is in pciehp itself. A device replacement detected in
> pciehp_resume_noirq() still starts the removal from the IRQ thread in
> the middle of the noirq phase, unserialized against ->resume_noirq() of
> the drivers below the port (on today's mainline, fa4ad798f6f6,
> pciehp_core.c:310 calls pciehp_request(), and pciehp_ctrl.c:145 wakes
> the IRQ thread directly unless pciehp_poll_mode is set). Bjorn, Lukas:
> if that is not worth changing without a reproducer on correctly
> configured hardware, I will drop 1/2 as well.

I think the proper solution is to hold the device_lock() in
device_resume_noirq(), i.e. this needs to be addressed in the
driver core's device power management code, not in pciehp or
individual device drivers.

However as you're saying there's no reproducer anymore and
changing device_resume_noirq() is a bit risky.

Thanks,

Lukas
