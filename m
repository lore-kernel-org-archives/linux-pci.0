Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37239 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbbLFETM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Dec 2015 23:19:12 -0500
Subject: Re: [PATCH v2] PCI/AER: enable SERR# forwarding for bridges and
 switches
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1449074998-9664-1-git-send-email-okaya@codeaurora.org>
 <20151204210622.GI20125@localhost>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, izumi.taku@jp.fujitsu.com, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5663B73D.7080709@codeaurora.org>
Date: Sat, 5 Dec 2015 23:19:09 -0500
MIME-Version: 1.0
In-Reply-To: <20151204210622.GI20125@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/4/2015 4:06 PM, Bjorn Helgaas wrote:
> I'm sitting on this for the moment because if you have _HPP, it seems
> like that should be enough to get SERR# forwarding turned on, and if
> it's not, I'd like to understand why.  So no hurry, but I'm waiting on
> your investigation.
> 
> Bjorn

OK. I'll find out. I did not get a chance to debug it yet. My guess is
that I wrote this patch before enabling the hotplug support. Therefore,
I was not aware of any _HPP implementation in the kernel.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
