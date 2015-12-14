Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48535 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbLNSWm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 13:22:42 -0500
Subject: Re: [PATCH v2] PCI/AER: enable SERR# forwarding for bridges and
 switches
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1449074998-9664-1-git-send-email-okaya@codeaurora.org>
 <20151204210622.GI20125@localhost> <5669E073.4000801@codeaurora.org>
 <20151210223742.GC367@localhost> <566B5CA1.1010306@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, izumi.taku@jp.fujitsu.com, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <566F08EF.5010904@codeaurora.org>
Date: Mon, 14 Dec 2015 13:22:39 -0500
MIME-Version: 1.0
In-Reply-To: <566B5CA1.1010306@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/11/2015 6:30 PM, Sinan Kaya wrote:
>> I think the best way to fix all the cases would be to do something in
>> > in pci_configure_device().  Then we could drop the AER bus walk in
>> > set_downstream_devices_error_reporting().  A bus walk like that is
>> > always an issue for hotplug.
>> > 
> Let me read some code.
> 

OK, If I understand it right; pci_configure_device is where
program_hpp_type0 called. You also want to enable AER in this function.

Move the contents of set_device_error_reporting into
pci_configure_device like this below ?

...
+ int type = pci_pcie_type(dev);

pci_configure_mps(dev);

+	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (type == PCI_EXP_TYPE_UPSTREAM) ||
+	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
+		pci_enable_pcie_error_reporting(dev);
+	}

+	pcie_set_ecrc_checking(dev);




-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
