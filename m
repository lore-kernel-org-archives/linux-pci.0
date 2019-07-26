Return-Path: <SRS0=nurA=VX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5346FC7618F
	for <linux-pci@archiver.kernel.org>; Fri, 26 Jul 2019 21:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F8A21842
	for <linux-pci@archiver.kernel.org>; Fri, 26 Jul 2019 21:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564178164;
	bh=L75kzm4mD+NnYmv8EULxOVtdiQggy6+uKjf3KGdDqtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rZ8aXAEEDTt26fGxkUTUoC9cl1WOLwiE7Zj8tuxAR2jUCn8mk+UbDacOdPopTNWSO
	 oAFAw3kpJNOLteHi7U42j4b63c3+Fviap6pV5NFjrEz1KHjho0dCds1Mp5ODX5XwnD
	 y2NARPh1Nn2fOo+bPnhraNSiBJD3KD9vue0V8JJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGZV4D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:56:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:49220 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbfGZV4D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 17:56:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 14:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,312,1559545200"; 
   d="scan'208";a="170771618"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2019 14:56:02 -0700
Date:   Fri, 26 Jul 2019 15:53:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com
Subject: Re: [PATCH v6 0/9] Add Error Disconnect Recover (EDR) support
Message-ID: <20190726215311.GA8720@localhost.localdomain>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 02:43:10PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> This patchset adds support for following features:
> 
> 1. Error Disconnect Recover (EDR) support.
> 2. _OSC based negotiation support for DPC.
> 
> You can find EDR spec in the following link.
> 
> https://members.pcisig.com/wg/PCI-SIG/document/12614

Thank you for sticking with this. I've reviewed the series and I think
this looks good for the next merge window.

Acked-by: Keith Busch <keith.busch@intel.com>
