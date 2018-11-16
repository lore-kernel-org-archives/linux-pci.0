Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D7C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 12:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFE3208A3
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 12:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFE3208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389653AbeKPWNV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:13:21 -0500
Received: from foss.arm.com ([217.140.101.70]:50356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeKPWNV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 17:13:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E7B80D;
        Fri, 16 Nov 2018 04:01:16 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB7F23F718;
        Fri, 16 Nov 2018 04:01:15 -0800 (PST)
Date:   Fri, 16 Nov 2018 12:01:13 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: PCI: exit with error code when test fails
Message-ID: <20181116120113.GB3228@e107981-ln.cambridge.arm.com>
References: <1537455773-13470-1-git-send-email-jjhiblot@ti.com>
 <20181004111144.GC5233@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004111144.GC5233@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 04, 2018 at 12:11:44PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Sep 20, 2018 at 05:02:53PM +0200, Jean-Jacques Hiblot wrote:
> > This makes it easier to use pcitest in automated setups.
> > 
> > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> > ---
> >  tools/pci/pcitest.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> > index af146bb..5adc8cd 100644
> > --- a/tools/pci/pcitest.c
> > +++ b/tools/pci/pcitest.c
> > @@ -143,6 +143,7 @@ static int run_test(struct pci_test *test)
> >  	}
> >  
> >  	fflush(stdout);
> > +	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
> >  }
> >  
> >  int main(int argc, char **argv)
> > @@ -231,6 +232,5 @@ int main(int argc, char **argv)
> >  		return -EINVAL;
> >  	}
> >  
> > -	run_test(test);
> > -	return 0;
> > +	return run_test(test);
> >  }
> > -- 
> > 2.7.4
> > 
> 
> Hi Kishon,
> 
> are you OK with this patch ? Please let me know.

Please let me know, I need your ACK on this to queue it.

Lorenzo
