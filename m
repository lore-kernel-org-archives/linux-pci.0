Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E81753FD31
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953035; cv=none; b=lRaZ89i6skfa+jC304PWkGBd6ntYtBw5vU1XGP7IYp5ojuMV6Jtjy7JTgheLlvknpg2NPoroS4nzSWWdWMEG6/S9vxEiIZLrlcGCR81kFjvFWC2lYvXQcY6h6SeqD2+Cp1sThUhsDGB7W7GgdpryVpqD+mPziHozajcLz/zZovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953035; c=relaxed/simple;
	bh=i5oc8G+FPJUXrDJ9GzNQWBwY5F3Q8cqZHnD+c8ruQgw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSWkotYn8IDUX2D/Rl+iggJjp26VGJqUKmP+md5KzuyijfyriXrX5KxjOCsO4AMyU12zq48shQb1z4WvJDtFk57X8RdMPbST6S2XptvHmG8UnZJQ8tS6wAN0A+Jrp2Zn4fzhPMBPOlntCPC4r6f/HfCpuz26zn3dTj8yYM8KvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dKjzYKoM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dKjzYKoM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso83227725e9.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788953031; x=1789557831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ec2Fsn3mNWnCkR7kAoCbAQzF9VNKLUvPjpImLB8zqX8=;
        b=dKjzYKoMRJR9ivkBbDzzBvg/dF5yChHS6sZCU0UxJNLb/xu3dlDwNYK09PKgwtC69E
         mnv17BCoRYUD5ZezzhjMyNDzvIGa8MKylhHup/h3A1h8BibdjOsOa4eXkmScHDijl121
         1+MQa96oZ9PDa3tDjDapBAXEo5mUgWlQU+F9hevAkAJe7EPzhYkJEyyOr8XNAPl3xKOj
         ggZ/hH0sxmjq85UYrXlwxj/px0fYO193R9dBeUWjDuKGq7oKKjQWdR0JIuF/4mSUhkgA
         KNlRwiOGjd/iMNmXrkqS+yM3DF1YX8hmfRR5R8GfhZu9S4zO8ot40QWlwlCqpnHLpyv8
         kkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788953031; x=1789557831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ec2Fsn3mNWnCkR7kAoCbAQzF9VNKLUvPjpImLB8zqX8=;
        b=Ne71rhOyX6uRz8dIsCVms3K2AglANABCpnKahZ8pMnOd8NkArXlmBOmF0St9rphB0M
         A0tQ8rmyybpHdx5hn1nzJKckvxY/kaemEF6JLWJDY/jmvcebnJZT8c5u2EDKq4IWxOzG
         X7GuxdQ543AugZr2zJ/BK8VHcKHKKjTWJhKBQPwL72hxy4AixVa94QpaGO5aP0/dOG+Z
         K/nOBMOfap8uq8TtAK9XWHjfT0zzINUbusduIhLvAhgkxR98/Fnb4UnP6d3vId/PwkhA
         TDZypodUy8mPzkSWue3reFh52fYzOK23xzQRUsd5XtZTFNYAQc40vbHr03opOojB5l5z
         UNAw==
X-Forwarded-Encrypted: i=1; AKwUvBxSb0ACvBBIMU2olL+CakcQxXxlTAa8II/+fXZsNZ/RH39HEJM2aD+ICT9qXDSD6i8WBRn7xkFNvOc=@vger.kernel.org
X-Gm-Message-State: AFuF++kOEMTHEvfBWLAcKsbsqHj0cbWAj9Nr76ilqkSBNX3+1CJAxItu
	VP3iJtT2uphVDDzKbl3GDjOY8ovqvAjzhyt9V02ILnIwRvgy9+Kymi5nncfPwpRxh1l2MWXGScY
	U3BgjW+4=
X-Gm-Gg: AYBFou2ekQ1e4JSyQH2qTs3QZKjHkpIjEbnndB8X4v6yFshqpGDX9tsKVmu9vudWs1/
	gJSIhmITv5gtsmWu16D37IQh2uxJP1LhvoFgPr1MGp/vWo8a+pmTiozzqGYXpT7KdHJ0v6pOyho
	0+/jmpI8NuMY9R0OVddWaHZx6WVj9g+TvAeqlxiRewadhZigHoX0fDkxNzTU+gBYiNkFoIHHxsI
	cQOp8OVYUGistI9g7o9jvZlF0oib1Zjgm+cC+GVO9hvBtwfvBbFTHl/2vqwKBN0Uv7L7qSYfnrI
	aW/YSIdHkvyAEjuiVthWH1uK49S08LfuFTimdqghFpgx9PWaKUFAzzricTBYnIVd58M+II9/bPX
	OYPJoGuaLZ25yWfUbDTprrQ+WHLbsu+h/hAhcXXwNRvAX7XuBDNQ4A7sNic3OlhraQ8q3iTLLtU
	v7nLKevZplwlsycS6PP33UpXmVFSv7aO+rCQrJFAMChi9R238OSBp4DS8UKm/VuKNIzwcd1+dne
	g7HI6E=
X-Received: by 2002:a05:600c:474c:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49cf8227619mr315909275e9.5.1788953031373;
        Wed, 09 Sep 2026 04:23:51 -0700 (PDT)
Received: from localhost ([82.145.119.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d08144037sm381473505e9.7.2026.09.09.04.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:23:50 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 9 Sep 2026 13:27:30 +0200
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Angel J <iamanaws@httpd.dev>,
	Lizhi Hou <lizhi.hou@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"robh@kernel.org" <robh@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid
 bridge configuration
Message-ID: <aqFCouobgTYOBbEe@apocalypse>
References: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
 <20260903231744.GA2281658@bhelgaas>
 <20260904105743.1c396a8b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904105743.1c396a8b@bootlin.com>

Hi,

On 10:57 Fri 04 Sep     , Herve Codina wrote:
> Hi Angel, Bjorn,
> 
> On Thu, 3 Sep 2026 18:17:44 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > [+to Herve, Lizhi for PCI dynamic OF node stuff]
> > 
> > On Sun, Aug 23, 2026 at 02:14:25AM +0000, Angel J wrote:
> > > Hello,
> > > 
> > > This regression was introduced in v6.17-rc1 and remains in the dynamic
> > > PCI OF node code. Linux 6.18 fails very early during boot on my Dell XPS
> > > 8940 when CONFIG_PCI_DYNAMIC_OF_NODES=y. The display goes black before
> > > any useful console or pstore output appears, and the machine remains
> > > hung.  
> > 
> > Oof, sorry, that's a terrible failure to debug.  Thanks for your
> > persistence in chasing it.
> > 
> > I don't think 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
> > is a likely culprit by itself because there's just nothing there that
> > looks like it would relate to a Dell XPS 8940.
> > 
> > > Disabling CONFIG_PCI_DYNAMIC_OF_NODES makes the same kernel boot normally.
> > > Linux v6.19-rc5 also boots because the RP1 driver stopped selecting that
> > > option, not because the dynamic PCI OF node code changed.
> > > 
> > > Hardware:
> > > 
> > >   System: Dell XPS 8940, board 0K3CM7, BIOS 2.27.1 (2025-04-03)
> > >   CPU: Intel Core i7-11700 (Rocket Lake)
> > >   Triggering device: 0000:00:00.0, Intel 8086:4c43
> > >   Firmware boot: UEFI, ACPI-based x86_64
> > > 
> > > Test results:
> > > 
> > >   Linux 6.12.103: good
> > >   Linux v6.17-rc1: bad
> > >   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=y: bad
> > >   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=n: good
> > >   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=y, skip invalid bridge: good
> > >   Linux v6.19-rc4: bad
> > >   Linux v6.19-rc5: good
> > >   Linux 4621c338d33f: bad
> > >   Linux e55feea3a03a: good
> > > 
> > > The first-parent boundary between the last two tests is:
> > > 
> > >   e55feea3a03a ("Merge tag 'soc-fixes-6.19' ...")
> > > 
> > > That merge contains ce26f588c831 ("misc: rp1: drop overlay support"), which
> > > removes:
> > > 
> > >   select PCI_DYNAMIC_OF_NODES
> > > 
> > > from MISC_RP1. The generated configurations differed only by:
> > > 
> > >   -CONFIG_PCI_DYNAMIC_OF_NODES=y
> > >   +# CONFIG_PCI_DYNAMIC_OF_NODES is not set
> > > 
> > > CONFIG_MISC_RP1=m in both. The known-bad 4621c338d33f and Linux 6.18.44
> > > both boot after disabling PCI_DYNAMIC_OF_NODES (and MISC_RP1, whose Kconfig
> > > select otherwise forces it on).
> > > 
> > > There is no RP1 device in this machine, and its driver does not probe.
> > > MISC_RP1 affects this x86 system only because its Kconfig select enables
> > > PCI_DYNAMIC_OF_NODES globally.
> > > 
> > > I narrowed the hang to dynamic OF node creation for 0000:00:00.0
> > > (8086:4c43), the Intel Rocket Lake-S integrated memory controller. On
> > > this machine it reports PCI class 0604 and header type 1, but it is bound
> > > to icl_uncore and is not a usable forwarding bridge:
> > > 
> > >   Bus: primary=ff, secondary=ff, subordinate=ff
> > >   I/O and memory bridge windows: invalid/all ones
> > >   kernel: bridge configuration invalid ([bus ff-ff]), reconfiguring
> 
> Is this PCI logs reported with PCI_DYNAMIC_OF_NODES=y or PCI_DYNAMIC_OF_NODES=n
> or always whatever the PCI_DYNAMIC_OF_NODES Kconfig value ?
> 
> A PCI class 0604 is a PCI-to-PCI bridge.
> 
> Something in kernel code prevent the scan of this PCI-to-PCI bridge even if the
> kernel tries to reconfigure it. Indeed, the device is "Intel Rocket Lake-S
> integrated memory controller" and not a PCI-to-PCI bridge

Indeed, a Host-bridge should have 0600 class and Header 0 (or 80, if it's multi
function as it seems). Angel, could you please provide the following output:

lspci -nn
setpci -s 00:00.0 HEADER_TYPE

from a running (i.e. with CONFIG_PCI_DYNAMIC_OF_NODES=n) system? Just to make
sure we're talking about the correct device and that the hw is 'lying' to us...

Many thanks,
Andrea

> 
> The of_pci_make_dev_node() is called by the PCI core [1] to create OF node for
> bridges.
> 
> of_pci_make_dev_node() will set (device_type = "pci" in the created node).
> 
> But if the device it is not a bridge, this is obviously wrong (even if I don't
> understand why it hangs the system).
> 
> Maybe the test done at [1] should be improved to detect those wrong bridges.
> and skip the of_pci_make_dev_node() call when a wrong bridge is detected.
> 
> [1] https://elixir.bootlin.com/linux/v7.2/source/drivers/pci/bus.c#L355
> 
> 
> Best regards,
> Hervé
