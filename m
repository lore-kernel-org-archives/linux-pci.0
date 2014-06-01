Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59919 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaFAQeU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 1 Jun 2014 12:34:20 -0400
From: Matthew Garrett <matthew.garrett@nebula.com>
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Date: Sun,  1 Jun 2014 12:33:52 -0400
Message-Id: <1401640436-1947-1-git-send-email-matthew.garrett@nebula.com>
Subject: ACPI: Improve behaviour on Apple hardware
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Apple hardware behaves differently depending on whether or not the OS claims
to be Darwin. Failing to report Darwin results in some hardware being
disabled. However, claiming to be Darwin also alters the behaviour of
battery reporting and PCI handling. These patches add support for reporting
Darwin support and fixing up the behavioural quirks that are exposed as a
result.

-- 
Matthew Garrett | matthew.garrett@nebula.com

