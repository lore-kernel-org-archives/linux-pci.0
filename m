Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11825 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576AbcC1Idm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Mar 2016 04:33:42 -0400
Message-ID: <56F8EC63.7050003@intel.com>
Date: Mon, 28 Mar 2016 16:33:39 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: bhelgaas@google.com
Subject: Re: [RFC v3] PCI: PTM Driver
References: <1458705848-26056-1-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1458705848-26056-1-git-send-email-jonathan.yong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/23/2016 12:04, Yong, Jonathan wrote:
> Changes since v1:
> * Moved register constants to pci_regs.h
> * Use pci_dev to hold PTM status
> * PTM initialization now done top-down hierarchy wise.
>
> Changes since v2:
> * Added missing void return in the pci_ptm_init inline stub.
>

Ping?


