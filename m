Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C491C3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 22:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15AC2184D
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566945182;
	bh=1+QNJKUgz+gea1zCCXAK/Hc/T4SGAhK43TGzjR48Lmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cMTD54+U+NwZV8pRdlJ212Hs/yH+vhOkqXNLK/51R0qKE7ODjAsFK72Zijy8ZPaW6
	 bGt53cRUNkRFyhyDvudusrvvp4Ivf3G+H+TJ/srKOhI2sbP+PeUEDs8mM+s95E3UHL
	 rID0F5hWnN850LaXMRtwcl79jrYq0i6enUXS0JZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfH0Wc6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfH0Wc5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 18:32:57 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D726120856;
        Tue, 27 Aug 2019 22:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566945176;
        bh=1+QNJKUgz+gea1zCCXAK/Hc/T4SGAhK43TGzjR48Lmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZn1gGeISV7sMLyJAWPA3zeSgGFzMulVtOlCichsCyw2q3fdgawfyEsHjr4KL65bz
         wCm7gNW2nm5lFa3R90WX//Grb6qYufDlmR7iFbjWqtbOy7Cpn7x3nErLKRZxDcbq/o
         yCwTXt4Awd8wYq48Pu5CdmDCAOnwdhW8w0TQDmvc=
Date:   Tue, 27 Aug 2019 17:32:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Simplify PCIe hotplug indicator control
Message-ID: <20190827223254.GC9987@google.com>
References: <20190819160643.27998-1-efremov@linux.com>
 <2f4c857e-a7cc-58da-8be5-cba581c56d9f@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4c857e-a7cc-58da-8be5-cba581c56d9f@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 03:16:43PM +0300, Denis Efremov wrote:
> On 8/19/19 7:06 PM, Denis Efremov wrote:
> > PCIe defines two optional hotplug indicators: a Power indicator and an
> > Attention indicator. Both are controlled by the same register, and each
> > can be on, off or blinking. The current interfaces
> > (pciehp_green_led_{on,off,blink}() and pciehp_set_attention_status()) are
> > non-uniform and require two register writes in many cases where we could
> > do one.
> > 
> > This patchset introduces the new function pciehp_set_indicators(). It
> > allows one to set two indicators with a single register write. All
> > calls to previous interfaces (pciehp_green_led_* and
> > pciehp_set_attention_status()) are replaced with a new one. Thus,
> > the amount of duplicated code for setting indicators is reduced.
> > 
> > Changes in v3:
> >   - Changed pciehp_set_indicators() to work with existing
> >     PCI_EXP_SLTCTL_* macros
> >   - Reworked the inputs validation in pciehp_set_indicators()
> >   - Removed pciehp_set_attention_status() and pciehp_green_led_*()
> >     completely
> > 
> > Denis Efremov (4):
> >   PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
> >   PCI: pciehp: Switch LED indicators with a single write
> >   PCI: pciehp: Remove pciehp_set_attention_status()
> >   PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()
> 
> Lukas, Sathyanarayanan, sorry that I've dropped most of yours "Reviewed-by".
> The changes in the last 2 patches were significant.

Anybody want to review these?
