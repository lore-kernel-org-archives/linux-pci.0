Return-Path: <SRS0=ph/K=S7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A5C43219
	for <linux-pci@archiver.kernel.org>; Mon, 29 Apr 2019 18:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9548521655
	for <linux-pci@archiver.kernel.org>; Mon, 29 Apr 2019 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556564189;
	bh=l9u1ysS3GT7OB/kiY6gTzx5x3l55qd0OUe7XJXsNJF4=;
	h=From:To:Subject:Date:List-ID:From;
	b=xaSQnIkmwOMlUPCGLdAlhliozd8V1lz4xcolmNwpqP1HfMfMSOxBKY1D22ortQCQx
	 VgWMLAK0El//2JQB8hIkCTWgaAeW7V+WrkZs1jseEE+XHKFW091QC4ofknK8t3Kkz0
	 UNvICCbyA6H3biZDMHR73oKqQRD85aWMT7MMAy9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfD2S42 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfD2S42 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 14:56:28 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B682075E;
        Mon, 29 Apr 2019 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556564188;
        bh=l9u1ysS3GT7OB/kiY6gTzx5x3l55qd0OUe7XJXsNJF4=;
        h=From:To:Subject:Date:From;
        b=USnEw7w7sFx64aezMaHI1O7bocLHlTB9WcH7ytJ12BDLpC88wuqiiO87fe9JsMlBi
         lVjQzUWecb94A6bes2n2UHG/YbYR0wIAHVmp2Wy8cUihNL1Z4q4+bnlk70+XR0oTPX
         7jyBhVWtx6fgfUUZ/VqFArv4oI06g02OFDh8TJz0=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "PCI/LINK: Report degraded links via link bandwidth
Date:   Mon, 29 Apr 2019 13:56:10 -0500
Message-Id: <20190429185611.121751-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alex W. reported a case where the new link bandwidth notification logging,
e.g.:

  vfio-pci 0000:07:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 64.000 Gb/s with 5 GT/s x16 link)

is somewhat surprising.  The message is great if link bandwidth was reduced
because of a hardware problem, but in this case it's caused by a GPU doing
link state management to conserve power, so the message is to be expected
and is likely to confuse the user.

We haven't figured out a good way to handle both the "hardware failure" and
the "active link management" cases yet, so revert this for now.

Bjorn

