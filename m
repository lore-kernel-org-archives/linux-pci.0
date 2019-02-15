Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE3C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B7B2070D
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 09:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfBOJwe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:52:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57220 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfBOJwe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Feb 2019 04:52:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092C6A78;
        Fri, 15 Feb 2019 01:52:34 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24223F557;
        Fri, 15 Feb 2019 01:52:31 -0800 (PST)
Date:   Fri, 15 Feb 2019 09:52:21 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set
 correct MEM TYPE flags
Message-ID: <20190215095214.GA24988@e107981-ln.cambridge.arm.com>
References: <20190114111513.21618-1-kishon@ti.com>
 <20190114111513.21618-9-kishon@ti.com>
 <20190211173723.GA31035@e107981-ln.cambridge.arm.com>
 <ebadc615-f633-e84e-041a-99b7936a123b@ti.com>
 <20190214162928.GA32523@e107981-ln.cambridge.arm.com>
 <edc76e9b-bdd4-80bb-3dff-1d44a100c153@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc76e9b-bdd4-80bb-3dff-1d44a100c153@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 15, 2019 at 11:49:12AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 14/02/19 9:59 PM, Lorenzo Pieralisi wrote:
> > On Wed, Feb 13, 2019 at 07:17:14PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Lorenzo,
> >>
> >> On 11/02/19 11:07 PM, Lorenzo Pieralisi wrote:
> >>> On Mon, Jan 14, 2019 at 04:45:06PM +0530, Kishon Vijay Abraham I wrote:
> >>>> pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
> >>>> Base Address Register irrespective of the size. Fix it here to indicate
> >>>> 64-bit BAR if the size is > 2GB.
> >>>>
> >>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>> ---
> >>>>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
> >>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> This looks like a fix and should me marked as such. Does it work
> >>> as as standalone patch if it gets backported ?
> >>
> >> Yeah, it should work. But the current users doesn't allocate > 2GB and some
> >> EPC drivers configure their registers based on size. So nothing is broken
> >> without this patch as such.
> > 
> > I suspect you mean 4GB (here and the commit log), right ? I am checking
> > the commit logs, aiming at merging the patches.
> 
> A 32bit BAR register can support a 'size' of only up to 2GB. Though it
> can hold a memory address of up to 4GB.
> 
> This is also mentioned in the PCI Local Bus Specification.  "A 32-bit
> register can be implemented to support a single memory size that is a
> power of 2 from 16 bytes to 2 GB"

Very true - sorry for the noise.

Lorenz,o
