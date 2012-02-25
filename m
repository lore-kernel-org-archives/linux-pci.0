Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:23648 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab2BYVyt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 Feb 2012 16:54:49 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/4] PCI: Rename pci_remove_* to pci_stop_and_remove_*
Date: Sat, 25 Feb 2012 13:54:19 -0800
Message-Id: <1330206863-31381-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So make them to reflect original action: stop and remove, less confusing.

stop means stop, remove means remove.

Thanks

Yinghai
