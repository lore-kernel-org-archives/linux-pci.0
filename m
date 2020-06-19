Return-Path: <SRS0=kzLt=AA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBB5C433E0
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jun 2020 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0AB121531
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jun 2020 18:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgFSSSx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:18:53 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:33684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729580AbgFSSSw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2020 14:18:52 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 14:18:52 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 925128112757
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2020 18:09:11 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DE1461313C2;
        Fri, 19 Jun 2020 18:09:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: song67_620abc226e1b
X-Filterd-Recvd-Size: 1591
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jun 2020 18:09:08 +0000 (UTC)
Message-ID: <a70251985203280662cd0db2de05a9a0b1c5de7d.camel@perches.com>
Subject: Re: [PATCH] pci: pcie: AER: Fix logging of Correctable errors
From:   Joe Perches <joe@perches.com>
To:     Sinan Kaya <okaya@kernel.org>, Matt Jolly <Kangie@footclan.ninja>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Jun 2020 11:09:07 -0700
In-Reply-To: <d611dabd-b943-8492-a29e-0b7fb1980de8@kernel.org>
References: <20200618155511.16009-1-Kangie@footclan.ninja>
         <d611dabd-b943-8492-a29e-0b7fb1980de8@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2020-06-19 at 13:17 -0400, Sinan Kaya wrote:
> On 6/18/2020 11:55 AM, Matt Jolly wrote:
> 
> > +		pci_warn(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> > +			dev->vendor, dev->device,
> > +			info->status, info->mask);
> > +	} else {
> 
> <snip>
> 
> > +		pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> > +			dev->vendor, dev->device,
> > +			info->status, info->mask);
> 
> Function pointers for pci_warn vs. pci_err ?

Not really possible as both are function-like macros.


