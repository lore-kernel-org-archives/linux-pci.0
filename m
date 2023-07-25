Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9438AC001DE
	for <linux-pci@archiver.kernel.org>; Tue, 25 Jul 2023 21:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGYVdF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGYVc6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 17:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8BA3;
        Tue, 25 Jul 2023 14:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D4E61901;
        Tue, 25 Jul 2023 21:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5255BC433C8;
        Tue, 25 Jul 2023 21:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690320776;
        bh=6koY50l11od8QxZowt9EtG4lqhEmlEzPITDh/N0Q/8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AlJa1Lh2MxGgjfDu1nB2BimBZ64+gnm6HyY2ap07l0vUlfiPD5c8AGRCJQIhiEn/a
         cDLa9C+KoMEOxFPWdElsWKsAa3CV79IvL6N59m31WQCdzCCt4qYXFbq5Et9PiYTfFm
         at80aIsmg+eSVFQjrFgx1IA+i0KSPu22JJGKBxB7Yh9jYZisPgLZyF42OCvM4oKYOH
         0vES2jrNODH0oDDU+lfrYLIF4koOrB9/6bo4n1ktThdQ2GsCTTbBzLca6hHYrv3Ui/
         rmWvJK8PkXMvyoNqUosYM+TYQNUb70w90HVlyFqWI81Abe0KjbNwwrXCS3oxYkErG9
         +qHfvfhBYBulg==
Date:   Tue, 25 Jul 2023 16:32:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        David Airlie <airlied@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        kvm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/9] PCI/VGA: Improve the default VGA device selection
Message-ID: <20230725213254.GA666777@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb6fd14-4661-4285-ac5f-c8f6ea1f4208@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 08:47:48PM +0800, suijingfeng wrote:
> On 2023/7/20 03:32, Bjorn Helgaas wrote:
> > "drm/loongson: Add an implement for ..." also solves a problem, but it
> > lacks a commit log, so I don't know what the problem is.
> 
> I have already telling you one yeas ago.

The patch itself must be self-contained, including a commit log that
justifies the change.  You may have told me a year ago, but that
doesn't help somebody looking at these changes next year.

Bjorn
