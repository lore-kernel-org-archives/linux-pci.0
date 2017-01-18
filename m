Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:46616 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751740AbdARKxr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jan 2017 05:53:47 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 0932643F1C
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2017 11:43:08 +0100 (CET)
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id uyEKu8aKVoor for <linux-pci@vger.kernel.org>;
        Wed, 18 Jan 2017 11:43:06 +0100 (CET)
To: linux-pci@vger.kernel.org
From: Stefan Roese <stefan.roese@mailbox.org>
Subject: PCIe card supporting multiple MSI vectors
Message-ID: <a6eb25e3-effc-39a4-88c1-8309d601d7b9@mailbox.org>
Date: Wed, 18 Jan 2017 11:43:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

for some test with MSI related tests I would like to test
with a desktop PCIe card that supports multiple MSI vectors.
Could somebody please make a suggestion for such a card
(not too expansive if possible) with a Linux driver that
also support multiple MSI vectors?

Thanks,
Stefan
