Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdHCXO6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 19:14:58 -0400
Date: Thu, 3 Aug 2017 18:14:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Piotr Gregor <piotrgregor@rsyncme.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pci: Add in description of pci_set_power_state
Message-ID: <20170803231445.GT20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170802194216.GA12995@westernst>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802194216.GA12995@westernst>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 02, 2017 at 08:42:18PM +0100, Piotr Gregor wrote:
> Add two reasons of returning 0 value to the description
> of the pci_set_power_state to include the cases when:
> 
> - the transition is to D1 or D2 but D1 and D2 are not supported
> - the transition is to D3 but D3 is not supported.
> 
> Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>

Applied to pci/pm for v4.14, thanks!

> ---
>  drivers/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index af0cc34..9528781 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -892,7 +892,9 @@ EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
>   * -EINVAL if the requested state is invalid.
>   * -EIO if device does not support PCI PM or its PM capabilities register has a
>   * wrong version, or device doesn't support the requested state.
> + * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
>   * 0 if device already is in the requested state.
> + * 0 if the transition is to D3 but D3 is not supported.
>   * 0 if device's power state has been successfully changed.
>   */
>  int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
> -- 
> 2.1.4
> 
