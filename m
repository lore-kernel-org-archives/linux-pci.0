Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:56012 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaGNFeR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jul 2014 01:34:17 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so2734768oag.30
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2014 22:34:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpo=UNwzppiTHzg0qxFBdkiR8fkwTu27OKKPTUFo5GVDKcA@mail.gmail.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
	<d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
	<53BE926A.2070005@ti.com>
	<CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
	<53BFA120.2070005@ti.com>
	<2CC2A0A4A178534D93D5159BF3BCB661A47A2A7BF3@EAPEX1MAIL1.st.com>
	<CAKohpo=UNwzppiTHzg0qxFBdkiR8fkwTu27OKKPTUFo5GVDKcA@mail.gmail.com>
Date: Mon, 14 Jul 2014 11:04:16 +0530
Message-ID: <CAKohpo=jRq7GaO7t7_=e-y4XFP=MaNY_GhNSGXnnkFubTMbucA@mail.gmail.com>
Subject: Re: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
	Arnd Bergmann <arnd@linaro.org>,
	"olof@lixom.net" <olof@lixom.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	spear-devel <spear-devel@list.st.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Nicholson <mark@nicholnet.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14 July 2014 10:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> These makes sense. Will add them.

Kishon, here is how the diff looks like now:

diff --git a/drivers/phy/phy-spear1340-miphy.c
b/drivers/phy/phy-spear1340-miphy.c
index 5e39231..8de98ad 100644
--- a/drivers/phy/phy-spear1340-miphy.c
+++ b/drivers/phy/phy-spear1340-miphy.c
@@ -101,10 +101,13 @@ static int spear1340_miphy_sata_init(struct
spear1340_miphy_priv *priv)
        regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
                           SPEAR1340_PCM_CFG_SATA_POWER_EN,
                           SPEAR1340_PCM_CFG_SATA_POWER_EN);
+       /* Wait for SATA power domain on */
        msleep(20);
+
        /* Disable PCIE SATA Controller reset */
        regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
                           SPEAR1340_PERIP1_SW_RSATA, 0);
+       /* Wait for SATA reset de-assert completion */
        msleep(20);

        return 0;
@@ -121,10 +124,12 @@ static int spear1340_miphy_sata_exit(struct
spear1340_miphy_priv *priv)
        regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
                           SPEAR1340_PERIP1_SW_RSATA,
                           SPEAR1340_PERIP1_SW_RSATA);
+       /* Wait for SATA power domain off */
        msleep(20);
        /* Switch off sata power domain */
        regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
                           SPEAR1340_PCM_CFG_SATA_POWER_EN, 0);
+       /* Wait for SATA reset assert completion */
        msleep(20);

        return 0;
