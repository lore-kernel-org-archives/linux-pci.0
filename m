Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D8DC3DA7A
	for <linux-pci@archiver.kernel.org>; Thu,  5 Jan 2023 19:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjAETYy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Jan 2023 14:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjAETYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 14:24:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414926B18C
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 11:20:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDDE0B81AD0
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 19:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4249FC433EF;
        Thu,  5 Jan 2023 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672946334;
        bh=zqSQFaHq+x7i1XN2go9Qd53R5NHegeHyCXAtjoQkHLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tee4HKIui2Z8g2qV6m/y9j95aP+wd2szoKUnIZsNPgF5IygahBI2xIaDibwwsArH6
         BfvGPHGACcBe9WNCPQZ2m2IT3hddJqih/I1zFPY5K1fiISt8q2B+X69E/+TDVDKLpM
         Sq1NuEdseCghWQh3RctLnYUyKd+VqOt7zgxrTv3zrCx+F897+/ivlEUxTpkYUqjDfy
         DzaP4Sgq36U0AejjGys/LwySaOmMPBiNGwWRQDRIzibHpWOp0ZeGOzbn9liz2OQ1QT
         ZtZFSmyuc1UUpQr8m/YCG0bbw9X+0Bq4M/0vx102c+attkqQqzbYqIVQ2XTDhnMp+/
         gBEQgHDEQDU4Q==
Date:   Thu, 5 Jan 2023 13:18:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Anatoli Antonovitch <a.antonovitch@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
        Alexander.Deucher@amd.com, christian.koenig@amd.com,
        Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Message-ID: <20230105191852.GA1162145@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105184355.9829-1-a.antonovitch@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 01:43:55PM -0500, Anatoli Antonovitch wrote:
> From: Anatoli Antonovitch <anatoli.antonovitch@amd.com>
> 
> It is to avoid any potential issues when S3 resume but at the same time we want to hot-unplug.
> Need to do some more testing to see if it is still necessary.

I'm not sure how to interpret this.

I guess I'll wait for you to do the testing and repost this if it does
turn out to be necessary?

I don't want to merge a patch with a commit log that says "need to do
more testing."

Bjorn
