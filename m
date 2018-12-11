Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1721C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 13:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A301120849
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544536284;
	bh=gRzf6z/MKDvgtnWkAZXJlfic2APrhs8q9Aso7EbUsxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CdPjgUVX50CwZE4+91xSI6m2SBA4zODYBSdWsMRf8B/11bTzRZFuehRSrSbK5q2l0
	 QOftWFbXHoa38Qn/GOuAYdgNyP+HboKac4dA11u/wHgmPoJFwwsa5Gw/ZEY5ZAUoye
	 2D/anYZZPDm5bRjU3DYpgULeW65Mkmcimpwa8224=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A301120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeLKNvX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLKNvX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 08:51:23 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 947C42082F;
        Tue, 11 Dec 2018 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544536282;
        bh=gRzf6z/MKDvgtnWkAZXJlfic2APrhs8q9Aso7EbUsxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7GBUfnr+efAKmVLq5gc/PkXkIhSA+S9fHYHn4wpvr75KyFcw3adV7njHSltYBWrM
         KLJiUWSJdCrejIZh2mNsdpLsBP8zLh6QvSicz1G9+end1tvT/QCsDA3Ne64b/3uwiI
         hdFn44tWuCuhM53qZ4H1kMi6pB7BrBpebkkEAcSM=
Date:   Tue, 11 Dec 2018 07:51:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Mertarg10@gmail.com" <Mertarg10@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get
 detected but bluetooth works
Message-ID: <20181211135121.GB99796@google.com>
References: <bug-201647-193951@https.bugzilla.kernel.org/>
 <CABhMZUXc4FS-f52ZDsErEhbkm_jjEz+kn75YO5Tuvp42Qm+1xw@mail.gmail.com>
 <20181128211959.GB178809@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB3013373E4A3@HASMSX112.ger.corp.intel.com>
 <20181210222452.GC85090@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133754C00@HASMSX112.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0BA3FCBA62E2DC44AF3030971E174FB30133754C00@HASMSX112.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 06:35:20AM +0000, Grumbach, Emmanuel wrote:
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=201647

> > The Windows device manager info (requested above) would be interesting.

I *thought* I had requested it, but I can't find that.  Mert, thanks
for the screenshot you attached.  Would you mind also capturing the
other tabs from device manager?  I'm really looking for a hex dump of
the config space, which should be at least 256 bytes.  I *think*
that's available somewhere in device manager.  If not, AIDA64
(https://www.aida64.com/downloads) should be able to get it.

> FWIW: I saw another problem like this with a 9650 device.

Do you have a pointer to any info about this 9650 issue?  Maybe that
would have a clue.

> PS: PCI folks don't use bugzilla's anymore? It's all over the mailing list?

Personally, I use bugzilla as a convenient place to archive artifacts
like logs, screenshots, etc.  But it doesn't seem as convenient for
conversations as the mailing list, and it doesn't have the visibility
that the list does.

Bjorn
