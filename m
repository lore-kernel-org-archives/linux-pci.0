Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F37C433F5
	for <linux-pci@archiver.kernel.org>; Sat, 23 Apr 2022 05:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiDWFwu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 23 Apr 2022 01:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiDWFwi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 01:52:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6923E3E4
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 22:49:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A9EE68AFE; Sat, 23 Apr 2022 07:49:38 +0200 (CEST)
Date:   Sat, 23 Apr 2022 07:49:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>, kbusch@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220423054938.GA17945@lst.de>
References: <20220201165006.3074615-1-kbusch@kernel.org> <20220411135850.GA42637@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411135850.GA42637@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 07:28:50PM +0530, Manivannan Sadhasivam wrote:
> PCI core only accepts the quirks for the host devices that could be passed onto
> the PCI device drivers like this one. In this case, this is not a quirk but
> actually an aggressive power saving feature (atleast on the Qcom platforms).
> Moreover, adding a flag to the PCI bus will make it applicable to all the
> child devices of the RC/bridge and that would be wrong.

As you correctly state it is not a device quirk.  It describes the
power management applied by the platform.  So we do need to communicate
it through the core PM and/or PCI code.  Please work with the relevant
maintainers.

> In our case, the same power saving feature is not applicable to all PCI devices
> like WLAN for an example.

This doesn't make sense.  Your plaform can't know what device is connected
to a given root port / slot.  So you might have different policies per
slot, but that has nothing to do with the Linux drivers for given devices.
