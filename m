Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Aug 2015 20:13:40 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM/PCI: set MPS before pci_bus_add_devices()
Message-ID: <20150803191340.GM7557@n2100.arm.linux.org.uk>
References: <1437514519-18545-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437514519-18545-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 21, 2015 at 05:35:19PM -0400, Murali Karicheri wrote:
> The MPS configuration should be done *before* pci_bus_add_devices().
> After pci_bus_add_devices(), drivers may be bound to devices, and
> the PCI core shouldn't touch device configuration while a driver
> owns the device.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm/kernel/bios32.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index fcbbbb1..17efde7 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -520,7 +520,8 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>  	list_for_each_entry(sys, &head, node) {
>  		struct pci_bus *bus = sys->bus;
>  
> -		if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {

Let's get rid of that useless check.  bus can't be NULL here.

In the original code (below) if bus was NULL, then we would've already
oopsed before we got here.  As we don't oops here, no one is ever
seeing it being NULL, so the test is redundant.

> -	list_for_each_entry(sys, &head, node) {
> -		struct pci_bus *bus = sys->bus;
> -
> -		/* Configure PCI Express settings */
> -		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
