Return-Path: <SRS0=laK2=5L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257FCC43331
	for <linux-pci@archiver.kernel.org>; Thu, 26 Mar 2020 22:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8602082D
	for <linux-pci@archiver.kernel.org>; Thu, 26 Mar 2020 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585262201;
	bh=0DtT905qVdWNBDrBCna0NgQ5Od+cslLqNzlrUIModX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Ac0aFtZi9e6TfKIZPXUB975M520n5DPFjdJE2TX51yQ8fNXiwmrp1orpMHtADyRZq
	 0oiV513cY6LQKwV9TnVSYRZQgmVfD3vskj3hwXaBNR/JT6zpJZbsT+/TBgjOne/7DV
	 zDFJvyhq7jGd2SRmuq/m0PTbANUjAsg7LGBB+/+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgCZWgk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZWgk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 18:36:40 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 573642077D;
        Thu, 26 Mar 2020 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585262199;
        bh=0DtT905qVdWNBDrBCna0NgQ5Od+cslLqNzlrUIModX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tsBKZvCW4tQGv92f3syNeoLj0fegellrPHn5oyyzz27WysT5sEoVMOjlJdtOvesIG
         ZTeEWtcDOyoSqORBEaNSRz0SRSisNtNXaspmqixgUCw+L421lOZU+yNKOuyudYUrl+
         y9aeDUwoE0p5uWYEswtwhtCKp4a9TXRRfssbIeiw=
Date:   Thu, 26 Mar 2020 17:36:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v18 10/11] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200326223637.GA106135@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f71c989b-b8f8-3437-b086-a97c2aa1e2c5@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 06:00:31PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 3/24/20 2:37 PM, Bjorn Helgaas wrote:
> > This is really ugly.  What's the story on this firmware?  It sounds
> > defective to me.
>
> I think there is no defined standard for this. I have checked few
> _DSM implementations. Some of them return default value and some
> don't. But atleast in the test hardware I use, we need this check.

I agree that I don't see anything in the ACPI spec v6.3 about what
should happen if we supply a Function Index that isn't supported.
That looks like a hole in the spec.

> > Or is everybody that uses _DSM supposed to check before evaluating it?
>
> I think its safer to do this check.
>
> > E.g.,
> > 
> >    if (!acpi_check_dsm(...))
> >      return -EINVAL;
> > 
> >    obj = acpi_evaluate_dsm(...);
> > 
> > If everybody is supposed to do this, it seems like the check part
> > should be moved into acpi_evaluate_dsm().

So my question, and I guess this is really for Rafael, is that since
it seems like *everybody* needs to use acpi_check_dsm() in order to
use acpi_evaluate_dsm() safely, why don't we move the check *into*
acpi_evaluate_dsm()?

It's just error prone if we expect everybody to call both interfaces.

Bjorn
