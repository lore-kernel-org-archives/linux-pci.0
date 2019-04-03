Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBC5C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9552147C
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554297289;
	bh=HG9WifRKyyDiTzBy1ez5ZgwdhS7Vtx8XlpaFTlMgfAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQTVrABHIllxFxfkRxOpQcIDI5RLzeXlgpxEpXZq5PFBR2jTue6aDeN+bGkVWAMdf
	 9dEDlGYSA8JoJIxlo9yc3Hrj6wz95ekY8pABwNSj4pRK3xqsh1gzmYvN0pVOmNZols
	 SzTGlTIamUmaIY1OJm37w3SSdqxDbrtghqQNIQzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfDCNOt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCNOs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Apr 2019 09:14:48 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65D02084C;
        Wed,  3 Apr 2019 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554297288;
        bh=HG9WifRKyyDiTzBy1ez5ZgwdhS7Vtx8XlpaFTlMgfAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOzzfPdW9vdgXdI2L8g2K4cZNu5LgJkCwHWzXIfHH05ClhvAsimaXDYidlbp3aNxS
         WSoFvZduz+DobzP3l7vum017n0x25zA6EFLVtTnq3t4+AnnoP+HU/ZmziDiIh2v6kX
         533MMAcPB0Lf5+vvSv7nFmv4DReR7mPvMsMeMqjg=
Date:   Wed, 3 Apr 2019 08:14:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH net] r8169: switch off ASPM by default and add sysfs
 attribute to control ASPM
Message-ID: <20190403131446.GH141706@google.com>
References: <275eb60f-8cfe-9ff6-97bc-39d9ef280d36@gmail.com>
 <0640ba80-519f-ab76-a86d-e42833df46fb@gmail.com>
 <4f0e0f6c-20b7-73f8-e524-9798dfbac6d9@gmail.com>
 <20190402215752.GG141706@google.com>
 <436d3d44-27ab-2d4b-988e-8411b8ea3759@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436d3d44-27ab-2d4b-988e-8411b8ea3759@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Frederick]

On Wed, Apr 03, 2019 at 07:53:40AM +0200, Heiner Kallweit wrote:
> On 02.04.2019 23:57, Bjorn Helgaas wrote:
> > On Tue, Apr 02, 2019 at 10:41:20PM +0200, Heiner Kallweit wrote:
> >> On 02.04.2019 22:16, Florian Fainelli wrote:
> >>> On 4/2/19 12:55 PM, Heiner Kallweit wrote:
> >>>> There are numerous reports about different problems caused by ASPM
> >>>> incompatibilities between certain network chip versions and board
> >>>> chipsets. On the other hand on (especially mobile) systems where ASPM
> >>>> works properly it can significantly contribute to power-saving and
> >>>> increased battery runtime.
> >>>> One problem so far to make ASPM configurable was to find an acceptable
> >>>> way of configuration (e.g. module parameters are discouraged for that
> >>>> purpose).
> >>>>
> >>>> As a new attempt let's switch off ASPM per default and make it
> >>>> configurable by a sysfs attribute. The attribute is documented in
> >>>> new file Documentation/networking/device_drivers/realtek/r8169.txt.
> > 
> > Both module parameters and sysfs attributes are a poor user
> > experience.  It's very difficult for users to figure out that
> > a tweak is needed.
> > 
> >>> I am not sure this is where it should be solved, there is
> >>> definitively a device specific aspect to properly supporting the
> >>> enabling of ASPM L0s, L1s etc, but the actual sysfs knobs should
> >>> belong to the pci_device itself, since this is something that
> >>> likely other drivers would want to be able to expose. You would
> >>> probably want to work with the PCI maintainers to come up with a
> >>> standard solution that applies beyond just r8169 since presumably
> >>> there must be a gazillion of devices with the same issues.
> > 
> > The Linux PCI core support for ASPM is poor.  Without more details,
> > it's impossible to tell whether these issues are hardware or firmware
> > defects on the device itself, or something that Linux is doing wrong.
> > There are several known defects, especially related to L1 substates
> > and hotplug.
> > 
> The vendor refuses to release datasheets or errata. Only certain
> combinations of board chipsets (and maybe BIOS versions) and network
> chip versions (from the ~ 50 supported by the driver) seem to be
> affected. One typical symptom is missed RX packets, maybe the RX FIFO
> isn't big enough to buffer all packets until PCIe has woken up.
> The Windows vendor driver uses a hack, they dynamically disable ASPM
> under load.

I'm not super sympathetic to vendors like that or to OEMs that work
with them.  If we can make the NIC work reliably by disabling ASPM,
that's step one.  If we can figure out how to extend battery life by
enabling ASPM in some cases, great, but we have to be careful to do it
in a way that is supportable and doesn't generate lots of user
complaints that require debugging.

That said, I think Frederick has already started working on a plan for
the PCI core to expose sysfs files to manage ASPM.  This is similar to
the link_state files enabled by CONFIG_PCIEASPM_DEBUG, but it will be
always enabled and probably structured slightly differently.  The idea
is that this would be generic and would not require any driver
support.

Bjorn
