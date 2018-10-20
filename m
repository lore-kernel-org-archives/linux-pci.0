Return-Path: <SRS0=Xsl3=NA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDF4ECDE43
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 02:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ADB214C4
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 02:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NThxKtFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ADB214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeJTKRz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Oct 2018 06:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbeJTKRy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Oct 2018 06:17:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F60214C3;
        Sat, 20 Oct 2018 02:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540001351;
        bh=T+wwpAHS0FCU1OC+2Va+SnsGL1rH95CRLn7EpAbQue0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NThxKtFACTxrDhrbkV4bKFnYNaQwV6oQE0lyE/wDhMS9sXUBw/wYfgjPGXGkjT9Qn
         Y5Wi22X1osPv/GdUs9/9207vBE9+GBFd2i7d/IZo2SlWAoTQkUZI3ulYcIzuMCJEvU
         t/kAsLGRtZLCT8IWYKMLlhmYTWj4zGlscC5/d/68=
Date:   Fri, 19 Oct 2018 21:09:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v6 1/7] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
Message-ID: <20181020020908.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181019021132.14743-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019021132.14743-1-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series (and v5, it looks like) lost the cover letter, which had a
nice diffstat overview :)

On Fri, Oct 19, 2018 at 02:11:21AM +0000, Sinan Kaya wrote:
> We need a contract between the reset API users and the PCI core about the
> types of reset that a user needs vs. what PCI core can do internally.
> If a platform supports hotplug, we need to do hotplug reset as an example.

Somewhere this needs a description of a bug that's being fixed or some
other justification, e.g., code simplification.  The above is a little
too abstract for me to grasp it.

> Expose the reset types to the drivers and try different reset types based
> on the new reset_type parameter.
> 
> Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
> PCI_RESET_LINK parameters.

There are fewer than a dozen callers of all these functions and the
complication of these interfaces doesn't seem commensurate with the
problem.  With six different interfaces and five independent bit
flags, the possibilities are way more than necessary.

It seems like there are only three main cases (possibly extended by
locked/unlocked versions):

  - a generic reset, used by ipc, genwqe, qlcnic, sfc, liquidio,
    mwifiex, xen

  - something special for VFIO that is affected by the set of devices
    owned by the user

  - a link reset for places like these where a device needs help to
    train the link correctly:

      cik_pcie_gen3_enable()       # amdgpu, radeon
      si_pcie_gen3_enable()        # amdgpu, radeon
      do_pcie_gen3_transition()    # infiniband/hfi1

The interface for the generic case should be simple and made to be the
obvious choice for drivers, i.e., requires only the pci_dev and no
magic flags.  The link reset case is different enough that it might
deserve its own special interface.

> Link: https://www.spinics.net/lists/linux-pci/msg75828.html

Can you switch to using https://lore.kernel.org/linux-pci/<Message-ID>
URLs so we don't depend on 3rd-party archives like spinics?  See
https://www.kernel.org/lore.html .  I usually silently convert to the
lore URLs, but I guess doing it silently only makes more work for
myself.

Bjorn
