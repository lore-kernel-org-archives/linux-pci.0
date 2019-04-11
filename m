Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161D3C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23032073F
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 12:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfDKMhA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:37:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfDKMg7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 08:36:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BAA4AC4C;
        Thu, 11 Apr 2019 12:36:58 +0000 (UTC)
Date:   Thu, 11 Apr 2019 14:36:56 +0200
From:   "jroedel@suse.de" <jroedel@suse.de>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Nikolai Kostrigin <nickel@altlinux.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7
 GPUs
Message-ID: <20190411123656.GE3349@suse.de>
References: <20190408103725.30426-1-nickel@altlinux.org>
 <20190408103725.30426-2-nickel@altlinux.org>
 <20190409215927.GC256045@google.com>
 <BN6PR12MB1809C529684D59E8DF3D1F0FF72E0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB18094BA9F4011E6698A56742F72E0@BN6PR12MB1809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR12MB18094BA9F4011E6698A56742F72E0@BN6PR12MB1809.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 03:59:57PM +0000, Deucher, Alexander wrote:
> > + a few AMD people
> > 
> > Seeing this bug makes it more clear.  I don't think this is a problem with the
> > GPU.  I think it's a problem with either the sbios or iommu.  I think the original
> > quirk added for stoney (0x98e4) is probably wrong as well.  I suspect we
> > need a quirk for a particular laptop or sbios versions.  We validated ATS
> > extensively with Carrizo based systems (the system in the bug report above
> > is Carrizo based) since it is the basis of our ROCm support on APUs.  We have
> > also been involved in tons of Linux OEM preloads with both Carrizo and
> > Stoney based APUs in combination with TOPAZ dGPUs (0x6900) and haven't
> > seen this issue in those programs.  We also have TOPAZ dGPUs used in OEM
> > programs with Intel chipsets and haven't seen the issue.  I suspect since
> > windows does not use the IOMMU by default, the sbios settings may not be
> > well validated on certain windows only skus.  I'd rather make these DMI
> > matches or something like that for the platform or at the very least match
> > the SSIDs as well.
> 
> Reading through these bugs again it seems to be an issue with Stoney
> APUs, not the dGPU specifically.  I think it would be better to
> disable ATS in general if a stoney based platform was detected rather
> than adding ATS quirks for devices then someone may put in a Stoney
> based platform.  It also seems to be related to runtime pm on the
> dGPU.  Disabling runtime pm also seem to fix the issue.  On these
> systems runtime pm for the dGPU is controlled via ACPI (either ATPX or
> _PR3 depending on the platform).  Maybe something doesn't get restored
> properly on runtime resume which cases the ATS issues?

This seems all pretty much possible, but we lack the ability to debug
this further on our side. So until we have a real root-cause with a more
specific quirk that only targets systems with a broken sbios or
whatever, we need to catch-all approach.

We can remove these quirks again when AMD sends more specific quirks
upstream.


Regards,

	Joerg
