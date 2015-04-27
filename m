Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vn0-f49.google.com ([209.85.216.49]:33816 "EHLO
	mail-vn0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbbD0Fn0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2015 01:43:26 -0400
MIME-Version: 1.0
In-Reply-To: <20150421202807.7963.2088.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150421194625.4792.69968.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150421202807.7963.2088.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Mon, 27 Apr 2015 11:13:25 +0530
Message-ID: <CAOh2x=kQ0nNO-ZU6G2KG7kYqcQqS6=jy1a-=xHZAnr5B=tSOFA@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Remove Mohit Kumar (email bounces)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Patrice Chotard <patrice.chotard@st.com>,
	Joe Perches <joe@perches.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	Mohit Kumar <mohit.kumar.dhaka@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Fixing Mohit's and Pratyush's email ids]

On Wed, Apr 22, 2015 at 1:58 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Email to Mohit Kumar <mohit.kumar@st.com> has been bouncing, so remove the
> address from MAINTAINERS and add an entry in CREDITS.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  CREDITS     |    4 ++++
>  MAINTAINERS |    4 +---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/CREDITS b/CREDITS
> index 843e17647f3b..6bb0d51e83de 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2045,6 +2045,10 @@ D: pirq addr, CS5535 alsa audio driver
>  S: Gurgaon, India
>  S: Kuala Lumpur, Malaysia
>
> +N: Mohit Kumar
> +D: ST Microelectronics SPEAr13xx PCI host bridge driver
> +D: Synopsys Designware PCI host bridge driver
> +
>  N: Gabor Kuti
>  M: seasons@falcon.sch.bme.hu
>  M: seasons@makosteszta.sote.hu
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a123c39b4f0e..1c95b707a5f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7490,7 +7490,6 @@ S:        Maintained
>  F:     drivers/pci/host/pci-exynos.c
>
>  PCI DRIVER FOR SYNOPSIS DESIGNWARE
> -M:     Mohit Kumar <mohit.kumar@st.com>
>  M:     Jingoo Han <jg1.han@samsung.com>
>  L:     linux-pci@vger.kernel.org
>  S:     Maintained
> @@ -7505,9 +7504,8 @@ F:        Documentation/devicetree/bindings/pci/host-generic-pci.txt
>  F:     drivers/pci/host/pci-host-generic.c
>
>  PCIE DRIVER FOR ST SPEAR13XX
> -M:     Mohit Kumar <mohit.kumar@st.com>
>  L:     linux-pci@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  F:     drivers/pci/host/*spear*
>
>  PCMCIA SUBSYSTEM

Its really sad that we have to get down to this, these two
should have done it..

Anyway, please hold on this patch and I will update it for them.
