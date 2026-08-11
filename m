Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD12472AA;
	Tue, 11 Aug 2026 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411283; cv=none; b=QkOomdFKTW8/9AK4EeAEdaKFQztu53yaIaSAFO6dgzMKSvocFSTduFuOZEh7+ItFopNWA6+4SWfmhfyo+UFzYFz/itf7entm1InZYwZMGWQJLbXqQjsskhTJcuQ64zW9eM/F2z9CEsnDMPjf1C4hVc93gSkxyyWrNpDgZVL4CW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411283; c=relaxed/simple;
	bh=4VsyuwtkTUhrXnk3KWbSs/NUQXtBKbDWKCu0CkbAeq0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A0PxDF/W0Rt+d0oaMzduks9mtLajRXupiossxr+jWslCaZR9/+w3mKl8jgwdq0ebwqSmtIK3kCNKr9oLdU5FIKW+CsSbBUaZJF+mNHcB+wrvcGIk7ehV60cKHD/F8Zq9fvqJv/bSgJEh6L7R0G8efz7iCI3X3HkMdlV4+fz02Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2KzuHx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2KzuHx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115701F000E9;
	Tue, 11 Aug 2026 01:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411282;
	bh=GzcC4f8yWV7bjtoALTklsfI0DAvnCEcaSlGVdwZz3Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=l2KzuHx1GvPyVMJ4BABHXJDXzvCbQJPQ91zgDsrLWEl43ipWJNPvqd67RAutLJDzl
	 q+biFLe/sDX0JY0rZ77LOFo/YhHFtHRmPaTqF6uSCoRTpzl7zoywvZr7EzpRJ+NSxW
	 z4avT9uuAaInoDzPKjC+0AWJGnyAPvJyRWC8+D/ZLdfpBEhMplT9a0Di0JZI5OKWMm
	 rl7ymqr1NH+RMmnKnooZTP1+5YMsjSZD8CSQBvBZv0wjiupZApsHca81H3nGneWeQF
	 VyVVag99p08Zfi4PV3l9rWDUKdpI1BDe5wnHoc5sCM5MIkdgUJ3dAbBxPTgGnFpPw5
	 6QEm6Rl8/Xt2g==
Date: Mon, 10 Aug 2026 20:21:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Max Stevens <thinker.healer@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, nathan@nathanrossi.com,
	nicolas.cavallari@green-communications.fr,
	linux-usb@vger.kernel.org
Subject: Re: Pericom PI7C9X2G608 =?utf-8?B?KDEyZDg6?=
 =?utf-8?Q?2608=29_missing_from_ACS_quirk_?= =?utf-8?B?4oCU?= breaks Renesas
 uPD720202 USB3 cards when IOMMU is on
Message-ID: <20260811012120.GA565400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADoo8uyrmw_GkNgNf+bV_pieYN_gn5i49rOF8jUvSsfPOcqCJA@mail.gmail.com>

On Mon, Aug 10, 2026 at 08:00:59PM -0500, Max Stevens wrote:
> Hello,
> 
> I'd like to report that the Pericom PI7C9X2G ACS erratum handled by
> pci_fixup_pericom_acs_store_forward() also affects the 6-port variant
> of the switch, PI7C9X2G608GP (12d8:2608), which is not covered by the
> existing quirk (2404/2304/2303, and b404 recently proposed by Nicolas
> Cavallari). On this switch the erratum is severe enough to make an
> entire class of consumer USB 3.0 cards completely non-functional on
> any system with the IOMMU enabled.
> 
> Hardware
> 
> StarTech PEXUSB3S44V-style 4-port USB 3.0 card ("one dedicated channel
> per port", widely sold ~2016 for Oculus Rift sensors). Topology:
> 
> 00:1d.0 Intel Z690 PCH root port 07:00.0 Pericom PI7C9X2G608GP switch
> upstream [12d8:2608] (x4 gen2) 08:01.0 - 08:04.0 switch downstream
> ports [12d8:2608] 09:00.0 - 0c:00.0 4x Renesas uPD720202 xHCI
> [1912:0015] (rev 02)
> 
> System: Alder Lake / Z690, kernel 6.18.43 (Void Linux), VT-d enabled,
> booted with iommu=pt (default domain: passthrough). Firmware for the
> uPD720202s is the correct v2.0.2.6 image (sha256 177560c2...) and
> uploads successfully on every probe.
> 
> Symptom
> 
> With the IOMMU on, the kernel enables ACS on the switch's downstream
> ports (ACSCtl: SrcValid+ ReqRedir+ CmpltRedir+ UpstreamFwd+). The four
> xHCI controllers then probe cleanly, register their buses, upload
> firmware, and report port connect status normally — but any device
> plugged into any port fails enumeration with:
> 
> xhci-pci-renesas 0000:09:00.0: Error while assigning device slot ID:
> Command Aborted xhci-pci-renesas 0000:09:00.0: Max number of devices
> this xHCI host supports is 32. usb usb3-port1: couldn't allocate
> usb_device
> 
> All four controllers fail identically. xhci debugfs portsc shows the
> port stuck at "Connected ... Link:Polling" while the Enable Slot
> command times out. Posted writes from the endpoints still work (MSI-X
> interrupts for port change events are delivered), but the controllers
> appear unable to complete DMA reads (command ring fetch) — consistent
> with the known PI7C9X2G packet-buffering erratum when P2P Request
> Redirect is enabled. No AER/DMAR errors are logged for the failed
> requests.
> 
> Confirmation
> 
> Clearing ACS control on the downstream ports at runtime and rebinding
> the drivers immediately and fully fixes the card:
> 
> for p in 08:01.0 08:02.0 08:03.0 08:04.0; do setpci -s $p
> ECAP_ACS+6.w=0x0000 done
> 
> + unbind/rebind xhci-pci-renesas for each 0x:00.0
> 
> After this, all four controllers enumerate devices normally and the
> card works (tested with HID devices, hubs, and mass storage).
> "pci=disable_acs_redir=pci:12d8:2608" is my current persistent
> workaround.
> 
> Given that the 2G404/2G304/2G303 (and b404) already have the
> store-and-forward fixup, could 12d8:2608 be added as well? I'm happy
> to test a patch, and can provide full lspci -vv dumps, dmesg, or
> register reads from the switch on request. I can't say whether the
> store-and-forward vendor register of the smaller switches exists at
> the same offset on the 2G608, but I'm glad to poke it under
> instruction.
> 
> These cards were sold in large numbers and every Linux report I can
> find about them (Arch, FreeBSD, Proxmox, Unraid forums) describes
> unexplained failures or dropped input events with no root cause
> identified — this quirk gap likely explains most of them.

Can you test the patch below?


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..27f7d56c9ac3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6263,6 +6263,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
 			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2608,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2608,
+			 pci_fixup_pericom_acs_store_forward);
 
 static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 {
