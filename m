Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:49905 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaGNFaE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jul 2014 01:30:04 -0400
Received: by mail-ob0-f180.google.com with SMTP id uy5so3468500obc.11
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2014 22:30:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB661A47A2A7BF3@EAPEX1MAIL1.st.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
	<d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
	<53BE926A.2070005@ti.com>
	<CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
	<53BFA120.2070005@ti.com>
	<2CC2A0A4A178534D93D5159BF3BCB661A47A2A7BF3@EAPEX1MAIL1.st.com>
Date: Mon, 14 Jul 2014 10:54:18 +0530
Message-ID: <CAKohpo=UNwzppiTHzg0qxFBdkiR8fkwTu27OKKPTUFo5GVDKcA@mail.gmail.com>
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

On 14 July 2014 10:52, Mohit KUMAR DCG <Mohit.KUMAR@st.com> wrote:
> - I think we should read regmap_*() and msleep() in continuation and so the comment above it
> is valid for both the operations.

Probably not, its not obvious why a msleep() is required after regmap_*().

> Otherwise we can add comment line for msleep() like:
> /* Wait for SATA power domain on */
> /* Wait for SATA reset de-assert completion */
>
> Similarily in *_exit routine:
> /* Wait for SATA power domain off */
> /* Wait for SATA reset assert completion */

These makes sense. Will add them.
