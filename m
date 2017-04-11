Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34534 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdDKOQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2017 10:16:23 -0400
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: abhijit <abhijitnaik27@gmail.com>
Subject: Doubt on first access for PCIe device
Message-ID: <50712b3b-2943-0b78-9413-257f33b26c3f@gmail.com>
Date: Tue, 11 Apr 2017 19:45:40 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi All,

I was referring Linux code for PCIe enumeration and I have one doubt 
w.r.t to very first operation that must be done on device.

Currently while scanning for device, we directly read vendor ID from 
device. But PCIE base specification 
"CB-PCI_Express_Base_4.0r0.7_November-11-2016.pdf" section 2.2.6.2 
specifies that,

"Functions must capture the Bus and Device Numbers supplied with all 
Type 0 Configuration Write Requests completed by the Function and supply 
these numbers in the Bus and Device Number fields of the Requester ID 
for all Requests initiated by the Device/Function."

Here I am assuming, the completer ID will be device number and function 
number that will eventually programmed in to  device. In that case, my 
question is, without first write, how read request(VENDOR ID read) is 
serviced/routed?

Sorry I am feeling bit confused, help will be appreciated.
-- 
Best wishes,
Abhijit Naik
