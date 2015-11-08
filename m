Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53452 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbbKHRUE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2015 12:20:04 -0500
Subject: Re: ECRC and Max Read Request Size
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56310B34.6000102@codeaurora.org>
 <20151106172205.GA1002@localhost>
Cc: linux-pci@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <563F8440.4060001@codeaurora.org>
Date: Sun, 8 Nov 2015 12:20:00 -0500
MIME-Version: 1.0
In-Reply-To: <20151106172205.GA1002@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/6/2015 12:22 PM, Bjorn Helgaas wrote:
> I've never been thrilled about the way Linux ties MRRS and MPS
> together.  I don't think the spec envisioned MRRS being used to
> control segment size on the link.  My impression is that the purpose
> of MRRS is to limit the amount of time one device can dominate a link.
>
> I am sympathetic to the idea of having MRRS larger than MPS.  The
> question is how to accomplish that.  I'm not really happy with the
> current set of "pcie_bus_tune_*" parameters, so I'd hesitate to add
> yet another one.  They feel like they're basically workarounds for the
> fact that Linux can't optimize MPS directly itself.
>
> Can you give any more specifics of your MRRS/MPS situation?  I guess
> you hope to improve bandwidth to some device by reducing the number of
> read requests?  Do you have any quantitative estimate of what you can
> gain?

Xilinx has a nice whitepaper about PCIe performance here. See the 
section about Maximum Read Request Size.

http://www.xilinx.com/support/documentation/white_papers/wp350.pdf

The benefits of maximum read request is seen when moving large amounts 
of data usually.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
