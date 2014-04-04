Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:37434 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbaDDQoN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 12:44:13 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so3721823pbc.9
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 09:44:13 -0700 (PDT)
Date: Fri, 4 Apr 2014 10:44:09 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mohit Kumar <mohit.kumar@st.com>
Cc: arnd@arndb.de, Pratyush Anand <pratyush.anand@st.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 10/10] MAINTAINERS: Add ST SPEAr13xx PCIe driver
 maintainer
Message-ID: <20140404164409.GD9007@google.com>
References: <cover.1393568715.git.mohit.kumar@st.com>
 <0274095453d14c848977441f303aab6b53a098cd.1393568715.git.mohit.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0274095453d14c848977441f303aab6b53a098cd.1393568715.git.mohit.kumar@st.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 28, 2014 at 05:25:03PM +0530, Mohit Kumar wrote:
> Add Mohit Kumar as maintainer for ST SPEAr13xx PCIe driver.
> 
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Please merge this along with the drivers/pci/host/pcie-spear13xx.c patch.

> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2cf5cf..ebdca89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6596,6 +6596,12 @@ L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/host/*designware*
>  
> +PCIE DRIVER FOR ST SPEAR13XX
> +M:	Mohit Kumar <mohit.kumar@st.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/pcie-spear13xx.c
> +
>  PCMCIA SUBSYSTEM
>  P:	Linux PCMCIA Team
>  L:	linux-pcmcia@lists.infradead.org
> -- 
> 1.7.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
