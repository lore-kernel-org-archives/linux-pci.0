Return-Path: <SRS0=taQ7=XW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43843C4360C
	for <linux-pci@archiver.kernel.org>; Fri, 27 Sep 2019 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150E6217D9
	for <linux-pci@archiver.kernel.org>; Fri, 27 Sep 2019 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569621563;
	bh=vjYWy4L7Eyb3/PmemD47fPDcJCVBojbdz7DDNpbWr7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=fY9YB6rGpKPd2Yopmj6sUpzFIEbQalBVuTiogVC2vB0J8CO0HyFu4IcQNLRBsGEal
	 nUoTFUeKX71+c9DqkvOD0foCmprgmxq8KOxoQ7av1PiswUWspRy+YV05JOILmdh/Kc
	 JKLPbQbBs/La3pEq7UgGTuwf0D6X0LxV0x4aE570=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfI0V7W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfI0V7W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 17:59:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D172082F;
        Fri, 27 Sep 2019 21:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569621561;
        bh=vjYWy4L7Eyb3/PmemD47fPDcJCVBojbdz7DDNpbWr7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iL1pA+i7CQJ35abdfV61IEEyNrKcYqudsqFZUhXcGeRPfS5DBbUipjFRPmMA+V8sr
         1pFjQasqXBzQwEhBg6QOjY6cQ+Ae7GUT1jkqoam1XfrlKBWRNajwGykgQpAWHRahoM
         ahQYevtEbds+x6g+lGjKSFVeRgM1DgXbXFflWNUY=
Date:   Fri, 27 Sep 2019 16:59:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com, Srinath Mannam <srinath.mannam@broadcom.com>,
        Marta Rybczynska <mrybczyn@kalray.eu>
Subject: Re: [PATCH v5 01/23] PCI: Fix race condition in
 pci_enable/disable_device()
Message-ID: <20190927215919.GA54330@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816165101.911-2-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 16, 2019 at 07:50:39PM +0300, Sergey Miroshnichenko wrote:
> This is a yet another approach to fix an old [1-2] concurrency issue, when:
>  - two or more devices are being hot-added into a bridge which was
>    initially empty;
>  - a bridge with two or more devices is being hot-added;
>  - during boot, if BIOS/bootloader/firmware doesn't pre-enable bridges.
> 
> The problem is that a bridge is reported as enabled before the MEM/IO bits
> are actually written to the PCI_COMMAND register, so another driver thread
> starts memory requests through the not-yet-enabled bridge:
> 
>  CPU0                                        CPU1
> 
>  pci_enable_device_mem()                     pci_enable_device_mem()
>    pci_enable_bridge()                         pci_enable_bridge()
>      pci_is_enabled()
>        return false;
>      atomic_inc_return(enable_cnt)
>      Start actual enabling the bridge
>      ...                                         pci_is_enabled()
>      ...                                           return true;
>      ...                                     Start memory requests <-- FAIL
>      ...
>      Set the PCI_COMMAND_MEMORY bit <-- Must wait for this
> 
> Protect the pci_enable/disable_device() and pci_enable_bridge(), which is
> similar to the previous solution from commit 40f11adc7cd9 ("PCI: Avoid race
> while enabling upstream bridges"), but adding a per-device mutexes and
> preventing the dev->enable_cnt from from incrementing early.

This isn't directly related to the movable BARs functionality; is it
here because you see the problem more frequently when moving BARs?
