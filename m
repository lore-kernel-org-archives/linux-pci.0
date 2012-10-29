Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54093 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950Ab2J2NeU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 09:34:20 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so5272465vbb.19
        for <linux-pci@vger.kernel.org>; Mon, 29 Oct 2012 06:34:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a52b6d280831df4d8a4e4fe3d72f3caaf985a88f.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
	<a52b6d280831df4d8a4e4fe3d72f3caaf985a88f.1351492562.git.pratyush.anand@st.com>
Date: Mon, 29 Oct 2012 19:04:19 +0530
Message-ID: <CAOh2x=m+rrH4eR23TPvgNJy0Ui4oQ6ChsbYAL5AU61g-i1o05Q@mail.gmail.com>
Subject: Re: [PATCH 14/15] SPEAR13xx: Update makefile for PCIe inclusion
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
>  arch/arm/mach-spear13xx/Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-spear13xx/Makefile b/arch/arm/mach-spear13xx/Makefile
> index b721566..f7a42fb 100644
> --- a/arch/arm/mach-spear13xx/Makefile
> +++ b/arch/arm/mach-spear13xx/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_ARCH_SPEAR13XX)    += spear13xx.o
>  obj-$(CONFIG_SUSPEND)          += pm.o wakeup.o sleep_1340.o sleep_1310.o
>  obj-$(CONFIG_MACH_SPEAR1310)   += spear1310.o
>  obj-$(CONFIG_MACH_SPEAR1340)   += spear1340.o
> +obj-$(CONFIG_SPEAR13XX_PCI)    += pcie.o

Add this before Machines. Also, you can add Kconfig and Makefile changes
with drivers patch only.
