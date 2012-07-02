Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36367 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab2GBUCJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2012 16:02:09 -0400
Received: by bkwj10 with SMTP id j10so1057567bkw.19
        for <linux-pci@vger.kernel.org>; Mon, 02 Jul 2012 13:02:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPM=9tys7x5CmK-nrETA93B-9xS1uschZSgrb14-a9k9s_DNMA@mail.gmail.com>
References: <1340782554-9865-1-git-send-email-airlied@gmail.com> <CAPM=9tys7x5CmK-nrETA93B-9xS1uschZSgrb14-a9k9s_DNMA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Jul 2012 14:01:47 -0600
Message-ID: <CAErSpo64LNij4-68VX157jt9DqmzO0NAi0LsjMmUdAN8bysTPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] pci_regs: define LNKSTA2 pcie cap + bits.
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 28, 2012 at 3:45 AM, Dave Airlie <airlied@gmail.com> wrote:
> On Wed, Jun 27, 2012 at 8:35 AM, Dave Airlie <airlied@gmail.com> wrote:
>> From: Dave Airlie <airlied@redhat.com>
>>
>> We need these for detecting the max link speed for drm drivers.
>
> Hi Bjorn,
>
> Can you ack this patch so I can carry it in the drm-next tree? we need
> these regs for getting the PCIE v2/v3 supported link speeds.

Sure.  Note that I already have a patch in my "next" tree that will
conflict with this because it contains this hunk:

 #define  PCI_EXP_OBFF_WAKE_EN  0x6000  /* OBFF using WAKE# signaling */
+#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 44      /* v2 endpoints end here */
 #define PCI_EXP_LNKCTL2                48      /* Link Control 2 */

at this commit:
http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=commitdiff;h=a0dee2ed0cdc666b5622f1fc74979355a6b36850

I think the comments would make more sense as "2.5GT/s supported",
etc., since these bits don't tell you anything about the "Current Link
Speed".

Maybe it would make sense for me to incorporate this patch into my
"next" branch, and you could carry both commits in your drm-next tree?
 I don't know what results in the easiest merge later.  But if you
need it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Bjorn

>> Signed-off-by: Dave Airlie <airlied@redhat.com>
>> ---
>>  include/linux/pci_regs.h |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
>> index 4b608f5..7f04132 100644
>> --- a/include/linux/pci_regs.h
>> +++ b/include/linux/pci_regs.h
>> @@ -521,6 +521,11 @@
>>  #define  PCI_EXP_OBFF_MSGA_EN  0x2000  /* OBFF enable with Message type A */
>>  #define  PCI_EXP_OBFF_MSGB_EN  0x4000  /* OBFF enable with Message type B */
>>  #define  PCI_EXP_OBFF_WAKE_EN  0x6000  /* OBFF using WAKE# signaling */
>> +#define PCI_EXP_LNKCAP2                44      /* Link Capability 2 */
>> +#define  PCI_EXP_LNKCAP2_SLS_2_5GB 0x01        /* Current Link Speed 2.5GT/s */
>> +#define  PCI_EXP_LNKCAP2_SLS_5_0GB 0x02        /* Current Link Speed 5.0GT/s */
>> +#define  PCI_EXP_LNKCAP2_SLS_8_0GB 0x04        /* Current Link Speed 8.0GT/s */
>> +#define  PCI_EXP_LNKCAP2_CROSSLINK 0x100 /* Crosslink supported */
>>  #define PCI_EXP_LNKCTL2                48      /* Link Control 2 */
>>  #define PCI_EXP_SLTCTL2                56      /* Slot Control 2 */
>>
>> --
>> 1.7.7.6
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
