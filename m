Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D74C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 06:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C9522419
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 06:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjJDvjlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C9522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeKOQay (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbeKOQay (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 11:30:54 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B086721582;
        Thu, 15 Nov 2018 06:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542263063;
        bh=AyFOkRxtya+RssMRl/vlVs/iw1ditv6b1eUmxfhkRBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjJDvjlRdX5YN1jY0z1mpgZZCqNO4iTFm2rQPbe/Yl+kWs5dTLlpBqJZiUfRMZK2h
         W26J9ymk1EyUNGc0KcvNfm5yWAgDkU8FM89ybokZMAPuhGF1Rjtpsow6jKN52aT0Zt
         wuFCN91i6tObscQnwN500xcBXv5R5RFwd94HKj5k=
Date:   Thu, 15 Nov 2018 00:24:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex_Gagniuc@Dellteam.com
Cc:     oohall@gmail.com, gregkh@linuxfoundation.org,
        keith.busch@intel.com, mr.nuke.me@gmail.com,
        linux-pci@vger.kernel.org, Austin.Bolen@dell.com,
        Shyam.Iyer@dell.com, linux-kernel@vger.kernel.org,
        jonathan.derrick@intel.com, lukas@wunner.de, ruscur@russell.cc,
        sbobroff@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181115062423.GA94998@google.com>
References: <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
 <20181113050240.GA182139@google.com>
 <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
 <20181114055956.GA144931@google.com>
 <1eb0fa27924f426992715684f5e63346@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb0fa27924f426992715684f5e63346@ausx13mps321.AMER.DELL.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 14, 2018 at 07:22:04PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/14/2018 12:00 AM, Bjorn Helgaas wrote:
> > On Tue, Nov 13, 2018 at 10:39:15PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> >> On 11/12/2018 11:02 PM, Bjorn Helgaas wrote:
> >> ...
> >>> Do you think Linux observes the rule about not touching AER bits on
> >>> FFS?  I'm not sure it does.  I'm not even sure what section of the
> >>> spec is relevant.
> >>
> >> I haven't found any place where linux breaks this rule. I'm very
> >> confident that, unless otherwise instructed, we follow this rule.
> > 
> > Just to make sure we're on the same page, can you point me to this
> > rule?  I do see that OSPM must request control of AER using _OSC
> > before it touches the AER registers.  What I don't see is the
> > connection between firmware-first and the AER registers.
> 
> ACPI 6.2 - 6.2.11.3, Table 6-197:
> 
> PCI Express Advanced Error Reporting control:
>   * The firmware sets this bit to 1 to grant control over PCI Express 
> Advanced Error Reporting. If firmware allows the OS control of this 
> feature, then in the context of the _OSC method it must ensure that 
> error messages are routed to device interrupts as described in the PCI 
> Express Base Specification[...]

The PCIe Base Spec is pretty big, so I wish this reference were a
little more explicit.  I *guess* maybe it's referring to PCIe r4.0,
figure 6-3 in sec 6.2.6, where PCIe ERR_* Messages can be routed to
"INTx or MSI Error Interrupts" and/or "platform-specific System Error"
interrupts.

"Device interrupts" seems like it refers to the "INTx or MSI"
interrupts, not the platform-specific System Errors, so I would read
that as saying "if firmware grants OS control of AER via _OSC,
firmware must set the AER Reporting Enables in the AER Root Error
Command register."  But that seems a little silly because the OS now
*owns* the AER capability and it can set the AER Root Error Command
register itself if it wants to.

And I still don't see the connection here with Firmware-First.  I'm
pretty sure firmware could not be notified via INTx or MSI interrupts
because those are totally managed by OSPM.

> > The closest I can find is the "Enabled" field in the HEST PCIe
> > AER structures (ACPI v6.2, sec 18.3.2.4, .5, .6), where it says:
> > 
> >    If the field value is 1, indicates this error source is
> >    to be enabled.
> > 
> >    If the field value is 0, indicates that the error source
> >    is not to be enabled.
> > 
> >    If FIRMWARE_FIRST is set in the flags field, the Enabled
> >    field is ignored by the OSPM.
> > 
> > AFAICT, Linux completely ignores the Enabled field in these
> > structures.
> 
> I don't think ignoring the field is a problem:
>   * With FFS, OS should ignore it.
>   * Without FFS, we have control, and we get to make the decisions anyway.
> In the latter case we decide whether to use AER, independent of the crap 
> in ACPI. I'm not even sure why "Enabled" matters in native AER handling. 

It seems like these HEST structures are "here's how firmware thinks
you should set up AER on this device".  But I agree, I have no idea
how to interpret "Enabled".  The rest of the HEST fields cover all the
useful AER registers, including the Reporting Enables in the AER Root
Error Command register *and* the Error Reporting Enables in the Device
Control register.  So I don't know what the "Enabled" field adds to
all that.  What a mess.

> > For firmware-first to work, firmware has to get control.  How does
> > it get control?  How does OSPM know to either set up that
> > mechanism or keep its mitts off something firmware set up before
> > handoff?
> 
> My understanding is that, if FW keeps control of AER in _OSC, then
> it will have set things up to get notified instead of the OS. OSPM
> not touching AER bits is to make sure it doesn't mess up FW's setup.
> I think there are some proprietary bits in the root port to route
> interrupts to SMIs instead of the AER vectors.

It makes good sense that if OSPM doesn't have AER control, firmware
does all AER handling, including any setup for firmware-first
notification.  If we can assume that firmware-first notification is
done in some way the OS doesn't know about and can't mess up, that
would be awesome.

But I think the VMD model really has nothing to do with the APEI
firmware-first model.  With VMD, it sounds like OSPM owns the AER
capability and doesn't know firmware exists *except* that it has to be
careful not to step on firmware's interrupt.  So maybe we can handle it
separately.

Bjorn
