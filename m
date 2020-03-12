Return-Path: <SRS0=VYo7=45=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C12C10DCE
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 22:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A624206FA
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 22:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584052346;
	bh=IYnjR/uboZsMfV7EbSz7jXZaskj1wK3BEJnXwYPkD88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=2CAxzajxJSIfModkuuke5SEfkNJ78JkYDDdzve5qWyh9kV+e0Jp886ZOSj+dQTq7y
	 zbdTwr50NO3sIqUhCi3OrIy9c1+B1UMUiNkxLC6LXjA9UUanMfI0+e52ZB5J1Owepj
	 Kghg4D+4Kq+hNfSxpxmmnrBLFjijk37f2qIAZpkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCLWc0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgCLWcZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 18:32:25 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35E620637;
        Thu, 12 Mar 2020 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584052345;
        bh=IYnjR/uboZsMfV7EbSz7jXZaskj1wK3BEJnXwYPkD88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MG8L3Jc0+GGnKwH4fUPdBkuT7BAOZ+oS9MyMeXtCu1Qqktw/1BP6LvUN3vuL2vcQz
         c/3g+u7F6Ui+4SlEWWjAB7ejxg7b4Hu+2Rc7nDLNmelta50W/VW7ztI4BEPgUuCFY9
         2rWsqqJ3Ur0H92Mm3CtYxrojwAorerJSWTxh1ww0=
Date:   Thu, 12 Mar 2020 17:32:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200312223222.GA200236@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <951fc29a-1462-ef46-d9a2-5e1cd50bf90a@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 02:59:15PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 3/12/20 12:53 PM, Bjorn Helgaas wrote:
> > On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
> > > > Is any synchronization needed here between the EDR path and the
> > > > hotplug/enumeration path?
> > > If we want to follow the implementation note step by step (in
> > > sequence) then we need some synchronization between EDR path and
> > > enumeration path. But if it's OK to achieve the same end result by
> > > following steps out of sequence then we don't need to create any
> > > dependency between EDR and enumeration paths. Currently we follow
> > > the latter approach.
> > What would the synchronization look like?
> we might need some way to disable the enumeration path till
> we get response from firmware.
> 
> In native hot plug case, I think we can do it in two ways.
> 
> 1. Disable hotplug notification in slot ctl registers.
>     (pcie_disable_notification())
> 2. Some how block hotplug driver from processing the new
>     events (not sure how feasible its).
> 
> Following method 1 would be easy, But I am not sure whether
> its alright to disable them randomly. I think, unless we
> clear the status as well, we might get some issues due to stale
> notification history.
> 
> For ACPI event case, I am not sure whether we have some
> communication protocol in place to disable receiving ACPI
> events temporarily.
> 
> For polling model, we need to disable to the polling
> timer thread till we receive _OST response from firmware.
> > 
> > Ideally I think it would be better to follow the order in the
> > flowchart if it's not too onerous.
> None of the above changes will be pretty and I think it will
> not be simple as well.
> >   That will make the code easier to
> > understand.  The current situation with this dependency on pciehp and
> > what it will do leaves a lot of things implicit.
> > 
> > What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?
> > 
> > IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
> > unbinds the drivers and removes the devices.
> 
> >  If that doesn't happen, and Linux clears the DPC trigger to bring
> >  the link back up, will those drivers try to operate uninitialized
> >  devices?
>
> I don't think this will happen. In DPC reset_link before we bring up
> the device we wait for link to go down first using
> pcie_wait_for_link(pdev, false) function.

I understand that, but these child devices were reset when DPC
disabled the link.  When the link comes back up, their BARs contain
zeros.

If CONFIG_HOTPLUG_PCI_PCIE=y, the DLLSC interrupt will cause pciehp to
unbind the driver.  It seems like the unbind races with the EDR notify
handler.  If pciehp unbinds the driver before edr_handle_event() calls
pcie_do_recovery(), this seems fine -- we'll call dpc_reset_link(),
which brings up the link, we won't call any driver callbacks because
there's no driver, and another DLLSC interrupt will cause pciehp to
re-enumerate, which will re-initialize the device, then rebind the
driver.

If the EDR notify handler runs before pciehp unbinds the driver,
couldn't EDR bring up the link and call driver .mmio_enabled() before
the device has been initialized?

If CONFIG_HOTPLUG_PCI_PCIE=n and CONFIG_HOTPLUG_PCI_ACPI=y, I could
believe that the situations are similar to the above.

What if CONFIG_HOTPLUG_PCI_PCIE=n and CONFIG_HOTPLUG_PCI_ACPI=n?  Then
I assume there's nothing to unbind the driver, so pcie_do_recovery()
will call the driver .mmio_enabled() and other recovery callbacks on a
device that hasn't been initialized?
