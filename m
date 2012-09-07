Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fiji.vyatta.com ([76.74.103.50]:35653 "EHLO fiji.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab2IGQpo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 7 Sep 2012 12:45:44 -0400
Message-Id: <20120907163313.614852012@vyatta.com>
Date: Fri, 07 Sep 2012 09:33:13 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
To: Linas Vepstas <linasvepstas@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 0/4] PCI error handler const
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a trivial patch to make PCI error handler function
tables const. Split into pieces so that core changes are first.

