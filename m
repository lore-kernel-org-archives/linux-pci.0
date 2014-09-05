Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65079 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757040AbaIEOhN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Sep 2014 10:37:13 -0400
Date: Fri, 5 Sep 2014 08:37:11 -0600 (MDT)
From: Keith Busch <keith.busch@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Keith Busch <keith.busch@intel.com>,
	Jon Mason <jon.mason@intel.com>, Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
In-Reply-To: <5409117E.2000002@huawei.com>
Message-ID: <alpine.LRH.2.03.1409050833180.4696@AMR>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com> <20140903224201.GD26073@google.com> <540802D9.6000903@huawei.com> <CAErSpo6qy76zTX07Ufm0n1_HUA5G0MrAYxauEFa5QkibWsejFQ@mail.gmail.com> <5409117E.2000002@huawei.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 4 Sep 2014, Yijing Wang wrote:
> So I think the problem won't happen in other modes.

Yes, you're right; we currently recommend end-users set one of the other
bus tuning options because the problem doesn't happen there.
