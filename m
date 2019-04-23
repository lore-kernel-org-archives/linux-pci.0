Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC8C10F11
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 00:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2828620896
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 00:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfDWAdt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbfDWAdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 20:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1796B58E33;
        Tue, 23 Apr 2019 00:33:49 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17D89608A4;
        Tue, 23 Apr 2019 00:33:48 +0000 (UTC)
Date:   Mon, 22 Apr 2019 18:33:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
Message-ID: <20190422183347.51ba522c@x1.home>
In-Reply-To: <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
        <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 23 Apr 2019 00:33:49 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Apr 2019 19:05:57 -0500
Alex G <mr.nuke.me@gmail.com> wrote:

> On 4/22/19 5:43 PM, Alex Williamson wrote:
> > [  329.725607] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
> > GT/s x16 link)
> > [  708.151488] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
> > GT/s x16 link)
> > [  718.262959] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
> > GT/s x16 link)
> > [ 1138.124932] vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth,
> > limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5
> > GT/s x16 link)
> > 
> > What is the value of this nagging?  
> 
> Good! The bandwidth notification service is working as intended. If this 
> bothers you, you can unbind the device from the bandwidth notification 
> driver:
> 
> echo 0000:07:00.0:pcie010 |
> sudo tee /sys/bus/pci_express/drivers/pcie_bw_notification/unbind

That's a bad solution for users, this is meaningless tracking of a
device whose driver is actively managing the link bandwidth for power
purposes.  There is nothing wrong happening here that needs to fill
logs.  I thought maybe if I enabled notification of autonomous
bandwidth changes that it might categorize these as something we could
ignore, but it doesn't.  How can we identify only cases where this is
an erroneous/noteworthy situation?  Thanks,

Alex

> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index 7d04f9d087a6..1b330129089f 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -55,7 +55,8 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
> >   	 * 7.8.2, 7.10.10, 7.31.2.
> >   	 */
> >   
> > -	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
> > +	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
> > +		    PCIE_PORT_SERVICE_BWNOTIF)) {
> >   		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
> >   		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
> >   		nvec = *pme + 1;  
> 
> Good catch!

