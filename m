Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A947CECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 14:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD6A21532
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 14:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD6A21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbeITUCH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:02:07 -0400
Received: from foss.arm.com ([217.140.101.70]:46832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730955AbeITUCH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 16:02:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E247B7A9;
        Thu, 20 Sep 2018 07:18:24 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DF4F3F557;
        Thu, 20 Sep 2018 07:18:23 -0700 (PDT)
Date:   Thu, 20 Sep 2018 15:18:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] hv_netvsc: associate VF and PV device by serial
 number
Message-ID: <20180920141820.GD838@e107981-ln.cambridge.arm.com>
References: <20180914195457.20433-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914195457.20433-1-sthemmin@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 14, 2018 at 12:54:55PM -0700, Stephen Hemminger wrote:
> The Hyper-V implementation of PCI controller has concept of 32 bit serial number
> (not to be confused with PCI-E serial number).  This value is sent in the protocol
> from the host to indicate SR-IOV VF device is attached to a synthetic NIC.
> 
> Using the serial number (instead of MAC address) to associate the two devices
> avoids lots of potential problems when there are duplicate MAC addresses from
> tunnels or layered devices.
> 
> The patch set is broken into two parts, one is for the PCI controller
> and the other is for the netvsc device. Normally, these go through different
> trees but sending them together here for better review. The PCI changes
> were submitted previously, but the main review comment was "why do you
> need this?". This is why.

The question was more whether we should convert this serial number into
a PCI slot number (that has user space visibility and that is what you are
after) to improve the current matching, I do not question why you need
it, just for the records.

Lorenzo

> v2 - slot name can be shorter.
>      remove locking when creating pci_slots; see comment for explaination
> 
> Stephen Hemminger (2):
>   PCI: hv: support reporting serial number as slot information
>   hv_netvsc: pair VF based on serial number
> 
>  drivers/net/hyperv/netvsc.c         |  3 ++
>  drivers/net/hyperv/netvsc_drv.c     | 58 ++++++++++++++++-------------
>  drivers/pci/controller/pci-hyperv.c | 37 ++++++++++++++++++
>  3 files changed, 73 insertions(+), 25 deletions(-)
> 
> -- 
> 2.18.0
> 
