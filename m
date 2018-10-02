Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06148C64EB8
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 20:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C6B2082A
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 20:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdUJ2qok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C6B2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJCCsz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJCCsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 22:48:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84D5320652;
        Tue,  2 Oct 2018 20:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538510631;
        bh=X5xWHYlf5yWDwyydsBDtMo3blqnal0/vOvaUTVJEYiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdUJ2qokdwPf8dOlpp7shfKxIbF0BdYX7l5lhZwThLuz7nNrzINQjNe3bnXl2CveE
         WOCJFR7YZA8kHoMZHopBunwhP7d5HxGWGdetjoR4hjazXfxpfX9PdSMbRklVgj1s5f
         gllvwpr42zl16omXBq4poRp93LQ+CUhg5fTEPSaM=
Date:   Tue, 2 Oct 2018 15:03:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Martitz <kugel@rockbox.org>
Cc:     Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
        Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
        andy.shevchenko@linux.intel.com,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        netdev <netdev@vger.kernel.org>, nic_swsd@realtek.com,
        rchang@marvell.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers on resume
Message-ID: <20181002200350.GC120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913033745.11178-1-drake@endlessm.com>
 <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
 <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
 <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
 <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Mon, Oct 01, 2018 at 04:25:06PM +0200, Thomas Martitz wrote:
> Am 01.10.18 um 06:57 schrieb Daniel Drake:
> > On Sun, Sep 30, 2018 at 5:07 AM Thomas Martitz <kugel@rockbox.org> wrote:
> > > The latest iteration does not work on my HP system. The GPU fails to
> > > power up just like the unpatched kernel.
> > 
> > That's weird, I would not expect a behaviour change in the latest
> > patch. pci_restore_config_dword() has some debug messages, could you
> > please make them visible and show logs again?
> > Also remind us of the PCI device address of the parent bridge (lspci -vt)
> 
> I'll follow up with more the requested information on bugzilla
> (Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069).
> 
> On a quick re-check, it seems to depend on if I used the eGPU before
> the initial suspend. If I run glxgears (with DRI_PRIME=1) before suspend it
> seems fine.

Does the patch ([1]) make things *worse* compared to v4.19-rc5?

If so, I'll drop the patch until we figure this out.  But if the GPU
power issue also occurs in v4.19-rc5, I think we can assume it's a
different problem and we can go ahead and merge [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=083874549fdfefa629dfa752785e20427dde1511
