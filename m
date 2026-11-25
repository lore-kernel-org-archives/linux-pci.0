Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627205;
	b=tctnz0rJRpXb3QEl2vBIaOws8Pmkd8Zl/dRdsqO3u4pgSg1AVZPQq4ZKyzvZ0ZYS9sJC
	 khapEGaqUT+8KAIz+2bPwuqNk78nQuC2zDEJ+pzE8/3mTqpjEVPL1qktjz8BYD4DN8Vzk
	 gtv6QQmuXL8/7hAtNU3ToQM1olpzNuhvzbFsEb+H+s+jDRjWEDTGmox7N773JSFsVR7xo
	 EErB4vAOr6bj0XxUhO6QJK6Xifm5Gte6HYrEL6YbzA6+sTDR6pG5hVbBJ5s8QJin1rhZw
	 9KSPSB51oDVsgFwjuGXnvZAHFoFpFDaoSP8AlGRYTIHP5EplKTI08jbSx/lNZ8sPYCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627205;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=1VeF0WsTHNDWxRSGipjcHEafmmcWloXgO6FUvDzmvV0=;
	b=0s/5Pacj0s0opViBrJf4RsZvlxAwFHpwc3OgzpsHO2wkybEqujZ9aAtn68ISVziuX0Kx
	 DHWYTTfSUpLHzRs/Q83QiwWJWWvTXuzcgWtzL+7FaxNWEe/Lv6csjTauE8wH9OSXpd4by
	 Z12/aXyHgXbTcu+fPWNvP41nu2HSXUGBp7kuFCGfrFwnZeSVdLdQyqEleMDvvKbx9BAuC
	 IJ9Mxxozr4D05sKFXs5NMovW93iq2fpN8lvwlvrfekIeBPSmMtQtMHgjgAglXNtfj1qRN
	 wkWrDHoZ6HGQ2iDHxVhreObtuSFeTsXIFlBeMfWbS8CRBYLmRrWm9aIPPSetpYmbjOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3849606A334;
	Wed, 25 Nov 2026 17:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477561F000E6;
	Wed, 25 Nov 2026 17:19:59 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 13/14] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 John Madieu <john.madieu.xa@bp.renesas.com>, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20261019065025.2146539-14-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-14-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 22:49:54 +0530
Message-Id: <179562719476.5580.14610373538848505541.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3657;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=bYSEJKrV7khjaIUzpX7CIM9cUkO1quv3CtOsjOa2nGw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBxi/LJLkt6Yhs2FY40MiXbnEBE4fIAPRrzC2C
 8rNYyiwhoKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcYvwAKCRBVnxHm/pHO
 9XWBB/9RxcM1A4q0IVCYhmuaEzKclJm5e8h5oS/AnT8+B+Efqg/3e3vnDy+S2GslPQtW9ErW+/c
 /WdfzrdWK/jpM7vo2e5d+ZSEhRfg901SDkj67aJENKgJkdWSn0U9Ff7bUCuz4Q0ATcFQUOS3+CY
 J/bU2Cay1bilcUGts0rbKwBsuS+ACl5JolNW8+LpaTkks/ovhnMhHrHlk1nHJysnIJqMGHDzHQF
 lsx+gxG8dLFnzyvKoexYjKFmCxlM+1QRCY/dNKTqmz01+mSsGu0IT0uLCYEDrL3CrAB2UjqEugm
 hRQzSRJN3Eu+xTdspTVC0VstfE9gd23pVlIgjYxdtMX+38cr
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> 
> The RZ/G3{E, S}, RZ/V2{H(P), N} PCIe controllers do not expose the
> standard PCIe Slot Capability registers, so the generic pciehp driver
> cannot be used. The only link-state signal the hardware provides is the
> DL_UpDown bit in the PEIS0 event status register, which is raised on every
> Data Link layer up/down transition.
> 
> Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
> can react to link-state changes: a device that trains after boot gets
> enumerated, and a device that disappears on link loss is removed. This
> provides hotplug-like behavior without the PCI hotplug core, which is
> unavailable for the reason above.
> 
> On a DL_UpDown event the handler acks the W1C status bit and inspects
> PCSTAT1.DL_DOWN_STS:
> 
> - Link up: re-run max link speed negotiation, wait for the link to settle
>   and rescan the root bus. To cover the case where the device is replaced
>   or removed while the system is suspended add the
>   rzg3s_pcie_device_replaced(). It reads the vendor ID, device ID,
>   revision ID and class code of the device behind the root port and
>   compares them against the values cached in the corresponding
>   struct pci_dev, along with the Device Serial Number cached in
>   struct rzg3s_pcie_host::con_dev_dsn, mirroring pciehp_device_replaced().
>   If the device is detected as replaced (or no longer present),
>   pci_dev_set_disconnected() is called for all the devices on the bus
>   below the root port, so that the teardown of the old devices does not
>   end up accessing the newly connected device, and the devices are then
>   removed. If a link up/down cycle occurred while devices are on the bus
>   (fast link transitions coalesced into a single DL_UpDown event), the
>   devices are removed and re-enumerated even if the connected device did
>   not change.
> - Link down: walk the bus in reverse and pci_stop_and_remove_bus_device()
>   each child.
> 
> Both paths take pci_lock_rescan_remove() to serialize against the PCI
> core.
> 
> Link events are processed only after the controller has been fully
> initialized.
> 
> Add rzg3s_pcie_pm_notifier() to avoid the link event interrupt interfering
> with the suspend/resume of the other PCIe devices in the topology, and to
> avoid deadlocks caused by pci_dev_lock() being taken from the link event
> handler while suspend/resume is in progress. The notifier disables the link
> event interrupt before suspend and enables it and rescans the bus, on
> resume, to pick up devices that may have been plugged or unplugged while
> the system was suspended. struct rzg3s_pcie_host::started was added to
> avoid touching the controller registers in case the resume failed.
> 
> While at it, make probe tolerant of an absent device. Previously, if the
> link failed to come up during rzg3s_pcie_host_setup(), probe tore the
> controller back down and failed. Ignore the timeout returned by
> rzg3s_pcie_wait_for_link_up(), leave the controller and refclk running,
> and let the link-up path enumerate the device once it appears.
> 

This patch is doing too much things at once which makes it hard to follow.
I can easily say that you've combined 4-5 patches into one. And even worse, you
add code to remove devices in this patch and add recovery in the next patch. If
you are recovering the link, why do you need to throw the devices away?

Please split and organize the patches logically. And also take a look at the the
issues raised by Sashiko too.

- Mani


