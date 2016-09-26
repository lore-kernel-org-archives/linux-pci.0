Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:44122 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933770AbcIZSat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2016 14:30:49 -0400
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 0ECBA1C019A
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2016 20:25:22 +0200 (CEST)
Date: Mon, 26 Sep 2016 20:23:50 +0200
From: Martin Mares <mj@ucw.cz>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        David Box <david.e.box@linux.intel.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Subject: Re: [PATCH v2] lspci: Parse all the L1 PM substate capability regs
Message-ID: <mj+md-20160926.182229.10984.albireo@ucw.cz>
References: <1472747248-60993-1-git-send-email-rajatja@google.com>
 <1473379530-70905-1-git-send-email-rajatja@google.com>
 <CACK8Z6HKhduwFj7LBoN52WBJaZB01LojNaA6J4u0cUx5RZzdpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6HKhduwFj7LBoN52WBJaZB01LojNaA6J4u0cUx5RZzdpg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> Just checking if you got a chance to look at this.

It currently lives in the l1pm branch of pciutils.git, together with
a couple of my cleanups. Most importantly, your original patch did sometimes
print unterminated lines.

Could you please check my version and submit a test case (a hex dump of
a config space with this capability, like those in tests/*).

				Martin
