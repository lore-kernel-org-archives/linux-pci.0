Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938984AbcJGPjV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 11:39:21 -0400
Date: Fri, 7 Oct 2016 10:39:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org
Subject: pcie-armada8k.c maintainer?
Message-ID: <20161007153900.GA18801@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

get_maintainer.pl doesn't know who maintains
drivers/pci/host/pcie-armada8k.c (actually, it says *I* support it,
but that's obviously wrong).  Can you send me a MAINTAINERS patch to
fix that?

Bjorn
