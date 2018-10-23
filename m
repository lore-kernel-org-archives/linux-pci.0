Return-Path: <SRS0=AklG=ND=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E918C46475
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 17:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B01F20824
	for <linux-pci@archiver.kernel.org>; Tue, 23 Oct 2018 17:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTsY33CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B01F20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeJXB17 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbeJXB16 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Oct 2018 21:27:58 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181DA20665;
        Tue, 23 Oct 2018 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540314225;
        bh=LvDDZ0w2nfjnEh/gQrBUQbsr+G1T51Ur6P5Szasppnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTsY33CL20e3eO1U2Y8xnJH4DBO+Tb4/2QArv6BaIjCAJg/DXuYipuG4ezW+7Nv6w
         k2PB0jfljLbYvAGr2af8CCwo489TT0VQywndnAqySC1ztJe2/0DLCWiOQDKcXf1EEI
         Ka11mLyuSMsplYBf2xEcLdiSUncjEeXHlW13O7TI=
Date:   Tue, 23 Oct 2018 12:03:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        andi@firstfloor.org, lukas@wunner.de, billy.olsen@canonical.com,
        cascardo@canonical.com, ddstreet@canonical.com,
        fabiomirmar@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net, mfo@canonical.com,
        shan.gavin@linux.alibaba.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com>
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018221538.GN5906@bhelgaas-glaptop.roam.corp.google.com>
 <d4e10c8d-aa39-7577-fbc8-0430ac44ba54@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e10c8d-aa39-7577-fbc8-0430ac44ba54@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 22, 2018 at 05:35:06PM -0300, Guilherme G. Piccoli wrote:
> On 18/10/2018 19:15, Bjorn Helgaas wrote:
> > On Thu, Oct 18, 2018 at 03:37:19PM -0300, Guilherme G. Piccoli wrote:
> > [...] 
> I understand your point, but I think this is inherently an architecture
> problem. No matter what solution we decide for, it'll need to be applied
> in early boot time, like before the PCI layer gets initialized.

This is the part I want to know more about.  Apparently there's some
event X between early_quirks() and the PCI device enumeration, and we
must disable MSIs before X:

  setup_arch()
      early_quirks()                     # arch/x86/kernel/early-quirks.c
      early_pci_clear_msi()
  ...
  X
  ...
  pci_scan_root_bus_bridge()
    ...
    DECLARE_PCI_FIXUP_EARLY              # drivers/pci/quirks.c

I want to know specifically what X is.  If we don't know what X is and
all we know is "we have to disable MSIs earlier than PCI init", then
we're likely to break things again in the future by changing the order
of disabling MSIs and whatever X is.

Bjorn
