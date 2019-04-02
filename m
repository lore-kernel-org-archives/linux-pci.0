Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13001C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63662146E
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554210568;
	bh=0+hom9BLjtV694qKT+w8eJqbTX3SBGJBNO/VA7gHckY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fMs1ohiPcIzx2tIldTl8eRrK1BySyDmGAKqTdAk/QFBK6nlQgtFSg+w1kJwQupj+m
	 xUsHmbTQs3SNLBgL0K7VFvbJe6PDFj58drqDI/qbBsh0w1Kqkk0MQeis1RKP47rLR+
	 SNwC3VR+wvq7yNrcdfA0HSFwm1VARulCMaMfBAfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfDBNJ2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbfDBNJ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 09:09:28 -0400
Received: from localhost (173-27-100-4.client.mchsi.com [173.27.100.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305B92133D;
        Tue,  2 Apr 2019 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554210567;
        bh=0+hom9BLjtV694qKT+w8eJqbTX3SBGJBNO/VA7gHckY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OO2yA0qPZ+sQ513ssxsy49xIrlcUccDgUIbTXTb+E7IpRPdqY70pQfQ1vmXB1LR+B
         9znutKKbqJAcBYnxF8fBbPF2qbm43iQhjXMzx5jkFghy/3c4WaCgiY/lbABWYC65Xw
         BD+5MBgnSO+EoHpfLIFOhiVTZNfLcBAzGv1D3xyc=
Date:   Tue, 2 Apr 2019 08:09:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ron Murray <rjmx@rjmx.net>
Cc:     linux-pci@vger.kernel.org
Subject: Re: PCI device appears intermittently
Message-ID: <20190402130925.GC141706@google.com>
References: <06ca8af7-46e3-2769-cce0-48596ce99211@rjmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ca8af7-46e3-2769-cce0-48596ce99211@rjmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 28, 2019 at 09:22:03PM -0400, Ron Murray wrote:
> I have an ASRock 970A-G/3.1 motherboard, which, with current Linux
> kernels, occasionally "finds" an extra PCI device on the initial
> scan.

Hmmm, I don't have any good ideas.  You mention "current" kernels.  Is
this a regression?  If there is an earlier kernel that never finds
this extra device, it's possible we could find the problem by
bisecting.  It's a little harder with intermittent problems like this,
though.

Is there any rhyme or reason to when the problem occurs?  Do you dual
boot with Windows?  Does it happen after an unusual shutdown (crash,
oops, etc)?  Is there anything connected to that port?

Can you collect the output of "sudo lspci -vvv" and the dmesg logs for
successful and failing boots?  Maybe attach them to a
bugzilla.kernel.org entry.

> I wouldn't mind, but it finds it early in the piece, and that
> changes the PCI allocation of my Ethernet board from 02:06.0 to
> 03:06.0, and, with systemd, Linux comes up with no network
> connection. A reboot fixes it, mostly.
> 
> Here's the first few lines of 'lspci' when Linux doesn't find the
> extra device
> 
> > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD9x0/RX980 Host Bridge (rev 02) 
> > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD890S/RD990 I/O Memory Management Unit (IOMMU)
> > 00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GFX port 0)
> > 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40) 
> 
> and here's the same thing when it does:
> 
> > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD9x0/RX980 Host Bridge (rev 02)
> > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD890S/RD990 I/O Memory Management Unit (IOMMU)
> > 00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GFX port 0)
> > 00:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GPP Port 4)
> > 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
> > 00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller 
> 
> The 00:09.0 device is the extra one. Anything else I can provide to assist?
