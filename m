Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C4332EC1;
	Thu, 19 Feb 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491744; cv=none; b=UsldG0nKFcupAn4D7ZKTzK6uIBiakg782mBeIxflcT/vg38C8GdnGt59XBduETklrxVbOQC6CuVGIWbBvihxvUwYWOfOrAxHIh6ESchadnUsagDkO+qeSoSJtuyzJNu6VCORcNyuLLHWXasuhg2A8MQM1RrKz06bj204eYbqR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491744; c=relaxed/simple;
	bh=cmzwAyQlD7aw4KeWpqKfb6cmRQVYU+DuusqIqogTB34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXHtMpuv4CN8mRlCn1R03qiCVTyhh0NcR1n39GLUAmqIvKQaNNL+V8RWN/GbrXKNoOBhIg6Zlv5ttrp/SGkTdY9Z+RADlVl8IKAO720uznqqp+Trwo1xy6avTIn/B3TzKtFbQ7YhsLMPqhbdWdXdiawBv7C8dZBXW7SIiwWtcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKAuuE02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKAuuE02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589BDC4CEF7;
	Thu, 19 Feb 2026 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771491744;
	bh=cmzwAyQlD7aw4KeWpqKfb6cmRQVYU+DuusqIqogTB34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKAuuE02c8jiqE6UGa7AjTdDiv4ALgLhZDxU+gT/mBYL3Zw/L85OmBWsRggQoiJdm
	 DfQ0Y1GuVjpml8T6BkOOtE0Yfav9eT73Ecs9Cw3BG9KuomFW1fb534n5NRMedKGHx/
	 BpEn5E5bGgCy3qLasqkGgT6WUyuwAvHUqOxFA46ebsOuUWtF1i9S7a3E0ISf4Sxz9T
	 aYsSsv21s8WS2OpEHCM3wTw56J5LFBbHmzJZ6rCjWBYmiFZB4MDTeGeAMU9Q4IbIJ8
	 T3ZHS5zvScuoq/Moz14DiokT03uPOTHj4cQz/QqBz0amB6+6Gm1D3oK9GdcdXgUwuO
	 DqH3hgjc6hb/g==
Date: Thu, 19 Feb 2026 10:02:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Arnd Bergmann <arnd@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <aZbRkXM2vIgAwvzz@ryzen>
References: <aY7wXJQJsfdqJ4j9@ryzen>
 <20260218180027.GA3435176@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218180027.GA3435176@bhelgaas>

On Wed, Feb 18, 2026 at 12:00:27PM -0600, Bjorn Helgaas wrote:
> Are there other undefined references lurking that we just haven't
> tripped over yet?

I guess time (or Arnd's randconfig builds, or kernel test robot) will tell :)

On a more serious note:
I don't think there are any other undefined references caused by my
commit ffcc4850a161 ("PCI: endpoint: pci-epf-test: Allow overriding
default BAR sizes").


Bjorn, btw, is it perhaps possible for you to remove the tag:
pci/for-linus

tag pci/for-linus
Tagger: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Aug 20 16:37:46 2012 -0600

PCI updates for v3.6:

  Power management
    - Fix EHCI-related crash during hibernation on ASUS (extension of similar suspend fix we merged in v3.6-rc1) (Rafael Wysocki)
    - Clarify D3/D3cold/D4 messages related to runtime D3cold support we added in v3.6-rc1 (Rafael Wysocki)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJQMr2TAAoJEPGMOI97Hn6zcIYP/0GNPqoPWKxummEVZJO4ctZW
l/c1HrsBdh8Yd296wLsI8LFb4ELWL9YYusFxRXjbBiq45QyH50f1n7plq4qxH6gZ
cjf1s2OkMEK3/nh2kXj4FNjFDSAA2vgcTQI8p4M+BcNaKq87hvvT/OQ0iEi4fOul
E9UMrSf1RP9hkHit/pbPm53JARYHNEWoZxc1p8+Dd0I6i6igdRuYDoT8eUYp6l+c
Fw7oR0qmxy6fByqhjKGJjc1rzs/1J7SDPDUzPuMtd6XAUni0+V9gfOl2/YoMzB8H
C5f8OYB4Raoz3uKR/rqNXS8dcxAxkzhtUQQ+CvZ4t7qhQueGI0KZMrJItJyinvQb
NJuaE/7VJJP3/sPtO0X4Q+UPWvMoASswcDyR59NAUroD/WmlGLSg+GiySPC/kn+H
URUeqF2ZlNsQmZNnw2j3g1HD3dipYEAivDIt2Z6CCi0080tokFINAxEibkpCyjB2
WiMKkC6tw5ol9avbRtV6OlJDwbEKSqm+LmwBcTCTz09lUBD1+aMTL+s8SnE9y4aN
AowpRWkKhRyiZsYrRSsiL16wAZZB11ueRWIJ6veA4+KFQxyoVof1IvbmBZ1EEhAU
/AJ7jkPHG4yKfk/K9w7oCCVI4lT7rKTerjzvw1kd8Z4zs0KMfI4TJKBRaDK49gA7
p3b1r1nisHMhPPh1zXal
=2g7M
-----END PGP SIGNATURE-----

commit 10c63c9aec648402f593b6c883ca247ece7b2af9 (tag: pci/for-linus)
Merge: c3e2f79d2d48 8f057d7bca54
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Aug 20 13:14:22 2012 -0700

    Merge tag 'usb-3.6-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
    
    Pull more USB patches from Greg Kroah-Hartman:
     "Here are 10 more USB patches for 3.6-rc3.  They all fix reported
      problems (build problems for one of them, and easily repeatable oopses
      for the others.)
    
      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>"
    
    * tag 'usb-3.6-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb:
      gpu/mfd/usb: Fix USB randconfig problems
      USB: CDC ACM: Fix NULL pointer dereference
      USB: emi62: remove __devinit* from the struct usb_device_id table
      USB: winbond: remove __devinit* from the struct usb_device_id table
      USB: vt6656: remove __devinit* from the struct usb_device_id table
      USB: rtl8187: remove __devinit* from the struct usb_device_id table
      USB: p54usb: remove __devinit* from the struct usb_device_id table
      USB: spca506: remove __devinit* from the struct usb_device_id table
      USB: jl2005bcd: remove __devinit* from the struct usb_device_id table
      USB: smsusb: remove __devinit* from the struct usb_device_id table



It was created in 2012, and looking at the commit which the tag points to,
it is just merge commit from Linus, which is merging the USB tree, so it
does not even seem to correspond to the description of the tag.

The tag is annoying because, if the remote is named pci (which I assume I'm
not alone to name the PCI tree remote as), you will get a warning from git:
warning: refname 'pci/for-linus' is ambiguous.

Because the ref pci/for-linus can mean both your branch (for-linus) and the
ancient tag pci/for-linus.

Since most people why do a git log pci/for-linus wants to see what you have
queued for linus, and since the ancient tag seems bogus anyway, perhaps you
could just remove the tag from the PCI tree?


Kind regards,
Niklas
