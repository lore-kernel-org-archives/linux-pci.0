Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36264 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbdKXN3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 08:29:53 -0500
Date: Fri, 24 Nov 2017 08:29:48 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 07/29] ibft: deprecate pci_get_bus_and_slot()
Message-ID: <20171124132946.GA16160@localhost.localdomain>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
 <1511390964-9979-8-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511390964-9979-8-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 22, 2017 at 05:49:02PM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().

Aha!
> 
> We don't search for the device in other domains than zero. This is because
> on x86 platforms the BIOS executes only devices which are in domain 0.
> Furthermore, the iBFT spec doesn't have a domain id field.

Acked-by: Konrad Rzeszutek Wilk <konrad@kernel.org>
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/firmware/iscsi_ibft.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 14042a6..6bc8e66 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -719,8 +719,9 @@ static int __init ibft_create_kobject(struct acpi_table_ibft *header,
>  		* executes only devices which are in domain 0. Furthermore, the
>  		* iBFT spec doesn't have a domain id field :-(
>  		*/
> -		pci_dev = pci_get_bus_and_slot((nic->pci_bdf & 0xff00) >> 8,
> -					       (nic->pci_bdf & 0xff));
> +		pci_dev = pci_get_domain_bus_and_slot(0,
> +						(nic->pci_bdf & 0xff00) >> 8,
> +						(nic->pci_bdf & 0xff));
>  		if (pci_dev) {
>  			rc = sysfs_create_link(&boot_kobj->kobj,
>  					       &pci_dev->dev.kobj, "device");
> -- 
> 1.9.1
> 
