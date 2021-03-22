Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD36C433C1
	for <linux-pci@archiver.kernel.org>; Mon, 22 Mar 2021 12:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB5D60C3D
	for <linux-pci@archiver.kernel.org>; Mon, 22 Mar 2021 12:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVM2u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:28:50 -0400
Received: from foss.arm.com ([217.140.110.172]:58658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhCVM2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 08:28:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3E8E1063;
        Mon, 22 Mar 2021 05:28:40 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E75903F718;
        Mon, 22 Mar 2021 05:28:39 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:28:37 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>
Subject: Re: [PATCH 0/5] Legacy direct-assign mode
Message-ID: <20210322122837.GC11469@e121166-lin.cambridge.arm.com>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120225144.15138-1-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 03:51:39PM -0700, Jon Derrick wrote:
> This set adds a legacy direct-assign mode. Newer enterprise hardware has
> physical addressing hints to assist device passthrough to guests that needs to
> correctly program bridge windows with physical addresses. Some customers are
> using a legacy method that relies on the VMD subdevice domain's root port
> windows to be written with the physical addresses. This method also allows
> other hypervisors besides QEMU/KVM to perform guest passthrough.
> 
> This patchset adds a host and guest mode to write the physical address
> information to the root port registers in the host and read them in the guest,
> and restore them in both cases on module unload.
> 
> This patchset also folds in the VMD subdevice domain secondary bus reset
> patchset [1] to clear the domain prior to guest passthrough.
> 
> [1] https://patchwork.kernel.org/project/linux-pci/cover/20200928010557.5324-1-jonathan.derrick@intel.com/
> 
> Jon Derrick (5):
>   PCI: vmd: Reset the VMD subdevice domain on probe
>   PCI: Add a reset quirk for VMD
>   PCI: vmd: Add offset translation helper
>   PCI: vmd: Pass features to vmd_get_phys_offsets()
>   PCI: vmd: Add legacy guest passthrough mode
> 
>  drivers/pci/controller/vmd.c | 200 ++++++++++++++++++++++++++++++++++++++-----
>  drivers/pci/quirks.c         |  48 +++++++++++
>  2 files changed, 227 insertions(+), 21 deletions(-)

Hi Jon,

it is unclear to me where we are with this series, please let me know.

Thanks,
Lorenzo
