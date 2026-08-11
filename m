Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1C3BB11A;
	Tue, 11 Aug 2026 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483718; cv=none; b=WPJjnFuGM9CYC3QsZfr6FlHt4d7hSvcmazDp6V1itH4PzyvD5/ELagOxG6rCDDAlZ4f57SL605APRBem3Dv7r/7+ksHzBLVecQsAPSLXuuDpqLQ/rmsxiW3Uz8gUSnaaWo1sCIMH7yhWSV5i7BR1kePpoQocmPp1T27Mi4ZQ+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483718; c=relaxed/simple;
	bh=wDZVs8XU90w/eIPzfxPozO/j2bHvEcbcgxVrhSx0P20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gjCmNJS3Qd1SAn8IMXFsaclQrkYNDcpsKmkk8kvAbKd+idla/yYk+8DqbJtNZJzwE65ruFMZxz0MMujuC7uk+CRvBaY6VI0AzRQ3E0XwJd+Zq+Px+PwMyOMkWGb9xwgRVy6OUtcctKBPpBPOn5glLwgu9g55quJWNMbtcYMCrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B58w71Bk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B58w71Bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43C51F000E9;
	Tue, 11 Aug 2026 21:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786483717;
	bh=gS25S6JlZpqu1IUqlPefyLcaBuGPtqnLlkKcj17r50M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=B58w71BkZBBH8vuUMnMS+tctnVV7aOIHstxoS4PYgGpnPCvcLN4DSsy2bcxY5PpiS
	 R3Y+mp4Cld7bRU038yTUpFHIhFzPH/fXT+dcTyJnqh2COFtPACIQjz/qLI/YqYHjUo
	 boXlwQec9niyApjVsq1Izl70EYpVngu3FMQa0XFlvAobZvXiK+xllcC2CtPHWBe5wf
	 ISc5rwGiRtIr2JeS0x5Jzqf2CN4r0J98+Gg8JZCzVWKQS1CG56QigQPckENJCgPD9q
	 msBJ7irlqWlFenzXRqjQNSYsHNEyiqo7mnZX37hBWUiinKK0T3M4/vkRf0NHV2fJOy
	 VYHibof3G2ZsA==
Date: Tue, 11 Aug 2026 16:28:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Max Stevens <thinker.healer@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, nathan@nathanrossi.com,
	nicolas.cavallari@green-communications.fr,
	linux-usb@vger.kernel.org
Subject: Re: Pericom PI7C9X2G608 =?utf-8?B?KDEyZDg6?=
 =?utf-8?Q?2608=29_missing_from_ACS_quirk_?= =?utf-8?B?4oCU?= breaks Renesas
 uPD720202 USB3 cards when IOMMU is on
Message-ID: <20260811212835.GA711008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADoo8ux-r7jnwO=PqTK_aZaJBrpM5P3W5fRNWeNxCi+FpP8G0w@mail.gmail.com>

On Tue, Aug 11, 2026 at 05:57:33AM -0500, Max Stevens wrote:
> Hi Bjorn,
> 
> Thanks for the quick patch. I tested its effect on my PI7C9X2G608GP
> (12d8:2608) by replicating what pci_fixup_pericom_acs_store_forward()
> does, using setpci at runtime (I have not built a patched kernel —
> happy to do that too if you want a test of the actual binary).
> 
> Findings on the 2G608:
> 
> The mode register exists at the same offset as on the smaller
> switches: upstream port config 0x74. Value on my system before any
> test: 0x0102 (store-forward bit clear).
> With ACS on all four downstream ports set to what the kernel normally
> enables here (ACSCtl = SrcValid+ ReqRedir+ CmpltRedir+ UpstreamFwd+),
> and 0x74 bit 0 CLEAR, device enumeration on the downstream xHCI
> controllers fails: [43069.603242] xhci-pci-renesas 0000:0c:00.0: Error
> while assigning device slot ID: Command Aborted [43069.603270] usb
> usb9-port1: couldn't allocate usb_device
> Setting 0x74 to 0x0103 (bit 0, store-forward) with ACS unchanged, then
> rebinding the xHCI drivers: the same device on the same port
> enumerates immediately and works fully: [43071.971147] usb 9-1: new
> full-speed USB device number 2 using xhci-pci-renesas [43072.132176]
> usb 9-1: Product: Azeron Keypad [43072.218656] hid-generic
> 0003:16D0:113C.0017: input,hidraw12: USB HID v1.11 Keyboard [Azeron
> LTD Azeron Keypad] on usb-0000:0c:00.0-1/input1
> I toggled the bit back and forth across several driver rebinds. Every
> "Command Aborted" failure I have logged (both today and across earlier
> debugging) occurred with the bit clear; none with it set.
> 
> One honest nuance: with the bit clear the failure is not 100% — I saw
> one enumeration attempt start successfully during a bit-clear window.
> That intermittency is consistent with the load-dependent packet
> buffering behaviour described in Nathan's original erratum writeup,
> and with this card family's long history of "sometimes almost works"
> reports on various forums.

If it's an improvement, I think it's worth applying even if it's not a
100% fix.

> So on this hardware the store-forward workaround behaves exactly as it
> does on the already-quirked siblings, and the patch looks correct to
> me.
> 
> Tested-by: Maximo Paulino Thinker.Healer@gmail.com

Thanks for doing this.  I'll queue up the patch below for v7.3 without
your explicit tested-by because quirks run at different times than
setpci, and the timing/ordering is often important.


commit c56a7c02e664 ("PCI: Add ACS quirk for Pericom PI7C9X2G404 switches [12d8:2608]")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Aug 10 20:20:26 2026 -0500

    PCI: Add ACS quirk for Pericom PI7C9X2G404 switches [12d8:2608]
    
    Max reported that PI7C9X2G608GP (12d8:2608), the 6-port variant, has the
    same erratum and makes an entire class of consumer USB 3.0 cards completely
    non-functional on any system with the IOMMU enabled.
    
    On a system with a StarTech PEXUSB3S44V-style 4-port USB 3.0 card With
    IOMMU on, ACS on the switch's downstream ports is enabled (ACSCtl:
    SrcValid+ ReqRedir+ CmpltRedir+ UpstreamFwd+). The four xHCI controllers
    then probe cleanly, register their buses, upload firmware, and report port
    connect status normally — but any device plugged into any port fails
    enumeration with:
    
      xhci-pci-renesas 0000:09:00.0: Error while assigning device slot ID: Command Aborted
      xhci-pci-renesas 0000:09:00.0: Max number of devices this xHCI host supports is 32.
      usb usb3-port1: couldn't allocate usb_device
    
    Apply the same workaround used for other related Pericom switches.
    
    Reported-by: Max Stevens <thinker.healer@gmail.com>
    Closes: https://lore.kernel.org/all/CADoo8uyrmw_GkNgNf+bV_pieYN_gn5i49rOF8jUvSsfPOcqCJA@mail.gmail.com
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


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
