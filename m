Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:40475 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdLCN4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Dec 2017 08:56:36 -0500
Subject: Invalidation in SMMU v3
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
References: <52a6fdbb-9a47-76c0-da59-89ac561b8ee3@gmail.com>
 <8fd78f56-43ed-e480-1c98-5d1162452674@arm.com>
 <e8effeac-bdfb-34dd-63e5-eb3fb08fd540@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>
From: valmiki <valmikibow@gmail.com>
Message-ID: <c2c2c5b0-7533-632b-f69e-050f125bef06@gmail.com>
Date: Sun, 3 Dec 2017 19:26:31 +0530
MIME-Version: 1.0
In-Reply-To: <e8effeac-bdfb-34dd-63e5-eb3fb08fd540@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

In PASID flow arm_smmu_atc_inv_master_all is called where size and iova 
of arm_smmu_atc_inv_to_cmd are zero and  no address is being filled in 
struct arm_smmu_cmdq_ent->atc.addr.
So how will smmu hardware know if there are any ats translations 
requested or not ?
How invalidation are carried out in PASID flow w.r.t address and size?


Regards,
Valmiki

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
