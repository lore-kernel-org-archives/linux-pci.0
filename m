Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59790423780;
	Thu,  8 Oct 2026 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498854; cv=none; b=DyB0LaZkVzdEQyYnrSzaYh6+qxS0pRefZigqmgDyRgYxm1G/ZLkCb0aQtd9kraTVW7Albkj7JTTcJ73ncczgjn1r87b0wJ/hueeaiaJn9A7PcpYY6Jukv9CgwMxOpdd1s7bWdEQSlFipnTET4lD96hJ42msRxoqwAdnJXL0Qk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498854; c=relaxed/simple;
	bh=4hIJRGLLPzLtSOW0/8kSMLsp7D/XXVMxYMO2f9MpE7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H+YvbpjqHHKm0MsXUCytV9du+SwVpflJlRioS2N+Nrsq7UPCH8EVdBAhd41e91wJ+vLQfFlp9u7L48wCLjQ0lxiYlBwkiKeKlRliQ/XYYTXpQFK8ndu1C0pzu5AHVc1XaSrahoyL6uiZfOj2WexZn8HusCeIKnOj/yd2i7gb7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnTrG3hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnTrG3hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A531F000FF;
	Thu,  8 Oct 2026 22:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791498853;
	bh=I/yFTg6piSWv92WJrEO4ckrAJ5KFZUODUUE7rV07bsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QnTrG3hriGCuKAjqPXXfaPBGqoaYV5xGUDBQHGvw43r03S1MevQZdd4xbkSzOf+cD
	 9fwupJSvSI+so7Q/P7XLbq/tInff9Z2waDmBbXpXGCJgvXfwp6sl8ww2oa7URZy1LL
	 szZkQfv6mjfNhnvhyHmMJReyJekhrI0D7k1pEM82Ji5svllft+PmYwHWnS51wzzuTZ
	 GgHDbTbh54cpkI/qETJWkkouvPKs8dlwRMOwWYumNSA/T/5xc4z8OpWxP5s9iXr50S
	 muwYWslsslqd4Ctbfu1jIViHSBxKDqMfICv70xfejJ5AqzR20cjyggKe/UUU86xmYI
	 7/UsASAewlFyQ==
Date: Thu, 8 Oct 2026 17:34:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 0/3] PCI/PM: Do not save the config space of an
 inaccessible device
Message-ID: <20261008223411.GA935963@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930141914.6678-1-fbeltranmillalen@gmail.com>

[+cc Lukas]

On Wed, Sep 30, 2026 at 11:19:11AM -0300, Francisco Beltrán Millalén wrote:
> When a PCI device becomes inaccessible while the system is suspending,
> pci_save_state() stores all ones over its saved config space, and
> pci_restore_state() writes that back on resume to a device that answers
> again.  On a MacBookPro14,3 this happens to the upstream bridge of a
> Thunderbolt 3 controller that drops off the bus while the system is
> suspending: after resume the bridge has bus numbers ff/ff/ff and
> Secondary Bus Reset asserted, and the xHCI controllers behind it are
> removed.  Resume also waits about 65 seconds for a device behind a dead
> bridge, because an all-ones Link Status reads as an active link.
> 
> Patch 2 makes pci_save_state() refuse to save an inaccessible device,
> using pci_dev_config_accessible() from commit e18d1abc3bff ("PCI: Avoid
> saving config space state if inaccessible"), so that system suspend is
> covered and not only resets.  Patch 1 prepares the USB PCI HCD for it;
> without patch 1, patch 2 makes pci_pm_suspend_noirq() warn.  Patch 3
> stops the link wait code from taking an all-ones Link Status for an
> active link.
> 
> Patch 1 touches drivers/usb.  Bjorn, if you take the series, it would
> need an ack from Greg or Alan.

If it would be safe to apply patches 2 and 3 without patch 1, I could
go ahead and do that.

Patch 2 returns errors from pci_save_state() in more cases, but
hcd_pci_suspend_noirq() doesn't check for errors anyway, so I think
it's would be no worse off it we applied patch 2 without patch 1.

And patch 3 looks like it's probably safe by itself independent of the
others.

> Changes since v1:
> - v1 2/4 and 3/4 took an all-ones Vendor and Device ID to mean that the
>   device was inaccessible, but that is always the case for SR-IOV VFs,
>   so they broke saving and restoring VFs (as I said in reply to v1).
>   2/3 now uses pci_dev_config_accessible(), which reads the Command and
>   Status registers.
> - Dropped v1 3/4 ("PCI/PM: Do not restore a config space snapshot that
>   is all ones"): it would never restore a VF, and it did not protect
>   what it claimed to, as pci_restore_state() restores the PCIe
>   capability state before the standard header.
> - 1/3: rewrote the commit message and moved the wakeup handling for a
>   dead root hub ahead of the early return.  Alan's Acked-by is dropped.
> - 2/3: the second accessibility check now runs after the capabilities
>   are saved, and state_saved is only set if both checks pass.
> - 3/3: also cover pcie_wait_for_link_status().
> - The v1 cover letter spoke of an earlier version; that version was
>   never posted.
> - Based on pci/next.
> 
> v1: https://lore.kernel.org/all/20260924124221.12374-1-fbeltranmillalen@gmail.com/
> 
> Testing:
> On a MacBookPro14,3 (two Alpine Ridge controllers), v6.18.49 with
> e18d1abc3bff backported and this series, S3 entered by closing the lid
> (158 s asleep), a USB disk on one controller and nothing on the other:
> 
> - In pci_pm_suspend_noirq() the bridges of both controllers, including
>   the upstream bridge 04:00.0, were inaccessible and their state was not
>   saved ("Device config space inaccessible; unable to save state").
> - On resume the controller with nothing attached came back: 04:00.0
>   kept bus numbers 04/05/79 and Bridge Control 0x0002, the link came up
>   at 8 GT/s and its xHCI controller resumed.  Before the series the same
>   bridge came back with ff/ff/ff and Bridge Control 0x005f (Secondary
>   Bus Reset asserted), and both xHCI controllers were removed.
> - The controller with the disk did not come back (its link does not
>   train, which is a separate problem); resume waited 1 s for its xHCI
>   controller instead of 65 s.
> - No "State of device not saved" warning.
> 
> With the separate Alpine Ridge quirk applied, the xHCI controllers of an
> empty controller are inaccessible in hcd_pci_suspend_noirq(); four S3
> cycles went through patch 1 without warnings and everything resumed.
> 
> When the machine wakes up again after a few seconds (with the lid open
> it does, after about 3.5 s), the empty controller does not come back
> either, with v1 as with v2, so there is nothing for the series to
> preserve.  The "1 of 2 controllers instead of 0 of 2" in the v1 cover
> letter holds only for the longer sleeps.
> 
> I have no SR-IOV hardware, so the VF case is untested, and the machine
> never reaches the pcie_wait_for_link_status() change.
> 
> Francisco Beltrán Millalén (3):
>   usb: hcd-pci: Honour pci_save_state() failure
>   PCI/PM: Do not save the config space of an inaccessible device
>   PCI: Do not mistake an absent device for an active link
> 
>  drivers/pci/pci.c          | 69 ++++++++++++++++++++++++++------------
>  drivers/usb/core/hcd-pci.c | 15 +++++++--
>  2 files changed, 61 insertions(+), 23 deletions(-)
