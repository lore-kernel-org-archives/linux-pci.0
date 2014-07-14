Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52266 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaGNFbr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jul 2014 01:31:47 -0400
Received: by mail-ob0-f174.google.com with SMTP id vb8so3388919obc.5
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2014 22:31:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53BE926A.2070005@ti.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
	<d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
	<53BE926A.2070005@ti.com>
Date: Mon, 14 Jul 2014 11:01:47 +0530
Message-ID: <CAKohpo=aoWgQseciOiZcYqupKZyz5eMFNA4A+VRSHoCbQuqeGw@mail.gmail.com>
Subject: Re: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Arnd Bergmann <arnd@linaro.org>, "olof@lixom.net" <olof@lixom.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	spear-devel <spear-devel@list.st.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Nicholson <mark@nicholnet.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 July 2014 18:47, Kishon Vijay Abraham I <kishon@ti.com> wrote:

>> diff --git a/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
>> new file mode 100644
>> index 0000000..b9b281a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
>
> We generally create a single document for a SoC vendor. So just use st-phy.txt.

st-phy may not be appropriate as this is specifically for SPEAr. New
binding doc looks like this:

diff --git a/Documentation/devicetree/bindings/phy/st-spear-miphy.txt
b/Documentation/devicetree/bindings/phy/st-spear-miphy.txt
new file mode 100644
index 0000000..2a6bfdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st-spear-miphy.txt
@@ -0,0 +1,15 @@
+ST SPEAr miphy DT details
+=========================
+
+ST Microelectronics SPEAr miphy is a phy controller supporting PCIe and SATA.
+
+Required properties:
+- compatible : should be "st,spear1310-miphy" or "st,spear1340-miphy"
+- reg : offset and length of the PHY register set.
+- misc: phandle for the syscon node to access misc registers
+- #phy-cells : from the generic PHY bindings, must be 1.
+       - cell[1]: 0 if phy used for SATA, 1 for PCIe.
+
+Optional properties:
+- phy-id: Instance id of the phy. Only required when there are multiple phys
+  present on a implementation.
