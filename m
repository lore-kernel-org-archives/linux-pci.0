Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:33229 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938515AbcIZSev (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2016 14:34:51 -0400
Date: Mon, 26 Sep 2016 20:28:40 +0200
From: Martin Mares <mj@ucw.cz>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        David Box <david.e.box@linux.intel.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Subject: Re: [PATCH v2] lspci: Parse all the L1 PM substate capability regs
Message-ID: <mj+md-20160926.182825.94359.nikam@ucw.cz>
References: <1472747248-60993-1-git-send-email-rajatja@google.com>
 <1473379530-70905-1-git-send-email-rajatja@google.com>
 <CACK8Z6HKhduwFj7LBoN52WBJaZB01LojNaA6J4u0cUx5RZzdpg@mail.gmail.com>
 <mj+md-20160926.182229.10984.albireo@ucw.cz>
 <CACK8Z6EFzB8VzGP7jqZJkKfO3_wS=K0XB7Q30ym0M=tkwtWuqA@mail.gmail.com>
 <CACK8Z6EChX9d99-=z=6HZYuKwusuVcZDHx4wkGY-_aO=yvUsOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6EChX9d99-=z=6HZYuKwusuVcZDHx4wkGY-_aO=yvUsOQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> I'll send the hex dump, however I do not know how to actually run the
> test. I assume it is fine to just send a patch to tests/ that has the
> hex dump.

Exactly.

So far, the tests are conducted manually.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
System going down at 5 pm to install scheduler bug.
