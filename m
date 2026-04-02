Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297B36D51B;
	Thu,  2 Apr 2026 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168457; cv=none; b=UXDsA9B3F081WZno8+5eCiaynd6NH2uQL8fO6MCM0adwiMa9pRExshmxW8NerKJNGWilCjTIjZbAbE9WTFxFZePgMsCWSPqQEre2dYJtjz6FO8TVQ/y1WYPpdsuciVDNrtq0NGTwEROcF/OGkZUko8QyhebWJlTcCE/+cgslHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168457; c=relaxed/simple;
	bh=KE5CJQvzLY7UMhd/2yz8skIZOhhpRl5F0TjWND7YUkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZtxXfIt4LwDW1GtQUKRkQxb2Q/YwLU+AZtUnXCShUQfFf8mPNID9h+1L++eRDmGowCN7JSutKjd6rfzOG+xGBJqBfkpkf+eM0ro7qcKZ+16fyNrMH5ltlbiTBd7s+fsgfYCGM/XvpL0Cf18bqP1BP2gHjG7cdHbEXNuHphtOjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prUW9UT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prUW9UT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D8AC116C6;
	Thu,  2 Apr 2026 22:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775168456;
	bh=KE5CJQvzLY7UMhd/2yz8skIZOhhpRl5F0TjWND7YUkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=prUW9UT3rmyzotQUUTkrod77DHp5m0ZeQwv/pLDDsFw61hdnQwmDt6kbTMrlmHXU4
	 Yav12lrsXexlysCdiZa/s+L93vFGEtXNLrXgQFQu0ZCXxoKQVIw0fJsUA8mxnZMGHw
	 /W5mbO7pMFwX56f2y+HnMPgOi9DNndI+cBzkSJxt/hU1UbW7AjapGJxaWqBfVfUD8J
	 PDuDkOVALGisc0MdTmzy0+gWJ6IuYkecZGM8Vgjf/0BhX3Afg6KO4cpSTJhRWwzGC7
	 Uio39ErNSNf+E0wuiJtGKnYaZaJrtFIJ13+WK6PFIhkbWK4oSQhxS/ozaajRXOQiZq
	 saOofhH1rQ8ag==
Date: Thu, 2 Apr 2026 17:20:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Georg Klima <Georg.Klima@durst-group.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Georg Klima <georg_klima@gmx.at>, Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: AW: [BUG] Thunderbolt runtime resume during PCIe removal causes
 IRQ warning and shutdown failure.
Message-ID: <20260402222055.GA293966@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR10MB4231D6536D271E1F5A81F3D1B757A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM>

[+cc Thunderbolt & pciehp folks, initial report of system poweroff
failure at
https://lore.kernel.org/all/AM9PR10MB42316BF3E59B29E1EA3E5600B756A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM]

On Fri, Mar 27, 2026 at 05:28:28PM +0000, Georg Klima wrote:
> Hi Bjorn,
> 
> Upstream without nvidia, more debug, same issue with aspm default:

Thanks for this test with an upstream kernel (6.19.10).  Complete
dmesg log was attached to
https://lore.kernel.org/all/AM9PR10MB4231D6536D271E1F5A81F3D1B757A@AM9PR10MB4231.EURPRD10.PROD.OUTLOOK.COM/

Linux only requests control of PME, AER, hotplug, etc if Linux
supports ASPM and MSI.  "pcie_aspm=off" means Linux doesn't support
ASPM, so it doesn't request control:

  --- dmesg_aspm_off.txt
  +++ dmesg_actual.txt
  - acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig Segments MSI EDR HPX-Type3]
  + acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
  - acpi PNP0A08:01: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
  + acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]

I suspect the issue is related to those services, not to ASPM itself.
Booting with "pcie_port_pm=off" might be a more targeted workaround.

You have this topology:

  0000:80:1b.4: [8086:7f44] PCIe Root Port to [bus 88-d8]
  0000:88:00.0: [8086:5780] PCIe Switch Upstream Port (JHL9580 Thunderbolt 5)

and the first thing I see in the 6.19.10 log is this, which makes me
think we put the Thunderbolt controller at 88:00.0 into D3 and are
trying to bring it back to D0 but it took too long, so we can't access
downstream devices like b1:00.0:

  Mar 27 18:08:40 fedora kernel: pcieport 0000:80:1b.4: Data Link Layer Link Active not set in 100 msec
  Mar 27 18:08:40 fedora kernel: pcieport 0000:80:1b.4: pciehp: Slot(25): Card not present
  Mar 27 18:08:40 fedora kernel: xhci_hcd 0000:b1:00.0: Controller not ready at resume -19
  Mar 27 18:08:40 fedora kernel: ------------[ cut here ]------------
  Mar 27 18:08:40 fedora kernel: xhci_hcd 0000:b1:00.0: PCI post-resume error -19!
  Mar 27 18:08:40 fedora kernel: thunderbolt 0000:8a:00.0: interrupt for TX ring 0 is already enabled
  Mar 27 18:08:40 fedora kernel:  tb_ring_start+0x149/0x330 [thunderbolt]
  Mar 27 18:08:40 fedora kernel:  tb_ctl_start+0x1b/0xc0 [thunderbolt]
  Mar 27 18:08:40 fedora kernel:  tb_domain_runtime_resume+0x19/0x40 [thunderbolt]
  Mar 27 18:08:40 fedora kernel:  __rpm_callback+0x48/0x1f0
  Mar 27 18:08:40 fedora kernel:  rpm_callback+0x6d/0x80
  Mar 27 18:08:40 fedora kernel:  rpm_resume+0x4ab/0x6d0
