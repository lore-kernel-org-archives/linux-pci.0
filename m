Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUIzx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Aug 2018 04:55:53 -0400
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id ED3D361220
        for <linux-pci@vger.kernel.org>; Tue, 21 Aug 2018 05:37:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 21 Aug 2018 11:07:15 +0530
From: poza@codeaurora.org
To: linux-pci@vger.kernel.org
Subject: PCIe Page request Interface Query (PRI)
Message-ID: <dbc3e13525d36553dfab3219fc6d4d81@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,


We have implemented the access control (ACS) for PRI request. If the BDF 
number of the PRI request is outside of the control window, the request 
will be dropped.

However, there is an requirement from PCIE spec 10.4, which says

Spec: 10.4 Page Request Services
A Page Request Message is a PCIe Message Request that is Routed to the 
Root Complex (see the PCI Express Base Specification) with a Message 
Code of 4 (0000 0100b). The mechanism employed at the RC to buffer 
requests is implementation specific. The only requirement is that an RC 
not silently discard requests.

My question on "The only requirement is that an RC not silently discard 
requests."

1) what is SW’s expectation in this case? Is hw expected to trigger an 
interrupt ?
2) any information to be logged anywhere into status register ?
3) What if there are back-to-back violations?

Regards,
Oza.
