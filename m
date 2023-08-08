Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE369C41513
	for <linux-pci@archiver.kernel.org>; Tue,  8 Aug 2023 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjHHUYe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjHHUYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 16:24:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE7CFAB0;
        Tue,  8 Aug 2023 12:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5701062B76;
        Tue,  8 Aug 2023 19:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE6FC433C8;
        Tue,  8 Aug 2023 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691523331;
        bh=nFKrvD+coJjNEf+lNj7pLiF4D1tHak7/3eeLoE0MEj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BoxiUVrNFftgw6LZCJI294+Gjvs2VPYqD4VfXiBT820A8fQ5hVMqN7awlMjQG8uZp
         z0Fl9GGiEss02oeHSfDH9IjuEpvU77p1lCd2VlOD6vsUj2SrqolM8jBJ5pOzPe30N0
         WTNjWrTuYSg7IySQeImKHPNlNiaz7OEY+0CCu8tB0GcRSTJINkr7VvRK4h0WZVNglP
         We44v3SHontu8qg0inm72O1RIksbDunTm2IuqNzcSqTwuE4xGnVTIvPLFxehYskGsH
         iEV1RPaP/ArG/C8MkDVsKMGWmU1AKP3ca/3Yc7wejZwgRRSOKvY53b0b4dw5X1p6OO
         /rQhAwJvrSFEQ==
Date:   Tue, 8 Aug 2023 14:35:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230808193529.GA330050@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ku2hdnc2wixu5ygnwvtzbti3ujgkcte7fluvypno2zufnqqzt5@5ip4ndk4ha5l>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 11:25:06AM +0200, Michal Koutný wrote:
> Hello.
> 
> On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov <imammedo@redhat.com> wrote:
> > The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
> > following sequence:
> >    1. suspend to RAM
> >    2. wake up with the same backtrace being observed:
> >    3. 2nd suspend to RAM attempt makes laptop freeze
> 
> My Dell laptop suffers this since v6.5-rc1.
> I've found this thread because of the same call stack triggering the
> NULL ptr dereference I captured on my machine.
> 
> I applied this patch and resume works as before and I have observed no
> issues during typical usage.
> 
> I'd be glad if a fix like this makes it into the next -rc.
> Feel free to add
> 
> Tested-by: Michal Koutný <mkoutny@suse.com>

Added tested-by for both you and Woody, thank you very much!  This
should appear in -rc6.

Bjorn
