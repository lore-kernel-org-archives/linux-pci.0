Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod7og129.obsmtp.com ([64.18.2.122]:32866 "EHLO
	exprod7og129.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbaHTLJG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Aug 2014 07:09:06 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so7493496qcv.26
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2014 04:09:05 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Aug 2014 16:39:05 +0530
Message-ID: <CAK=zhgrv=e20s11v7Ls5ioWZrbyvp9Rzyv+QRDLR3mffr9E61A@mail.gmail.com>
Subject: How to get the number of VFs assigned to the guests in XEN
From: Sreekanth Reddy <sreekanth.reddy@avagotech.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, konrad.wilk@oracle.com
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, boris.ostrovsky@oracle.com,
	Sathya Prakash <sathya.prakash@avagotech.com>,
	Nagalakshmi Nandigama <nagalakshmi.nandigama@avagotech.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

HI,

For SRIOV support, currently in the KVM environment, mpt3sas driver
can use the API pci_vfs_assigned() to know the number of VFs that are
currently assigned to the running VMs. So that during the PF driver
unload time, if the return value of this API is greater than zero the
our driver won't call the pci_disable_sriov() to disable the VFs.

Now for the same purpose in XEN environment, is there any API similar
to pci_vfs_assigned() which the low lever device driver can use to
know 'the number of VFs that are currently assigned to the running
VMs'. In XEN environment this API pci_vfs_assigned() will return
always zero even though VFs are assigned to the running VMs.

Regards,
Sreekanth
