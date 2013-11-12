Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:37779 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3KLIWT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2013 03:22:19 -0500
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 9DAFB3EE110
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 17:22:17 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 86ECB45DE4E
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 17:22:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6A56545DE4D
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 17:22:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 527261DB8037
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 17:22:17 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id ECD9C1DB803B
	for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 17:22:16 +0900 (JST)
Message-ID: <5281E523.3090503@jp.fujitsu.com>
Date: Tue, 12 Nov 2013 17:21:55 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
To: cl91tp@gmail.com
CC: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist certain hardware from clearing Bus Master
 bit
References: <1383132131-1096-1-git-send-email-cl91tp@gmail.com>	<5281D717.3090809@jp.fujitsu.com> <CAMZVYU9Vwarz=Fn6AHjbYPw1q4EDda7shp9ZXMsuQd+Zo_BsiQ@mail.gmail.com>
In-Reply-To: <CAMZVYU9Vwarz=Fn6AHjbYPw1q4EDda7shp9ZXMsuQd+Zo_BsiQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(2013/11/12 16:51), Chang Liu wrote:
> Hi Takao,
> 
> Thanks for your interest! From the log message during my testings, it appears that the system does not hang immediately after clearing the Bus Master bit, but continues to do the remaining shutdown routines (which aren't many though) until it hangs at the very last step (which I think is machine_power_off(), which in my machine calls acpi_power_off()).
> 
> So the two events (clearing Bus Master bit and system hangup) don't necessarily happen simultaneously but do occur within microseconds.

Understood, thanks for the information.

Regarding your patch, how about adding pci quirk instead of introducing
black list? Add new member into struct pci_dev like below and set this
bit in the quirk. Just an idea.

 unsigned int keep_busmaster_on_shutdown:1;

Thanks,
Takao Indoh


> 
> Cheers,
> Chang
> 
> 在 2013年11月12日 下午3:22，"Takao Indoh" <indou.takao@jp.fujitsu.com <mailto:indou.takao@jp.fujitsu.com>>写道：
> 
>     Hi Chang,
> 
>     I'm working on DMA problem of kdump and interested in your patch. What
>     happens when clearing Bus Master bit? The system hangs up immediately
>     after calling pci_device_shutdown()?
> 
>     Thanks,
>     Takao Indoh
> 
>     (2013/10/30 20:22), Chang Liu wrote:
>      > This patch adds a blacklist that prevents pci device shutdown code
>      > from clearing Bus Master bit on certain hardware that cannot tolerate it.
>      >
>      > Clearing Bus Master bit was originally added in commit b566a22 to address
>      > the issue of some PCI device breaking kexec by continuing to do DMA
>      > after having been signaled to shutdown. However, this introduced a
>      > regression (https://bugzilla.kernel.org/show_bug.cgi?id=63861) that
>      > hangs the machine on kernel power off path.
>      >
>      > It has been pointed out previously (https://lkml.org/lkml/2012/6/6/545)
>      > that clearing Bus Master bit during PCI shutdown may have surprising
>      > consequences as some devices may not tolerate this, and may hang the
>      > system indefinitely. However, not doing so may break kexec. Since only
>      > one bug report has come up since the introduction of b566a22, therefore
>      > indicating that these misbehaving devices are in the minority, the
>      > logical way to fix the hang while not breaking kexec is to blacklist
>      > these devices from having their Bus Master bit cleared during the PCI
>      > shutdown routine.
>      >
>      > Signed-off-by: Chang Liu <cl91tp@gmail.com <mailto:cl91tp@gmail.com>>
>      > ---
>      > This fixes the above mentioned bug https://bugzilla.kernel.org/show_bug.cgi?id=63861
>      >
>      > As Alan Cox has warned in https://lkml.org/lkml/2012/6/6/545, some device
>      > will break if we clear bus master bit on shutdown. So sooner or later
>      > we will need to blacklist some device if we are to keep Bus Master being cleared
>      > as the default behavior. Now with the first (as I have been aware) device
>      > that breaks under this default behavior has surfaced, we might as well
>      > add the infrastructure code now in case some other devices break down
>      > in the future. These devices may not be many so a blacklist likely won't
>      > add much maintainance overhead. And we should keep the blacklist here in
>      > the pci shutdown code instead of in individual device drivers since this
>      > is the most direct way and will likely aid future debug process.
>      >
>      > Regarding the kexec issue which the original commit b566a22c was trying to address:
>      > kexec doesn't work on this machine, even before the patch was applied (ie. in
>      > earlier kernels, I tested 3.11.6 and 3.12-rc7). Possibly because some devices
>      > won't reinitialize themselves properly. On 3.11.6, kexec -e triggers an immediate
>      > reboot. On 3.12-rc7, both with and without this patch applied, kexec -e can get it
>      > halfway into booting the new kernel but then a reboot is also triggered. I'm not sure
>      > if this patch has helped the kexec situation in this machine or not, but since it
>      > has no effects on machines without this defective SATA controller (and/or its firmware),
>      > I would say it is unlikely to negatively affect kexec on other machines.
>      >
>      >   drivers/pci/pci-driver.c | 34 +++++++++++++++++++++++++++++++++-
>      >   1 file changed, 33 insertions(+), 1 deletion(-)
>      >
>      > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>      > index 98f7b9b..1744ebf 100644
>      > --- a/drivers/pci/pci-driver.c
>      > +++ b/drivers/pci/pci-driver.c
>      > @@ -376,6 +376,29 @@ static int pci_device_remove(struct device * dev)
>      >       return 0;
>      >   }
>      >
>      > +/*
>      > + * Blacklisting certain hardware from having their Bus Master bit cleared
>      > + * during device shutdown. This is to workaround certain hardware's issue
>      > + * with clearing Bus Master bit that hangs the entire system.
>      > + */
>      > +struct {
>      > +     unsigned short vendor;
>      > +     unsigned short device;
>      > +} pci_bus_master_blacklist[] = {
>      > +     { 0x8086, 0x9c03 },     /* Intel Corporation Lynx Point-LP SATA Controller */
>      > +};
>      > +
>      > +static bool pci_should_clear_master(struct pci_dev *pdev)
>      > +{
>      > +     int i;
>      > +     for (i = 0; i < ARRAY_SIZE(pci_bus_master_blacklist); i++) {
>      > +             if (pdev->vendor == pci_bus_master_blacklist[i].vendor
>      > +                 && pdev->device == pci_bus_master_blacklist[i].device)
>      > +                     return false;
>      > +     }
>      > +     return true;
>      > +}
>      > +
>      >   static void pci_device_shutdown(struct device *dev)
>      >   {
>      >       struct pci_dev *pci_dev = to_pci_dev(dev);
>      > @@ -391,9 +414,18 @@ static void pci_device_shutdown(struct device *dev)
>      >       /*
>      >        * Turn off Bus Master bit on the device to tell it to not
>      >        * continue to do DMA. Don't touch devices in D3cold or unknown states.
>      > +      * This is useful for proper kexec. However, a number of hardware
>      > +      * aren't happy with this. At the slightest, some hardware simply
>      > +      * ignore the bus master bit. For some other hardware, clearing
>      > +      * the bit on shutdown path hangs the entire system.
>      > +      * This is likely to be a firmware or hardware problem, but
>      > +      * we can workaround it here by blacklisting these hardware
>      > +      * from having their bus master bit cleared during device shutdown.
>      >        */
>      > -     if (pci_dev->current_state <= PCI_D3hot)
>      > +     if (pci_should_clear_master(pci_dev)
>      > +         && pci_dev->current_state <= PCI_D3hot) {
>      >               pci_clear_master(pci_dev);
>      > +     }
>      >   }
>      >
>      >   #ifdef CONFIG_PM
>      >
> 


