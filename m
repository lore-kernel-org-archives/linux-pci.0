Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC23C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 15:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443852184C
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548342935;
	bh=W1sfOq/m2FKrPyWAjzeHkTKNoJ62ZWEC66UvHa//XaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UyNnan0PfOwOu+gkRNZpIvDMHruSNr61b18SQhyRLWmu6GeEQGZfErrT+PudQAQmi
	 h3uo4eKGwM0pJZPd7z/7k1xvpIkQOtUSkAOXy2MKM4rvkaR9EIF/9Ayt27UgrOEtIr
	 xCGcMOl/erbCHHnP8oLtNZ+DaK/HIsFYUNjrKwGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfAXPP1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfAXPP1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 10:15:27 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE4E2184C;
        Thu, 24 Jan 2019 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548342926;
        bh=W1sfOq/m2FKrPyWAjzeHkTKNoJ62ZWEC66UvHa//XaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mskKQ7WUWSL6H6Z7rcRa9QWYHd+G6WZblzBxXLIze5dEY/LhPOxA8pQnOsXldxevr
         yCizxgoqAi+qaYZpY47zmnwrJsfbK1q8AaNX3nDo98baFE9s3838VWJqxrqkClleaj
         uBObu9hhqHiER7QLBJX5sefgASrrKcdf+E8izfOs=
Date:   Thu, 24 Jan 2019 09:15:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
Message-ID: <20190124151524.GF14636@google.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 03:17:37PM +0800, Kai Heng Feng wrote:
> > On Jan 23, 2019, at 7:51 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 22, 2019 at 02:45:44PM +0800, Kai-Heng Feng wrote:
> >> There are some e1000e devices can only be woken up from D3 one time, by
> >> plugging ethernet cable. Subsequent cable plugging does set PME bit
> >> correctly, but it still doesn't get woken up.
> >> 
> >> Since e1000e connects to the root complex directly, we rely on ACPI to
> >> wake it up. In this case, the GPE from _PRW only works once and stops
> >> working after that.
> >> 
> >> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
> >> platform firmwares that have unreliable GPE wake.
> > 
> > This quirk applies to all 0x15bb (E1000_DEV_ID_PCH_CNP_I219_LM7) and
> > 0x15bd (E1000_DEV_ID_PCH_CNP_I219_LM6) devices.  The e1000e driver
> > claims about a zillion different device IDs.
> > 
> > I would be surprised if these two devices are defective but all the
> > others work correctly.  Could it be that there is a problem with the
> > wiring on this particular motherboard or with the ACPI _PRW methods
> > (or the way Linux interprets them) in this firmware?
> 
> If this is a motherboard issue or platform specific, do you prefer to use
> DMI matches here?

I'm not sure what the problem is yet, so let's hold off on the exact
structure of the fix.

If I understand correctly, e1000e wakeup works once, but doesn't work
after that.  Your lspci (from after that first wakeup, from
https://bugzilla.kernel.org/attachment.cgi?id=280691) shows this:

  00:14.0 XHC  XHCI USB
    Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
  00:1f.3 HDAS audio
    Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
  00:1f.6 GLAN e1000e
    Flags: PMEClk- DSI+ D1- D2- ... PME(D0+,D1-,D2-,D3hot+,D3cold+)
    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME+

So the e1000e PME_Status bit is still set, which means it probably
won't generate another PME interrupt, which would explain why wakeup
doesn't work.  To test this theory, can you try this:

  - sleep
  - wakeup via e1000e
  # DEV=00:1f.6
  # lspci -vvs $DEV
  # setpci -s $DEV CAP_PM+4.W
  # setpci -s $DEV CAP_PM+4.W=0x8100
  - sleep
  - attempt another wakeup via e1000e

If this second wakeup works, it would suggest that PME_Status isn't
being cleared correctly.  I see code, e.g., in
acpi_setup_gpe_for_wake(), that *looks* like it would arrange to clear
it, but I'm not very familiar with it.  Maybe there's some issue with
multiple devices sharing an "implicit notification" situation like
this.

> As for _PRW, it’s shared by USB controller, Audio controller and ethernet.
> Only the ethernet (e1000e) has this issue.
> 
> When this issue happens, the e1000e doesn’t get woken up by ethernet cable
> plugging, but inserting a USB device or plugging audio jack can wake up all
> three devices. So I think Linux interprets ACPI correctly here.
> 
> Their _PRW here:
> USB controller:
>     Scope (_SB.PCI0)                       
>     {                                      
>         Device (XDCI)                            
>         {                    
>             Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
>             {            
>                 Return (GPRW (0x6D, 0x04))
>             } 
> 
> Audio controller:
> Scope (_SB.PCI0)                                                                                           
>     {                                                                                                          
>         Device (HDAS)                                  
>         {                                                                             
>             …         
>             Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake                 
>             {                                        
>                 Return (GPRW (0x6D, 0x04))           
>             }                                  
> 
> Ethernet controller:
>     Scope (_SB.PCI0)                                                                     
>     {                                                                     
>         Device (GLAN)                                                  
>         {                                                                            
>            …
>             Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake                 
>             {                                        
>                 Return (GPRW (0x6D, 0x04))                       
>             }                                                              
>         }                                                             
>     }  
> 
> 
> > 
> > Would you mind attaching a complete dmesg log and "sudo lspci -vvv"
> > output to the bugzilla, please?
> 
> Sure.
> 
> Kai-Heng
> 
> > 
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/pci/pci-acpi.c | 2 +-
> >> drivers/pci/quirks.c   | 8 ++++++++
> >> include/linux/pci.h    | 1 +
> >> 3 files changed, 10 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> >> index e1949f7efd9c..184e2fc8a294 100644
> >> --- a/drivers/pci/pci-acpi.c
> >> +++ b/drivers/pci/pci-acpi.c
> >> @@ -430,7 +430,7 @@ static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
> >> 
> >> 	pci_dev = to_pci_dev(context->dev);
> >> 
> >> -	if (pci_dev->pme_poll)
> >> +	if (pci_dev->pme_poll && !pci_dev->unreliable_acpi_wake)
> >> 		pci_dev->pme_poll = false;
> >> 
> >> 	if (pci_dev->current_state == PCI_D3cold) {
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index b0a413f3f7ca..ed4863496fa8 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -4948,6 +4948,14 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
> >> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> >> 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
> >> 
> >> +static void quirk_unreliable_acpi_wake(struct pci_dev *pdev)
> >> +{
> >> +	pci_info(pdev, "ACPI Wake unreliable, always poll PME\n");
> >> +	pdev->unreliable_acpi_wake = 1;
> >> +}
> >> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bb, quirk_unreliable_acpi_wake);
> >> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bd, quirk_unreliable_acpi_wake);
> >> +
> >> /*
> >>  * Some IDT switches incorrectly flag an ACS Source Validation error on
> >>  * completions for config read requests even though PCIe r4.0, sec
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 65f1d8c2f082..d22065c1576f 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -331,6 +331,7 @@ struct pci_dev {
> >> 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
> >> 					   can be generated */
> >> 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
> >> +	unsigned int	unreliable_acpi_wake:1;	/* ACPI Wake doesn't always work */
> >> 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
> >> 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> >> 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
> >> -- 
> >> 2.17.1
