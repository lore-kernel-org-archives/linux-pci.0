Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47039 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab3KLHWM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2013 02:22:12 -0500
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 59B723EE0BD
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 16:22:10 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3D21145DEBE
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 16:22:10 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 258D845DEBB
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 16:22:10 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A0B19E08001
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 16:22:09 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com [10.240.81.139])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 42924E08008
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 16:22:09 +0900 (JST)
Message-ID: <5281D717.3090809@jp.fujitsu.com>
Date: Tue, 12 Nov 2013 16:21:59 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
To: cl91tp@gmail.com, linux-pci@vger.kernel.org
CC: khalid.aziz@hp.com
Subject: Re: [PATCH] PCI: Blacklist certain hardware from clearing Bus Master
 bit
References: <1383132131-1096-1-git-send-email-cl91tp@gmail.com>
In-Reply-To: <1383132131-1096-1-git-send-email-cl91tp@gmail.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Chang,

I'm working on DMA problem of kdump and interested in your patch. What
happens when clearing Bus Master bit? The system hangs up immediately
after calling pci_device_shutdown()?

Thanks,
Takao Indoh

(2013/10/30 20:22), Chang Liu wrote:
> This patch adds a blacklist that prevents pci device shutdown code
> from clearing Bus Master bit on certain hardware that cannot tolerate it.
> 
> Clearing Bus Master bit was originally added in commit b566a22 to address
> the issue of some PCI device breaking kexec by continuing to do DMA
> after having been signaled to shutdown. However, this introduced a
> regression (https://bugzilla.kernel.org/show_bug.cgi?id=63861) that
> hangs the machine on kernel power off path.
> 
> It has been pointed out previously (https://lkml.org/lkml/2012/6/6/545)
> that clearing Bus Master bit during PCI shutdown may have surprising
> consequences as some devices may not tolerate this, and may hang the
> system indefinitely. However, not doing so may break kexec. Since only
> one bug report has come up since the introduction of b566a22, therefore
> indicating that these misbehaving devices are in the minority, the
> logical way to fix the hang while not breaking kexec is to blacklist
> these devices from having their Bus Master bit cleared during the PCI
> shutdown routine.
> 
> Signed-off-by: Chang Liu <cl91tp@gmail.com>
> ---
> This fixes the above mentioned bug https://bugzilla.kernel.org/show_bug.cgi?id=63861
> 
> As Alan Cox has warned in https://lkml.org/lkml/2012/6/6/545, some device
> will break if we clear bus master bit on shutdown. So sooner or later
> we will need to blacklist some device if we are to keep Bus Master being cleared
> as the default behavior. Now with the first (as I have been aware) device
> that breaks under this default behavior has surfaced, we might as well
> add the infrastructure code now in case some other devices break down
> in the future. These devices may not be many so a blacklist likely won't
> add much maintainance overhead. And we should keep the blacklist here in
> the pci shutdown code instead of in individual device drivers since this
> is the most direct way and will likely aid future debug process.
> 
> Regarding the kexec issue which the original commit b566a22c was trying to address:
> kexec doesn't work on this machine, even before the patch was applied (ie. in
> earlier kernels, I tested 3.11.6 and 3.12-rc7). Possibly because some devices
> won't reinitialize themselves properly. On 3.11.6, kexec -e triggers an immediate
> reboot. On 3.12-rc7, both with and without this patch applied, kexec -e can get it
> halfway into booting the new kernel but then a reboot is also triggered. I'm not sure
> if this patch has helped the kexec situation in this machine or not, but since it
> has no effects on machines without this defective SATA controller (and/or its firmware),
> I would say it is unlikely to negatively affect kexec on other machines.
> 
>   drivers/pci/pci-driver.c | 34 +++++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 98f7b9b..1744ebf 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -376,6 +376,29 @@ static int pci_device_remove(struct device * dev)
>   	return 0;
>   }
>   
> +/*
> + * Blacklisting certain hardware from having their Bus Master bit cleared
> + * during device shutdown. This is to workaround certain hardware's issue
> + * with clearing Bus Master bit that hangs the entire system.
> + */
> +struct {
> +	unsigned short vendor;
> +	unsigned short device;
> +} pci_bus_master_blacklist[] = {
> +	{ 0x8086, 0x9c03 },	/* Intel Corporation Lynx Point-LP SATA Controller */
> +};
> +
> +static bool pci_should_clear_master(struct pci_dev *pdev)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(pci_bus_master_blacklist); i++) {
> +		if (pdev->vendor == pci_bus_master_blacklist[i].vendor
> +		    && pdev->device == pci_bus_master_blacklist[i].device)
> +			return false;
> +	}
> +	return true;
> +}
> +
>   static void pci_device_shutdown(struct device *dev)
>   {
>   	struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -391,9 +414,18 @@ static void pci_device_shutdown(struct device *dev)
>   	/*
>   	 * Turn off Bus Master bit on the device to tell it to not
>   	 * continue to do DMA. Don't touch devices in D3cold or unknown states.
> +	 * This is useful for proper kexec. However, a number of hardware
> +	 * aren't happy with this. At the slightest, some hardware simply
> +	 * ignore the bus master bit. For some other hardware, clearing
> +	 * the bit on shutdown path hangs the entire system.
> +	 * This is likely to be a firmware or hardware problem, but
> +	 * we can workaround it here by blacklisting these hardware
> +	 * from having their bus master bit cleared during device shutdown.
>   	 */
> -	if (pci_dev->current_state <= PCI_D3hot)
> +	if (pci_should_clear_master(pci_dev)
> +	    && pci_dev->current_state <= PCI_D3hot) {
>   		pci_clear_master(pci_dev);
> +	}
>   }
>   
>   #ifdef CONFIG_PM
> 

