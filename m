Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728821AbeHMVCy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Aug 2018 17:02:54 -0400
Subject: [PATCH 0/2] Augment device matching its upstream Root Port's MPS
 logic
From: Myron Stowe <myron.stowe@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: keith.busch@intel.com, jdmason@kudzu.us, okaya@kernel.org
Date: Mon, 13 Aug 2018 12:19:31 -0600
Message-ID: <20180813181931.105655.22182.stgit@tak.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge") Keith made
sure every device's MPS setting matched its upstream bridge, making it more
likely that a hot-added devices would work in a system with an optimized MPS
configuration.

This series augments Keith's approach to include tuning down a Root Port's
MPS setting in the case where a hot-added device is not capable of matching
it (see: [1]).

Testing by Dongdong exposed a bug with the logic including Virtual Functions
(VFs).  VFs should not be included so a pre-cursor patch, 1/2, was added to
cover such.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=200527

Myron Stowe (2):
      PCI: Skip MPS logic for Virtual Functions (VFs)
      PCI: Match Root Port's MPS to endpoint's MPSS as necessary


 drivers/pci/probe.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
