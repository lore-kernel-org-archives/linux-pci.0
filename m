Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD10CC678D5
	for <linux-pci@archiver.kernel.org>; Wed,  8 Mar 2023 23:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCHXEj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCHXEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 18:04:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE72DB78A6
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 15:03:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B02FB81E28
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 23:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83AEC4339B;
        Wed,  8 Mar 2023 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678316586;
        bh=cLRc1uEwXF3DERfYhSsOnoKOMROpqkCWfxj0gSiRHNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QZJD/Nn4Zn99tjl1YQS34qYQXhZzeKaqlHkkudMLVb3yWjHHBuZRp8awI0YsGSViD
         F4Qd4ZK3/tboWrf7MyLG7qeRZrh3mVNCKbzY6F4LfmuCmjGMfLvW3XUoetEQ+prQAO
         iahSEIzK57KmKe6bOToZaWzu/mUnlSaFitrMJgf5bqElxaVP9PA44tHN5sOg2M9qGw
         OQyQwg+uRZO+vRtRbKY8zJtdX3y2TclfA6/XXO9/HnMklbFB4Jhl/Tgp9frkRDdVuY
         V40tSHinN0oagU3r44/Vs6AQcWgzy84bBurZu9ecj65YQoDwoMnvedvQM0Jw3z9nMU
         vt92V4quNJjag==
Date:   Wed, 8 Mar 2023 17:03:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     rec <gael.seibert@gmx.fr>
Cc:     linux-pci@vger.kernel.org
Subject: Re: The MSI Driver Guide HOWTO
Message-ID: <20230308230304.GA1055709@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EXLGBDE.RHCGXKUL.PVZZRIJ5@4WBK2UU6.UECE5XTY.OLOBOVLW>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 07, 2023 at 12:22:44PM +0100, rec wrote:
> Like asked in : https://www.kernel.org/doc/html/latest/PCI/msi-howto.html#disabling-msis-globally

Thanks for the report!  I assume this means your system has problems
with MSIs, and booting with "pci=nomsi" makes it work better?

Can you please give some details about what is broken when you boot
without "pci=nomsi"?  If you can collect a complete dmesg log both
with and without "pci=nomsi", that would be great.

Bjorn

> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 671MX
>     Subsystem: ASUSTeK Computer Inc. 671MX
>     Flags: bus master, medium devsel, latency 64
> ...
