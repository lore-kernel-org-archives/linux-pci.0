Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39276 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433Ab2J2NdS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 09:33:18 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so5213698vcb.19
        for <linux-pci@vger.kernel.org>; Mon, 29 Oct 2012 06:33:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d13ec089ce3a327746ddf20674a0c1f5d22acb88.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
	<d13ec089ce3a327746ddf20674a0c1f5d22acb88.1351492562.git.pratyush.anand@st.com>
Date: Mon, 29 Oct 2012 19:03:17 +0530
Message-ID: <CAOh2x==OzbwA+4ArPG+yJuZHaQ-v_2VS8YNuFYH36ZqrkZLn3A@mail.gmail.com>
Subject: Re: [PATCH 13/15] SPEAr13xx: update kconfig for PCIe selection
From: viresh kumar <viresh.kumar@linaro.org>
To: Pratyush Anand <pratyush.anand@st.com>
Cc: arnd@arndb.de, shiraz.hashim@st.com, spear-devel@list.st.com,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	olof@lixom.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 29, 2012 at 12:31 PM, Pratyush Anand <pratyush.anand@st.com> wrote:
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> ---
>  arch/arm/mach-spear13xx/Kconfig |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-spear13xx/Kconfig b/arch/arm/mach-spear13xx/Kconfig
> index eaadc66..4817314 100644
> --- a/arch/arm/mach-spear13xx/Kconfig
> +++ b/arch/arm/mach-spear13xx/Kconfig
> @@ -16,5 +16,17 @@ config MACH_SPEAR1340
>         select PINCTRL_SPEAR1340
>         help
>           Supports ST SPEAr1340 machine configured via the device-tree
> +

change irrelevant to your patch

>  endmenu
> +
> +config SPEAR13XX_PCI
> +       bool "PCI Express support"

cant this be module

> +       select PCI
> +       select PCIEPORTBUS
> +       select ARCH_SUPPORTS_MSI
> +       select PCI_MSI
> +       select NEED_MACH_IO_H
> +       help
> +         Support SPEAr13xx PCIe Dual controler as a host

s/controler/controller

> +
>  endif #ARCH_SPEAR13XX
> --
> 1.7.5.4
>
