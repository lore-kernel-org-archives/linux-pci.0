Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:33772 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab2APQs4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2012 11:48:56 -0500
Received: from localhost.localdomain ([127.0.0.1]:50321 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903614Ab2APQZ0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Jan 2012 17:25:26 +0100
Date: Mon, 16 Jan 2012 17:25:20 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: PCI: use list_for_each_entry() for
 bus->devices traversal
Message-ID: <20120116162520.GF12896@linux-mips.org>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
 <20111216223139.5963.51460.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111216223139.5963.51460.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks, applied.

  Ralf
