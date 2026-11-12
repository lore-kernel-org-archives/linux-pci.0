Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494588;
	b=Ourudo892z0hSRiryyvB9T2qopwulawvxlDa8EMcAsI6gUxAScrBUwnDWUvWLF7LBKDX
	 k8WgmQ5bkeUAqP95tIovNVadw1X21bMZsmPXonDGs7AvS+y2FMiEau6DGkMyHiLa28HWH
	 nvIh5ypdpKb/DHLJJ+sJOl1fhMGoNODEVWuaymE/wJ5iro6kEyxfU74D4XffjZ0yH1WNi
	 BfKCsf1OO/H2vDXF6QKX1eSIVegoFWFGH6nHFTExDt0OOKGXKiRET9kuFKVDRfFfGTg2E
	 uI5WniMkRqpLp7jOE0rdv/hO/VhjfpntXxFzlZGuie60lP6Ld6oS26hPVhnDX1NwIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494588;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=jRuMej/UssxCu0WfAqyK3aFAeYxCdtDxIB4ndk/e91Y=;
	b=rBzv8UGieWFxZr9gdRaXL4K1gfrdJgX/ixVYi9ebJpjdvobBwR0nfoto0eDvcbVblPSb
	 cHh517XTdIpsViRqkEj7YJhn6hz7KiidIcw/aR+3JRZllVo90uZLOJsz4yJ60DX+1qoka
	 CaCl8q1YL5M4WNCMFQIod7T9DTFPtEHzCk+9ZubfgZv0NymwRvh0Z7aiUTma++FW9VsAs
	 qEKpTMs5PxynH8r2bPf0wBlaxkl/XBMR3sFMqWWOaDJSmSAqzHBhDgz7/bUd5nW7VE/r8
	 mhzLtv+3JTlDAF4GZgIIkSpWOprj3wMbUk5kADKM79qLQd6MkER9tCZQ6QOTRGd1qvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gF4FaKa6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C89606A321;
	Thu, 12 Nov 2026 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gF4FaKa6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F061F00A05;
	Thu, 12 Nov 2026 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494587;
	bh=jRuMej/UssxCu0WfAqyK3aFAeYxCdtDxIB4ndk/e91Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gF4FaKa6B22vd7rEBBJMDa3CQ1envHjmOTw6kpq39uxXL3i8tIxEmZuA4GGaHYIA0
	 IeFYF/TN/+JDB+K6y5s4GjTqeoGo//OgQWp1oOLQJ3mFuG7OfG1W7vyp86akt7ntQe
	 EwsgWsB+FjpGNECdaAe1QUm/V1kg7iY9Cs5MLplglRBLmxle71TWrMO3HnxN9UufEt
	 LyuSDp/k76zWluxV3bKcecIdZ/77ag6hS2C3r0QFb9767CfparS/TakBDlLfwP8nkg
	 7DRWkpjorupWP4NOUeW5j2dewkQKuozoiWp9mHUj1LpdZiy4WKaJEsZQPM6LPHh+Kv
	 MKAzObwDZTo9A==
Date: Thu, 12 Nov 2026 20:13:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC] power: sequencing: pcie-m2: stop requiring subsystem
 IDs for WCN6855/WCN7850
Message-ID: <avXPkTkW2ZE_fngY@debian>
References: <20261106-pwrseq-bt-subsystem-v1-1-11fb09f63c93@oldschoolsolutions.biz>
 <sashiko-outbox-201312@kernel.org>
 <1c9b4722-0466-4c74-ac86-4d0f61c350a9@oldschoolsolutions.biz>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c9b4722-0466-4c74-ac86-4d0f61c350a9@oldschoolsolutions.biz>

On Fri, Nov 06, 2026 at 07:30:06PM +0100, Jens Glathe wrote:
> Hi sashiko-bot,
> 
> On 11/6/26 12:26, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue to consider:
> > - [High] pwrseq: pcie-m2: bare PCI_DEVICE() creates bogus serdev on
> >    USB-BT cards
> > --
> > 
> > commit 651d16502b81077112cba212f5fb84dc03306321
> > Author: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> > 
> > power: sequencing: pcie-m2: stop requiring subsystem IDs for WCN6855/WCN7850
> > 
> > This commit replaces the subsystem-specific PCI_DEVICE_SUB() entries for
> > Qualcomm WCN6855 (0x1103) and WCN7850 (0x1107) in pwrseq_m2_pci_ids[] with
> > bare PCI_DEVICE() entries.
> > 
> > > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > > index 56c5d51293c10..72c721149dfae 100644
> > > --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> > > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > > @@ -217,15 +217,9 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
> > >   	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
> > >   	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
> > >   	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
> > > -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0xe105),
> > > +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
> > >   	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
> > > -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x337e),
> > > -	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
> > > -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c),
> > > -	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
> > > -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_LENOVO, 0xe0e9),
> > > -	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
> > > -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_FOXCONN, 0xe0ee),
> > > +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
> > >   	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
> > >   	{ } /* Sentinel */
> > >   };
> > [Severity: High]
> > Won't matching bare 0x1103 and 0x1107 device IDs reintroduce the regression
> > fixed by a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and
> > WCN7851 UART BT variants by subdevice ID") whenever a USB-BT M.2 card is
> > plugged into a socketed M.2 Key E slot?
> > 
> > The pcie-m2-e-connector node describes the physical M.2 slot wiring on the
> > host board, not the card installed in it.  Boards with a general-purpose M.2
> > Key E socket (such as arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts) wire the
> > SoC UART to the slot and define port@3 unconditionally in their static DT.
> > 
> > When a USB-BT WCN6855 or WCN7850/WCN7851 card is inserted into such a slot,
> > pwrseq_pcie_m2_create_serdev() -> pwrseq_pcie_m2_create_serdev_one() sees
> > port@3 on ctx->dev and matches 0x1103 or 0x1107 in pwrseq_m2_pci_ids[].  It
> > then creates a bogus bluetooth OF node and UART serdev device, causing
> > hci_qca to bind alongside btusb and fail with -ETIMEDOUT in qca_setup() on
> > the unconnected UART lines.
> > 
> > Also, the commit message notes that Lenovo T14s Gen 6 (17aa:e0e9) is missing
> > from the table, but 58a003302481 ("power: sequencing: pcie-m2: Add Lenovo
> > ThinkPad T14s gen6 WCN7850 subsystem PCI ids") already added that entry
> > above.
> Well. It was missing upstream when I made the experience on my T14s G6.
> Having a whitelist for every subsystem that is allowed in such a generic
> driver is not the best design decision, IMO.
> I took another look, this driver is loaded when it is a compatible in a
> device tree. Usually this means the hardware got described, and you can draw
> conclusions from the device tree on what is supported. For the conflicting
> case, the device tree would need to describe the USB and the serial port on
> the e-key connector. When you have a connector wired up this way, the driver
> would need directions on what to choose, for instance by providing the
> subsystem IDs as base for a decision. These are the special cases, though.
> For most boards describing the uart on the connector would suffice to choose
> the right, mostly generic driver for WCN6855 and WCN7850. So it would be
> better to have the driver detect the "both ports are defined in the dt" case
> and  not create a serdev:
> 
> static bool pwrseq_pcie_m2_bt_ambiguous(struct device *dev)
> {
>     bool has_usb  = pwrseq_pcie_m2_check_remote_node(dev, 2, 0, "usb");
>     bool has_uart = pwrseq_pcie_m2_check_remote_node(dev, 3, 0, "serial");
> 
>     return has_usb && has_uart;
> }
> 

This is wrong. A generic slot can define both 'usb' and 'serial' endpoint
nodes and users can connect any key E cards to the slot. So having both nodes
doesn't mean that the user is only going to connect BT-UART cards.

While I agree with you that populating the ID table for each module is a pain,
we can't magically detect the card type before probing the device.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
