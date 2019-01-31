Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21502C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D4720881
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfAaSDl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:03:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbfAaSDl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 13:03:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEC7C3DBE6;
        Thu, 31 Jan 2019 18:03:40 +0000 (UTC)
Received: from w520.home (ovpn-116-182.phx2.redhat.com [10.3.116.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74FC11001938;
        Thu, 31 Jan 2019 18:03:40 +0000 (UTC)
Date:   Thu, 31 Jan 2019 11:03:39 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     James Prestwood <james.prestwood@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: BCM43602 + PCI passthrough causing freeze
Message-ID: <20190131110339.207a3e6c@w520.home>
In-Reply-To: <75816515f1675f819b993eb96b84becd418ab271.camel@linux.intel.com>
References: <75816515f1675f819b993eb96b84becd418ab271.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 31 Jan 2019 18:03:40 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 31 Jan 2019 09:36:58 -0800
James Prestwood <james.prestwood@linux.intel.com> wrote:

> Hi,
> 
> I posted about a month ago on linux-wireless about an Ath9k card that
> was causing my host machine to freeze/lock up when doing PCI
> passthrough into a VM. This was resolved by adding:
> 
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034,
> quirk_no_bus_reset);
> 
> to drivers/pci/quirks.c and rebuilding the host kernel.
> 
> Original thread: 
> https://marc.info/?l=linux-wireless&m=154689580213002&w=2
> 
> I am now trying to get this BCM43602 card working under the same
> conditions but again I am seeing the host machine freeze when starting
> the VM. I did try adding a similar line for this card, which actually
> prevented the machine from freezing, but I am seeing this when starting
> the VM:
> 
> qemu-system-x86_64: vfio: Cannot reset device 0000:0a:00.0, no
> available reset mechanism.
> 
> And once inside the VM the device is UNCLAIMED and not usable:
> 
> $ lshw -C network
> 
> *-network:2 UNCLAIMED
>        description: Network controller
>        product: BCM43602 802.11ac Wireless LAN SoC
>        vendor: Broadcom Limited
>        physical id: 6
>        bus info: pci@0000:00:06.0
>        version: 01
>        width: 64 bits
>        clock: 33MHz
>        capabilities: pm msi pciexpress cap_list
>        configuration: latency=0
>        resources: memory:fe890000-fe897fff memory:fe400000-fe7fffff
> 
> This change was really a shot in the dark as I only have a vague
> understanding of what its actually doing. I see other entries in
> quirks.c for the Broadcom vendor ID but would rather not go poking
> around here without any direction.

Welcome to the world of "all hardware is broken".  If masking bus reset
prevents the system freeze then a) something about triggering a bus
reset on this link makes your system very unhappy, and b) there are no
other generic reset mechanisms available for this device.  The error
message you receive from QEMU is basically a warning about b), we don't
know how to reset the device, therefore you may have trouble with it
behaving reliably in the VM, which appears to be true in this case.
There are no easy options here, either we need to find something that
makes bus reset work, find some way to implement a device specific
reset for this endpoint, or maybe debug why the guest driver is unhappy
claiming the device and massage the device somewhere in the hypervisor
or the driver to accept the device.  Thanks,

Alex
