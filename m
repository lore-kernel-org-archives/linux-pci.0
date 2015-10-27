Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33382 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965331AbbJ0UwK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 16:52:10 -0400
Received: by pabla5 with SMTP id la5so39776848pab.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 13:52:10 -0700 (PDT)
Subject: [PATCH 0/5] Various of SR-IOV fixes and cleanup
From: Alexander Duyck <aduyck@mirantis.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2015 13:52:08 -0700
Message-ID: <20151027204607.14626.59671.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set is meant to address several issues found in recent patches
currently in the pci/virtualization branch.

The first two patches address possible issues in initialization.
Specifically the fact that offset and stride cannot be read while numvfs is
0, and that the BARs need to be reset if totalVFs has increased because the
BIOS likely allocated the given resources under the assumption of a smaller
number of VFs being available.

The last 3 address a number of issues in sriov_enable.  They started as
just a patch to address the offset and stride issues, however there were
some other issues found related to pcibios_enable_sriov that I decided to
address as well, and then there was some minor cleanup in addition to all
of that.

---

Alexander Duyck (5):
      iov: Update virtfn_max_buses to validate offset and stride
      iov: Reset resources to 0 if totalVFs increases after enabling ARI
      iov: Fix sriov_enable exception handling path
      iov: Variable and loop cleanup for sriov_disable and sriov_enable
      iov: Update sriov_enable to correctly handle offset and stride


 drivers/pci/iov.c |  123 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 58 deletions(-)

--
