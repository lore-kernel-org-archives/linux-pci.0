Return-Path: <SRS0=y01v=7D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB8C433DF
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EF32070A
	for <linux-pci@archiver.kernel.org>; Thu, 21 May 2020 08:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgEUIbw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 May 2020 04:31:52 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:53140 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgEUIbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 04:31:52 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2020 04:31:52 EDT
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id E3F7A2002E4; Thu, 21 May 2020 08:24:21 +0000 (UTC)
Date:   Thu, 21 May 2020 10:24:21 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reference bridge window resources explicitly
Message-ID: <20200521082421.GA15141@isilmar-4.linta.de>
References: <20200520183411.1534621-1-kw@linux.com>
 <20200520203022.GA1117009@bjorn-Precision-5520>
 <20200521081638.GA30231@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521081638.GA30231@rocinante>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 10:16:38AM +0200, Krzysztof Wilczynski wrote:
> On 20-05-20 15:30:22, Bjorn Helgaas wrote:
> 
> Hello Bjorn!
> 
> [...]
> > 
> > Applied to pci/enumeration for v5.8, thanks!
> 
> Thank you for help!
> 
> Sadly, I need to send v4 after getting a message from the kbuild bot, as
> there was a variable I missed when authoring diff for v3.  Sorry about
> that!

FWIW, feel free to add my

	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

for the pcmcia part.

Thanks,
	Dominik
