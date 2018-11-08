Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EBAECDE4B
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C365320883
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 13:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYlaKKu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C365320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeKHXfN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbeKHXfN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 18:35:13 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638582081D;
        Thu,  8 Nov 2018 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541685576;
        bh=EHEe93uojf1nDTDoOLc9Pfl+3DEZomziHl2ZXm/sP5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYlaKKu/HYgibJPLjEwyXjVVahtbe6Bi1H/t6Tz6DDk83PpCLP4tCEXLEA7aovIlE
         3KzD0dLO1Fb4ZKcV/RUE9Kb3PqKMrgBo2pXlNJhOJ4yC26Dq1UYL/BEiBLqqhY0b0H
         a3Kve0C5px7J08ClDaMAHoDWVrS2TC6woJz80sqo=
Date:   Thu, 8 Nov 2018 07:59:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Woods, Brian" <Brian.Woods@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181108135934.GD41183@google.com>
References: <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic>
 <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic>
 <20181106232040.GA85755@google.com>
 <75748b089ee696d5cbaa5c0ce68bad228699894c.camel@linux.intel.com>
 <20181107213103.GA41183@google.com>
 <baf4b2e9c9b7cb2f827fd3bffce4b72f6d9376a8.camel@linux.intel.com>
 <20181107231411.GB41183@google.com>
 <2c4b9e7e-6558-e5ce-50e6-58aaec22fd1c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4b9e7e-6558-e5ce-50e6-58aaec22fd1c@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 05:40:14PM -0800, Guenter Roeck wrote:
> On 11/7/18 3:14 PM, Bjorn Helgaas wrote:
> > 
> > > 
> > > There is no INT3401 on any newer atom or core platforms, so you can't
> > > enumerate on this device. We don't control what ACPI device is present
> > > on a system. It depends on what the other non-Linux OS is using.
> > 
> > Sure, you can't *force* OEMs to supply a given ACPI device, but you
> > can certainly say "if you want this functionality, supply INT3401
> > devices."  That's what you do with PNP0A03 (PCI host bridges), for
> > example.  If an OEM doesn't supply PNP0A03 devices, the system can
> > boot just fine as long as you don't need PCI.
> > 
> > This model of using the PCI IDs forces OS vendors to release updates
> > for every new platform.  I guess you must have considered that and
> > decided whatever benefit you're getting was worth the cost.
> > 
> 
> I really dislike where this is going. Board vendors - and that included
> Intel when Intel was still selling boards - have a long history of only
> making mandatory methods available in ACPI. Pretty much all of them don't
> make hardware monitoring information available via ACPI. This is a pain
> especially for laptops where the information is provided by an embedded
> controller. On systems with Super-IO chips with dedicated hardware
> monitoring functionality, they often go as far as signing mutual NDAs
> with chip vendors, which lets both the board and the chip vendor claim
> that they can not provide chip specifications to third parties, aka
> users.
> 
> You are pretty much extending that to CPU temperature monitoring. The
> fallout, if adopted, will be that it will effectively no longer be
> possible to monitor the temperature on chips supporting this
> "feature".
> 
> I do not think that would be a good idea.

I wasn't aware of these political implications.  Thanks for raising
them.

I'm not in a position to balance those implications vs the technical
question of minimizing the burden of supporting new platforms, so I'll
try again to bow out of this.

Bjorn
