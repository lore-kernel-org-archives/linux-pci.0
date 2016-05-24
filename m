Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33525 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbcEXLxi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 May 2016 07:53:38 -0400
Date: Tue, 24 May 2016 06:53:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"prarit@redhat.com" <prarit@redhat.com>,
	"jcm@redhat.com" <jcm@redhat.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>
Subject: Re: [PATCH] PCI/ASPM: fix reverse ASPM L0s assignment of upstream
 and downstream
Message-ID: <20160524115333.GA19140@localhost>
References: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ocean,

On Tue, May 24, 2016 at 06:29:44AM +0000, Ocean HY1 He wrote:
> In pcie_config_aspm_link(), when convert ASPM state to
> upstream/downstream ASPM register state, the upstream variable and
> dwsream variable are reversed. This causes PCI/E link enter ASPM L0s
> even it should be disabled and PCI/E endpoint may reset randomly.

Random resets of an endpoint sounds like a pretty bad problem.  Do you
have a bug report?  We've had lots of issues with ASPM; I wonder if
this could account for some of them.

> Signed-off-by: Ocean He <hehy1@lenovo.com>
> ---
>  drivers/pci/pcie/aspm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 2dfe7fd..3f8a44d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -439,9 +439,9 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  		return;
>  	/* Convert ASPM state to upstream/downstream ASPM register state */
>  	if (state & ASPM_STATE_L0S_UP)
> -		dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;
> -	if (state & ASPM_STATE_L0S_DW)
>  		upstream |= PCI_EXP_LNKCTL_ASPM_L0S;
> +	if (state & ASPM_STATE_L0S_DW)
> +		dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;
>  	if (state & ASPM_STATE_L1) {
>  		upstream |= PCI_EXP_LNKCTL_ASPM_L1;
>  		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
> -- 
> 1.8.3.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
