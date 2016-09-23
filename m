Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33144 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbcIWLww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2016 07:52:52 -0400
Received: by mail-lf0-f44.google.com with SMTP id b71so64122143lfg.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Sep 2016 04:52:51 -0700 (PDT)
Subject: Re: [net-next 5/5] PCI: disable FLR for 82579 device
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, davem@davemloft.net,
        bhelgaas@google.com
References: <1474612741-75681-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1474612741-75681-6-git-send-email-jeffrey.t.kirsher@intel.com>
Cc: Sasha Neftin <sasha.neftin@intel.com>, netdev@vger.kernel.org,
        nhorman@redhat.com, sassmann@redhat.com, jogreene@redhat.com,
        guru.anbalagane@oracle.com, linux-pci@vger.kernel.org
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <50623a1c-085d-73c3-1afe-3d48edd2cc43@cogentembedded.com>
Date: Fri, 23 Sep 2016 14:52:48 +0300
MIME-Version: 1.0
In-Reply-To: <1474612741-75681-6-git-send-email-jeffrey.t.kirsher@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 9/23/2016 9:39 AM, Jeff Kirsher wrote:

> From: Sasha Neftin <sasha.neftin@intel.com>
>
> 82579 has a problem reattaching itself after the device is detached.
> The bug was reported by Redhat. The suggested fix is to disable
> FLR capability in PCIe configuration space.
>
> Reproduction:
> Attach the device to a VM, then detach and try to attach again.
>
> Fix:
> Disable FLR capability to prevent the 82579 from hanging.
>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/pci/quirks.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44e0ff3..59fba6e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4431,3 +4431,24 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> +/*
> + * Workaround FLR issues for 82579
> + * This code disables the FLR (Function Level Reset) via PCIe, in order
> + * to workaround a bug found while using device passthrough, where the
> + * interface would become non-responsive.
> + * NOTE: the FLR bit is Read/Write Once (RWO) in config space, so if
> + * the BIOS or kernel writes this register * then this workaround will
                                               ^
    That asterisk shouldn't be there.

> + * not work.
> + */
> +static void quirk_intel_flr_cap_dis(struct pci_dev *dev)
> +{
> +	int pos = pci_find_capability(dev, PCI_CAP_ID_AF);

    Should be an empty line here...

> +	if (pos) {
> +		u8 cap;

    And here...

> +		pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);
> +		cap = cap & (~PCI_AF_CAP_FLR);

    () not needed.

> +		pci_write_config_byte(dev, pos + PCI_AF_CAP, cap);
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_flr_cap_dis);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_flr_cap_dis);

MBR, Sergei

