Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:58397 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751430AbaBTH2j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 02:28:39 -0500
Message-ID: <5305A704.7020308@st.com>
Date: Thu, 20 Feb 2014 12:26:04 +0530
From: Rajeev kumar <rajeev-dlh.kumar@st.com>
MIME-Version: 1.0
To: Mohit KUMAR <mohit.kumar@st.com>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgass@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI:designware:Fix comment for setting number of
 lanes
References: <1392873774-22249-1-git-send-email-mohit.kumar@st.com>
In-Reply-To: <1392873774-22249-1-git-send-email-mohit.kumar@st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

subject line

PCI: designware: Fix comment for setting number of lanes

~Rajeev

On 2/20/2014 10:52 AM, Mohit KUMAR wrote:
> Corrects comment for setting number of lanes.
>
> Signed-off-by: Mohit Kumar<mohit.kumar@st.com>
> Cc: Jingoo Han<jg1.han@samsung.com>
> Cc: Bjorn Helgaas<bhelgass@google.com>
> Cc: spear-devel@list.st.com
> Cc: linux-pci@vger.kernel.org
> ---
>   drivers/pci/host/pcie-designware.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 6d23d8c..391966f 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -766,7 +766,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>   	u32 membase;
>   	u32 memlimit;
>
> -	/* set the number of lines as 4 */
> +	/* set the number of lanes */
>   	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL,&val);
>   	val&= ~PORT_LINK_MODE_MASK;
>   	switch (pp->lanes) {

