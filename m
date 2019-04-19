Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417CCC282DA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D30E20643
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555699672;
	bh=exErL+htx5Go3GECaErHR65rZU6Dinuf8zQnf3uO8Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NOQVrPEyQEfYLJ51d4nogvQ6/ZEXmFB19f7Prcfzd747iKlmgRST59aod0gRluESU
	 0RZAvd6xDExfKCEO/XF5PBEqnaotmy2ayLIZhgNopRRx4qgZZdJD9pluueaJBHAsPY
	 tbHEZ/OkWUHKnaXSxzBECvhRrU6m3+kyypLEftog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfDSSrv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfDSSrv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 14:47:51 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09544205F4;
        Fri, 19 Apr 2019 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555699670;
        bh=exErL+htx5Go3GECaErHR65rZU6Dinuf8zQnf3uO8Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdv/d7dVnyqGoBj4xmCZ/RdqHlcS3+GsnjOqsSK2XfYpc8TdqjXUPqwn1aCkiLBQr
         Jhpp0iAQttZbGmYLlFKnRudTVhsHkt3g9uCa71WPcRI7Gof9qk996HqERdmfzfqcno
         XiD3DjWKk+KDFUW2fscjroCPFr+3yjkLNqYCsw98=
Date:   Fri, 19 Apr 2019 13:47:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
Message-ID: <20190419184748.GF173520@google.com>
References: <20190418115859.2394-1-christian.koenig@amd.com>
 <20190418163347.GA213349@google.com>
 <22b686f0-572b-d083-915f-5c46c89dfbc3@deltatee.com>
 <20190418172426.GB213349@google.com>
 <ef5839af-4ddb-2e68-ebf3-f11fa01b0403@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef5839af-4ddb-2e68-ebf3-f11fa01b0403@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 19, 2019 at 02:24:18PM +0000, Koenig, Christian wrote:
> Am 18.04.19 um 19:24 schrieb Bjorn Helgaas:
> > On Thu, Apr 18, 2019 at 10:58:55AM -0600, Logan Gunthorpe wrote:
> >> On 2019-04-18 10:33 a.m., Bjorn Helgaas wrote:
> >>> On Thu, Apr 18, 2019 at 01:58:59PM +0200, Christian König wrote:
> >>>> A lot of root complexes can still do P2P even when PCI devices
> >>>> don't share a common upstream bridge.
> >>>>
> >>>> Start adding a whitelist and allow P2P if both participants are
> >>>> attached to known good root complex.
> >>> Is there a plan for addressing this in a generic way that doesn't
> >>> require an OS modification for every new "known good root complex",
> >>> e.g., some PCIe or ACPI spec update that allows the OS to discover
> >>> this?
> >> I'm aware of work going on in the PCI SIG to address this [1].
> >>
> >> But I expect it's going to be a long time before actual hardware advertises
> >> this capability to indicate support. So in the interim we either need to not
> >> use p2pdma on root complexes or create a white list. I'm in favour of the
> >> white list approach.
> > I agree we need a whitelist; I just want to make sure we also make
> > progress on some way to limit the amount of time we need to update it.
> 
> Well as far as I know at least for AMD there is also a vendor specific 
> way to figure out if a chipset does P2P routing or not. So you don't 
> need every possible combination listed.
> 
> It's perfectly possible that Intel, ARM and PowerPC have something 
> similar and with all those on board you have pretty much every 
> interesting case covered.
> 
> I will try to dig something up into that direction.
> 
> Another problem is also that some root complexes have very very strange 
> limitations on the routing which are hard to handle. For example some 
> old chipsets can do P2P, but only for writes and not reads!
> 
> Anyway at least for my current use case a simple whitelist with 
> vendor/device should be sufficient, so I'm fine with maintaining that 
> for now. But on the other hand I also understand that in 10+ years we 
> don't want a list with 200 entries here....

Right.  And it's not just *you*; maintaining a list like that is also
a burden for me and every distro maintainer who has to backport
updates.

And the fact that it's not covered by any spec also means we're open
to all kinds of quirks about how it interacts with things that *are*
in the spec: ACS, ATS, the read/write thing you mentioned, ...

> >> [1] https://lore.kernel.org/linux-pci/20181210115653.0000615a@huawei.com/
