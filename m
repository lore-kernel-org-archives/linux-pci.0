Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9018C43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903FD20868
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 20:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903FD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeK3IG1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:06:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33106 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeK3IG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Nov 2018 03:06:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so3151271otl.0;
        Thu, 29 Nov 2018 12:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecNpW9FlIciGr0ZOsxh0ds2o4ow6kp3tMqjNmA73Tx8=;
        b=QG4gbN+xssrADVG+EmJcsYr6J2CES3Z5+lPJzLjdctj/BuHe6cxCljyfDOW6MuIJ/o
         Sf1TZwRFREK5F0ztq3yJDChuqorWggRl/jdJIa7RizbYth0GloZx3MvX2LK+Gaisli61
         ytTlnIA8Dj/lvvkjgjyhRRKfFb0aMG0nzdtYnT2LWsRdW0Q4JooO8NvTCD/tSzM69Gri
         L31BgvgAOmfoEyQzVslkQQmZep35/oNd1DHuP70PAjWE5H56KBtkFis5diCCLtAfM2Oc
         gjv2gLUCEYsoZ5iK8ILZ6P/AzkW8h7cFbFsUuDptkd+moDVmkpg8BodUGwamfa0bwIBl
         FM8g==
X-Gm-Message-State: AA+aEWYDFQuuJPQ8HY/hSqZzbY39f0WqeJJguTYhUMVB15V49G/wPEyC
        gUUYuJAd5S6YLw3mGZWKhrkTPFRPAt0u6YfDzuw=
X-Google-Smtp-Source: AFSGD/Vh4qwiAgQildcI7YIxZTJ6pIOCzXVz/p2mafnviiaX0K6dbaLL++RxEvI0SqP7zw3tCFTfuVGcUlgZbXZAiCg=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr1776334otq.119.1543525183187;
 Thu, 29 Nov 2018 12:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20181129155153.35840-1-mika.westerberg@linux.intel.com> <20181129155153.35840-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20181129155153.35840-2-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Nov 2018 21:59:32 +0100
Message-ID: <CAJZ5v0iCDWWSycJgs7srsYEputDxpoGQzf5ZO46BkWPNyHHghg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI / ACPI: Identify untrusted PCI devices
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, ckellner@redhat.com,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 29, 2018 at 4:52 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> A malicious PCI device may use DMA to attack the system. An external
> Thunderbolt port is a convenient point to attach such a device. The OS
> may use IOMMU to defend against DMA attacks.
>
> Recent BIOSes with Thunderbolt ports mark these externally facing root
> ports with this ACPI _DSD [1]:
>
>   Name (_DSD, Package () {
>       ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
>       Package () {
>           Package () {"ExternalFacingPort", 1},
>           Package () {"UID", 0 }
>       }
>   })
>
> If we find such a root port, mark it and all its children as untrusted.
> The rest of the OS may use this information to enable DMA protection
> against malicious devices. For instance the device may be put behind an
> IOMMU to keep it from accessing memory outside of what the driver has
> allocated for it.
>
> While at it, add a comment on top of prp_guids array explaining the
> possible caveat resulting when these GUIDs are treated equivalent.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/property.c | 11 +++++++++++
>  drivers/pci/pci-acpi.c  | 19 +++++++++++++++++++
>  drivers/pci/probe.c     | 15 +++++++++++++++
>  include/linux/pci.h     |  8 ++++++++
>  4 files changed, 53 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8c7c4583b52d..77abe0ec4043 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -24,6 +24,14 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
>                                         acpi_object_type type,
>                                         const union acpi_object **obj);
>
> +/*
> + * The GUIDs here are made equivalent to each other in order to avoid extra
> + * complexity in the properties handling code, with the caveat that the
> + * kernel will accept certain combinations of GUID and properties that are
> + * not defined without a warning. For instance if any of the properties
> + * from different GUID appear in a property list of another, it will be
> + * accepted by the kernel. Firmware validation tools should catch these.
> + */
>  static const guid_t prp_guids[] = {
>         /* ACPI _DSD device properties GUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
>         GUID_INIT(0xdaffd814, 0x6eba, 0x4d8c,
> @@ -31,6 +39,9 @@ static const guid_t prp_guids[] = {
>         /* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
>         GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
>                   0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> +       /* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
> +       GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
> +                 0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
>  };
>
>  static const guid_t ads_guid =
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 921db6f80340..e1949f7efd9c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -789,6 +789,24 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>         ACPI_FREE(obj);
>  }
>
> +static void pci_acpi_set_untrusted(struct pci_dev *dev)
> +{
> +       u8 val;
> +
> +       if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +               return;
> +       if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
> +               return;
> +
> +       /*
> +        * These root ports expose PCIe (including DMA) outside of the
> +        * system so make sure we treat them and everything behind as
> +        * untrusted.
> +        */
> +       if (val)
> +               dev->untrusted = 1;
> +}
> +
>  static void pci_acpi_setup(struct device *dev)
>  {
>         struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -798,6 +816,7 @@ static void pci_acpi_setup(struct device *dev)
>                 return;
>
>         pci_acpi_optimize_delay(pci_dev, adev->handle);
> +       pci_acpi_set_untrusted(pci_dev);
>
>         pci_acpi_add_pm_notifier(adev, pci_dev);
>         if (!adev->wakeup.flags.valid)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b1c05b5054a0..257b9f6f2ebb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1378,6 +1378,19 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>         }
>  }
>
> +static void set_pcie_untrusted(struct pci_dev *dev)
> +{
> +       struct pci_dev *parent;
> +
> +       /*
> +        * If the upstream bridge is untrusted we treat this device
> +        * untrusted as well.
> +        */
> +       parent = pci_upstream_bridge(dev);
> +       if (parent && parent->untrusted)
> +               dev->untrusted = true;
> +}
> +
>  /**
>   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1638,6 +1651,8 @@ int pci_setup_device(struct pci_dev *dev)
>         /* Need to have dev->cfg_size ready */
>         set_pcie_thunderbolt(dev);
>
> +       set_pcie_untrusted(dev);
> +
>         /* "Unknown power state" */
>         dev->current_state = PCI_UNKNOWN;
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 11c71c4ecf75..c786a2f27bee 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -396,6 +396,14 @@ struct pci_dev {
>         unsigned int    is_hotplug_bridge:1;
>         unsigned int    shpc_managed:1;         /* SHPC owned by shpchp */
>         unsigned int    is_thunderbolt:1;       /* Thunderbolt controller */
> +       /*
> +        * Devices marked being untrusted are the ones that can potentially
> +        * execute DMA attacks and similar. They are typically connected
> +        * through external ports such as Thunderbolt but not limited to
> +        * that. When an IOMMU is enabled they should be getting full
> +        * mappings to make sure they cannot access arbitrary memory.
> +        */
> +       unsigned int    untrusted:1;
>         unsigned int    __aer_firmware_first_valid:1;
>         unsigned int    __aer_firmware_first:1;
>         unsigned int    broken_intx_masking:1;  /* INTx masking can't be used */
> --
> 2.19.2
>
