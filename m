Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:59121 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbaDVJuH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Apr 2014 05:50:07 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so5484758obc.32
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2014 02:50:07 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 22 Apr 2014 15:20:07 +0530
Message-ID: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com>
Subject: Intel NIC testing on ARM
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Has anybody tested below Intel I210 NIC card using igb driver on ARM?

http://www.intel.com/content/www/us/en/ethernet-controllers/ethernet-controller-i210-i211-family.html

It hangs during configuration stage for me. Actually it shows BAR0
requirement as 0 which is non-zero for x86.
