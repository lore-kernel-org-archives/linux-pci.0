Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192ADC282E0
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5317217F9
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 22:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555711347;
	bh=PS8LjbJMCIT6Rk/Q4T0ozZ5oTgL2MhQCPvR+ZMlOi5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YK/k3h6QaC5PmnsJu8GbUxeSU2IgbQi2Sug5wWFJlWwTgOZbWArigJ360isUva0ZX
	 C44vCZdRhmyQZSaUF1VynvGNGoqtIfG4woWMFSIgXuo8iDNLnnvi2YXceRro0Oj39K
	 v3uYU1i/+C/zZwKG8JXe1AKpiGnCdfMcv1U+eSm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDSWCX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfDSWCX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 18:02:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2365E217F9;
        Fri, 19 Apr 2019 22:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555711342;
        bh=PS8LjbJMCIT6Rk/Q4T0ozZ5oTgL2MhQCPvR+ZMlOi5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZHRVVIkABdhs1cTCwNWWkHiCLHvqx/xUXWpDOJBurkmmqslnPD7aFroMGOm5TrysD
         iOJNNPOkRYG1xlhlqO3FI6conmai1R6HYV2iN8wA2+T/TJBIH3Gvpm4+ErYgveN+OR
         qTo6zXhUvSP21hb/gwavuQR72XBLAWkMKPDT2z3M=
Date:   Fri, 19 Apr 2019 17:02:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] PCI / ACPI: Remove the need for 'struct
 hotplug_params'
Message-ID: <20190419220220.GI173520@google.com>
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
 <20190208162414.3996-3-mr.nuke.me@gmail.com>
 <20190419200745.GH173520@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419200745.GH173520@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 19, 2019 at 03:07:45PM -0500, Bjorn Helgaas wrote:
> On Fri, Feb 08, 2019 at 10:24:12AM -0600, Alexandru Gagniuc wrote:
> > We used to first parse all the _HPP and _HPX tables before using the
> > information to program registers of PCIe devices. Up until HPX type 2,
> > there was only one structure of each type, so we could cheat and store
> > it on the stack.
> > 
> > With HPX type 3 we get an arbitrary number of entries, so the above
> > model doesn't scale that well. Instead of parsing all tables at once,
> > parse and program each entry separately. For _HPP and _HPX 0 thru 2,
> > this is functionally equivalent. The change enables the upcoming _HPX3
> > to integrate more easily.
> 
> I think this is tremendous!  It's going to simplify this code
> dramatically.  Two comments below.

> >  static void pci_configure_device(struct pci_dev *dev)
> >  {
> > -	struct hotplug_params hpp;
> > -	int ret;
> > +	static const struct hotplug_program_ops hp_ops = {
> > +		.program_type0 = program_hpp_type0,
> > +		.program_type1 = program_hpp_type1,
> > +		.program_type2 = program_hpp_type2,
> > +	};
> 
> What if we just moved program_hpp_type0(), etc from probe.c to
> pci-acpi.c?  The only reason I see to have it in probe.c is for
> pci_default_type0, and I think that is a pretty obtuse way of doing
> default configuration.  I would have no problem at all just hardcoding
> those defaults in probe.c and then potentially having them overwritten
> by _HPP/_HPX.

Actually, never mind about this.  This would be a perfect project for
mentoring a Linux newbie.

I'll merge this series as-is and any restructuring/cleanup can happen
later, since it's not related to this series anyway.

Bjorn
