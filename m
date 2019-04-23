Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3394C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 22:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1A217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 22:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556057497;
	bh=6uaIDqhlQe789sFXRkyJVF8NsVndwaJW3RinM5iteNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=beaX2jm+6gYTin9PwNaslI4r1M6u/12XRkW40HaWUCQ/8zVgVGC/9NxQAkpw0+UdV
	 sLsS4lBz8/odIEEMEb9uCg8leLBv+oISxdjnCSkMlwKOEFZIGxjS/N5vLYXqD+dFzt
	 LpMiPJCs39r4P8yb+HAsAfxc6oVt3Mr+GZ4VYJsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfDWWLg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfDWWLg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 18:11:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5FD21738;
        Tue, 23 Apr 2019 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556057496;
        bh=6uaIDqhlQe789sFXRkyJVF8NsVndwaJW3RinM5iteNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQl6VeFTzcdo2gVP1ZdPp8m7WgIVsiolfKFmY1PC9/qgjcPMGQDCkj5xbv6PT593t
         R2k7ne6t2oXNpbphqANwgxGyxRELMdIspps1SSjnO5QB78pTVLwJLTN0SgcZgLtD0Q
         kmJOkzl2ZhgIUvUzGEaMPEu7vKQx/2Cw3CY8B7GE=
Date:   Tue, 23 Apr 2019 17:11:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        alex.williamson@redhat.com
Subject: Re: [PATCH v1 1/5] PCI/IOV: Add support to verify PF/VF spec
 compliance
Message-ID: <20190423221134.GI14616@google.com>
References: <cover.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <317aaed09820db65c21452663bed33468f874d3a.1551909341.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190419135918.GC173520@google.com>
 <20190419173728.GE46517@otc-nc-03>
 <22ad30c0-fc7e-b5ac-a224-c1a247c33359@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ad30c0-fc7e-b5ac-a224-c1a247c33359@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 19, 2019 at 11:41:31AM -0700, sathyanarayanan kuppuswamy wrote:
> On 4/19/19 10:37 AM, Raj, Ashok wrote:
> > On Fri, Apr 19, 2019 at 08:59:18AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 06, 2019 at 02:11:14PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > 
> > > > PF/VF implementation must comply with PCIe specification as
> > > > defined in r4.0, sec 9.3.4, 9.3.5, 9.3.6 and 9.3.7. And if
> > > > it does not comply, return error and skip PF/VF device
> > > > creation.
> > > As far as I can tell, this patch basically looks for excuses not to
> > > enable SR-IOV.  Does this actually solve a problem?  Are there
> > > non-compliant devices out there that blow up if we enable SR-IOV?
> > We ran into one case with a future product for INTx value on VF's. We do have
> > a quirk for it upstream now. We thought it might be good to just run through
> > some of the basic requirements and see if any device violates it, that would allow
> > us to catch them early.
> > 
> > We are looking into other things like PASID and End-2-End prefix capability for instance.
> > There is another subtle thing like number of eetlp_prefix_supported. Which i don't
> > pci core checks today, and we might need to do that to be compliant or find devices
> > that break that contract.
> > 
> > Real intend is to be find such breaks early, it also helps the product guys :-)
> > 
> > With upcoming vIOMMU effort, we need to ensure that capabilities are exported properly
> > depending on if its a SRIOV-PF/VF or a Scalable device.
> > 
> > Cheers,
> > Ashok
> 
> I agree with Ashok's comments. It helps us find SRIOV related features
> enable/disable issues easily.
> 
> Also, there is some of level of spec compliance checks in enabling
> PASID/PRI/ATS already in our existing code.
> 
> I am just grouping them together in one place and expanded it for other IOV
> related features.

My $0.02:

  - If there's a problem that actually prevents Linux from using a feature,
    check for the problem close to the point where we use the feature.

  - If you want to check for spec compliance, most of that can be done more
    easily in user-space by examining lspci output.

Bjorn
