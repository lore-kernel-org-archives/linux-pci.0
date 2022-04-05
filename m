Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C98C433F5
	for <linux-pci@archiver.kernel.org>; Wed,  6 Apr 2022 05:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiDFFoF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Apr 2022 01:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1850751AbiDFC7m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 22:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90EBAA03C
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 16:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A433361599
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 23:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B0BC385A0;
        Tue,  5 Apr 2022 23:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649202797;
        bh=gBFTojaFBZXwayWYh3mJNcB4x/Tmry15CzXCjswCv8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YTXAHMwzPcqMf5ZFNhOoWVQbXnrcLJmHqtz9NSm5tP/4HX23j7L/JecUoa/eOx4DH
         OiZlJEUJoVdR4rAd55ndHsWvqdp9imJh6Upnq73B7PNNT3VFL5f923AeotOHjsd7oj
         jSOo+R+kkOms19+j/yrDTX7Ph1e6Q2EEhqUUqGFgvekR2YTJjstnLcxJcrhdweGvRq
         +5Eqw08HcM+gV0NyWPVr2Z3OzSjm6Fb6jVfbTxdxLN3LCT0TRHMfL66FxzClTddv+0
         DF50CyxGnHHu/L6J4GpuAdHxGI5QKwlZNSoEMiqgRWvi+gJp4QuASxfZ+oc0Rxm3kW
         /uwO8yudRJ2yQ==
Date:   Tue, 5 Apr 2022 18:53:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <20220405235315.GA101393@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjyv03JsetIsTJxN@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 05:52:19PM +0000, Mark Brown wrote:
> On Wed, Mar 23, 2022 at 11:47:08PM -0700, KernelCI bot wrote:
> 
> The KernelCI bisection bot has identified commit 5949965ec9340cfc0e
> ("x86/PCI: Preserve host bridge windows completely covered by E820")
> as causing a boot regression in next on asus-C523NA-A20057-coral (a
> Chromebook AIUI).  Unfortunately there's no useful output when starting
> the kernel.  I've left the full report below including links to the web
> dashboard.
> 
> The last successful boot in -next had this log:
> 
>    https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
> 
> I'd also note that the machine hp-x360-12b-n4000-octopus appears to have
> started failing at the same time with similar symptoms, failing log:
> 
>    https://storage.kernelci.org/next/master/next-20220324/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-n4000-octopus.html

Is there any way to get the contents of:

  /sys/firmware/acpi/tables/DSDT
  /sys/firmware/acpi/tables/SSDT*

from these Chromebooks?
