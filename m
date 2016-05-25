Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52519 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671AbcEYQ5b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 May 2016 12:57:31 -0400
Date: Wed, 25 May 2016 11:57:26 -0500
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
Message-ID: <20160525165726.GB3208@localhost>
References: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 24, 2016 at 06:29:44AM +0000, Ocean HY1 He wrote:
> In pcie_config_aspm_link(), when convert ASPM state to
> upstream/downstream ASPM register state, the upstream variable and
> dwsream variable are reversed. This causes PCI/E link enter ASPM L0s
> even it should be disabled and PCI/E endpoint may reset randomly.
> 
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

I think the current code is correct.  Here's my reasoning, please
check and see if you agree:

  #define ASPM_STATE_L0S_UP       (1)
  #define ASPM_STATE_L0S_DW       (2)
  #define ASPM_STATE_L0S          (ASPM_STATE_L0S_UP | ASPM_STATE_L0S_DW)

  pcie_aspm_cap_init
  {
    ...
    if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
      link->aspm_support |= ASPM_STATE_L0S;
    link->aspm_capable = link->aspm_support;

Now "aspm_capable" has ASPM_STATE_L0S set only if both ends support L0s.

  pcie_config_aspm_link(link, state)
  {
    ...
    state &= (link->aspm_capable & ...)

This clears ASPM_STATE_L0S in "state" unless both ends support L0s.

    if (state & ASPM_STATE_L0S_UP)
      dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;

If the caller of pcie_config_aspm_link() requested ASPM_STATE_L0S_UP
*and* both ends support L0s, we set PCI_EXP_LNKCTL_ASPM_L0S in
"dwstream".

    pcie_config_aspm_dev(child, dwstream);

Now we enable the downstream component's transmitter to enter L0s.
Per PCIe spec r3.0, sec 7.8.7, the receiver, i.e., the upstream
component, must be capable of entering L0s even when its transmitter
is disabled from entering L0s.

The way I read this,

  - We can only enable L0s when both ends of the link support L0s, and
  - We only need to enable L0s on the transmitting end.

ASPM_STATE_L0S_UP refers to L0s in the upstream direction, so that
would mean enabling L0s in the downstream component's transmitter.

Bjorn
