Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52936 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761015Ab3DCXPa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 19:15:30 -0400
Received: by mail-ob0-f174.google.com with SMTP id 16so1984365obc.33
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2013 16:15:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363817083-2807-1-git-send-email-prarit@redhat.com>
References: <1363817083-2807-1-git-send-email-prarit@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Apr 2013 17:15:10 -0600
Message-ID: <CAErSpo6ptTjWaomGsP-PSUOdH37oGFnH0t-O_zy5SLPXh0GD4g@mail.gmail.com>
Subject: Re: [PATCH] pci, aer_inject fix return values when device not found
To: Prarit Bhargava <prarit@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ben Hutchings <bhutchings@solarflare.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 20, 2013 at 4:04 PM, Prarit Bhargava <prarit@redhat.com> wrote:
> Currently the aer_inject driver returns -ENOTTY when the target PCIE device
> root port is not found or if the device or root port doesn't support AER.
>
> In the case where the root port isn't found, the driver should return -ENODEV,
> and in the other cases it should return -EPERM.
>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Applied for v3.10, thanks.

Ben, chime in if you have any input about errno usage :)

> ---
>  drivers/pci/pcie/aer/aer_inject.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> index 4e24cb8..8d4a5e3 100644
> --- a/drivers/pci/pcie/aer/aer_inject.c
> +++ b/drivers/pci/pcie/aer/aer_inject.c
> @@ -334,13 +334,13 @@ static int aer_inject(struct aer_error_inj *einj)
>                 return -ENODEV;
>         rpdev = pcie_find_root_port(dev);
>         if (!rpdev) {
> -               ret = -ENOTTY;
> +               ret = -ENODEV;
>                 goto out_put;
>         }
>
>         pos_cap_err = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>         if (!pos_cap_err) {
> -               ret = -ENOTTY;
> +               ret = -EPERM;
>                 goto out_put;
>         }
>         pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, &sever);
> @@ -350,7 +350,7 @@ static int aer_inject(struct aer_error_inj *einj)
>
>         rp_pos_cap_err = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ERR);
>         if (!rp_pos_cap_err) {
> -               ret = -ENOTTY;
> +               ret = -EPERM;
>                 goto out_put;
>         }
>
> --
> 1.7.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
