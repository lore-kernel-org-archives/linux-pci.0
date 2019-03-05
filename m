Return-Path: <SRS0=Jbu+=RI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0D5C43381
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 23:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174A32082C
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 23:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551827816;
	bh=zwqZZsThZQ6nowJFulARgnU52hfdsiy0qYX3oid09v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F8bpFraMFzwfnVbolMmXsEBVMgSap+6NLUI+gIDbQlHqUpXzM9L6BbeK7xuvpIeks
	 axZp5jdpR15K4fKaDtOWK3Ow/m3+s3nx8RvshSf3ZmDNFsxTqfs6gw5Q2v490tQ03w
	 o0Adotd935s6rTLwK43WTt4qKrpffNObs8ou7Pos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfCEXQz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfCEXQz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Mar 2019 18:16:55 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4E020652;
        Tue,  5 Mar 2019 23:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551827814;
        bh=zwqZZsThZQ6nowJFulARgnU52hfdsiy0qYX3oid09v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxU5oyTEoYzO/8/bDOiE3EDCuPG1CB3YOWzpuv75fOQtoIG+6Wr16ZiaOuqyz/UYw
         v+HAMLS4Xc3RpgdMc2ZNPDKAeAcpVcC6ag4lYV4A7laDsMS/9kUvtqK6bXr9Ur29k7
         oxuUoO0XzuFFr0L3IlxHxVpfk6CQW/qfxpxJti04=
Date:   Tue, 5 Mar 2019 17:16:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     helgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, lukas@wunner.de,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Message-ID: <20190305231650.GC215617@google.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 05:16:01PM -0600, Alexandru Gagniuc wrote:
> Thanks to Keith for pointing out that it doesn't make sense to disable
> AER services when only one device has a FIRMWARE_FIRST HEST.
> 
> AER ownership is an interesting issue brought in by FFS (firmware-first)
> model. In a nutshell if FFS handles AER, then OS should not touch any
> of the AER bits. FW might set things up so that it receives AER
> notifications via SMI. It's theoretically possible to receive SCIs,
> but the exact mechanism is platform-dependent. OS touching AER bits
> when firmware owns them may interfere with these notifications.
> 
> The ACPI mechanism for negotiating control of AER is _OSC, and is
> described in detail in ACPI 6.2 Ch. 6.2.11.3. _OSC is negotiated at
> the root bus level. Any root port, switch, or endpoint under the bus
> would have its AER ownership negotiated in one _OSC call.
> 
> Then there is HEST, which is part of ACPI Platform Error Interfaces
> (APEI). HEST tables describe the errors that FW may report to the OS.
> A types 6,7 and 7 HEST tables describe AER errors from PCIe devices.
> As part of this description, we're told if the error source is FFS.
> 
> Information in HEST seems to be redundant, as each error reported by
> FW will have a CPER table that describes it in detail.
> 
> Because HEST describes an error source as firmware-first or not, we've
> taken this to mean ownership of AER. Because AER ownership and error
> reporting are coupled, _OSC and HEST usually agree on the matter of
> ownership. However, that doesn't seem to be required by ACPI.
> 
> I've asked around a few people at Dell and they unanimously agree that
> _OSC is the correct way to determine ownership of AER. In linux, we
> use the result of _OSC to enable AER services, but we use HEST to
> determine AER ownership. That's inconsistent. This series drops the
> use of HEST in favor of _OSC.
> 
> [1] https://lkml.org/lkml/2018/11/15/62
> 
> Alexandru Gagniuc (2):
>   PCI/AER: Do not use APEI/HEST to disable AER services globally
>   PCI/AER: Determine AER ownership based on _OSC instead of HEST
> 
>  drivers/acpi/pci_root.c  |  9 +----
>  drivers/pci/pcie/aer.c   | 82 ++--------------------------------------
>  include/linux/pci-acpi.h |  6 ---
>  3 files changed, 5 insertions(+), 92 deletions(-)

I'm pretty sure we do need to do something here, but there was quite a
lot of discussion that didn't seem to really get resolved, so I'm
dropping these for now.

Please repost them with any relevant updates and we'll see if we can
get a consensus that we're going the right direction.

Bjorn
