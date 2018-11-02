Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49FBC32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765E020831
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 16:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765E020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeKCB10 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:27:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:62347 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeKCB10 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 21:27:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 09:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="93244637"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2018 09:19:46 -0700
Date:   Fri, 2 Nov 2018 10:17:30 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20181102161730.GA26392@localhost.localdomain>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
 <20181102095300.GB14602@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102095300.GB14602@zn.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 10:53:00AM +0100, Borislav Petkov wrote:
> On Mon, Oct 29, 2018 at 04:06:51PM -0500, Bjorn Helgaas wrote:
> > If I squint hard enough this sort of makes sense, but it also makes me
> > confused about the normal APEI firmware-first model works.
> > 
> > In the NON-firmare-first case, firmware isn't involved in handling AER
> > errors.  The Linux AER driver fields an interrupt from a Root Port,
> > reads AER log registers, etc.
> > 
> > In the normal APEI firmware-first case, when the hardware reports an
> > AER event, I think firmware gets control first, and *it* reads the AER
> > log registers, packages them up, and generates an interrupt to the OS,
> > which reads the packaged error state from the firmware via the HEST.
> > 
> > If I understand this special Intel VMD firmware-first case correctly,
> > firmware gets control first, reads the AER log registers, and
> > synthesizes what looks to the OS like a normal AER interrupt.  The
> 
> Why?
> 
> Why the faking?
> 
> If firmware needs to get control, why doesn't it then *retain* control
> and report the error through HEST, like others do?
> 
> AFAIUC, fw wants to do something underneath. What's wrong with making it
> a normal firmware-first case?

VMD acts a bit like a host-bus adapter. The firmware knows about the
adapter, but not about anything on the bus that it attaches to.

This "hybrid" approach is basically saying that the firmware knows about
the HBA, and it wants a chance to be notified of errors on the bus it
attaches to, but the firmware can't do anything about such errors.

The bus in this case is PCIe, where we have capable error handling in the
kernel driver, so we ultimately want the AER driver handling the errors.
