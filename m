Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25860C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7477223CB
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 17:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx/VBiNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7477223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeKPEHW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:07:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52545 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPEHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 23:07:22 -0500
Received: by mail-it1-f194.google.com with SMTP id t190-v6so30715403itb.2;
        Thu, 15 Nov 2018 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooXTaPBrKWZJbdOQ4QUrmUpZGa9iRizTaCm7MuadtjU=;
        b=gx/VBiNOWSaKoWjwpd5nVmGhpUOiS8OhhULUP+LkM7ei4KmvCRNdjwT64gdG8JPEmQ
         HVhG64q2fhvt26LmAQhCNeyHEdJNLrjEk0haGp6QRLOeDr0HZuTmjkG7GWPn2OOR4ztk
         2uvm0X7xH1j8raEr0bguXoHMsxt/COUd0W7bVUe181tgQ6q93MjxB3LvGmW5SFzbLaYd
         Akro0jm6llywDWtKbLIDvejCfZpF1EM44CkDW9FO7+hXMhqv2zek/H4b/hgxyjJBCpo2
         bZD2wOynPAGychy6+PeoEElm4B0mJDwd+xmYrI1dCnLzHTgVPf48sv8dVYwmJ+dXldd/
         ggvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooXTaPBrKWZJbdOQ4QUrmUpZGa9iRizTaCm7MuadtjU=;
        b=W5yS4XUNu+ZJUE2eZFRhaPMFPvFj1RPNgw0nZDZ8uQpWe5K8q8yUN2whlDInLtP8G1
         Bw3T5DoU6/vLdId3MmEoi4wmm8lAYTBHRpfoeQE4TXEKvx3XBfMGZToAeVpfWykdy70g
         qJgG2CKwUEjq2g0aAMIgpEyRAL585iNXVlwd5/wnBwv9EBmjmTMFpcY0iWsb3TQojd4J
         4R75LjBePdFWpGI6OPuQSE/BN0V4lEbWSP4lse19ZI4lYLCn3JnMPfwKBAO50oEL6CBT
         cBnVyw6rJeVwnsQuf+/70Vr07USKyhwLwZhW4BlzKCUOCA9NLzMzJdRph3mQPQD+L3YM
         2yAQ==
X-Gm-Message-State: AGRZ1gL9k9uVwEAgQl05z5m/t0lFTljkDbviaDbug5IAmAJwGtu1yvKj
        Aj8S9LTws+Jm426zxT6wsLDQR0zI3o2Cr0L5mgM=
X-Google-Smtp-Source: AJdET5dd6ff2Wv0NEo/UkAci4LoOYxp/Nc5KFGfr8Va30t+tCrrCHVeeg98ZVFNDlMJTfpnpzNlJvgEs63VVZ2OfnyY=
X-Received: by 2002:a02:954f:: with SMTP id y73-v6mr6976037jah.115.1542304710714;
 Thu, 15 Nov 2018 09:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20181112160628.86620-2-mika.westerberg@linux.intel.com>
 <20181112180203.lx72gjfplb6xlur7@wunner.de> <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com> <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com> <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com> <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com> <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Thu, 15 Nov 2018 19:58:13 +0200
Message-ID: <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
To:     lorenzo.pieralisi@arm.com
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>, lukas@wunner.de,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        David Woodhouse <dwmw2@infradead.org>,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 7:46 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Nov 15, 2018 at 02:16:27PM +0200, Mika Westerberg wrote:
> > On Thu, Nov 15, 2018 at 01:07:36PM +0100, Lukas Wunner wrote:
> > > On Thu, Nov 15, 2018 at 01:37:37PM +0200, Mika Westerberg wrote:
> > > > On Thu, Nov 15, 2018 at 11:13:56AM +0000, Lorenzo Pieralisi wrote:
> > > > > I have strong objections to the way these bindings have been forced upon
> > > > > everybody; if that's the way *generic* ACPI bindings are specified I
> > > > > wonder why there still exists an ACPI specification and related working
> > > > > group.
> > > > >
> > > > > I personally (but that's Bjorn and Rafael choice) think that this is
> > > > > not a change that belongs in PCI core, ACPI bindings are ill-defined
> > > > > and device tree bindings are non-existing.
> > > >
> > > > Any idea where should I put it then? These systems are already out there
> > > > and we need to support them one way or another.
> > >
> > > I suppose those are all Thunderbolt, so could be handled by the
> > > existing ->is_thunderbolt bit?
> > >
> > > It was said in this thread that ->is_external is more generic in
> > > that it could also be used on PCIe slots, however that use case
> > > doesn't appear to lend itself to the "plug in while laptop owner
> > > is getting coffee" attack.  To access PCIe slots on a server you
> > > normally need access to a data center.  On a desktop, you usually
> > > have to open the case, by which time the coffee may already have
> > > been fetched.  So frankly the binding seems a bit over-engineered
> > > to me and yet another thing that BIOS writers may get wrong.
> >
> > I would not say it should include PCIe slots but there are other cables
> > that carry PCIe and I was thinking we could make it to support those as
> > well.
> >
> > I have no problem using is_thunderbolt here, though if we don't want to
> > support non-Thunderbolt external devices this way.
> >
> > However, the question here is more that where I should put the _DSD
> > parsing code if it is not suitable to be placed inside PCI/ACPI core as
> > I've done in this patch? ;-)
>
> Do you really need to parse it if the dev->is_thunderbolt check is enough ?

From what I know, there are more devices that suffer from similar security
issues like Thunderbolt, e.g. FireWire [1].
My assumption is that the same protection may be applied to such devices too,
even if currently it sounds like vendors care mostly about Thunderbolt (probably
because it removes the need for user approval for device connection; it becames
a simple plug-and-play experience).

Thus, I don't think binding it with dev->is_thunderbolt is the correct
thing to do.

[1] https://github.com/carmaa/inception
