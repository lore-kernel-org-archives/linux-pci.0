Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15222D792
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606447; cv=none; b=IrfQuizDV/1tlKvJah9DAWqjMzIY86tY3rW3YZKqaL8xSM9HWO9hhelRlk2nqzLamT9x+kVMKsl8MGQogAuX8JkZxgfhQyL14frxwh7hv7ZFwucHB9WbWh3pHgWi1hrandhg7O7XKsiN0IgyyNzc+FHCLQgQc74DJ5YTBsFgX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606447; c=relaxed/simple;
	bh=XnpRpUcjV+SwhssoG64/pVM4fLCQfD7X+rQPr7zKOCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUtMVheFkuqkr+npE9BJ5Dc3mJySybjnjvA4e7kwsXGF1uCU/zKkmQwLnmTn2SFsl7h+U2QHPYXnyT85WtWX83JlTaJvENOrXe023WuRe8ZiWYKej2/37Sd3FYxkguuToRxlbuVtGcW2s9IWwf25X6QpZPSxh8RBkk+8LYbUqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvWWrseZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvWWrseZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495437bb891so5457245e9.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786606443; x=1787211243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OGfHdF5zxh45WiCN9Yf2JdXz9PpfwZ4K8R4uurHSBm8=;
        b=gvWWrseZuy8AxGaHbVSJEozC3ucZEDsa2IS/jCWIeR+ZxpDrlPOSHcTctyZwDVSdrn
         vySh+DAAQmJr3GQb7lWh5E1Z6pNDZfFAOH3kJqyY3AHYw4VkZ6V3OaTXRjk+81fkw3mr
         O5JcBlMr34HKnau2FSDZEjsiB8QH/oXtjSCMNPgPSM15krvgD0RI8lqhIrcS8k7Pzy1d
         Y05raeT8RdbGbboDbj0mwTkqDol4nHDFpJTFbI1GEJyAzHVm09kK1whGvwhQck5BJFsF
         dH2MutlAOLUG4N4pjjQsSRXVYtDp2sjT80EsDR2E5LaKn0Loscel5gtXJvfj1pwoJq1m
         JJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786606443; x=1787211243;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGfHdF5zxh45WiCN9Yf2JdXz9PpfwZ4K8R4uurHSBm8=;
        b=BURaKZYbT6oLF/PRgPfrsfpfsjqj4w9+dKlJeCtCELom0Jx/617FFnoYy3GH5XlRQt
         xx0JU+K5lrSoBQOmEbz3yOpyr/ki2ZCC/0m+QrTxmfPjXqgYR7kkdb/DgYwI6Cubaolf
         KfTDe9xjoP6LMLOm7D+qverNpx7cm5kJ1QK2Wjh6Tjfw6VJ7ra8QCHXDjsooLz6SHDjL
         as/01noPIXnl/aXwn5JsnKnVuEHuBM+WyZ2Qi4giqNrr3TLcKYpbDP/RXCSA8dUWsOtC
         rdsYt72suUbVY3Q9NqhH2dpaHTp9StbL7Q49efpalj9kBdtr3/gUJUv3kjLcOJlocd1q
         InJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQo8g2tCiB/sUAWhAPZYK7sI/sufHYl26gNViTClanP3/HDn/Oauf09AFlNyDdN0e3ySxhC4BAbMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbBqjoSEW8umYXqbOmUmYIbo21+3yX4srU/PRIaJ1IDnrro5Y
	voWfaZxX/HnZCd6TWH8htuXK0O/ZZKw+wNb6y5vESmughvSUgCWKdvyA
X-Gm-Gg: AR+sD100Yam3uciwfkV0GUhGXgWSsmhONjPcYkPsaGWfmd2W0R5lzPgVofzyapJ2OLW
	x783BUSh5ocAQRLN3ip3DR9UClxvrBYCNUg4jozh2WGjPRkZq4k425RN2zGRpBl7pouUWABF7s4
	jD238nYBz1qNnBnVDacILkqlo71kIWaFSACKUa0b2ASJBMoy2NrYjUqpMTCd+P3h6zJ1BfulyJg
	j7/VgpMB4kNpRn0NKnp3eyUv6Clkrmpzm/SBDdb4/IT0IxMum9aks+XO8kSiDLG51y5APEi4XKD
	LKOA8Gqb4fCHLdFpOoIPo+J76SgVIw69kb4R39xXROJg0TnN1bHkgyDRpPscVsRqEWbNuTlFDFf
	288A0tp+1/1OW5Io8scR5M9lZz9a3QodsHxrNm6TUD2m2hUACKmnFG3fn4hU5Z/pTkUoUsxk5KT
	kGpN/hc4gQu4wslB4sIufXMHHdwjbihypFgyBvIesflr6LJgz52eBRspsNXP8uYl6JYdXQWsMYx
	d1FotyVYYIt9AM46YiXExHdMujtsepIt4Yl/LAUlkJekCT9xxYrUuSiPGtEDoovnk+H4yZ/iTUW
	Rk9GJw8vPkOCeNV7ngiPuisawOBhJ7DyKjo=
X-Received: by 2002:a05:600c:c87:b0:499:810b:6f57 with SMTP id 5b1f17b1804b1-49982200fa5mr26972705e9.4.1786606443134;
        Thu, 13 Aug 2026 00:34:03 -0700 (PDT)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981de6a05sm67287465e9.1.2026.08.13.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:34:02 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:34:01 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, 
	"Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>, Leonardo Costa <leoreis.costa@gmail.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"leonardo.costa@toradex.com" <leonardo.costa@toradex.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, Sherry Sun <sherry.sun@nxp.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Message-ID: <t65y5d54axtksbfs7r4olcefqhwm6m4dz3njgnrnf7fcotj74i@o7avoznlafbj>
References: <20260629143439.361560-1-leoreis.costa@gmail.com>
 <20260715234736.GA288957@bhelgaas>
 <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>
 <i6x6wpua7wlwmdq3hitoo53wkptgp62tvegmkabcru3d54eqg3@yk4eehwaarn2>
 <3hxiy6aaiagt5zunntpidaeqc4or4wrebf7mu7asvyyibqmvo2@xhvasdqp64rw>
 <GV2PR04MB12019BD5B14FA63CDFCC2015B8CDD2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <20260811063752.GA7332@francesco-nb>
 <GV2PR04MB12019BC21C743E1BEF1BE8F4C8CDC2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <anwYlX0uC1nFCxnp@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anwYlX0uC1nFCxnp@gaggiata.pivistrello.it>

On Wed, Aug 12, 2026 at 08:54:13AM +0200, Francesco Dolcini wrote:
> On Wed, Aug 12, 2026 at 06:22:57AM +0000, Hongxing Zhu wrote:
> > 
> > NXP Confidential
> > > -----Original Message-----
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Tuesday, August 11, 2026 2:38 PM
> > > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > > Cc: Leonardo Costa <leoreis.costa@gmail.com>; Bjorn Helgaas
> > > <helgaas@kernel.org>; robh@kernel.org; krzk+dt@kernel.org;
> > > conor+dt@kernel.org; Frank Li <frank.li@nxp.com>; s.hauer@pengutronix.de;
> > > kernel@pengutronix.de; festevam@gmail.com; leonardo.costa@toradex.com;
> > > devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > regressions@lists.linux.dev; Sherry Sun <sherry.sun@nxp.com>; Manivannan
> > > Sadhasivam <mani@kernel.org>; Hongxing Zhu <hongxing.zhu@nxp.com>;
> > > linux-pci@vger.kernel.org
> > > Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
> > >
> > > On Tue, Aug 11, 2026 at 12:47:18AM +0000, Hongxing Zhu (OSS) wrote:
> > > > > -----Original Message-----
> > > > > From: Leonardo Costa <leoreis.costa@gmail.com>
> > > > > Sent: Tuesday, August 11, 2026 2:26 AM
> > > > > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > > > > Cc: Bjorn Helgaas <helgaas@kernel.org>; robh@kernel.org;
> > > > > krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li
> > > > > krzk+<frank.li@nxp.com>;
> > > > > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > > > > leonardo.costa@toradex.com; devicetree@vger.kernel.org;
> > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org; linux-
> > > > > kernel@vger.kernel.org; regressions@lists.linux.dev; Sherry Sun
> > > > > <sherry.sun@nxp.com>; Manivannan Sadhasivam <mani@kernel.org>;
> > > > > Hongxing Zhu <hongxing.zhu@nxp.com>; linux-pci@vger.kernel.org
> > > > > Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer
> > > > > boots
> > > > >
> > > > > On Thu, Jul 16, 2026 at 02:09:19PM -0300, Leonardo Costa wrote:
> > > > > > On Thu, Jul 16, 2026 at 02:15:42AM +0000, Hongxing Zhu (OSS) wrote:
> > > > > > > Hi Leonardo,
> > > > > > >
> > > > > > > Would you be able to test this patch on your affected boards?
> > > > > > > Your testing would help expedite the merge process and ensure
> > > > > > > the fix resolves the boot issue you're experiencing.
> > > > > > >
> > > > > > > Best Regards
> > > > > > > Richard Zhu
> > > > > >
> > > > > > Hi Richard,
> > > > > >
> > > > > > Sorry for taking long to respond, I was caught up with something.
> > > > > > I tested the patch and it solved the issue. I sent a Tested-by tag there.
> > > > > > Thanks for looking into this!
> > > > > >
> > > > > > Best Regards
> > > > > > Leonardo
> > > > >
> > > > > Hi Richard,
> > > > >
> > > > > That patch might have introduced/exposed a second regression where
> > > > > PCI devices are not linked properly during the initialization. Sorry
> > > > > for not catching this before, as I didn't have any device connected during
> > > the previous test.
> > > > Hi Leonardo:
> > > > Sorry to hear about that.
> > > > I did test commit 7678e81498e2 with one Intel NIC (82574L) connected,
> > > > and I've double-checked today based on v7.2-rc7. The PCIe link can be
> > > > set up properly on the i.MX6Q Sabresd board in my testing.
> > > >
> > > > Here are the logs:
> > > > root@imx6qpdlsolox:~# lspci
> > > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > > 01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
> > > > Connection root@imx6qpdlsolox:~# uname -a Linux imx6qpdlsolox
> > > > 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l GNU/Linux
> > > > root@imx6qpdlsolox:~# dmesg | grep pci
> > > > [    0.256138] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
> > > > [    0.256307] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff ->
> > > 0x0000000000
> > > > [    0.256339] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -
> > > > 0x0001000000
> > > > [    0.256434] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu
> > > 0x01f00000
> > > > [    0.458388] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K,
> > > limit 4G
> > > > [    0.458492] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
> > > > [    0.555294] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
> > > > [    0.555783] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> > > > ...
> > > >
> > > > The following endpoint devices also yielded the same results.
> > > > root@imx6qpdlsolox:~# lspci
> > > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > > 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network
> > > > Adapter (PCI-Express) (rev 01) root@imx6qpdlsolox:~# uname -a Linux
> > > > imx6qpdlsolox 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l
> > > > GNU/Linux ...
> > > >
> > > > root@imx6qpdlsolox:~# lspci
> > > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > > 01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
> > > > Controller (rev 04) root@imx6qpdlsolox:~# uname -a Linux imx6qpdlsolox
> > > > 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l GNU/Linux
> > > >
> > > > Could you provide more details of your hardware setup (board,
> > > > connected devices, PERST# present or not)?
> > > > This may help us identify if there's a specific scenario that triggers
> > > > the regression you're experiencing.
> > >
> > > It's an apalis imx6, as reported already in this email thread.
> > > The DT is in Linux, you can check
> > > arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts every details about
> > > PERST# and more.
> > >
> > > This is the device connected:
> > >
> > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > 01:00.0 SATA controller: ASMedia Technology Inc. ASM1061/ASM1062 Serial
> > > ATA Controller (rev 02)
> > >
> > > 01:00.0 SATA controller: ASMedia Technology Inc. ASM1061/ASM1062 Serial
> > > ATA Controller (rev 02) (prog-if 01 [AHCI 1.0])
> > >       Subsystem: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA
> > > Controller
> > >       Flags: bus master, fast devsel, latency 0, IRQ 308
> > >       I/O ports at 1020 [size=8]
> > >       I/O ports at 1030 [size=4]
> > >       I/O ports at 1028 [size=8]
> > >       I/O ports at 1034 [size=4]
> > >       I/O ports at 1000 [size=32]
> > >       Memory at 01100000 (32-bit, non-prefetchable) [size=512]
> > >       Expansion ROM at 01200000 [virtual] [disabled] [size=64K]
> > >       Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > >       Capabilities: [78] Power Management version 3
> > >       Capabilities: [80] Express Legacy Endpoint, IntMsgNum 0
> > >       Capabilities: [100] Virtual Channel
> > >       Kernel driver in use: ahci
> > >       Kernel modules: ahci
> > >
> 
> I just did one additional test, trying to help out Leonardo.
> 
> Unfortunately I do not have the same PCIe card available, so I tested with a
> 
> 01:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)
> 	Subsystem: Intel Corporation Dual Band Wireless-AC 7260 [Wilkins Peak 2]
> 	Flags: fast devsel
> 	Memory at 01100000 (64-bit, non-prefetchable) [disabled] [size=8K]
> 	Capabilities: [c8] Power Management version 3
> 	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
> 	Capabilities: [40] Express Endpoint, IntMsgNum 0
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [140] Device Serial Number ac-7b-a1-ff-ff-4e-a1-d8
> 	Capabilities: [14c] Latency Tolerance Reporting
> 	Capabilities: [154] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>
> 
> no wi-fi driver is loaded (but this seems unrelevant for the issue here), but
> the card is detected with the current mainline Linux 7.2.0-rc7+. I tested the
> apalis SoM on both the eval carrier board and on ixora v1.2.
> 
> Same kernel config as the one failing.
> 
> So, unless I did some mistake in my manual test, the issue is related to the specific
> PCIe card or some other subtle difference I cannot see yet.
> 
> For the record, the failure was detected by our CI/CD, and it is systematically
> reproduced on multiple hardware boards.
> 
> Leonardo: any chance you can test with the same PCIe board that is failing?

Hi all,

I reproduced the issue on my setup (eval board + same PCIe card as in our CI/CD).

root@apalis-imx6-11486042:~# lspci
root@apalis-imx6-11486042:~# dmesg | grep pcie
[    0.162860] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
[    0.162974] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
[    0.163043] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
[    0.163193] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
[    0.505056] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
[    0.505230] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
[    1.508173] imx6q-pcie 1ffc000.pcie: Link failed to come up. LTSSM: POLL_CONFIG
[    1.508314] imx6q-pcie 1ffc000.pcie: probe with driver imx6q-pcie failed with error -110

After applying the new sequence proposed by Zhu, the PCIe card comes up.

root@apalis-imx6-11486042:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 SATA controller: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA Controller (rev 02)
root@apalis-imx6-11486042:~# dmesg | grep pcie
[    0.162515] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
[    0.162636] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
[    0.162702] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
[    0.162828] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
[    0.488893] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
[    0.489033] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
[    0.591333] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
[    0.591967] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.602947] pcieport 0000:00:00.0: PME: Signaling with IRQ 291
[    0.603534] pcieport 0000:00:00.0: AER: enabled with IRQ 291

I'm completely out of the loop on this whole issue and I only helped out
to test the patch. However, I wanted to add that before applying Zhu's 
proposed sequence, I could only reproduce the issue by power cycling the
module, as rebooting alone did not trigger the issue.

kind regards

Franz
