Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED727732;
	Thu, 16 Jul 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208460; cv=none; b=T+QBiTfU6TyDx8QblESHroZZU5hWmHCUfTEnME45z8mrXvqJGm96/I4vi0/eytHh4WLZ2wBSB9oMm4vUwtdFBsggikmyKnIV6dgyhzdV8WAY71C56yl7sCAA7AbXa1jU3RXn+vktVRVMlcCLT7aC1RV9P54/Ia+8DrQnHmlv1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208460; c=relaxed/simple;
	bh=iHl99yAiaCB2ojjN38knJUitBepBWiB4XPw53sJATbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0Y5Vk6AShEf+LIGj4Y7TMoU3T2DCIPOLbGLQBwIIzHRpUziw6UOqxYTohYqLZXEFEPRTvYkJjiAGi74b5TcepUBXQMdfHiU+thWgzf+zh4ypuKOOL1aXOI7KLsSHVXVNfLIw0gEEBCUSR2RcfE6Xhdz54iBHDAXNYUo8Pq+4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQRWWr1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQRWWr1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB491F000E9;
	Thu, 16 Jul 2026 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784208459;
	bh=pK4wGHQGlTWWcDSNcS+7j9qGc+Xk5c3INtbKz7/onyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lQRWWr1NcRycGuYw9f04LK8S2UT/aGSQtLwbOfcbTReGDcuZRQRnAN1rw4fQ1OnMJ
	 ApnPmfG1Ogh2WLLjtL/OCz1afH4pcZWGP8CCNrVMuhEGR1DThk3Cso92az3EBchIwf
	 kIt8a7eKe+mfAHmCBCEYFSrdgBHVWYYnzIrwUZnivaKNBbiUDac7reGQivpeJuE0k3
	 2rNlnX5B8OZTgu3ykRaTOwIDgobdfRlEnUt528JypXl5hl35sXawWPA/SNZwkV9yqa
	 SkzIE38s+3QCt6p+qV8icENYZ114PT6RBHx3PuQYr0R6WQveXlDlo5A0p3DEXoQr/3
	 UjR0MsMD3aOcQ==
Date: Thu, 16 Jul 2026 15:27:26 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, 
	claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, john.madieu@gmail.com, 
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH v2] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
Message-ID: <3jeysofa5igtcerzrtz52t2cwy5dhkrixyyqehiae6puj6cgyj@jwtusmgzh5xn>
References: <20260630141720.3938514-1-john.madieu.xa@bp.renesas.com>
 <aifual6ttxnrbi3o3lrnprwinmhvkysmebzrscoxhyhxbaqkz5@l66w7bdechqz>
 <80e9582c-9441-4d5a-9931-b77b3c359eea@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80e9582c-9441-4d5a-9931-b77b3c359eea@tuxon.dev>

On Thu, Jul 16, 2026 at 03:04:56PM +0300, Claudiu Beznea wrote:
> Hi, Mani,
> 
> On 7/14/26 19:58, Manivannan Sadhasivam wrote:
> > On Tue, Jun 30, 2026 at 02:17:20PM +0000, John Madieu wrote:
> > > The RZ/G3E PCIe controller does not expose the standard PCIe Slot
> > > Capability registers, so the generic pciehp driver cannot be used. The
> > > only link-state signal the hardware provides is the DL_UpDown bit in the
> > > PEIS0 event status register, which is raised on every Data Link layer
> > > up/down transition.
> > > 
> > > Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
> > > can react to link-state changes: a device that trains after boot gets
> > > enumerated, and a device that disappears on link loss is removed. This
> > > provides hotplug-like behaviour without the PCI hotplug core, which is
> > > unavailable for the reason above.
> > > 
> > > On a DL_UpDown event the handler acks the W1C status bit and schedules a
> > > worker that inspects PCSTAT1.DL_DOWN_STS:
> > > 
> > >    - link up: re-run max link speed negotiation, wait for the link to
> > >      settle and pci_rescan_bus() the root bus;
> > >    - link down: walk the bus in reverse and
> > >      pci_stop_and_remove_bus_device() each child.
> > > 
> > > Both paths take pci_lock_rescan_remove() to serialise against the PCI
> > > core.
> > > 
> > > Link events are only acted upon once the controller is fully
> > > initialised. A DL_UpDown latched while the registers are not configured,
> > > for example when the event IRQ is used as a system wakeup source during
> > > resume, is acknowledged but does not schedule a rescan.
> > This is not correct. I don't see the patch configuring 'event IRQ' as a wakeup
> > source.
> > 
> > Rest of the patch LGTM. If you confirm above, I can reword while applying.
> 
> John is not with Renesas anymore so I confirm on his behalf it is OK for you
> to amend it while applying.
> 
> However, I checked if this patch applies on top of next-20260715 or v7.2-rc1
> and it doesn't on neither of these two HEADs.
> 
> I can re-base and re-send. Please let me know otherwise.
> 

Please do so. Thanks for checking!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
