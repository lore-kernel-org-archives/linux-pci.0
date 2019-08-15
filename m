Return-Path: <SRS0=qLqV=WL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4DC433FF
	for <linux-pci@archiver.kernel.org>; Thu, 15 Aug 2019 04:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A434208C2
	for <linux-pci@archiver.kernel.org>; Thu, 15 Aug 2019 04:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565845021;
	bh=ZTUx4s7X4k1wmp8mhUXp+Qc27PtJV9wUfGR2o7Tzn9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vsO/22dkxiC8guL3ZvcfZK5E6s5IG15J+kQ748Prmvd/iMCos0iDhe82h0hG+3qu8
	 DL5OKBgUS+pN5rOFPklEgF5jdpB3JfmgrnjERk1Og0x0pugc/gGCnXtbefDO4ZymmY
	 vqg9JC1V169fEAgNHMwTYNcgZ8IGmJVymZpnId2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfHOE5A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOE5A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 00:57:00 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D83208C2;
        Thu, 15 Aug 2019 04:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565845019;
        bh=ZTUx4s7X4k1wmp8mhUXp+Qc27PtJV9wUfGR2o7Tzn9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdq7ieIyxzTm+JAekKfXJwFSiMqfZHbvZe4DPunk36hY3ZFaUs7KE2DxheCEski3X
         QjRRb3Z9nO9LlXo4HYREVOTZq921XQH2yReMlCHRPP6bVMt0UFKgW/GurmV0AEQIAl
         v3rCr7mo1XlQ28hXJj2XzTvo1qTZOtIbot8IZnDI=
Date:   Wed, 14 Aug 2019 23:56:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 3/7] PCI/ATS: Initialize PASID in pci_ats_init()
Message-ID: <20190815045659.GF253360@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5edb0209f7657e0706d4e5305ea0087873603daf.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edb0209f7657e0706d4e5305ea0087873603daf.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 05:06:00PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently, PASID Capability checks are repeated across all PASID API's.
> Instead, cache the capability check result in pci_pasid_init() and use
> it in other PASID API's. Also, since PASID is a shared resource between
> PF/VF, initialize PASID features with default values in pci_pasid_init().
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> + * TODO: Since PASID is a shared resource between PF/VF, don't update
> + * PASID features in the same API as a per device feature.

This comment is slightly misleading (at least, it misled *me* :))
because it hints that PASID might be specific to SR-IOV.  But I don't
think that's true, so if you keep a comment like this, please reword
it along the lines of "for SR-IOV devices, the PF's PASID is shared
between the PF and all VFs" so it leaves open the possibility of
non-SR-IOV devices using PASID as well.

Bjorn
