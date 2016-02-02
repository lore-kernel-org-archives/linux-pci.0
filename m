Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34558 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbcBBLja (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2016 06:39:30 -0500
Received: by mail-ig0-f170.google.com with SMTP id ik10so58475243igb.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Feb 2016 03:39:29 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 2 Feb 2016 13:39:29 +0200
Message-ID: <CAJ2oMhKMcwX+5SUR6_jANqVu-F9nbmx5+k8G+wym6BvVuH3uoQ@mail.gmail.com>
Subject: Emulate pci deviceID/vendor for driver debug ?
From: Ran Shalit <ranshalit@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

Is there some simple way - just for debug purpose - to make the kernel
think that the driver matches the board/vendor , so that the driver
will be called ?
I don't have the real harware yet (even not a pci physical interface
for any card), but wanted to start debugging some template driver.

Thank you,
Ran
