Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07762C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43112081F
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 16:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43112081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeKCBeP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:34:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60742 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeKCBeP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 21:34:15 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mMnH1nvg94mC; Fri,  2 Nov 2018 17:26:34 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD3B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:3b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0E191EC0380;
        Fri,  2 Nov 2018 17:26:33 +0100 (CET)
Date:   Fri, 2 Nov 2018 17:26:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Message-ID: <20181102162623.GH14602@zn.tnic>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
 <20181102095300.GB14602@zn.tnic>
 <20181102161730.GA26392@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102161730.GA26392@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 10:17:30AM -0600, Keith Busch wrote:
> VMD acts a bit like a host-bus adapter. The firmware knows about the
> adapter, but not about anything on the bus that it attaches to.
> 
> This "hybrid" approach is basically saying that the firmware knows about
> the HBA, and it wants a chance to be notified of errors on the bus it
> attaches to, but the firmware can't do anything about such errors.
> 
> The bus in this case is PCIe, where we have capable error handling in the
> kernel driver, so we ultimately want the AER driver handling the errors.

Not a problem - GHES already knows about AER and calls into it for
CPER_SEC_PCIE errors:

ghes_do_proc
-> ghes_handle_aer
  |-> aer_recover_queue

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
