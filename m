Return-Path: <SRS0=kfIp=BG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77DFC433E1
	for <linux-pci@archiver.kernel.org>; Mon, 27 Jul 2020 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C052A2065C
	for <linux-pci@archiver.kernel.org>; Mon, 27 Jul 2020 09:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgG0J2l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:28:41 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42609 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgG0J2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 05:28:41 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 064DC206466D7;
        Mon, 27 Jul 2020 11:28:39 +0200 (CEST)
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Delays in PCI/ACPI initialization
Message-ID: <90c62e70-186c-f0cb-e2ac-8defcdb4405a@molgen.mpg.de>
Date:   Mon, 27 Jul 2020 11:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Linux folks,


Trying to decrease the boot time on a Acer TravelMate 5735Z with Debian 
Sid/unstable and Linux 5.7.6, there are two delays of 100 ms. I created 
a separate issue for each of the delays.

1.  [Bug 208703] PnP ACPI init has 100 ms delay until quirk message
2.  [Bug 208705] New: 100 ms delay in PCI initialization

But maybe they have the same cause, and are duplicates. It’d be great, 
if you took a look.


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=208703
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=208705
