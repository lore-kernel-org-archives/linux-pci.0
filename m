Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20087 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3FJIig (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jun 2013 04:38:36 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Arnd Bergmann' <arnd@arndb.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>
Cc: linux-arm-kernel@lists.infradead.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Andrew Murray' <andrew.murray@arm.com>,
	Jingoo Han <jg1.han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <1880458.2ksb8qtzHh@wuerfel> <20130607162050.GA31895@obsidianresearch.com>
 <201306071943.18407.arnd@arndb.de>
In-reply-to: <201306071943.18407.arnd@arndb.de>
Subject: Re: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
Date: Mon, 10 Jun 2013 17:38:33 +0900
Message-id: <000001ce65b5$e45477f0$acfd67d0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, June 08, 2013 2:43 AM, Arnd Bergmann wrote:
> On Friday 07 June 2013, Jason Gunthorpe wrote:
> > Sounds fair to me.
> >
> > But when we talk about multiple domains we don't mean a disjoint range
> > bus bus numbers, as your other email shows:
> >
> > 00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
> > 10:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
> >
> > We mean multiple domains, it should look like this:
> >
> > 0000:00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
> > 0001:00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
> >
> > ie lspci -D.
> >
> > Each domain gets a unique bus number range, config space, io range,
> > etc. This is much clearer to everyone than trying to pretend there is
> > only one domain when the HW is actually multi-domain.
> 
> Yes, absolutely. This means we also don't need a bus-range property in DT, since each
> domain will allow all 255 buses.

After removing a bus-range property in DT, it looks like:

00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
02:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])

For multiple domains, how can I fix the DT properties?

Current DT properties are as below:

+	pcie0@40000000 {
+		compatible = "samsung,exynos5440-pcie";
+		reg = <0x40000000 0x4000
+			0x290000 0x1000
+			0x270000 0x1000
+			0x271000 0x40>;
+		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
+			  0x81000000 0 0	  0x40200000 0 0x00004000   /* downstream I/O */
+			  0x82000000 0 0	  0x40204000 0 0x10000000>; /* non-prefetchable memory */
+	};
+
+	pcie1@60000000 {
+		compatible = "samsung,exynos5440-pcie";
+		reg = <0x60000000 0x4000
+			0x2a0000 0x1000
+			0x272000 0x1000
+			0x271040 0x40>;
+		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00200000   /* configuration space */
+			  0x81000000 0 0	  0x60200000 0 0x00004000   /* downstream I/O */
+			  0x82000000 0 0	  0x60204000 0 0x10000000>; /* non-prefetchable memory */
+	};



Best regards,
Jingoo Han

> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

