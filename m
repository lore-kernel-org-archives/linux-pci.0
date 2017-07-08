Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34302 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbdGHRDG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Jul 2017 13:03:06 -0400
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org
From: valmiki <valmikibow@gmail.com>
Cc: jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        tianyu.lan@intel.com, kevin.tian@intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        jacob.jun.pan@intel.com
Subject: Support SVM without PASID
Message-ID: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
Date: Sat, 8 Jul 2017 22:33:01 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

In SMMUv3 architecture document i see "PASIDs are optional, 
configurable, and of a size determined by the minimum
of the endpoint".

So if PASID's are optional and not supported by PCIe end point, how SVM 
can be achieved ?

How will the translation for a particular process virtual address is 
obtained ?

Regards,
Valmiki
