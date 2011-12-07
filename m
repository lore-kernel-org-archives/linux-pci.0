Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:32011 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab1LGIxw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 03:53:52 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/5] PCI: make pci hotplug/rescan path to handle add_size list
Date: Wed,  7 Dec 2011 00:52:59 -0800
Message-Id: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resending.

will make hotplug path treat sriov and etc good have resources.

big change is: during allocation will try to allocation must_have plus good
 to have at same time, and then could fall back to must_have only.

Thanks

Yinghai




