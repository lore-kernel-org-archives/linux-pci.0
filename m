Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC02C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 19:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8BC2075C
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553025590;
	bh=KOwOkhbz8WmBoAiT/wnLZx0PFhrFTU6iLPHTKe2BIzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k/uFKnQgER96wYQbMXbnp2Dbzxvibr1YtHgUEWRfmu0gAbaBFOZUw/6UeDN97/Vgn
	 2LtZjFUN6Ns0SusytyEhhtEXg0TVTjHj4qdK/pTQMbIiMRraZeNcMMZrPSTwiRYDJW
	 hnE2F+QRcz1W3phTyw+Cd4e4pzxOjZpNyw8UUDDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCST7u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:59:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:17220 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfCST7u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Mar 2019 15:59:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 12:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,245,1549958400"; 
   d="scan'208";a="330084538"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2019 12:59:48 -0700
Date:   Tue, 19 Mar 2019 14:00:44 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org,
        torvalds@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: bw_notification: Do not leave interrupt
 handler NULL
Message-ID: <20190319200044.GE24176@localhost.localdomain>
References: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
 <20190319011214.7847-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319011214.7847-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 18, 2019 at 08:12:04PM -0500, Alexandru Gagniuc wrote:
> I was able to test this on edge-triggered interrupts. None of my
> machines have PCIe ports that use level-triggered interrupts. This
> might not be too straightforward to test without a hardware yanker,
> but if there's a way to force a specific interrupt to be level
> triggered, I could do the testing on my end.

Spec says INTx emulation is required, so I think it ought to be possible
to force them to level-triggered if you disable MSI. The kernel parameter
'pci=nomsi' can force everything to INTx.
