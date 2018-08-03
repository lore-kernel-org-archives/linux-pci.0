Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeHCIJE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Aug 2018 04:09:04 -0400
Subject: Re: [RFC] PCI: add support for Immediate Readiness
To: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org>
Date: Fri, 3 Aug 2018 02:14:20 -0400
MIME-Version: 1.0
In-Reply-To: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/2/2018 7:36 AM, Felipe Balbi wrote:
> PCIe GEN4 defines a new bit on Status Register which tells us that, if
> Set, a function is immediately ready after a Reset. This means that
> all delays after a Conventional or Function Reset can be skipped.

Can you give a reference to the section of the specification? or
a pointer to the ECN?
