Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD4CC43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 10:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7498221924
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 10:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393317AbfBOKgf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:36:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57842 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388223AbfBOKgf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Feb 2019 05:36:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03541EBD;
        Fri, 15 Feb 2019 02:36:35 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B40E3F557;
        Fri, 15 Feb 2019 02:36:32 -0800 (PST)
Date:   Fri, 15 Feb 2019 10:36:27 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: Re: [PATCH v3 0/2] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset
 and cpumask_to_vpset()
Message-ID: <20190215103627.GA27700@e107981-ln.cambridge.arm.com>
References: <cover.1548745212.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548745212.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 28, 2019 at 11:15:37PM -0800, Maya Nakamura wrote:
> This patchset removes a duplicate definition of VP set (hv_vp_set) and
> uses the common definition (hv_vpset) that is used in other places. It
> changes the order of the members in struct hv_pcibus_device due to
> flexible array in hv_vpset.
> 
> It also removes the duplicate implementation of cpumask_to_vpset(), uses
> the shared implementation, and exports hv_max_vp_index, which is
> required by cpumask_to_vpset().
> 
> Maya Nakamura (2):
>   PCI: hv: Replace hv_vp_set with hv_vpset
>   PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()
> 
>  arch/x86/hyperv/hv_init.c           |  1 +
>  drivers/pci/controller/pci-hyperv.c | 59 +++++++++++++----------------
>  2 files changed, 28 insertions(+), 32 deletions(-)

Applied to pci/hv for v5.1, thanks.

Lorenzo
