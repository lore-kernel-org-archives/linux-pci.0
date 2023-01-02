Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8902C3DA7A
	for <linux-pci@archiver.kernel.org>; Mon,  2 Jan 2023 17:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjABRPU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Jan 2023 12:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjABRPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 12:15:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C221BC;
        Mon,  2 Jan 2023 09:15:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E51D61053;
        Mon,  2 Jan 2023 17:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCBDC433D2;
        Mon,  2 Jan 2023 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679718;
        bh=uMa+2EV8sQXIoi7krGE5+lHKqNZXdhy8KBaJhGQjXSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HmzQGfemzxgmLHmxBM3S4HC6OCLBy/6NtfV0hyA4R7FU4JGUUe3/RJNIMsH8Ff+Sr
         F3IHEuBavVNUqyxNYPKXrRdz2GqOu39U6beSc0j/+oOmazX7ve40CfxETv7aYhzoOz
         FdblQxUioHjDQGqrKISWbyZrIdtabCOFdLNPt11OG6IAzl/XbXeMZpgXqzyfwpNA2c
         +pnWR2fGzFnP7Y4S1kZV9xXlgnAr09Il/1y9kJZM3gkLPJvVPtHGBp6RIidV1lsirz
         ae5topn3GQcPSQi4mfNvACI6LZSDjpetT2+cYoLbcIyRb4AJhF3bOb+S/ckXsqZzbx
         HrMpa71alZ+lQ==
Date:   Mon, 2 Jan 2023 11:15:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Thomas Witt <kernel@witt.link>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [Bug 216877] New: Regression in PCI powermanagement breaks
 resume after suspend
Message-ID: <20230102171516.GA783946@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216877-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you very much for your report and all the work of bisecting,
Thomas!  If you have a chance, can you collect the "sudo lspci -vv"
output (the one attached doesn't include the ASPM info, probably
because lspci wasn't run as root), and also a complete dmesg log from
before the suspend?

On Mon, Jan 02, 2023 at 02:02:51PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216877
> 
>             Bug ID: 216877
>            Summary: Regression in PCI powermanagement breaks resume after
>                     suspend
>     Kernel Version: 6.0.0-rc1
> 
> Created attachment 303512
>   --> https://bugzilla.kernel.org/attachment.cgi?id=303512&action=edit
> output of git bisect log
> 
> After commit 5e85eba6f50dc288c22083a7e213152bcc4b8208 "PCI/ASPM:
> Refactor L1 PM Substates Control Register programming" my Laptop
> does not resume PCI devices back from suspend.
> 
> My Laptop is a Tuxedo Infinitybook S 14 v5, as far as I can tell
> they use a Clevo L140CU Mainboard.
> 
> The main symptom is:
> iwlwifi 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> nvme 0000:03:00.0: Unable to change power state from D3hot to D0, device inaccessible
> 
> after that, the level of interaction I still have with the laptop
> varies, but It cannot run dmesg and it cannot do a clean reboot. The
> issue occurs on every suspend/resume cycle.
