Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41639 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850Ab3GKIyv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Jul 2013 04:54:51 -0400
Message-ID: <51DE72CC.9050001@ti.com>
Date: Thu, 11 Jul 2013 14:24:36 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>
CC: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	"'Kukjin Kim'" <kgene.kim@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'SRIKANTH TUMKUR SHIVANAND'" <ts.srikanth@samsung.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] pci: exynos: split into two parts such as Synopsys
 part and Exynos part
References: <001201ce7dfa$716b3370$54419a50$@samsung.com>
In-Reply-To: <001201ce7dfa$716b3370$54419a50$@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 11 July 2013 11:19 AM, Jingoo Han wrote:
> Exynos PCIe IP consists of Synopsys specific part and Exynos
> specific part. Only core block is a Synopsys designware part;
> other parts are Exynos specific.
> Also, the Synopsys designware part can be shared with other
> platforms; thus, it can be split two parts such as Synopsys
> designware part and Exynos specific part.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> ---
.
.
<snip>
.
.
> +
> +/* Exynos PCIe driver does not allow module unload */

Just curious, why is this restriction?

Thanks
Kishon
