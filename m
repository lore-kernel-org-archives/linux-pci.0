Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D214A5EC3;
	Thu, 24 Sep 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265379; cv=none; b=gCEV61sSE4ZsRjVeK7j0PJqn/+jLqxQ9Ip8W5FnoDTE7XUxmSkrPcWpRzueLiIVbfTMKnDrXK8jhO/4MfEmry7Nh1y2lE8+ErhT8Dlgk9KBac0YZp8vF/Aro6P4Q2njgWizQPsCS1aN3pEEUYoLXsLMtiQbftA4j6a09/wKKSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265379; c=relaxed/simple;
	bh=vcOjnbGn1ShWJBNTNFJrGQnXqDa49XfATRpJvsoyBjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6Ln4sSBqneuyX89UI6M/GYRf3GVqS2HhSmS+J+DGjuBTCvf9Qw3CrvYWb4VaSga9LdR+EhJwk6e++RhmY1/gTpNw+jALI3djrWqzWlc5yWc/veTX1mv9apJDRuXbQCfK2EfZePvMPqY2VbQhHHsJCnWP56cX2Wqe5XwiJtwdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZNzAyLUf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZNzAyLUf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 338881A1002;
	Thu, 24 Sep 2026 15:56:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B999060738;
	Thu, 24 Sep 2026 15:56:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46DCB10329450;
	Thu, 24 Sep 2026 17:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790265373; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QhjUZkH6Uy6DN6tthN3/8kVaM0dMZm+WmEFrO9JFRZI=;
	b=ZNzAyLUfSoPkWoZTqf6l3E0tBhL2q8BDOq+Og4GUhIpWMmzx7bs9+YPDni1u7MmNze1HgN
	z23wVm91nNUDIhUXrthZOsvk/q5fjHwPiDd4h+WtrB2ici++xiE2cY9WfuWsYQlveKRDNy
	r9gbAoBtXbWyqixkGfIuaZ1KlEOm6HHraAjgat5QaqepzyIfoO83zuJIXrVK5zROB2JGra
	ABxo7STNk7WMclI8HuY9tAIQgb+ehgqjboimQ2/FSoMdsiCWUYOiTYjPK9FwmgxipFJSWO
	vepfIs+hT/n0iXGF7x1X6BaeNKRhtmkZjtlMonjEv05l3XXIbqbi1/4HSYGPyQ==
Date: Thu, 24 Sep 2026 17:56:03 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alex Elder <elder@riscstar.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 bhelgaas@google.com, andersson@kernel.org, konradybcio@kernel.org,
 abelvesa@kernel.org, daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrea della Porta <andrea.porta@suse.com>,
 Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH v4 2/3] misc: tc9564: introduce base PCI driver
Message-ID: <20260924175603.2a20e2b1@bootlin.com>
In-Reply-To: <e9bd7954-1cec-4ffb-a5b2-2389469b0c05@riscstar.com>
References: <20260918173003.GA1166280@bhelgaas>
	<e9bd7954-1cec-4ffb-a5b2-2389469b0c05@riscstar.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alex, Bjorn,

On Fri, 18 Sep 2026 12:49:53 -0500
Alex Elder <elder@riscstar.com> wrote:

> On 9/18/26 12:30 PM, Bjorn Helgaas wrote:
> > [+cc Andrea, Herve, Lizhi for of_pci_make_dev_node() quirks]
> > 
> > On Fri, Sep 18, 2026 at 10:26:57AM -0500, Alex Elder wrote:  
> >> The Toshiba TC9564 is small and highly-specialized SoC that implements
> >> a PCIe switch as well as an Ethernet AVB/TSN bridge.  In addition to
> >> these, the SoC implements other functions, including a reset and clock
> >> controller, an address translation unit, and a few other devices.  PCIe
> >> BARs provide access to registers that manage these IP blocks, and the
> >> SoC is modeled using a PCI endpoint bus in devicetree.  This allows the
> >> IP blocks to be bound to platform drivers that do MMIO via the PCI BARs.
> >>
> >> Create a new PCI driver under drivers/misc that binds with the embedded
> >> PCI endpoint functions within the TC9564 SoC.  Because these functions
> >> will use devicetree pci-ep-bus to provide access to other IP blocks
> >> within the TC9564 chip, the main purpose of this driver is to do basic
> >> PCI initialization, then call of_platform_default_populate() to scan for
> >> the any endpoint bus children, and probe all devices defined therein.
> >>
> >> Because we're using pci-ep-bus, we need to use the PCI quirks mechanism
> >> to have of_pci_make_dev_node() be called for each endpoint device in
> >> pci_bus_add_device() (via pci_fixup_device(pci_fixup_final, dev)).
> >>
> >> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> >> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>  
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# quirks.c
> > 
> > Not an issue for this patch, but I'm not sure the quirk mechanism is
> > the best mechanism for doing this.  It's not working around a device
> > defect like most quirks do.  
> 
> I pretty much agree with you.  I think I mentioned this before
> (though it might have been in a private conversation) that it
> is an intentional act to call of_pci_make_dev_node() for an
> endpoint (and not just a bridge).  And that's different from
> a hardware quirk.  You only need to do it if there's a pci-ep-bus
> sub-node on the endpoint.  (I'd have to verify this on the other
> users of this approach to be 100% sure though.)

I agree, a quirk is not the best way to trig the of_pci_make_dev_node()
call. An allow-list seems better.

Alex, on LAN966x, the pci-ep-bus is not present. The OF node must be
created (call to of_pci_make_dev_node()) and the lan966x_pci driver
will apply an overlay on this OF node created at run-time.

The pci-ep-bus is described in the OF overlay [1].

[1] https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/misc/lan966x_pci.dtso#L50

Best regards,
Hervé
