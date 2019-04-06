Return-Path: <SRS0=JDZy=SI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E1EC10F06
	for <linux-pci@archiver.kernel.org>; Sat,  6 Apr 2019 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C680218D4
	for <linux-pci@archiver.kernel.org>; Sat,  6 Apr 2019 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554561040;
	bh=GqZA3BNIkhRkbNkN0GKl3ste93NEIbRP49wR9NYYb4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KDuuFewik3FZoACwDt6Mr4FuDvtBOY593khrRdbgxFgzd8hvB/h/8j/38mZdu8p7A
	 kU3VoW43p6oxazVa1GN+e199jtuZui0skj0Ia7y5A0zq9YJtdA179GfR5QKhUtuwE0
	 TPE2Qpv367CIqsoonpLbbTmXHHiImzXh1yhvR/Vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDFOaj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 6 Apr 2019 10:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfDFOaj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 6 Apr 2019 10:30:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E58206BA;
        Sat,  6 Apr 2019 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554561037;
        bh=GqZA3BNIkhRkbNkN0GKl3ste93NEIbRP49wR9NYYb4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zl9p7dEKQSEd0YzTvd+SFjalPqQb4AuJSqXC+TrARoeGgU7GSipBr12CCrNU1+tfb
         JEtbr64xq2fhXIG73nVjnV2m95fLcGJevLqWOqDYryKkL2CYaV9P//4HUspCy5N/z3
         CSGWf2+4yz5in6Vsq2I4dUV9wncSsii1t0K4PU5E=
Date:   Sat, 6 Apr 2019 09:30:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan =?iso-8859-1?Q?M=E4tje?= <stefan.maetje@esd.eu>
Cc:     andriy.shevchenko@linux.intel.com, bhull@redhat.com,
        linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
        ptalbert@redhat.com, lukas@wunner.de, fred@fredlawl.com
Subject: Re: [PATCH v3 0/3] Add a quirk to work around link retrain errata of
 Pericom PCIe brigdes
Message-ID: <20190406143031.GB200379@google.com>
References: <20190329170736.1648-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329170736.1648-1-stefan.maetje@esd.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 29, 2019 at 06:07:33PM +0100, Stefan Mätje wrote:
> This patch provides a quirk that works around PCIe link retrain issues
> with some Pericom PCIe-to-PCI bridges.
> 
> This patches should be backported to the stable kernels ([1/3] and [2/3]). The
> problem shows up since our customers use kernels 4.10 and later.
> 
> The original patch was only for the Pericom PI7C9X111SL bridge. This is the
> only hardware I can test with.
> 
> In the meantime Brett Hull <bhull@redhat.com> brought to my attention that
> the PI7C9X110 and PI7C9X130 devices are also affected. I had access to the
> errata sheet for the PI7C9X130 PCI bridge and its has the same issue
> documented.
> 
> Therefore the patch will now handle all three mentioned devices.
> 
> I'd like to quote the errata sheet PI7C9X111SLB_errata_rev1.2_102711.pdf
> 
> > In Reverse Mode, retrain Link bit is not cleared automatically; this bit
> > needs to be cleared manually by configuration write after it is set.
> >
> > Problem:
> > In Reverse mode, after setting Retrain Link (bit 5 of register C0h), this
> > bit will stay on and PI7C9x111SL will continuously retrain until this bit
> > is cleared by another Configuration Write to register C0h.
> >
> > Workaround:
> > Issue another configuration write to clear Retrain Link bit after setting
> > this bit. No delay is required between these two configuration write.
> 
> There is no public URL to download these errata sheets. Because Pericom has
> been acquired by Diodes Inc. all information has to be downloaded from their
> web site. Following the link below one can find a datasheet and there is a
> button to request additional documents like the errata sheet for instance.
> 
> https://www.diodes.com/products/connectivity-and-timing/pcie-packet-switchbridges/pcie-pci-bridges/part/PI7C9X111SL#tab-details
> 
> I'm still using msleep(1) here because I don't want to change the timing for
> other parts of the kernel unintentionally.
> Some notes regarding this:
> 
> a) The link retraining is fast. The time measured on two different PCs and PCIe
> 	bridges is below 5µs.
> b) My slower test PC needs ~2.5µs for a checking the PCI_EXP_LNKSTA register the
> 	faster test PC needs ~1.5µs for that. So it comes the slower test PC runs
> 	through the wait loop without calling msleep(1) but the faster machine needs
> 	to wait once with msleep(1).
> 	In this case waiting with udelay(10) would perhaps be more appropriate but
> 	I didn't want to burden this pure bug fix patch with a timing change that
> 	possibly needs discussion.
> 
> History:
> 	[V3]
> 		- Split into more patches to make backporting easier.
> 		- Applied Andy Shevchenko's recommendations regarding wording and
> 			code style.
> 	[V2]
> 		https://lore.kernel.org/linux-pci/20190305173122.11875-1-stefan.maetje@esd.eu/
> 	[V1]
> 		https://lore.kernel.org/linux-pci/20181101192229.48352-2-stefan.maetje@esd.eu/
> 
> 
> Stefan Mätje (3):
>   PCI/ASPM: Prepare stand-alone pcie_retrain_link() function
>   PCI/ASPM: Work around link retrain errata of Pericom PCIe-to-PCI
>     bridges
>   PCI/ASPM: Trivial rework wait code in pcie_retrain_link()
> 
>  drivers/pci/pcie/aspm.c | 47 ++++++++++++++++++++++++++++++++---------------
>  drivers/pci/quirks.c    | 20 ++++++++++++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 54 insertions(+), 15 deletions(-)

Thanks, applied to pci/enumeration for v5.2.

I added stable tags for the first two patches.  I also moved the quirk
and related bits out from under CONFIG_PCIEASPM because I don't think
the erratum is actually related to ASPM; it just happens that ASPM is
the only place we currently retrain links.  But we *could* retrain
links for other reasons, e.g., changing link speed or error recovery,
and we would also want the quirk then.
