Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35449 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbbC3LDO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 07:03:14 -0400
Received: by wicne17 with SMTP id ne17so26430388wic.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2015 04:03:13 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 30 Mar 2015 13:03:13 +0200
Message-ID: <CAJN_i4_Qqsh16MfAV1UYyFp1DkNoQ=5nftQzNXLfJV9ted1Wjg@mail.gmail.com>
Subject: Detecting thunderbolt ports
From: Zygmunt Krynicki <zygmunt.krynicki@canonical.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi.

I'm interested in detecting if thunderbolt is present on a running
system. I need this as a part of certification testing so that the
test operator can be asked to do some thunderbolt-specific tasks.

I talked to some of the maintainers and from what I've learned there
are two thunderbolt drivers, one for apple and one for everything
else. The one for apple has the nice property of being able to
statically detect that the hardware is present. The one for everything
else, which I'm more interested in as I'm not certifying apple
hardware, apparently does not and there is no way to detect that a
machine has a thunderbolt port unless something is physically plugged
into that port.

So I'd like to ask more broadly, is the statement above accurate? Can
the presence of a thunderbolt port be detected from a running system
reliably?

Best regards
ZK
