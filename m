Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC65C282DA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8568F20449
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698556;
	bh=W3rK6NVqpOERRHajvvDevYluWZHMeEAi+aqbxcSi7Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G9TPc9nxKoT313e3bU94yK7tjpYbHohc9sfnvNQI1xGdBzlsIxOGffmLCaYUNu0OV
	 elUtTPN4dZVzTn3PSdpGv+etkb7pULvKDnawY4+LHlYaeZuRXzs5FJuWJzZ55Ffwlb
	 D78HpmJzftuv4dwCIeXFr3R82I1pkZ/u9qPS4sGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDSS3P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfDSS3P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:15 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DB96222B5;
        Fri, 19 Apr 2019 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555683226;
        bh=W3rK6NVqpOERRHajvvDevYluWZHMeEAi+aqbxcSi7Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObUQ/H/BYTzikfiRvyQOnd3R9BAnuEiriQa3A1NVwX+d4d1M509mwX/5uaL1oYydi
         CRTZqa17iFqr9c1qeXoF+/Qb+3kcOQz7gSWAfY8rF3OzUgMEBLy2ai3/ENNhzcAxKn
         6MICDg+lZi5F+nK7jB9BQvh9Cm9dIH78j/MKeg2Q=
Date:   Fri, 19 Apr 2019 09:13:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Fix PF/VF dependency issues
Message-ID: <20190419141345.GD173520@google.com>
References: <cover.1551907663.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551907663.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 06, 2019 at 02:11:13PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Current implementation of ATS, PASID, PRI does not handle the PF/VF
> dependencies as defined in PCIe spec r4.0. Following patches
> addresses this issue.

Some of these patches probably fix issues, like making PASID work
correctly on VFs.  But that needs to be made explicit in the commit
logs.

The current commit logs read more like "make XYZ follow the spec",
and that's not really what we need to know.  The commit log needs to
tell us why we need the change, not just what the spec says.

For example, maybe VFs can't use PASID because Linux incorrectly tries
to use the PASID capability on the VF when it should be using the
capability on the PF.  The commit log should say that explicitly and
also say what the current behavior is, e.g., does it cause IOMMU
faults, does it cause data corruption, does some DMA mapping interface
called by the VF driver fail when it shouldn't, etc?

Bjorn

> Kuppuswamy Sathyanarayanan (5):
>   PCI/IOV: Add support to verify PF/VF spec compliance
>   PCI/ATS: Fix PRI PF/VF dependency issues
>   PCI/ATS: Fix PASID PF/VF dependency issues
>   PCI/ATS: For PF/VF skip ATS initalization if spec check failed
>   PCI/ATS: Fix ATS PF/VF dependency issues
> 
>  .../admin-guide/kernel-parameters.txt         |   2 +
>  drivers/pci/ats.c                             | 129 ++++-
>  drivers/pci/iov.c                             | 468 ++++++++++++++++++
>  drivers/pci/pci.c                             |   2 +
>  drivers/pci/pci.h                             |   6 +
>  include/linux/pci.h                           |  33 +-
>  include/uapi/linux/pci_regs.h                 |  15 +-
>  7 files changed, 639 insertions(+), 16 deletions(-)
> 
> -- 
> 2.20.1
> 
