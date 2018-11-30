Return-Path: <SRS0=gDpg=OJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9986C04EB8
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE70F20867
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 16:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE70F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeLAD3V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:29:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeLAD3V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Nov 2018 22:29:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19E99A797;
        Fri, 30 Nov 2018 16:19:31 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8A40600C9;
        Fri, 30 Nov 2018 16:19:29 +0000 (UTC)
Date:   Fri, 30 Nov 2018 09:19:29 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bharat Bhushan <bharat.bhushan@nxp.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>,
        David Daney <david.daney@cavium.com>,
        "jglauber@cavium.com" <jglauber@cavium.com>,
        "mbroemme@libmpq.org" <mbroemme@libmpq.org>,
        "chrisrblake93@gmail.com" <chrisrblake93@gmail.com>
Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Message-ID: <20181130091929.3eae4e99@x1.home>
In-Reply-To: <VI1PR04MB48458DF3A1EBB73A4E2CDCD19AD30@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
        <20181127153356.GA112381@google.com>
        <20181127090830.084fedf1@x1.home>
        <VI1PR04MB48457E23AA3354316C7782D69AD10@VI1PR04MB4845.eurprd04.prod.outlook.com>
        <CAErSpo7By1t5X=M=x_+Fs8TeROACBnS3f5ujsi=Ewiogh=-wRg@mail.gmail.com>
        <VI1PR04MB4845D4ED02E38246E71DD1A49AD30@VI1PR04MB4845.eurprd04.prod.outlook.com>
        <20181129225606.328f7386@x1.home>
        <VI1PR04MB48458DF3A1EBB73A4E2CDCD19AD30@VI1PR04MB4845.eurprd04.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 30 Nov 2018 16:19:31 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 30 Nov 2018 06:24:16 +0000
Bharat Bhushan <bharat.bhushan@nxp.com> wrote:

> Hi Alex,
> 
> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, November 30, 2018 11:26 AM
> > To: Bharat Bhushan <bharat.bhushan@nxp.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; Bjorn Helgaas
> > <helgaas@kernel.org>; linux-pci@vger.kernel.org; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; bharatb.yadav@gmail.com; David Daney
> > <david.daney@cavium.com>; jglauber@cavium.com;
> > mbroemme@libmpq.org; chrisrblake93@gmail.com
> > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
> > 
> > On Fri, 30 Nov 2018 05:29:47 +0000
> > Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
> >   
> > > Hi,
> > >  
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > Sent: Thursday, November 29, 2018 1:46 AM
> > > > To: Bharat Bhushan <bharat.bhushan@nxp.com>
> > > > Cc: alex.williamson@redhat.com; Bjorn Helgaas <helgaas@kernel.org>;
> > > > linux- pci@vger.kernel.org; Linux Kernel Mailing List <linux-  
> > > > kernel@vger.kernel.org>; bharatb.yadav@gmail.com; David Daney  
> > > > <david.daney@cavium.com>; jglauber@cavium.com;  
> > mbroemme@libmpq.org;  
> > > > chrisrblake93@gmail.com
> > > > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
> > > >
> > > > On Tue, Nov 27, 2018 at 10:32 PM Bharat Bhushan
> > > > <bharat.bhushan@nxp.com> wrote:
> > > >  
> > > > > > -----Original Message-----
> > > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > > Sent: Tuesday, November 27, 2018 9:39 PM
> > > > > > To: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > Cc: Bharat Bhushan <bharat.bhushan@nxp.com>;
> > > > > > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > > bharatb.yadav@gmail.com; David Daney  
> > <david.daney@cavium.com>;  
> > > > Jan  
> > > > > > Glauber <jglauber@cavium.com>; Maik Broemme  
> > > > <mbroemme@libmpq.org>;  
> > > > > > Chris Blake <chrisrblake93@gmail.com>
> > > > > > Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
> > > > > >
> > > > > > On Tue, 27 Nov 2018 09:33:56 -0600 Bjorn Helgaas
> > > > > > <helgaas@kernel.org> wrote:  
> > > >  
> > > > > > > 4) Is there a hardware erratum for this?  If so, please
> > > > > > > include the URL here.  
> > > > >
> > > > > No h/w errata as of now.  
> > > >
> > > > Does that mean (a) the HW folks agree this is a hardware problem but
> > > > they haven't written an erratum, (b) there is an erratum but it
> > > > isn't public, (c) we don't have any concrete evidence of a hardware
> > > > problem, but things just don't work if we do a bus reset, (d) something  
> > else?  
> > >
> > > I will say it is (c) - not concluded to be hardware h/w issue.
> > >  
> > > >  
> > > > > In pci_reset_secondary_bus() I have tried to increase the delay
> > > > > after reset  
> > > > but not helped.  
> > > > > Do I need to add delay at some other place as well?  
> > > >
> > > > No, I think the place you tried should be enough.
> > > >
> > > > You should also be able to exercise this from user-space by using
> > > > "setpci" to set and clear the Secondary Bus Reset bit in the Bridge
> > > > Control register.  Then you can also use setpci to read/write config
> > > > space of the NIC.  The kernel would normally read the Vendor and
> > > > Device IDs as the first access to the device during enumeration.
> > > > You also might be able to learn something by using "lspci -vv" on
> > > > the bridge before and after the reset to see if it logs any AER bits (if it  
> > supports AER) or the other standard error logging bits.  
> > >
> > > I tried below sequence for Secondary bus reset and device config space
> > > show 0xff
> > >
> > > root@localhost:~# lspci -x
> > > 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0 (rev
> > > 10)
> > > 00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
> > > 10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
> > > 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> > > 30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00
> > >
> > > 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit
> > > Network Connection
> > > 00: 86 80 d3 10 06 04 10 00 00 00 00 02 10 00 00 00
> > > 10: 00 00 0c 40 00 00 00 40 01 00 00 00 00 00 0e 40
> > > 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 1f a0
> > > 30: 00 00 24 40 c8 00 00 00 00 00 00 00 63 01 00 00
> > >
> > > root@localhost:~#  setpci -s 0002:00:00.0 0x3e.b=0x40
> > > root@localhost:~#  setpci -s 0002:00:00.0 0x3e.b=0x00
> > >
> > > root@localhost:~# lspci -x
> > > 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0 (rev
> > > 10)
> > > 00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
> > > 10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
> > > 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> > > 30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00  
> > 
> > Just for curiosity sake, what if you re-write the secondary and subordinate
> > bus registers here:
> > 
> > # setpci -s 0002:00:00.0 0x19.b=0x01
> > # setpci -s 0002:00:00.0 0x1a.b=0xff  
> 
> Result is same, here are logs
> 
> root@localhost:~# setpci -s 0002:00:00.0 0x3e.b=0x40
> root@localhost:~# setpci -s 0002:00:00.0 0x3e.b=0x00
> root@localhost:~# setpci -s 0002:00:00.0 0x19.b=0x01
> root@localhost:~# setpci -s 0002:00:00.0 0x1a.b=0xff
> root@localhost:~# lspci -x
> 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 80c0 (rev 10)
> 00: 57 19 c0 80 07 01 10 00 10 00 04 06 08 00 01 00
> 10: 00 00 00 00 00 00 00 00 00 01 ff 00 01 01 00 00
> 20: 00 40 00 40 f1 ff 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 40 00 00 00 00 00 00 40 63 01 00 00
> 
> 0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection (rev ff)
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Ok, thanks for scratching my itch.

> > IIRC the users that debugged the AMD bus reset issue re-wrote the entire 64
> > bytes of the bridge config header and then further narrowed the issue down
> > to the two registers above.  If one bridge implementation can have such an
> > issue, maybe others do too.  Perhaps there's common IP in use.  
> 
> >  Are you able
> > to test other endpoints besides this e1000e device with this setpci
> > technique?  Thanks,  
> 
> I tried  with " Broadcom Limited NetXtreme BCM5722 Gigabit Ethernet PCI Express" I observe same issue.

Personally I'd exhaust talking with your hardware folks before blocking
bus resets at the software level, it seems like a gap in PCIe
compliance of the device.  Thanks,

Alex
