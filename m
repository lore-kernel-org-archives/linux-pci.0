Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37455 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117AbbJ1Rvu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2015 13:51:50 -0400
Received: from [10.228.68.96] (rrcs-67-52-130-30.west.biz.rr.com [67.52.130.30])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: okaya@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F716140E9D
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2015 17:51:49 +0000 (UTC)
To: linux-pci@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Subject: ECRC and Max Read Request Size
Message-ID: <56310B34.6000102@codeaurora.org>
Date: Wed, 28 Oct 2015 13:51:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm seeing two problems with the current PCI framework when it comes to 
end-to-end CRC (ECRC) and Max Read Request Size.

The problem with ECRC is that it blindly enables ECRC generation on 
devices without checking if it is supported by the entire bus with 
ECRC=on option.

ECRC check can be enabled on all devices but ECRC generation on the root 
complex and switches needs to be set only if all devices support ECRC 
checking.

I'm thinking of making changes in this area to cover this gap with 
ECRC=safe option.

The other problem I'm seeing is about the maximum read request size. If 
I choose the PCI bus performance mode, maximum read request size is 
being limited to the maximum payload size.

I'd like to add a new mode where I can have bigger read request size 
than the maximum payload size.

Opinions?

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
