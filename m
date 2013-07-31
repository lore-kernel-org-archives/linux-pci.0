Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:49001 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760675Ab3GaT5A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2013 15:57:00 -0400
Received: by mail-oa0-f51.google.com with SMTP id h2so2393370oag.24
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2013 12:57:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375264777-13595-9-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1375264777-13595-1-git-send-email-jeffrey.t.kirsher@intel.com> <1375264777-13595-9-git-send-email-jeffrey.t.kirsher@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 31 Jul 2013 13:56:40 -0600
Message-ID: <CAErSpo4Y=faP889_SQUoSDF75B+RYctV1q8hjhk1ixAmUXUzEg@mail.gmail.com>
Subject: Re: [net-next v2 08/15] PCI: expose pcie_link_speed and
 pcix_bus_speed arrays
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: David Miller <davem@davemloft.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev <netdev@vger.kernel.org>,
	"gospo@redhat.com" <gospo@redhat.com>,
	"sassmann@redhat.com" <sassmann@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 31, 2013 at 3:59 AM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> pcie_link_speed and pcix_bus_speed are arrays used by probe.c to correctly
> convert lnksta register values into the pci_bus_speed enum. These static arrays
> are useful outside probe for this purpose. This patch makes these defines into
> conist arrays and exposes them with an extern header in drivers/pci/pci.h
>
> -v2-
> * move extern declarations to drivers/pci/pci.h
>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If you edit this patch to add my ack or for other reasons,
s/conist/const/ above.  The "-v2-" text doesn't need to be in the
changelog, so you can omit it completely, or put it after a line
containing only "---".  I also conventionally capitalize the first
word of the change summary ("Expose") here; run "git log --oneline
drivers/pci/" to see samples.

But don't respin these patches just for that :)

> ---
>  drivers/pci/pci.h   | 3 +++
>  drivers/pci/probe.c | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d1182c4..948d1a0 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -6,6 +6,9 @@
>  #define PCI_CFG_SPACE_SIZE     256
>  #define PCI_CFG_SPACE_EXP_SIZE 4096
>
> +extern const unsigned char pcix_bus_speed[];
> +extern const unsigned char pcie_link_speed[];
> +
>  /* Functions internal to the PCI core code */
>
>  int pci_create_sysfs_dev_files(struct pci_dev *pdev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 46ada5c..496c5b0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -513,7 +513,7 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
>         return bridge;
>  }
>
> -static unsigned char pcix_bus_speed[] = {
> +const unsigned char pcix_bus_speed[] = {
>         PCI_SPEED_UNKNOWN,              /* 0 */
>         PCI_SPEED_66MHz_PCIX,           /* 1 */
>         PCI_SPEED_100MHz_PCIX,          /* 2 */
> @@ -532,7 +532,7 @@ static unsigned char pcix_bus_speed[] = {
>         PCI_SPEED_133MHz_PCIX_533       /* F */
>  };
>
> -static unsigned char pcie_link_speed[] = {
> +const unsigned char pcie_link_speed[] = {
>         PCI_SPEED_UNKNOWN,              /* 0 */
>         PCIE_SPEED_2_5GT,               /* 1 */
>         PCIE_SPEED_5_0GT,               /* 2 */
> --
> 1.7.11.7
>
