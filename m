Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45320 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab2HNFBH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 01:01:07 -0400
Received: by yenl14 with SMTP id l14so2871574yen.19
        for <linux-pci@vger.kernel.org>; Mon, 13 Aug 2012 22:01:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Aug 2012 22:00:45 -0700
Message-ID: <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] resource: add PCI configuration space support
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> This commit adds a new flag that allows marking resources as PCI
> configuration space.
>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v3:
> - new patch
>
>  include/linux/ioport.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 589e0e7..3314843 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -102,7 +102,7 @@ struct resource {
>
>  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
>  #define IORESOURCE_PCI_FIXED           (1<<4)  /* Do not move resource */
> -
> +#define IORESOURCE_PCI_CS              (1<<5)  /* PCI configuration space */

What is the purpose of this?  It seems that you are marking regions
that we call MMCONFIG on x86, or ECAM-type regions in the language of
the PCIe spec.  I see that you set it in several places, but I don't
see anything that ever looks for it.  Do you have plans to use it in
the future?  If it really does correspond to MMCONFIG/ECAM, we should
handle those regions consistently across all architectures.

>  /* helpers to define resources */
>  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)                 \
> --
> 1.7.11.2
>
