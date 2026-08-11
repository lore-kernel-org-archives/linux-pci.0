Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230B3B058E
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445869; cv=pass; b=chxCK2KaKXVNzOA2c9tNbR6aKlo+W/QjWONKVpRZ7juIZViPWppwccxGB25jg+g6PtKvVG0+4hktC0WuCiCY1N6Afppu2xyrPeVvYcHqFVGVMIAgFDPz19/s78802+wmDZwd//U422agSVwZa5IHO2SZPhzsY8O16+Tql5LcRLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445869; c=relaxed/simple;
	bh=O7+JYergMAsC015lG9tF5jzHYH8SbLJKj2G6GmXXTzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKuNThQCauEzc+7oIugOJX9TS8izQvMwUvgXNuBWRX2MxgI2EAxFLlMtM57hgUsgnujnJA6JiDW1jBxe+ynVLlnRsrEbmG9iLK9uZabsCzWTPTAVReX2hGE7j8PTWIoLma6iqGl+lUAtYBRKcO7VMjzjtnbJspa6dO7mEaYzgyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZlcS9QZ; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZlcS9QZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2081268a91.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 03:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786445865; cv=none;
        d=google.com; s=arc-20260327;
        b=ONZ3OWkZyrTEanig/JBgBHg3fh5QK10v9sJWwXRkr9b8DH/+npN/CmC4liIXEak5VA
         8GAsKicNwQqA1sJ/j1BnQp76ts81JFM1nzGNb6p9krVjSSPq82Ta/8uPM6Wjb8QuZVqn
         6Fx+wNGuj9OoSH1JoKWP949zU7zzfD41tOAC+m5aiY0n02RA1RBhhjHhr7h0xI2OLYXv
         6cg9ojS3e58+8vmncu65T/v0q9yVeaX/ynbooHaev0wuwQ90k+u76X3Y8AbB4VfSbO2Z
         LzCPkYW2opgSYB407dQ/Pz/IyTdcAcZdP/NJVFyE8PsQDSd871BcqJQGWFBR7NSKKYEP
         77mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HvnZNlDTcAoy+XAjgmpVzW3owkfclIIg7i3hD29IibY=;
        fh=gBJAq+6k1lJaEEUN3AX5w2beoS5qSfaEywkUv7UTRTI=;
        b=Qm5iaFfZCQOhtM2kQg9f7JrOjROGL2KAiJxVlOW3W5vVabUzVLVU/jPdwGqD4nlrQ7
         AgxkmhuXK3nQ19LWPXpf+FIOXSk7fbVIpO90l4K+LoyopjmpCN5iEl7SvacUQfAkgn1P
         gNuiZQ4eCNM9sXpBiTRkv/PjHCRpysGyS4HrkZjuO0h1obBjsnH7CRArNfHm92vOc/GR
         z6KxO7QNgxq/miKFiFqGRDKGPLAPAOeUZvpVoxMaOToVlUdbeCdSw+XMZRPsb2OyzTUN
         4RvVAA9Bo+OLbshjUp2FnEVo1DeZA2ew3kFdVj13mPiVQeTD7STb7jQhWD29kRWOXbGB
         EdIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786445865; x=1787050665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HvnZNlDTcAoy+XAjgmpVzW3owkfclIIg7i3hD29IibY=;
        b=rZlcS9QZ4TuKZDjB78qEYF3upOEiWHB+EE0jRUeMgjfEbeiF5N7yFmaS2oo4u4bJN0
         6GGNdtVygslB/RANaXs3+QA4Y7ylktdRxYVniYA+KPWHgAwE/6hfC693Dy58POY/oBEq
         dsWW4K/2MZ7c1AR5Sk46OECy1g9vCkJUueJdvO1csGd3HIw3C26YGXsb871/okT6jxQ0
         7Uxvt5l1Zxisor4QthCJduZoJ1CLZm5oqgeGSQ9Q0t+zZmAOqKEWdn8/D8Z+79fnBClg
         L6Hcr646231ptZS+n5bqTO/2pjmBpJLG5QHWxrKH8r+pRJQNmjsWdkgX+9IVXFD5cY+W
         Yc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786445865; x=1787050665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvnZNlDTcAoy+XAjgmpVzW3owkfclIIg7i3hD29IibY=;
        b=aE5SJiEE+A3FaRONn6O19KVWKDi6l4I1zkIrMJR/kWTqUGjQshTd02OLVCCJbTs+RJ
         3p4KntD1Yca8uFrwSr+kDHEzc8wK4FHiSr/rarlQRn+4jBvYF5E4n2yxmzk74eZa4Kw8
         T1UG3rw4pwbvGrgeDvKsDCyeNE61KQWSbC8NgnzZ6xDEnSQDMHi6+9+vtPi6AXCLg0/R
         f5ysDkaoaNvPZrmtnqrFG98yF27kZPQuL7rEEj/2W19+B0YbYa6U1vFyIS8BHhSer8o8
         mh6SERoGK15kk1LBIlj7OPb9zgZMbVlW4nhIMvehXqpbEEI9fyfa4+Q3QD9mDKX3vaFQ
         0Vcg==
X-Gm-Message-State: AOJu0YxsDTTKsKJ/7l8+82PnuICcBfnjUvqtTpGVU8vpUEtkHjK0SnX6
	0NJB4Gwio9McqYbj+0TH6qmRHdsnokGBemRf77aUhGeaixNP1okAbznSBKmUW+F/Fwv+s/DwPQu
	c5FPwJQp6aKPkDrf/ky/365o2YhUxIfg=
X-Gm-Gg: AR+sD10DjYbr0clTJdyxdGJRU+hLnOeK2afp6VzXP4c/ymN31wOeqMBHtl2XUPk1sLO
	586kGgLoKF9hE3m08CCo7oWGjyYsn9ZSdxTxviKNI414Dda8raN23WRzp1HPE6uGfKFHZdqe1Bl
	6BrNrgE+XmV5bja57X72bi/JuoMYUMA1PysGtoCUeCstXlcMkBPZukd2P0eKihDvRbdZpmfVwmv
	Wq9FeKoMUN8xBnSRFpw+TRu1hdD9OPDnjVsr65Fniyy98TTovlmxSIacM3D7d/rDFVLXm+pQidk
	Mn9QTlL2v2BI9sPoEhWEw3n6QjJiGrw7nGg4lHrNNmFP
X-Received: by 2002:a17:90b:5486:b0:38f:1a2e:6e56 with SMTP id
 98e67ed59e1d1-392ec3c39aamr2487616a91.9.1786445864914; Tue, 11 Aug 2026
 03:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADoo8uyrmw_GkNgNf+bV_pieYN_gn5i49rOF8jUvSsfPOcqCJA@mail.gmail.com>
 <20260811012120.GA565400@bhelgaas>
In-Reply-To: <20260811012120.GA565400@bhelgaas>
From: Max Stevens <thinker.healer@gmail.com>
Date: Tue, 11 Aug 2026 05:57:33 -0500
X-Gm-Features: AUfX_mxhIl2TuFBHubG-xrx-9hPHJ3dqEvw0IP4lGbnRIM-dykcUYOOlmq-C0u0
Message-ID: <CADoo8ux-r7jnwO=PqTK_aZaJBrpM5P3W5fRNWeNxCi+FpP8G0w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Pericom_PI7C9X2G608_=2812d8=3A2608=29_missing_from_ACS?=
	=?UTF-8?Q?_quirk_=E2=80=94_breaks_Renesas_uPD720202_USB3_cards_when_IOMMU_is?=
	=?UTF-8?Q?_on?=
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, nathan@nathanrossi.com, 
	nicolas.cavallari@green-communications.fr, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Thanks for the quick patch. I tested its effect on my PI7C9X2G608GP
(12d8:2608) by replicating what pci_fixup_pericom_acs_store_forward()
does, using setpci at runtime (I have not built a patched kernel =E2=80=94
happy to do that too if you want a test of the actual binary).

Findings on the 2G608:

The mode register exists at the same offset as on the smaller
switches: upstream port config 0x74. Value on my system before any
test: 0x0102 (store-forward bit clear).
With ACS on all four downstream ports set to what the kernel normally
enables here (ACSCtl =3D SrcValid+ ReqRedir+ CmpltRedir+ UpstreamFwd+),
and 0x74 bit 0 CLEAR, device enumeration on the downstream xHCI
controllers fails: [43069.603242] xhci-pci-renesas 0000:0c:00.0: Error
while assigning device slot ID: Command Aborted [43069.603270] usb
usb9-port1: couldn't allocate usb_device
Setting 0x74 to 0x0103 (bit 0, store-forward) with ACS unchanged, then
rebinding the xHCI drivers: the same device on the same port
enumerates immediately and works fully: [43071.971147] usb 9-1: new
full-speed USB device number 2 using xhci-pci-renesas [43072.132176]
usb 9-1: Product: Azeron Keypad [43072.218656] hid-generic
0003:16D0:113C.0017: input,hidraw12: USB HID v1.11 Keyboard [Azeron
LTD Azeron Keypad] on usb-0000:0c:00.0-1/input1
I toggled the bit back and forth across several driver rebinds. Every
"Command Aborted" failure I have logged (both today and across earlier
debugging) occurred with the bit clear; none with it set.

One honest nuance: with the bit clear the failure is not 100% =E2=80=94 I s=
aw
one enumeration attempt start successfully during a bit-clear window.
That intermittency is consistent with the load-dependent packet
buffering behaviour described in Nathan's original erratum writeup,
and with this card family's long history of "sometimes almost works"
reports on various forums.

So on this hardware the store-forward workaround behaves exactly as it
does on the already-quirked siblings, and the patch looks correct to
me.

Tested-by: Maximo Paulino Thinker.Healer@gmail.com

Thanks, Max

On Mon, Aug 10, 2026 at 8:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Aug 10, 2026 at 08:00:59PM -0500, Max Stevens wrote:
> > Hello,
> >
> > I'd like to report that the Pericom PI7C9X2G ACS erratum handled by
> > pci_fixup_pericom_acs_store_forward() also affects the 6-port variant
> > of the switch, PI7C9X2G608GP (12d8:2608), which is not covered by the
> > existing quirk (2404/2304/2303, and b404 recently proposed by Nicolas
> > Cavallari). On this switch the erratum is severe enough to make an
> > entire class of consumer USB 3.0 cards completely non-functional on
> > any system with the IOMMU enabled.
> >
> > Hardware
> >
> > StarTech PEXUSB3S44V-style 4-port USB 3.0 card ("one dedicated channel
> > per port", widely sold ~2016 for Oculus Rift sensors). Topology:
> >
> > 00:1d.0 Intel Z690 PCH root port 07:00.0 Pericom PI7C9X2G608GP switch
> > upstream [12d8:2608] (x4 gen2) 08:01.0 - 08:04.0 switch downstream
> > ports [12d8:2608] 09:00.0 - 0c:00.0 4x Renesas uPD720202 xHCI
> > [1912:0015] (rev 02)
> >
> > System: Alder Lake / Z690, kernel 6.18.43 (Void Linux), VT-d enabled,
> > booted with iommu=3Dpt (default domain: passthrough). Firmware for the
> > uPD720202s is the correct v2.0.2.6 image (sha256 177560c2...) and
> > uploads successfully on every probe.
> >
> > Symptom
> >
> > With the IOMMU on, the kernel enables ACS on the switch's downstream
> > ports (ACSCtl: SrcValid+ ReqRedir+ CmpltRedir+ UpstreamFwd+). The four
> > xHCI controllers then probe cleanly, register their buses, upload
> > firmware, and report port connect status normally =E2=80=94 but any dev=
ice
> > plugged into any port fails enumeration with:
> >
> > xhci-pci-renesas 0000:09:00.0: Error while assigning device slot ID:
> > Command Aborted xhci-pci-renesas 0000:09:00.0: Max number of devices
> > this xHCI host supports is 32. usb usb3-port1: couldn't allocate
> > usb_device
> >
> > All four controllers fail identically. xhci debugfs portsc shows the
> > port stuck at "Connected ... Link:Polling" while the Enable Slot
> > command times out. Posted writes from the endpoints still work (MSI-X
> > interrupts for port change events are delivered), but the controllers
> > appear unable to complete DMA reads (command ring fetch) =E2=80=94 cons=
istent
> > with the known PI7C9X2G packet-buffering erratum when P2P Request
> > Redirect is enabled. No AER/DMAR errors are logged for the failed
> > requests.
> >
> > Confirmation
> >
> > Clearing ACS control on the downstream ports at runtime and rebinding
> > the drivers immediately and fully fixes the card:
> >
> > for p in 08:01.0 08:02.0 08:03.0 08:04.0; do setpci -s $p
> > ECAP_ACS+6.w=3D0x0000 done
> >
> > + unbind/rebind xhci-pci-renesas for each 0x:00.0
> >
> > After this, all four controllers enumerate devices normally and the
> > card works (tested with HID devices, hubs, and mass storage).
> > "pci=3Ddisable_acs_redir=3Dpci:12d8:2608" is my current persistent
> > workaround.
> >
> > Given that the 2G404/2G304/2G303 (and b404) already have the
> > store-and-forward fixup, could 12d8:2608 be added as well? I'm happy
> > to test a patch, and can provide full lspci -vv dumps, dmesg, or
> > register reads from the switch on request. I can't say whether the
> > store-and-forward vendor register of the smaller switches exists at
> > the same offset on the 2G608, but I'm glad to poke it under
> > instruction.
> >
> > These cards were sold in large numbers and every Linux report I can
> > find about them (Arch, FreeBSD, Proxmox, Unraid forums) describes
> > unexplained failures or dropped input events with no root cause
> > identified =E2=80=94 this quirk gap likely explains most of them.
>
> Can you test the patch below?
>
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..27f7d56c9ac3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6263,6 +6263,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x=
b404,
>                          pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
>                          pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2608,
> +                        pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2608,
> +                        pci_fixup_pericom_acs_store_forward);
>
>  static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  {
