Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64759C282CE
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 18:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C582133D
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554834045;
	bh=6hTQw9NLE1XPKoFhTQTSi85y76KsTtUt4PBbO0pOOEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GoB8FNlzEWsD4ywmgrrOJ7pnFAKpFDMRA0BNujhekUfpw7ed1I9jAAPxfsMbxvcm2
	 pivpXi29CLRmNxOXjSBd0oVQv7aHvGKLCkatBlx4/+z9QR07j+LFHGA9uMktFNinRg
	 /SDWwWFbgXNAUybPx7McW5doCBO7tgTV+u6cFq6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfDISUo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfDISUo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Apr 2019 14:20:44 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C60C2077C;
        Tue,  9 Apr 2019 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554834043;
        bh=6hTQw9NLE1XPKoFhTQTSi85y76KsTtUt4PBbO0pOOEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPfeV9L92mV5AuFpTXbL6a7d7/cV64RRbxbpHaD3+c+IdzyUFYDCDpXKvAcdOc+MM
         coYdNbAndJK7I71VLrAnxmeQuVvJb8xFIndRdGQaqmhDdf65njIg3jNDj6EBF9BSHD
         +RXHS3u5cJqeDPtfIsMdSjAURt2w4+qFRBbKZUAo=
Date:   Tue, 9 Apr 2019 13:20:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH net] r8169: switch off ASPM by default and add sysfs
 attribute to control ASPM
Message-ID: <20190409182039.GB256045@google.com>
References: <275eb60f-8cfe-9ff6-97bc-39d9ef280d36@gmail.com>
 <0640ba80-519f-ab76-a86d-e42833df46fb@gmail.com>
 <4f0e0f6c-20b7-73f8-e524-9798dfbac6d9@gmail.com>
 <20190402215752.GG141706@google.com>
 <436d3d44-27ab-2d4b-988e-8411b8ea3759@gmail.com>
 <20190403131446.GH141706@google.com>
 <b8787012-0928-e613-bbf6-4de3e462f055@gmail.com>
 <20190405191024.GD26522@google.com>
 <58f445a2-1eb3-7759-62d6-efacd87d52b6@gmail.com>
 <2698cdee-91b9-8955-5b29-b5ba4e656526@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2698cdee-91b9-8955-5b29-b5ba4e656526@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 09, 2019 at 07:32:15PM +0200, Heiner Kallweit wrote:
> On 05.04.2019 21:28, Heiner Kallweit wrote:
> > On 05.04.2019 21:10, Bjorn Helgaas wrote:
> >> On Wed, Apr 03, 2019 at 07:45:29PM +0200, Heiner Kallweit wrote:
> >>> On 03.04.2019 15:14, Bjorn Helgaas wrote:
> >>>> On Wed, Apr 03, 2019 at 07:53:40AM +0200, Heiner Kallweit wrote:
> >>>>> On 02.04.2019 23:57, Bjorn Helgaas wrote:
> >>>>>> On Tue, Apr 02, 2019 at 10:41:20PM +0200, Heiner Kallweit wrote:
> >>>>>>> On 02.04.2019 22:16, Florian Fainelli wrote:
> >>>>>>>> On 4/2/19 12:55 PM, Heiner Kallweit wrote:
> >>>>>>>>> There are numerous reports about different problems caused by
> >>>>>>>>> ASPM incompatibilities between certain network chip versions
> >>>>>>>>> and board chipsets. On the other hand on (especially mobile)
> >>>>>>>>> systems where ASPM works properly it can significantly
> >>>>>>>>> contribute to power-saving and increased battery runtime.
> >>>>>>>>> One problem so far to make ASPM configurable was to find an
> >>>>>>>>> acceptable way of configuration (e.g. module parameters are
> >>>>>>>>> discouraged for that purpose).
> >>
> >>>>>>>>> +Certain combinations of network chip versions and board
> >>>>>>>>> +chipsets result in increased packet latency, PCIe errors, or
> >>>>>>>>> +significantly reduced network performance. Therefore ASPM is
> >>>>>>>>> +off by default. On the other hand ASPM can significantly
> >>>>>>>>> +contribute to power-saving and thus increased battery runtime
> >>>>>>>>> +on notebooks.
> >>
> >>>> That said, I think Frederick has already started working on a plan
> >>>> for the PCI core to expose sysfs files to manage ASPM.  This is
> >>>> similar to the link_state files enabled by CONFIG_PCIEASPM_DEBUG,
> >>>> but it will be always enabled and probably structured slightly
> >>>> differently.  The idea is that this would be generic and would not
> >>>> require any driver support.
> >>
> >>> Frederick, is there anything you could share already? Or any timeline?
> >>> Based on Bjorns info what seems to be best to me:
> >>> 1. Disable ASPM for r8169 on stable (back to 4.19).
> >>> 2. Once the generic ASPM sysfs attributes are available, reenable ASPM
> >>>    for r8169 in net-next.
> >>
> >> This is out of my wheelhouse, but even with a generic sysfs knob, it
> >> doesn't sound like a good idea to me to enable ASPM by default for
> >> r8169 if we think it's unreliable on any significant fraction of
> >> machines.
> >>
> > I was a little bit imprecise. With the second statement I wanted to say:
> > Keep ASPM disabled per default, but make it possible that setting the
> > new sysfs attribute enables ASPM. After digging deeper in the ASPM core
> > code it seems however that we don't even have to touch the driver later.
> 
> ASPM has been disabled again for r8169: b75bb8a5b755 ("r8169: disable ASPM
> again"). So, coming back to controlling ASPM via sysfs:
> My first thought would be to extend pci_disable_link_state with support
> for disabling L1.1/L1.2, and then basically expose pci_disable_link_state
> via sysfs (attribute reading being handled with a direct read from
> pcie_link_state->aspm_disable).
> 
> Is this what you were planning or do you have some other approach in mind?

I can't remember the details of what Frederick and I talked about, but
I think that's the general approach.

Bjorn
